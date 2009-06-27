From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: Re: [RFC] I2S and LEFT_J
Date: Fri, 26 Jun 2009 21:28:28 -0300
Message-ID: <1246062508.10360.358.camel@brutus>
References: <f17812d70906090239p5dee129egda49918b3862c0ca@mail.gmail.com>
	<1244672649.25905.70.camel@brutus>
	<f17812d70906110634i623eb236ib277e164678a7a34@mail.gmail.com>
	<1244730992.21356.50.camel@brutus>
	<f17812d70906150145p763002det5e2699442673d532@mail.gmail.com>
	<1245077824.24109.51.camel@brutus>
	<20090615150433.GF6106@sirena.org.uk>
	<1245086420.24109.159.camel@brutus> <4A39F3A5.5030109@gmail.com>
	<1245328258.303.45.camel@brutus>
	<20090622221430.GH29236@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2215296846403102957=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 87D4E2438D
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Jun 2009 02:28:46 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 5so1307194qwf.56
	for <alsa-devel@alsa-project.org>; Fri, 26 Jun 2009 17:28:45 -0700 (PDT)
In-Reply-To: <20090622221430.GH29236@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2215296846403102957==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-QR0N9CV6mods1UfkP+BF"


--=-QR0N9CV6mods1UfkP+BF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel, sorry for the delay on this.

Em Ter, 2009-06-23 =C3=A0s 00:14 +0200, Daniel Mack escreveu:
> And on the oscilloscope, I see an asynchronous LRCLK[1].

> What's worth mentioning is this quote from the PXA datasheet - the code
> does not currently follow that rule:
>=20
>   "When using Programmable Serial Protocol (PSP) format in network
>   mode, the parameters SFRMDLY, STRTDLY, DMYSTP, EDMYSTP, DMYSTRT, and
>   EDMYSTRT must be set to 0b0; the other parameters SFRMP, SCMODE, FSRT,
>   and SFRMWDTH are programmable."
>   (4.5.8 SSP Programmable Serial Protocol Registers (SSPSP_x))

Yes, and very likely this is what caused the asynchronous LRCLK.

> Without network mode, these are the register values that do what I need:
>=20
>   SSCR0 0x2100037F
>   SSCR1 0x00C01d08
>   SSPSP 0x31a08084
>   (SSTSA/SSRSA don't matter in this case)

Thanks for the testing. If you don't mind, can you please replace the
third patch, and try this one instead?

Use set_tdm_slot(5, 5, 4, 16), if this works for you we can just drop
the pxa3xx special case and use SSCR0_FSRT and network mode for both
pxa2xx and pxa3xx.

If not, use set_tdm_slot(1, 1, 1, 16), and tweak the
(slots =3D=3D 1 && slot_width =3D=3D 16) special case as needed. This condi=
tion
should give you a config without SSCR0_MOD, and you should be able to
match the register values above.

---
 arch/arm/mach-pxa/include/mach/regs-ssp.h |   14 ++--
 sound/soc/pxa/pxa-ssp.c                   |  125 ++++++++++++++-----------=
----
 2 files changed, 67 insertions(+), 72 deletions(-)

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
index d60492e..6efead5 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -179,21 +179,6 @@ static void ssp_set_scr(struct ssp_device *ssp, u32 di=
v)
 	ssp_write_reg(ssp, SSCR0, sscr0);
 }
=20
-/**
- * ssp_get_clkdiv - get SSP clock divider
- */
-static u32 ssp_get_scr(struct ssp_device *ssp)
-{
-	u32 sscr0 =3D ssp_read_reg(ssp, SSCR0);
-	u32 div;
-
-	if (cpu_is_pxa25x() && ssp->type =3D=3D PXA25x_SSP)
-		div =3D ((sscr0 >> 8) & 0xff) * 2 + 2;
-	else
-		div =3D ((sscr0 >> 8) & 0xfff) + 1;
-	return div;
-}
-
 /*
  * Set the SSP ports SYSCLK.
  */
@@ -487,17 +472,14 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cp=
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
@@ -561,6 +543,63 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream =
*substream,
 		sscr0 |=3D SSCR0_FPCKE;
 #endif
=20
+	sspsp =3D ssp_read_reg(ssp, SSPSP);
+	switch (priv->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		/*
+		 * I2S and LEFT_J are stereo only, we have to send data for
+		 * both channels.
+		 */
+		if (chn =3D=3D 1)
+			frame_width *=3D 2;
+
+		/*
+		 * If the user did not use network mode, we assume the codec
+		 * is I2S compliant.
+		 */
+		if (frame_width > 0) {
+			sspsp |=3D SSPSP_SFRMWDTH(frame_width / 2);
+			sspsp |=3D SSPSP_FSRT;
+		} else {
+			/*
+			 * Otherwise we assume that it is a single TDM slot, and
+			 * the user is abusing set_tdm_slot to support an
+			 * out of spec codec.
+			 */
+			int slots =3D ((sscr0 & SSCR0_SlotsPerFrm(8)) >> 24) + 1;
+
+			if (slots =3D=3D 1 && slot_width =3D=3D 16) {
+				if (!cpu_is_pxa3xx())
+					return -EINVAL;
+
+				sspsp |=3D SSPSP_DMYSTRT(1);
+				sspsp |=3D SSPSP_DMYSTOP(
+						slot_width * 2 - width - 1);
+				sspsp |=3D SSPSP_SFRMWDTH(slot_width * 2);
+			} else {
+				sspsp |=3D SSPSP_SFRMWDTH(slot_width * slots / 2);
+				sspsp |=3D SSPSP_FSRT;
+			}
+		}
+		break;
+
+	case SND_SOC_DAIFMT_LEFT_J:
+		if (chn =3D=3D 1)
+			frame_width *=3D 2;
+
+		if (frame_width > 0) {
+			sspsp |=3D SSPSP_SFRMWDTH(frame_width / 2);
+		} else {
+			int slots =3D ((sscr0 & SSCR0_SlotsPerFrm(8)) >> 24) + 1;
+
+			sspsp |=3D SSPSP_SFRMWDTH((slot_width * slots) / 2);
+		}
+		break;
+	default:
+		break;
+	}
+	ssp_write_reg(ssp, SSPSP, sspsp);
+
 	if (frame_width > 0) {
 		/* Not using network mode */
 		if (frame_width > 16)
@@ -598,50 +637,6 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream =
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
tg: (2d97ff5..) asoc/leftj-and-i2s (depends on: asoc/ssp-internals)


--=20
Daniel Ribeiro

--=-QR0N9CV6mods1UfkP+BF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta =?ISO-8859-1?Q?=E9?= uma parte de mensagem
 assinada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkpFZ6wACgkQw3OYl0G0liS3oQCePk8ryzi+vYtYsHWT74zNyVB2
ax0An3i7j4malyPXwoOuUGo6BpK0FvuP
=xYOR
-----END PGP SIGNATURE-----

--=-QR0N9CV6mods1UfkP+BF--


--===============2215296846403102957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2215296846403102957==--
