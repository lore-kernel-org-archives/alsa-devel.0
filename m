From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCH 3/3] ASoC: SDP3430: Connect twl4030 voice DAI
	to McBSP3
Date: Sun, 17 May 2009 20:03:40 -0500
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705F69E8125@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 03F7B1037F3
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 03:03:51 +0200 (CEST)
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4I13hPs027422
	for <alsa-devel@alsa-project.org>; Sun, 17 May 2009 20:03:48 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id n4I13hjI005017
	for <alsa-devel@alsa-project.org>; Sun, 17 May 2009 20:03:43 -0500 (CDT)
Received: from dsbe71.ent.ti.com (localhost [127.0.0.1])
	by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id n4I13hkh013640
	for <alsa-devel@alsa-project.org>; Sun, 17 May 2009 20:03:43 -0500 (CDT)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Connect twl4030 voice DAI to McBSP3 in sdp3430 machine driver.
Audio and voice DAI init functions are enabling corresponding
interface by writting directly to AUDIO_IF and VOICE_IF codec
registers, respectively.

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
---
 sound/soc/omap/sdp3430.c |   93 +++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 83 insertions(+), 10 deletions(-)

diff --git a/sound/soc/omap/sdp3430.c b/sound/soc/omap/sdp3430.c
index 1c79741..761065e 100644
--- a/sound/soc/omap/sdp3430.c
+++ b/sound/soc/omap/sdp3430.c
@@ -84,6 +84,49 @@ static struct snd_soc_ops sdp3430_ops = {
 	.hw_params = sdp3430_hw_params,
 };
 
+static int sdp3430_hw_voice_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	int ret;
+
+	/* Set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai,
+				SND_SOC_DAIFMT_DSP_A |
+				SND_SOC_DAIFMT_IB_NF |
+				SND_SOC_DAIFMT_CBS_CFM);
+	if (ret) {
+		printk(KERN_ERR "can't set codec DAI configuration\n");
+		return ret;
+	}
+
+	/* Set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai,
+				SND_SOC_DAIFMT_DSP_A |
+				SND_SOC_DAIFMT_IB_NF |
+				SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set cpu DAI configuration\n");
+		return ret;
+	}
+
+	/* Set the codec system clock for DAC and ADC */
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
+					    SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set codec system clock\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_ops sdp3430_voice_ops = {
+	.hw_params = sdp3430_hw_voice_params,
+};
+
 /* Headset jack */
 static struct snd_soc_jack hs_jack;
 
@@ -139,6 +182,7 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 static int sdp3430_twl4030_init(struct snd_soc_codec *codec)
 {
+	unsigned short reg;
 	int ret;
 
 	/* Add SDP3430 specific widgets */
@@ -150,6 +194,11 @@ static int sdp3430_twl4030_init(struct snd_soc_codec *codec)
 	/* Set up SDP3430 specific audio path audio_map */
 	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
 
+	/* Enable audio interface */
+	reg = codec->read(codec, TWL4030_REG_AUDIO_IF);
+	reg |= TWL4030_AIF_EN;
+	codec->write(codec, TWL4030_REG_AUDIO_IF, reg);
+
 	/* SDP3430 connected pins */
 	snd_soc_dapm_enable_pin(codec, "Ext Mic");
 	snd_soc_dapm_enable_pin(codec, "Ext Spk");
@@ -192,22 +241,45 @@ static int sdp3430_twl4030_init(struct snd_soc_codec *codec)
 	return ret;
 }
 
+static int sdp3430_twl4030_voice_init(struct snd_soc_codec *codec)
+{
+	unsigned short reg;
+
+	/* Enable voice interface */
+	reg = codec->read(codec, TWL4030_REG_VOICE_IF);
+	reg |= TWL4030_VIF_DIN_EN | TWL4030_VIF_DOUT_EN | TWL4030_VIF_EN;
+	codec->write(codec, TWL4030_REG_VOICE_IF, reg);
+
+	return 0;
+}
+
+
 /* Digital audio interface glue - connects codec <--> CPU */
-static struct snd_soc_dai_link sdp3430_dai = {
-	.name = "TWL4030",
-	.stream_name = "TWL4030",
-	.cpu_dai = &omap_mcbsp_dai[0],
-	.codec_dai = &twl4030_dai[TWL4030_DAI_HIFI],
-	.init = sdp3430_twl4030_init,
-	.ops = &sdp3430_ops,
+static struct snd_soc_dai_link sdp3430_dai[] = {
+	{
+		.name = "TWL4030 I2S",
+		.stream_name = "TWL4030 Audio",
+		.cpu_dai = &omap_mcbsp_dai[0],
+		.codec_dai = &twl4030_dai[TWL4030_DAI_HIFI],
+		.init = sdp3430_twl4030_init,
+		.ops = &sdp3430_ops,
+	},
+	{
+		.name = "TWL4030 PCM",
+		.stream_name = "TWL4030 Voice",
+		.cpu_dai = &omap_mcbsp_dai[1],
+		.codec_dai = &twl4030_dai[TWL4030_DAI_VOICE],
+		.init = sdp3430_twl4030_voice_init,
+		.ops = &sdp3430_voice_ops,
+	},
 };
 
 /* Audio machine driver */
 static struct snd_soc_card snd_soc_sdp3430 = {
 	.name = "SDP3430",
 	.platform = &omap_soc_platform,
-	.dai_link = &sdp3430_dai,
-	.num_links = 1,
+	.dai_link = sdp3430_dai,
+	.num_links = ARRAY_SIZE(sdp3430_dai),
 };
 
 /* Audio subsystem */
@@ -236,7 +308,8 @@ static int __init sdp3430_soc_init(void)
 
 	platform_set_drvdata(sdp3430_snd_device, &sdp3430_snd_devdata);
 	sdp3430_snd_devdata.dev = &sdp3430_snd_device->dev;
-	*(unsigned int *)sdp3430_dai.cpu_dai->private_data = 1; /* McBSP2 */
+	*(unsigned int *)sdp3430_dai[0].cpu_dai->private_data = 1; /* McBSP2 */
+	*(unsigned int *)sdp3430_dai[1].cpu_dai->private_data = 2; /* McBSP3 */
 
 	ret = platform_device_add(sdp3430_snd_device);
 	if (ret)
-- 
1.5.4.3
