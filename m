From: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
Subject: [PATCH v13 11/14] ASoC: sun4i-codec: Add Line Right,
 Line Left, Line Playback Switch.
Date: Sat, 24 Jun 2017 08:24:16 +0200
Message-ID: <20170624062419.23778-12-dannym@scratchpost.org>
References: <20170624062419.23778-1-dannym@scratchpost.org>
Reply-To: dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCPKHTHNWIPBBCUMXDFAKGQEXZXVW6Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170624062419.23778-1-dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Add Line Right, Line Left, Line Playback Switch for Allwinner A10 and
Allwinner A20.

Signed-off-by: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
---
 sound/soc/sunxi/sun4i-codec.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 564df33..bcd665d 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -67,6 +67,8 @@
 #define SUN4I_CODEC_DAC_ACTL_LNG			(26)
 #define SUN4I_CODEC_DAC_ACTL_FMG			(23)
 #define SUN4I_CODEC_DAC_ACTL_MICG			(20)
+#define SUN4I_CODEC_DAC_ACTL_LLNS			(19)
+#define SUN4I_CODEC_DAC_ACTL_RLNS			(18)
 #define SUN4I_CODEC_DAC_ACTL_LFMS			(17)
 #define SUN4I_CODEC_DAC_ACTL_RFMS			(16)
 #define SUN4I_CODEC_DAC_ACTL_LDACLMIXS			(15)
@@ -716,6 +718,9 @@ static const struct snd_kcontrol_new sun4i_codec_mixer_controls[] = {
 	SOC_DAPM_SINGLE("Right Mixer Left DAC Playback Switch",
 			SUN4I_CODEC_DAC_ACTL,
 			SUN4I_CODEC_DAC_ACTL_LDACRMIXS, 1, 0),
+	SOC_DAPM_DOUBLE("Line Playback Switch", SUN4I_CODEC_DAC_ACTL,
+			SUN4I_CODEC_DAC_ACTL_LLNS,
+			SUN4I_CODEC_DAC_ACTL_RLNS, 1, 0),
 	SOC_DAPM_DOUBLE("FM Playback Switch", SUN4I_CODEC_DAC_ACTL,
 			SUN4I_CODEC_DAC_ACTL_LFMS,
 			SUN4I_CODEC_DAC_ACTL_RFMS, 1, 0),
@@ -787,6 +792,8 @@ static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
 	SND_SOC_DAPM_SWITCH("Power Amplifier Mute", SND_SOC_NOPM, 0, 0,
 			    &sun4i_codec_pa_mute),
 
+	SND_SOC_DAPM_INPUT("Line Right"),
+	SND_SOC_DAPM_INPUT("Line Left"),
 	SND_SOC_DAPM_INPUT("FM Right"),
 	SND_SOC_DAPM_INPUT("FM Left"),
 	SND_SOC_DAPM_INPUT("Mic1"),
@@ -809,6 +816,7 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
 	{ "Right Mixer", NULL, "Mixer Enable" },
 	{ "Right Mixer", "DAC Playback Switch", "Left DAC" },
 	{ "Right Mixer", "Right Mixer Left DAC Playback Switch", "Left DAC" },
+	{ "Right Mixer", "Line Playback Switch", "Line Right" },
 	{ "Right Mixer", "FM Playback Switch", "FM Right" },
 	{ "Right Mixer", "Mic1 Playback Switch", "MIC1 Pre-Amplifier" },
 	{ "Right Mixer", "Mic2 Playback Switch", "MIC2 Pre-Amplifier" },
@@ -816,6 +824,7 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
 	/* Left Mixer Routes */
 	{ "Left Mixer", NULL, "Mixer Enable" },
 	{ "Left Mixer", "DAC Playback Switch", "Left DAC" },
+	{ "Left Mixer", "Line Playback Switch", "Line Left" },
 	{ "Left Mixer", "FM Playback Switch", "FM Left" },
 	{ "Left Mixer", "Mic1 Playback Switch", "MIC1 Pre-Amplifier" },
 	{ "Left Mixer", "Mic2 Playback Switch", "MIC2 Pre-Amplifier" },
-- 
2.1.4
