From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: [RFC] I2S and LEFT_J (was: ASoC: pxa-ssp: enhance I2S
 and add Left_J support)
Date: Thu, 11 Jun 2009 11:36:32 -0300
Message-ID: <1244730992.21356.50.camel@brutus>
References: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
	<74d0deb30906080512q29b9915fvec9b068bf4b2e126@mail.gmail.com>
	<20090608124045.GE7858@sirena.org.uk>
	<1244477000.30582.72.camel@brutus>
	<20090608165328.GB14026@rakim.wolfsonmicro.main>
	<1244481992.17327.22.camel@brutus>
	<20090608180656.GH7858@sirena.org.uk>
	<1244494349.17327.174.camel@brutus>
	<f17812d70906090239p5dee129egda49918b3862c0ca@mail.gmail.com>
	<1244672649.25905.70.camel@brutus>
	<f17812d70906110634i623eb236ib277e164678a7a34@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2781002654136373145=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.148])
	by alsa0.perex.cz (Postfix) with ESMTP id DB8BE103853
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Jun 2009 16:36:39 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 9so851072qwj.56
	for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2009 07:36:39 -0700 (PDT)
In-Reply-To: <f17812d70906110634i623eb236ib277e164678a7a34@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2781002654136373145==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-oxdsQnhEfuCfjRCbtpFm"


--=-oxdsQnhEfuCfjRCbtpFm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em Qui, 2009-06-11 =C3=A0s 21:34 +0800, Eric Miao escreveu:
> > We already use FSRT for DSP_A, and if this works on littleton I2S we
> > should just stick with FSRT (and frame_width =3D sample_width * channel=
s)
> > to keep the code simple.
> >
>=20
> I hope so, but the assumption of frame_width =3D=3D sample_width * 2 shou=
ld
> hold true first.

Ok, here is what I think that should work for I2S after my 2 patches to
sort the TDM thing.

2 Patches are inline, first version assumes that frame_width =3D
sample_width * 2(channels), and just increases the SFRM duration to
emulate the LRCLK.

Second version uses Eric and Paul code only for pxa3xx. In this version,
frame_width =3D sample_width * 2(channels) * 2(envelope).

This was only compile tested, I dont have PXA3XX hardware to test this.
It applies after the 3 patches I sent earlier.

First version:
---
 sound/soc/pxa/pxa-ssp.c |   76 ++++++++++++++++---------------------------=
----
 1 files changed, 26 insertions(+), 50 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 7e72c41..631eca4 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -487,17 +487,14 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cp=
u_dai,
 	}
=20
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
-	case SND_SOC_DAIFMT_I2S:
-		sscr0 |=3D SSCR0_PSP;
-		sscr1 |=3D SSCR1_RWOT | SSCR1_TRAIL;
-		/* See hw_params() */
-		break;
-
 	case SND_SOC_DAIFMT_DSP_A:
+	case SND_SOC_DAIFMT_I2S:
 		sspsp |=3D SSPSP_FSRT;
 	case SND_SOC_DAIFMT_DSP_B:
+	case SND_SOC_DAIFMT_LEFT_J:
 		sscr0 |=3D SSCR0_PSP;
 		sscr1 |=3D SSCR1_TRAIL | SSCR1_RWOT;
+		/* See hw_params() for I2S and LEFT_J */
 		break;
=20
 	default:
@@ -565,6 +562,29 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream =
*substream,
 		sscr0 |=3D SSCR0_FPCKE;
 #endif
=20
+	switch (priv->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+	case SND_SOC_DAIFMT_LEFT_J:
+		/*
+		 * We can't support network mode with I2S or LEFT_J,
+		 * SSPFRM is asserted only for the first slot.
+		 */
+		if (frame_width =3D=3D 0 || chn > 2)
+			return -EINVAL;
+
+		/*
+		 * I2S and LEFT_J are stereo only, we have to send data for
+		 * both channels.
+		 */
+		if (chn =3D=3D 1)
+			frame_width *=3D 2;
+
+		sspsp |=3D SSPSP_SFRMWDTH(frame_width / 2);
+		break;
+	default:
+		break;
+	}
+
 	if (frame_width > 0) {
 		/* Not using network mode */
 		if (frame_width > 16)
@@ -602,50 +622,6 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream =
*substream,
=20
 	ssp_write_reg(ssp, SSCR0, sscr0);
=20
-	switch (priv->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
-	case SND_SOC_DAIFMT_I2S:
-	       sspsp =3D ssp_read_reg(ssp, SSPSP);
-
-		if ((ssp_get_scr(ssp) =3D=3D 4) && (width =3D=3D 16)) {
-			/* This is a special case where the bitclk is 64fs
-			* and we're not dealing with 2*32 bits of audio
-			* samples.
-			*
-			* The SSP values used for that are all found out by
-			* trying and failing a lot; some of the registers
-			* needed for that mode are only available on PXA3xx.
-			*/
-
-#ifdef CONFIG_PXA3xx
-			if (!cpu_is_pxa3xx())
-				return -EINVAL;
-
-			sspsp |=3D SSPSP_SFRMWDTH(width * 2);
-			sspsp |=3D SSPSP_SFRMDLY(width * 4);
-			sspsp |=3D SSPSP_EDMYSTOP(3);
-			sspsp |=3D SSPSP_DMYSTOP(3);
-			sspsp |=3D SSPSP_DMYSTRT(1);
-#else
-			return -EINVAL;
-#endif
-		} else {
-			/* The frame width is the width the LRCLK is
-			 * asserted for; the delay is expressed in
-			 * half cycle units.  We need the extra cycle
-			 * because the data starts clocking out one BCLK
-			 * after LRCLK changes polarity.
-			 */
-			sspsp |=3D SSPSP_SFRMWDTH(width + 1);
-			sspsp |=3D SSPSP_SFRMDLY((width + 1) * 2);
-			sspsp |=3D SSPSP_DMYSTRT(1);
-		}
-
-		ssp_write_reg(ssp, SSPSP, sspsp);
-		break;
-	default:
-		break;
-	}
-
 	dump_registers(ssp);
=20
 	return 0;
--=20
tg: (99ef28c..) asoc/leftj-and-i2s (depends on: asoc/ssp-internals)


Second version:
---
 arch/arm/mach-pxa/include/mach/regs-ssp.h |   14 ++--
 sound/soc/pxa/pxa-ssp.c                   |   99 ++++++++++++++-----------=
----
 2 files changed, 56 insertions(+), 57 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/regs-ssp.h b/arch/arm/mach-pxa/=
include/mach/regs-ssp.h
index 6a2ed35..060e23b 100644
--- a/arch/arm/mach-pxa/include/mach/regs-ssp.h
+++ b/arch/arm/mach-pxa/include/mach/regs-ssp.h
@@ -108,21 +108,21 @@
 #define SSSR_TINT		(1 << 19)	/* Receiver Time-out Interrupt */
 #define SSSR_PINT		(1 << 18)	/* Peripheral Trailing Byte Interrupt */
=20
-#if defined(CONFIG_PXA3xx)
-#define SSPSP_EDMYSTOP(x)	((x) << 28)     /* Extended Dummy Stop */
-#define SSPSP_EDMYSTRT(x)	((x) << 26)     /* Extended Dummy Start */
-#endif
-
 #define SSPSP_FSRT		(1 << 25)	/* Frame Sync Relative Timing */
-#define SSPSP_DMYSTOP(x)	((x) << 23)	/* Dummy Stop */
 #define SSPSP_SFRMWDTH(x)	((x) << 16)	/* Serial Frame Width */
 #define SSPSP_SFRMDLY(x)	((x) << 9)	/* Serial Frame Delay */
-#define SSPSP_DMYSTRT(x)	((x) << 7)	/* Dummy Start */
 #define SSPSP_STRTDLY(x)	((x) << 4)	/* Start Delay */
 #define SSPSP_ETDS		(1 << 3)	/* End of Transfer data State */
 #define SSPSP_SFRMP		(1 << 2)	/* Serial Frame Polarity */
 #define SSPSP_SCMODE(x)		((x) << 0)	/* Serial Bit Rate Clock Mode */
=20
+/* NOTE: PXA3xx extends the bit number of dummy start and stop, the macros
+ * below are compatible with PXA25x/27x as long as the parameter is within
+ * the correct limits, driver code has to take care of this.
+ */
+#define SSPSP_DMYSTRT(x)       ((((x) & 3) << 7)  | ((((x) >> 2) & 3) << 2=
6))
+#define SSPSP_DMYSTOP(x)       ((((x) & 3) << 23) | ((((x) >> 2) & 7) << 2=
8))
+
 #define SSACD_SCDB		(1 << 3)	/* SSPSYSCLK Divider Bypass */
 #define SSACD_ACPS(x)		((x) << 4)	/* Audio clock PLL select */
 #define SSACD_ACDS(x)		((x) << 0)	/* Audio clock divider select */
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 7e72c41..a14ce77 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -487,17 +487,14 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cp=
u_dai,
 	}
=20
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
-	case SND_SOC_DAIFMT_I2S:
-		sscr0 |=3D SSCR0_PSP;
-		sscr1 |=3D SSCR1_RWOT | SSCR1_TRAIL;
-		/* See hw_params() */
-		break;
-
 	case SND_SOC_DAIFMT_DSP_A:
 		sspsp |=3D SSPSP_FSRT;
 	case SND_SOC_DAIFMT_DSP_B:
+	case SND_SOC_DAIFMT_LEFT_J:
+	case SND_SOC_DAIFMT_I2S:
 		sscr0 |=3D SSCR0_PSP;
 		sscr1 |=3D SSCR1_TRAIL | SSCR1_RWOT;
+		/* See hw_params() for I2S and LEFT_J */
 		break;
=20
 	default:
@@ -565,6 +562,52 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream =
*substream,
 		sscr0 |=3D SSCR0_FPCKE;
 #endif
=20
+	switch (priv->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		/*
+		 * We can't support network mode with I2S or LEFT_J,
+		 * SSPFRM is asserted only for the first slot.
+		 */
+		if (frame_width =3D=3D 0 || chn > 2)
+			return -EINVAL;
+
+		/*
+		 * I2S and LEFT_J are stereo only, we have to send data for
+		 * both channels.
+		 */
+		if (chn =3D=3D 1)
+			frame_width *=3D 2;
+
+		/* For pxa2xx we have to stick with FSRT */
+		if (cpu_is_pxa25x() || cpu_is_pxa27x())
+			sspsp |=3D SSPSP_FSRT;
+
+		/* For pxa3xx we use Paul's code */
+		if (cpu_is_pxa3xx()) {
+			/* We double the frame_width to envelope the sample */
+			frame_width *=3D 2;
+
+			sspsp |=3D SSPSP_DMYSTRT(1);
+			sspsp |=3D SSPSP_DMYSTOP(frame_width / 2 - width - 1);
+			sspsp |=3D SSPSP_SFRMWDTH(frame_width / 2);
+		}
+
+		break;
+
+	case SND_SOC_DAIFMT_LEFT_J:
+		if (frame_width =3D=3D 0 || chn > 2)
+			return -EINVAL;
+
+		if (chn =3D=3D 1)
+			frame_width *=3D 2;
+
+		/* No need to envelope the frame for LEFT_J */
+		sspsp |=3D SSPSP_SFRMWDTH(frame_width / 2);
+		break;
+	default:
+		break;
+	}
+
 	if (frame_width > 0) {
 		/* Not using network mode */
 		if (frame_width > 16)
@@ -602,50 +645,6 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream =
*substream,
=20
 	ssp_write_reg(ssp, SSCR0, sscr0);
=20
-	switch (priv->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
-	case SND_SOC_DAIFMT_I2S:
-	       sspsp =3D ssp_read_reg(ssp, SSPSP);
-
-		if ((ssp_get_scr(ssp) =3D=3D 4) && (width =3D=3D 16)) {
-			/* This is a special case where the bitclk is 64fs
-			* and we're not dealing with 2*32 bits of audio
-			* samples.
-			*
-			* The SSP values used for that are all found out by
-			* trying and failing a lot; some of the registers
-			* needed for that mode are only available on PXA3xx.
-			*/
-
-#ifdef CONFIG_PXA3xx
-			if (!cpu_is_pxa3xx())
-				return -EINVAL;
-
-			sspsp |=3D SSPSP_SFRMWDTH(width * 2);
-			sspsp |=3D SSPSP_SFRMDLY(width * 4);
-			sspsp |=3D SSPSP_EDMYSTOP(3);
-			sspsp |=3D SSPSP_DMYSTOP(3);
-			sspsp |=3D SSPSP_DMYSTRT(1);
-#else
-			return -EINVAL;
-#endif
-		} else {
-			/* The frame width is the width the LRCLK is
-			 * asserted for; the delay is expressed in
-			 * half cycle units.  We need the extra cycle
-			 * because the data starts clocking out one BCLK
-			 * after LRCLK changes polarity.
-			 */
-			sspsp |=3D SSPSP_SFRMWDTH(width + 1);
-			sspsp |=3D SSPSP_SFRMDLY((width + 1) * 2);
-			sspsp |=3D SSPSP_DMYSTRT(1);
-		}
-
-		ssp_write_reg(ssp, SSPSP, sspsp);
-		break;
-	default:
-		break;
-	}
-
 	dump_registers(ssp);
=20
 	return 0;
--=20
tg: (99ef28c..) asoc/leftj-and-i2s (depends on: asoc/ssp-internals)


--=20
Daniel Ribeiro

--=-oxdsQnhEfuCfjRCbtpFm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta =?ISO-8859-1?Q?=E9?= uma parte de mensagem
 assinada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkoxFnAACgkQw3OYl0G0liRGGwCfdtyMkdw3pzz815w7pIKHbHMJ
4ZMAnj3f5+rLrM2E6ZrDkenlZXxrI5cq
=vnl6
-----END PGP SIGNATURE-----

--=-oxdsQnhEfuCfjRCbtpFm--


--===============2781002654136373145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2781002654136373145==--
