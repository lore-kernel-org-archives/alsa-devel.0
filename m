From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH 10/12] ASoC: sun4i-codec: Add support for A31
 board level audio routing
Date: Mon,  3 Oct 2016 19:08:02 +0800
Message-ID: <20161003110804.28235-11-wens@csie.org>
References: <20161003110804.28235-1-wens@csie.org>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCMILY6JWQBBBIPYZC7QKGQELNDPRCA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20161003110804.28235-1-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The A31 SoC's codec has various inputs, outputs and microphone bias
supplies. These can be routed on the board in different ways, such as:

  - Microphones all use the MBIAS main microphone supply or one mic may
    use the HBIAS supply, which supports headset detection and buttons.

  - Line Out may be routed to an audio jack, or an onboard speaker amp
    with power controls.

Add support for specifying the audio routes in the device tree.

Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
---
 .../devicetree/bindings/sound/sun4i-codec.txt      | 35 ++++++++++++++++++++++
 sound/soc/sunxi/sun4i-codec.c                      | 21 +++++++++++--
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/sun4i-codec.txt b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
index 1d2411cea98d..893f37413943 100644
--- a/Documentation/devicetree/bindings/sound/sun4i-codec.txt
+++ b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
@@ -19,6 +19,32 @@ Required properties:
 Optional properties:
 - allwinner,pa-gpios: gpio to enable external amplifier
 
+Required properties for "allwinner,sun6i-a31-codec":
+- allwinner,audio-routing: A list of the connections between audio components.
+			   Each entry is a pair of strings, the first being the
+			   connection's sink, the second being the connection's
+			   source. Valid names include:
+
+			   Audio pins on the SoC:
+			   "HP"
+			   "LINEIN"
+			   "LINEOUT"
+			   "MIC1"
+			   "MIC2"
+			   "MIC3"
+
+			   Microphone biases from the SoC:
+			   "HBIAS"
+			   "MBIAS"
+
+			   Board connectors:
+			   "Headphone"
+			   "Headset Mic"
+			   "Line In"
+			   "Line Out"
+			   "Mic"
+			   "Speaker"
+
 Example:
 codec: codec@01c22c00 {
 	#sound-dai-cells = <0>;
@@ -29,4 +55,13 @@ codec: codec@01c22c00 {
 	clock-names = "apb", "codec";
 	dmas = <&dma 0 19>, <&dma 0 19>;
 	dma-names = "rx", "tx";
+	allwinner,pa-gpios = <&pio 7 22 GPIO_ACTIVE_HIGH>; /* PH22 */
+	allwinner,audio-routing =
+		"Headphone", "HP",
+		"Speaker", "LINEOUT",
+		"LINEIN", "Line In",
+		"MIC1",	"MBIAS",
+		"MIC1", "Mic",
+		"MIC2", "HBIAS",
+		"MIC2", "Headset Mic";
 };
diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index cd21914fd01f..4c364e6410dd 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -1133,9 +1133,19 @@ static struct snd_soc_card *sun4i_codec_create_card(struct device *dev)
 	return card;
 };
 
+static const struct snd_soc_dapm_widget sun6i_codec_card_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_LINE("Line In", NULL),
+	SND_SOC_DAPM_LINE("Line Out", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Mic", NULL),
+	SND_SOC_DAPM_SPK("Speaker", sun4i_codec_spk_event),
+};
+
 static struct snd_soc_card *sun6i_codec_create_card(struct device *dev)
 {
 	struct snd_soc_card *card;
+	int ret;
 
 	card = devm_kzalloc(dev, sizeof(*card), GFP_KERNEL);
 	if (!card)
@@ -1145,8 +1155,15 @@ static struct snd_soc_card *sun6i_codec_create_card(struct device *dev)
 	if (!card->dai_link)
 		return NULL;
 
-	card->dev	= dev;
-	card->name	= "sun4i-codec";
+	card->dev		= dev;
+	card->name		= "sun4i-codec";
+	card->dapm_widgets	= sun6i_codec_card_dapm_widgets;
+	card->num_dapm_widgets	= ARRAY_SIZE(sun6i_codec_card_dapm_widgets);
+	card->fully_routed	= true;
+
+	ret = snd_soc_of_parse_audio_routing(card, "allwinner,audio-routing");
+	if (ret)
+		dev_warn(dev, "failed to parse audio-routing: %d\n", ret);
 
 	return card;
 };
-- 
2.9.3
