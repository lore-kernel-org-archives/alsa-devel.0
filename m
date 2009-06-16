From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: [PATCH 2/3] ASoC: pxa-ssp.c,
	Automatically set TDM when needed
Date: Mon, 15 Jun 2009 21:44:59 -0300
Message-ID: <1245113099.24109.560.camel@brutus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4914987092046008793=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.150])
	by alsa0.perex.cz (Postfix) with ESMTP id 444D524423
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Jun 2009 02:45:07 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 9so2049989qwj.56
	for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2009 17:45:06 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>, Eric Miao <eric.y.miao@gmail.com>
Cc: Paul Shen <boshen9@gmail.com>, alsa-devel <alsa-devel@alsa-project.org>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4914987092046008793==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-rAN4e2edjo+pW4AdT5zq"


--=-rAN4e2edjo+pW4AdT5zq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

* Automatically sets TDM mode for frame_width larger than 32 bits, if
  the user doesn't setup the TDM slots with set_tdm_slot().
* Reset SSCR0_EDSS and SSCR0_DSS on pxa_ssp_set_dai_fmt.
* Makes SSCR0_MOD optional.
* Clears SSCR1_RWOT case SSCR0_MOD is set.

Signed-off-by: Daniel Ribeiro <drwyrm@gmail.com>

---
 sound/soc/pxa/pxa-ssp.c |   92 +++++++++++++++++++++++++++----------------=
----
 1 files changed, 53 insertions(+), 39 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 5b9ed64..d60492e 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -452,8 +452,8 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_=
dai,
 	}
=20
 	/* reset port settings */
-	sscr0 =3D ssp_read_reg(ssp, SSCR0) &
-		(SSCR0_ECS |  SSCR0_NCS | SSCR0_MOD | SSCR0_ACS);
+	sscr0 =3D ssp_read_reg(ssp, SSCR0) & (SSCR0_ECS | SSCR0_NCS | SSCR0_MOD |
+			SSCR0_ACS | SSCR0_DSS | SSCR0_EDSS);
 	sscr1 =3D SSCR1_RxTresh(8) | SSCR1_TxTresh(7);
 	sspsp =3D 0;
=20
@@ -496,7 +496,7 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_=
dai,
 	case SND_SOC_DAIFMT_DSP_A:
 		sspsp |=3D SSPSP_FSRT;
 	case SND_SOC_DAIFMT_DSP_B:
-		sscr0 |=3D SSCR0_MOD | SSCR0_PSP;
+		sscr0 |=3D SSCR0_PSP;
 		sscr1 |=3D SSCR1_TRAIL | SSCR1_RWOT;
 		break;
=20
@@ -532,48 +532,70 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream=
 *substream,
 	struct ssp_priv *priv =3D cpu_dai->private_data;
 	struct ssp_device *ssp =3D priv->dev.ssp;
 	int chn =3D params_channels(params);
-	u32 sscr0;
-	u32 sspsp;
+	u32 sscr0, sscr1, sspsp;
 	int width =3D snd_pcm_format_physical_width(params_format(params));
-	int ttsa =3D ssp_read_reg(ssp, SSTSA) & 0xf;
+	int slot_width, frame_width =3D 0;
+
+	/* check if the user explicitly set a slot_width */
+	sscr0 =3D ssp_read_reg(ssp, SSCR0);
+
+	if (sscr0 & (SSCR0_EDSS | SSCR0_DSS))
+		slot_width =3D (sscr0 & SSCR0_DSS) +
+			(sscr0 & SSCR0_EDSS ? 17 : 1);
+	else
+		frame_width =3D slot_width =3D width * chn;
=20
 	/* generate correct DMA params */
 	if (cpu_dai->dma_data)
 		kfree(cpu_dai->dma_data);
=20
-	/* Network mode with one active slot (ttsa =3D=3D 1) can be used
-	 * to force 16-bit frame width on the wire (for S16_LE), even
-	 * with two channels. Use 16-bit DMA transfers for this case.
-	 */
-	cpu_dai->dma_data =3D ssp_get_dma_params(ssp,
-			((chn =3D=3D 2) && (ttsa !=3D 1)) || (width =3D=3D 32),
+	cpu_dai->dma_data =3D ssp_get_dma_params(ssp, slot_width > 16,
 			substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK);
=20
 	/* we can only change the settings if the port is not in use */
-	if (ssp_read_reg(ssp, SSCR0) & SSCR0_SSE)
+	if (sscr0 & SSCR0_SSE)
 		return 0;
=20
-	/* clear selected SSP bits */
-	sscr0 =3D ssp_read_reg(ssp, SSCR0) & ~(SSCR0_DSS | SSCR0_EDSS);
-	ssp_write_reg(ssp, SSCR0, sscr0);
-
-	/* bit size */
-	sscr0 =3D ssp_read_reg(ssp, SSCR0);
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
 #ifdef CONFIG_PXA3xx
-		if (cpu_is_pxa3xx())
-			sscr0 |=3D SSCR0_FPCKE;
+	if (slot_width =3D=3D 16 && cpu_is_pxa3xx())
+		sscr0 |=3D SSCR0_FPCKE;
 #endif
-		sscr0 |=3D SSCR0_DataSize(16);
-		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
-		sscr0 |=3D (SSCR0_EDSS | SSCR0_DataSize(8));
-		break;
-	case SNDRV_PCM_FORMAT_S32_LE:
-		sscr0 |=3D (SSCR0_EDSS | SSCR0_DataSize(16));
-		break;
+
+	if (frame_width > 0) {
+		/* Not using network mode */
+		if (frame_width > 16)
+			sscr0 |=3D SSCR0_EDSS | SSCR0_DataSize(frame_width - 16);
+		else
+			sscr0 |=3D SSCR0_DataSize(frame_width);
+
+		if (frame_width > 32) {
+			/*
+			 * Network mode is needed to support this frame width.
+			 * We assume the wire is not networked and setup a
+			 * fake network mode here. Use as many slots as needed
+			 * each with 32 bits.
+			 */
+			int slots =3D frame_width / 32;
+
+			sscr0 |=3D SSCR0_MOD;
+			sscr0 |=3D SSCR0_SlotsPerFrm(slots);
+
+			/*
+			 * Set active slots. Only set an active TX slot
+			 * if we are going to use it.
+			 */
+			ssp_write_reg(ssp, SSRSA, slots - 1);
+			if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
+				ssp_write_reg(ssp, SSTSA, slots - 1);
+		}
 	}
+
+	/* If SSCR0_MOD is set we can't use SSCR1_RWOT */
+	if (sscr0 & SSCR0_MOD) {
+		sscr1 =3D ssp_read_reg(ssp, SSCR1);
+		ssp_write_reg(ssp, SSCR1, sscr1 & ~SSCR1_RWOT);
+	}
+
 	ssp_write_reg(ssp, SSCR0, sscr0);
=20
 	switch (priv->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
@@ -620,14 +642,6 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream =
*substream,
 		break;
 	}
=20
-	/* When we use a network mode, we always require TDM slots
-	 * - complain loudly and fail if they've not been set up yet.
-	 */
-	if ((sscr0 & SSCR0_MOD) && !ttsa) {
-		dev_err(&ssp->pdev->dev, "No TDM timeslot configured\n");
-		return -EINVAL;
-	}
-
 	dump_registers(ssp);
=20
 	return 0;
--=20
tg: (b977873..) asoc/ssp-internals (depends on: asoc/set_tdm_slot)

--=20
Daniel Ribeiro

--=-rAN4e2edjo+pW4AdT5zq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta =?ISO-8859-1?Q?=E9?= uma parte de mensagem
 assinada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAko26wsACgkQw3OYl0G0liTtZgCeLmxP3OV1vFjp0O0aB7GlJWuJ
J5sAni0MVdRz8E/hFyQ4oQZK0+yO0O7Z
=a+l/
-----END PGP SIGNATURE-----

--=-rAN4e2edjo+pW4AdT5zq--


--===============4914987092046008793==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4914987092046008793==--
