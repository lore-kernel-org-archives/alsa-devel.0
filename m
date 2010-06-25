From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [RFC 0/5] ASoC multi-component support : core
Date: Fri, 25 Jun 2010 16:51:40 +1200
Message-ID: <4C2435DC.5080509@bluewatersys.com>
References: <1277407467.3100.579.camel@odin>
	<4C23CFC0.6080700@bluewatersys.com>
	(sfid-20100624_223607_408551_609C17DE)
	<661928F7-0509-4E84-A296-0949E2D76EE3@opensource.wolfsonmicro.com>
	<4C23EC65.9080601@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hayes.bluewaternz.com (mail.bluewatersys.com [202.124.120.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 75AB810384B
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 06:51:42 +0200 (CEST)
In-Reply-To: <4C23EC65.9080601@bluewatersys.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: vbarinov <vbarinov@embeddedalley.com>, alsa-devel <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Wan ZongShun <mcuos.com@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, jassisinghbrar <jassisinghbrar@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Cliff Cai <cliff.cai@analog.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Sedji Gaouaou <sedji.gaouaou@atmel.com>, "timur.tabi@gmail.com" <timur.tabi@gmail.com>, "Candelaria Villareal, Jorge" <jorge.candelaria@ti.com>, "vaibhav.bedia" <vaibhav.bedia@ti.com>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 06/25/2010 11:38 AM, Ryan Mallon wrote:
> On 06/25/2010 11:12 AM, Mark Brown wrote:
>   
>> Do you actually see sound cards appearing? The log message at boot
>> is purely informational, cards can probe at any time.
>>
>> Define DEBUG at the top of soc-audio.c if the card never appears at all
>> then look at the log messages - they will say why the card is not being
>> instantiated.
>>   
>>     
> Hmm. If I define DEBUG at the top of sound/soc/soc-core.c I get this
> (boots fine without DEBUG, but have no sound cards):
>   

The crash was caused because I wasn't setting codec_drv in the
snd_soc_dai_link for the Snapper CL15 (updated patch below). I still
have no sound cards. I get the following in dmesg:

tlv320aic23 0-001a: probe
tlv320aic23 0-001a: codec register tlv320aic23 26
tlv320aic23 0-001a: dai register tlv320aic23 0
Registered DAI 'tlv320aic23.0'
Registered codec 'tlv320aic23.26'
i2c-core: driver [tlv320aic23] registered
ep93xx-pcm-audio ep93xx-pcm-audio: platform register ep93xx-audio -1
Registered platform 'ep93xx-audio'
ep93xx-i2s ep93xx-i2s: dai register ep93xx-i2s -1
Registered DAI 'ep93xx-i2s.-1'
soc-audio soc-audio: CODEC tlv320aic23 not registered
soc-audio soc-audio: Registered card 'Snapper CL15'
ALSA device list:
  No soundcards found.


I don't understand why the tlv320 codec is not being registered. Any ideas?

~Ryan

---
Fix build errors and warnings for ep93xx/snapper cl15 asoc
multi-component support

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 67dc876..b5261d4 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -732,9 +732,15 @@ static struct platform_device ep93xx_i2s_device = {
 	.resource	= ep93xx_i2s_resource,
 };
 
+static struct platform_device ep93xx_pcm_device = {
+	.name		= "ep93xx-pcm-audio",
+	.id		= -1,
+};
+
 void __init ep93xx_register_i2s(void)
 {
 	platform_device_register(&ep93xx_i2s_device);
+	platform_device_register(&ep93xx_pcm_device);
 }
 
 #define EP93XX_SYSCON_DEVCFG_I2S_MASK	(EP93XX_SYSCON_DEVCFG_I2SONSSP | \
@@ -798,6 +804,4 @@ void __init ep93xx_init_devices(void)
 	platform_device_register(&ep93xx_rtc_device);
 	platform_device_register(&ep93xx_ohci_device);
 	platform_device_register(&ep93xx_leds);
-	platform_device_register(&ep93xx_i2s_device);
-	platform_device_register(&ep93xx_pcm_device);
 }
diff --git a/sound/soc/ep93xx/ep93xx-i2s.c b/sound/soc/ep93xx/ep93xx-i2s.c
index b40201f..6e0fa03 100644
--- a/sound/soc/ep93xx/ep93xx-i2s.c
+++ b/sound/soc/ep93xx/ep93xx-i2s.c
@@ -146,6 +146,7 @@ static int ep93xx_i2s_startup(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct ep93xx_i2s_info *info = snd_soc_dai_get_drvdata(dai);
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 
 	snd_soc_dai_set_dma_data(cpu_dai, substream,
 				 &info->dma_params[substream->stream]);
@@ -155,7 +156,6 @@ static int ep93xx_i2s_startup(struct snd_pcm_substream *substream,
 static void ep93xx_i2s_shutdown(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct ep93xx_i2s_info *info = snd_soc_dai_get_drvdata(dai);
 
 	ep93xx_i2s_disable(info, substream->stream);
@@ -241,7 +241,6 @@ static int ep93xx_i2s_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct ep93xx_i2s_info *info = snd_soc_dai_get_drvdata(dai);
 	unsigned word_len, div, sdiv, lrdiv;
 	int found = 0, err;
diff --git a/sound/soc/ep93xx/snappercl15.c b/sound/soc/ep93xx/snappercl15.c
index 6495534..aeb822d 100644
--- a/sound/soc/ep93xx/snappercl15.c
+++ b/sound/soc/ep93xx/snappercl15.c
@@ -30,8 +30,8 @@ static int snappercl15_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int err;
 
 	err = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
@@ -77,8 +77,10 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"MICIN", NULL, "Mic Jack"},
 };
 
-static int snappercl15_tlv320aic23_init(struct snd_soc_codec *codec)
+static int snappercl15_tlv320aic23_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_codec *codec = rtd->codec;
+
 	snd_soc_dapm_new_controls(codec, tlv320aic23_dapm_widgets,
 				  ARRAY_SIZE(tlv320aic23_dapm_widgets));
 
@@ -89,24 +91,20 @@ static int snappercl15_tlv320aic23_init(struct snd_soc_codec *codec)
 static struct snd_soc_dai_link snappercl15_dai = {
 	.name		= "tlv320aic23",
 	.stream_name	= "AIC23",
-	.cpu_dai	= &ep93xx_i2s_dai,
-	.codec_dai	= &tlv320aic23_dai,
+	.cpu_dai_drv	= &ep93xx_i2s_dai,
+	.codec_dai_drv	= &tlv320aic23_dai,
+	.codec_drv	= &soc_codec_dev_tlv320aic23,
+	.platform_drv	= &ep93xx_soc_platform,
 	.init		= snappercl15_tlv320aic23_init,
 	.ops		= &snappercl15_ops,
 };
 
 static struct snd_soc_card snd_soc_snappercl15 = {
 	.name		= "Snapper CL15",
-	.platform	= &ep93xx_soc_platform,
 	.dai_link	= &snappercl15_dai,
 	.num_links	= 1,
 };
 
-static struct snd_soc_device snappercl15_snd_devdata = {
-	.card		= &snd_soc_snappercl15,
-	.codec_dev	= &soc_codec_dev_tlv320aic23,
-};
-
 static struct platform_device *snappercl15_snd_device;
 
 static int __init snappercl15_init(void)
@@ -126,8 +124,7 @@ static int __init snappercl15_init(void)
 	if (!snappercl15_snd_device)
 		return -ENOMEM;
 	
-	platform_set_drvdata(snappercl15_snd_device, &snappercl15_snd_devdata);
-	snappercl15_snd_devdata.dev = &snappercl15_snd_device->dev;
+	platform_set_drvdata(snappercl15_snd_device, &snd_soc_snappercl15);
 	ret = platform_device_add(snappercl15_snd_device);
 	if (ret)
 		platform_device_put(snappercl15_snd_device);
