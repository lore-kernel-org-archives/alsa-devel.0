From: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
Subject: [PATCH v14 4/8] ASoC: sun4i-codec: Add Mic1 Playback
 Switch, Mic2 Playback Switch
Date: Wed,  2 May 2018 23:07:56 +0200
Message-ID: <20180502210800.1971-5-dannym@scratchpost.org>
References: <20180502210800.1971-1-dannym@scratchpost.org>
Reply-To: dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCPKHTHNWIPBBTGRVDLQKGQEAOBOQDA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20180502210800.1971-1-dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>, Andrea Bondavalli <andrea.bondavalli74-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Add Mic1 Playback Switch and Mic2 Playback Switch for Allwinner A10 and
Allwinner A20.

Signed-off-by: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
---
 sound/soc/sunxi/sun4i-codec.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index b62af407967f..0add2c44115c 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -68,6 +68,10 @@
 #define SUN4I_CODEC_DAC_ACTL_LDACLMIXS			(15)
 #define SUN4I_CODEC_DAC_ACTL_RDACRMIXS			(14)
 #define SUN4I_CODEC_DAC_ACTL_LDACRMIXS			(13)
+#define SUN4I_CODEC_DAC_ACTL_MIC1LS			(12)
+#define SUN4I_CODEC_DAC_ACTL_MIC1RS			(11)
+#define SUN4I_CODEC_DAC_ACTL_MIC2LS			(10)
+#define SUN4I_CODEC_DAC_ACTL_MIC2RS			(9)
 #define SUN4I_CODEC_DAC_ACTL_DACPAS			(8)
 #define SUN4I_CODEC_DAC_ACTL_MIXPAS			(7)
 #define SUN4I_CODEC_DAC_ACTL_PA_MUTE			(6)
@@ -725,6 +729,12 @@ static const struct snd_kcontrol_new sun4i_codec_mixer_controls[] = {
 	SOC_DAPM_SINGLE("Right Mixer Left DAC Playback Switch",
 			SUN4I_CODEC_DAC_ACTL,
 			SUN4I_CODEC_DAC_ACTL_LDACRMIXS, 1, 0),
+	SOC_DAPM_DOUBLE("Mic1 Playback Switch", SUN4I_CODEC_DAC_ACTL,
+			SUN4I_CODEC_DAC_ACTL_MIC1LS,
+			SUN4I_CODEC_DAC_ACTL_MIC1RS, 1, 0),
+	SOC_DAPM_DOUBLE("Mic2 Playback Switch", SUN4I_CODEC_DAC_ACTL,
+			SUN4I_CODEC_DAC_ACTL_MIC2LS,
+			SUN4I_CODEC_DAC_ACTL_MIC2RS, 1, 0),
 };
 
 static const struct snd_kcontrol_new sun4i_codec_pa_mixer_controls[] = {
@@ -807,10 +817,14 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
 	{ "Right Mixer", NULL, "Mixer Enable" },
 	{ "Right Mixer", "Right Mixer Left DAC Playback Switch", "Left DAC" },
 	{ "Right Mixer", "Right Mixer Right DAC Playback Switch", "Right DAC" },
+	{ "Right Mixer", "Mic1 Playback Switch", "MIC1 Pre-Amplifier" },
+	{ "Right Mixer", "Mic2 Playback Switch", "MIC2 Pre-Amplifier" },
 
 	/* Left Mixer Routes */
 	{ "Left Mixer", NULL, "Mixer Enable" },
 	{ "Left Mixer", "Left Mixer Left DAC Playback Switch", "Left DAC" },
+	{ "Left Mixer", "Mic1 Playback Switch", "MIC1 Pre-Amplifier" },
+	{ "Left Mixer", "Mic2 Playback Switch", "MIC2 Pre-Amplifier" },
 
 	/* Power Amplifier Routes */
 	{ "Power Amplifier", "Mixer Playback Switch", "Left Mixer" },
