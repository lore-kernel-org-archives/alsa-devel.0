From: Adam Sampson <ats-G+91BasbrijYtjvyW6yDsg@public.gmane.org>
Subject: [PATCH] ASoC: sun4i-codec: use consistent names for PA controls
Date: Sat, 24 Oct 2015 13:11:52 +0100
Message-ID: <1445688712-31951-1-git-send-email-ats@offog.org>
Reply-To: ats-G+91BasbrijYtjvyW6yDsg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCQPXGGUXQGBBGHLVWYQKGQEF4SSX5I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Adam Sampson <ats-G+91BasbrijYtjvyW6yDsg@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

The power amplifier for the headphone output is called "the PA" and "the
headphone amplifier" in Allwinner's documentation for the A10 and A20.
sun4i-codec calls it "PA" in some places and "Pre-Amplifier" (which
isn't really accurate) in others, leading to user-visible controls with
different names referring to the same device.

When this driver implements audio input, it'll also need to expose
controls for the line and mic input preamps, so just referring to "the
Pre-Amplifier" will be ambiguous.

Change it to use "PA" consistently for the power amplifier.

Signed-off-by: Adam Sampson <ats-G+91BasbrijYtjvyW6yDsg@public.gmane.org>
---
 sound/soc/sunxi/sun4i-codec.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index bcbf4da..ff3304d 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -2,6 +2,7 @@
  * Copyright 2014 Emilio L=C3=B3pez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
  * Copyright 2014 Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
  * Copyright 2015 Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
+ * Copyright 2015 Adam Sampson <ats-G+91BasbrijYtjvyW6yDsg@public.gmane.org>
  *
  * Based on the Allwinner SDK driver, released under the GPL.
  *
@@ -452,12 +453,12 @@ static const struct snd_soc_dapm_widget sun4i_codec_d=
apm_widgets[] =3D {
 	SND_SOC_DAPM_SUPPLY("Mixer Enable", SUN4I_CODEC_DAC_ACTL,
 			    SUN4I_CODEC_DAC_ACTL_MIXEN, 0, NULL, 0),
=20
-	/* Pre-Amplifier */
-	SND_SOC_DAPM_MIXER("Pre-Amplifier", SUN4I_CODEC_ADC_ACTL,
+	/* Headphone output power amplifier */
+	SND_SOC_DAPM_MIXER("PA", SUN4I_CODEC_ADC_ACTL,
 			   SUN4I_CODEC_ADC_ACTL_PA_EN, 0,
 			   sun4i_codec_pa_mixer_controls,
 			   ARRAY_SIZE(sun4i_codec_pa_mixer_controls)),
-	SND_SOC_DAPM_SWITCH("Pre-Amplifier Mute", SND_SOC_NOPM, 0, 0,
+	SND_SOC_DAPM_SWITCH("PA Mute", SND_SOC_NOPM, 0, 0,
 			    &sun4i_codec_pa_mute),
=20
 	SND_SOC_DAPM_OUTPUT("HP Right"),
@@ -480,16 +481,16 @@ static const struct snd_soc_dapm_route sun4i_codec_da=
pm_routes[] =3D {
 	{ "Left Mixer", NULL, "Mixer Enable" },
 	{ "Left Mixer", "Left DAC Playback Switch", "Left DAC" },
=20
-	/* Pre-Amplifier Mixer Routes */
-	{ "Pre-Amplifier", "Mixer Playback Switch", "Left Mixer" },
-	{ "Pre-Amplifier", "Mixer Playback Switch", "Right Mixer" },
-	{ "Pre-Amplifier", "DAC Playback Switch", "Left DAC" },
-	{ "Pre-Amplifier", "DAC Playback Switch", "Right DAC" },
+	/* PA Mixer Routes */
+	{ "PA", "Mixer Playback Switch", "Left Mixer" },
+	{ "PA", "Mixer Playback Switch", "Right Mixer" },
+	{ "PA", "DAC Playback Switch", "Left DAC" },
+	{ "PA", "DAC Playback Switch", "Right DAC" },
=20
 	/* PA -> HP path */
-	{ "Pre-Amplifier Mute", "Switch", "Pre-Amplifier" },
-	{ "HP Right", NULL, "Pre-Amplifier Mute" },
-	{ "HP Left", NULL, "Pre-Amplifier Mute" },
+	{ "PA Mute", "Switch", "PA" },
+	{ "HP Right", NULL, "PA Mute" },
+	{ "HP Left", NULL, "PA Mute" },
 };
=20
 static struct snd_soc_codec_driver sun4i_codec_codec =3D {
--=20
2.1.4

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
