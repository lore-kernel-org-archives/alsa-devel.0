From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: [PATCH 1/3] ASoC: change set_tdm_slot api to allow
 slot_width override.
Date: Mon, 15 Jun 2009 21:44:31 -0300
Message-ID: <1245113071.24109.559.camel@brutus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8182674647126806214=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 5328A24402
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Jun 2009 02:44:39 +0200 (CEST)
Received: by qyk1 with SMTP id 1so5185848qyk.16
	for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2009 17:44:38 -0700 (PDT)
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


--===============8182674647126806214==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-sX1F2gC7yoR9rTAlH4Ui"


--=-sX1F2gC7yoR9rTAlH4Ui
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Extend set_tdm_slot to allow the user to arbitrarily set the frame width
and active TX/RX slots.

Updates magician.c and wm9081.c for the new set_tdm_slot(). wm9081.c
still doesn't handle the slot_width override.

While being there, correct an incorrect use of SlotsPerFrm(7) use in
bitmask on pxa-ssp.c (SSCR0_SlotsPerFrm(x) is (((x) - 1) << 24)) ).

(this series is meant for Mark's for-2.6.32 branch)

Signed-off-by: Daniel Ribeiro <drwyrm@gmail.com>

---
 include/sound/soc-dai.h   |    5 +++--
 sound/soc/codecs/wm9081.c |    5 +++--
 sound/soc/pxa/magician.c  |    2 +-
 sound/soc/pxa/pxa-ssp.c   |   27 ++++++++++++++++++++-------
 sound/soc/soc-core.c      |    9 ++++++---
 5 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 352d7ee..6692410 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -106,7 +106,7 @@ int snd_soc_dai_set_pll(struct snd_soc_dai *dai,
 int snd_soc_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt);
=20
 int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
-	unsigned int mask, int slots);
+	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width);
=20
 int snd_soc_dai_set_tristate(struct snd_soc_dai *dai, int tristate);
=20
@@ -140,7 +140,8 @@ struct snd_soc_dai_ops {
 	 */
 	int (*set_fmt)(struct snd_soc_dai *dai, unsigned int fmt);
 	int (*set_tdm_slot)(struct snd_soc_dai *dai,
-		unsigned int mask, int slots);
+		unsigned int tx_mask, unsigned int rx_mask,
+		int slots, int slot_width);
 	int (*set_tristate)(struct snd_soc_dai *dai, int tristate);
=20
 	/*
diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index 86fc57e..c47d573 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -1206,8 +1206,9 @@ static int wm9081_set_sysclk(struct snd_soc_dai *code=
c_dai,
 	return 0;
 }
=20
+/* FIXME: Needs to handle slot_width */
 static int wm9081_set_tdm_slot(struct snd_soc_dai *dai,
-			       unsigned int mask, int slots)
+	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width)
 {
 	struct snd_soc_codec *codec =3D dai->codec;
 	unsigned int aif1 =3D wm9081_read(codec, WM9081_AUDIO_INTERFACE_1);
@@ -1219,7 +1220,7 @@ static int wm9081_set_tdm_slot(struct snd_soc_dai *da=
i,
=20
 	aif1 |=3D (slots - 1) << WM9081_AIFDAC_TDM_MODE_SHIFT;
=20
-	switch (mask) {
+	switch (rx_mask) {
 	case 1:
 		break;
 	case 2:
diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
index c89a3cd..34437d8 100644
--- a/sound/soc/pxa/magician.c
+++ b/sound/soc/pxa/magician.c
@@ -188,7 +188,7 @@ static int magician_playback_hw_params(struct snd_pcm_s=
ubstream *substream,
 	if (ret < 0)
 		return ret;
=20
-	ret =3D snd_soc_dai_set_tdm_slot(cpu_dai, 1, 1);
+	ret =3D snd_soc_dai_set_tdm_slot(cpu_dai, 1, 0, 1, width);
 	if (ret < 0)
 		return ret;
=20
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index e22c5ce..5b9ed64 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -375,21 +375,34 @@ static int pxa_ssp_set_dai_pll(struct snd_soc_dai *cp=
u_dai,
  * Set the active slots in TDM/Network mode
  */
 static int pxa_ssp_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai,
-	unsigned int mask, int slots)
+	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width)
 {
 	struct ssp_priv *priv =3D cpu_dai->private_data;
 	struct ssp_device *ssp =3D priv->dev.ssp;
 	u32 sscr0;
=20
-	sscr0 =3D ssp_read_reg(ssp, SSCR0) & ~SSCR0_SlotsPerFrm(7);
+	sscr0 =3D ssp_read_reg(ssp, SSCR0);
+	sscr0 &=3D ~(SSCR0_MOD | SSCR0_SlotsPerFrm(8) | SSCR0_EDSS | SSCR0_DSS);
+
+	/* set slot width */
+	if (slot_width > 16)
+		sscr0 |=3D SSCR0_EDSS | SSCR0_DataSize(slot_width - 16);
+	else
+		sscr0 |=3D SSCR0_DataSize(slot_width);
=20
-	/* set number of active slots */
-	sscr0 |=3D SSCR0_SlotsPerFrm(slots);
+	if (slots > 1) {
+		/* enable network mode */
+		sscr0 |=3D SSCR0_MOD;
+
+		/* set number of active slots */
+		sscr0 |=3D SSCR0_SlotsPerFrm(slots);
+
+		/* set active slot mask */
+		ssp_write_reg(ssp, SSTSA, tx_mask);
+		ssp_write_reg(ssp, SSRSA, rx_mask);
+	}
 	ssp_write_reg(ssp, SSCR0, sscr0);
=20
-	/* set active slot mask */
-	ssp_write_reg(ssp, SSTSA, mask);
-	ssp_write_reg(ssp, SSRSA, mask);
 	return 0;
 }
=20
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e1a920c..c72a8e8 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2133,17 +2133,20 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_fmt);
 /**
  * snd_soc_dai_set_tdm_slot - configure DAI TDM.
  * @dai: DAI
- * @mask: DAI specific mask representing used slots.
+ * @tx_mask: bitmask representing active TX slots.
+ * @rx_mask: bitmask representing active RX slots.
  * @slots: Number of slots in use.
+ * @slot_width: Width in bits for each slot.
  *
  * Configures a DAI for TDM operation. Both mask and slots are codec and D=
AI
  * specific.
  */
 int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
-	unsigned int mask, int slots)
+	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width)
 {
 	if (dai->ops && dai->ops->set_tdm_slot)
-		return dai->ops->set_tdm_slot(dai, mask, slots);
+		return dai->ops->set_tdm_slot(dai, tx_mask, rx_mask,
+				slots, slot_width);
 	else
 		return -EINVAL;
 }
--=20
tg: (c787980..) asoc/set_tdm_slot (depends on: asoc/remove-code-duplication=
)

--=20
Daniel Ribeiro

--=-sX1F2gC7yoR9rTAlH4Ui
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta =?ISO-8859-1?Q?=E9?= uma parte de mensagem
 assinada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAko26u8ACgkQw3OYl0G0liSMqACfTyHJCTSdm94Gt4KuIiC18U2f
XTsAnR3Wi7L/mCiMqMow9frUwzLT+296
=LM8m
-----END PGP SIGNATURE-----

--=-sX1F2gC7yoR9rTAlH4Ui--


--===============8182674647126806214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8182674647126806214==--
