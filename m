From: Caleb Crome <caleb@crome.org>
Subject: Re: [alsa-devel] System with multiple arizona (wm5102) codecs
Date: Tue, 15 Sep 2015 08:26:36 -0700
Message-ID: <CAG5mAdzKC1FuF-DXosj2RBwyo6jA_qvnjSjuCKfHgMWvQ59kag@mail.gmail.com>
References: <20150914115439.GA29646@amd> <20150914115255.GE11200@ck-lbox>
 <20150915061832.GA25442@amd> <20150915080648.GG11200@ck-lbox>
 <20150915083552.GA14780@amd> <CAG5mAdybV2U5Z9FRPy4zVF10Ws63rybSHCMCEpKQ1ArTBLnXpw@mail.gmail.com>
 <20150915140919.GE11268@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150915140919.GE11268@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, tiwai@suse.de, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

>
> Like Charles said earlier the Bells machine in mainline has multiple
> CODECs hooked up.  Speyside too.  To hook up multiple CODECs to a single
> DAI link see 88bd870f02dff5c94 (ASoC: core: Add initial support for DAI
> multicodec), sadly I don't think Benoit ever got round to submitting a
> machine.

Thanks Mark.

I've been staring at that diff for a a day or two, and I still can't
quite figure out how to use it.

I think I'm getting close:  all codecs are registered, the DAPM stuff
seems to be connected (all with prefixed names), but the card won't
open more than a 2 channel interface.

For example, when I do aplay -l, I get this:
**** List of PLAYBACK Hardware Devices ****
card 0: PUPPYAUDIO [PUPPY-AUDIO], device 0: AIC3X tlv320aic3x-hifi-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PUPPYAUDIO [PUPPY-AUDIO], device 1: AIC3X tlv320aic3x-hifi-1 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PUPPYAUDIO [PUPPY-AUDIO], device 2: AIC3X tlv320aic3x-hifi-2 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PUPPYAUDIO [PUPPY-AUDIO], device 3: AIC3X tlv320aic3x-hifi-3 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0

Each device is a 2 channel codec, so I thought I should get 8
channels. but when I try to run jackd with 8 channels, I get the
following:
# jackd  -d alsa -D -i 8 -o 8 -S -r16000
...
ALSA: cannot set channel count to 8 for capture
ALSA: cannot configure capture channel
...


So, here are the relevent bits of my patch.  Any chance you could
point out the error in my ways?

Basically, what I did was add a snd_soc_dai_link and a
snd_soc_codec_conf for each codec, and set num_links and num_configs
to the number of codecs.

Thanks

-Caleb

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 731fb0d..d2e7049 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -23,10 +23,11 @@

 #include <asm/dma.h>
 #include <asm/mach-types.h>
-
 struct snd_soc_card_drvdata_davinci {
     struct clk *mclk;
     unsigned sysclk;
+        int controls_added_already;
 };

@@ -118,11 +122,18 @@ static int evm_aic3x_init(struct snd_soc_pcm_runtime *rtd)
 {
     struct snd_soc_card *card = rtd->card;
     struct device_node *np = card->dev->of_node;
+
+    struct snd_soc_card_drvdata_davinci *drvdata =
+        snd_soc_card_get_drvdata(card);
     int ret;

     /* Add davinci-evm specific widgets */
-    snd_soc_dapm_new_controls(&card->dapm, aic3x_dapm_widgets,
-                  ARRAY_SIZE(aic3x_dapm_widgets));
+    if (!drvdata->controls_added_already) {
+        snd_soc_dapm_new_controls(&card->dapm, aic3x_dapm_widgets,
+                      ARRAY_SIZE(aic3x_dapm_widgets));
+        drvdata->controls_added_already = 1;
+    }

     if (np) {
         ret = snd_soc_of_parse_audio_routing(card, "ti,audio-routing");
@@ -330,14 +342,71 @@ static struct snd_soc_card da850_snd_soc_card = {
  * The struct is used as place holder. It will be completely
  * filled with data from dt node.
  */
-static struct snd_soc_dai_link evm_dai_tlv320aic3x = {
-    .name        = "TLV320AIC3X",
+static struct snd_soc_dai_link evm_dai_tlv320aic3x[] = {
+    {
+    .name        = "TLV320AIC3X a",
     .stream_name    = "AIC3X",
     .codec_dai_name    = "tlv320aic3x-hifi",
     .ops            = &evm_ops,
     .init           = evm_aic3x_init,
-    .dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM |
-           SND_SOC_DAIFMT_IB_NF,
+    .dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM |
SND_SOC_DAIFMT_IB_NF,
+    },
+    {
+    .name        = "TLV320AIC3X b",
+    .stream_name    = "AIC3X",
+    .codec_dai_name    = "tlv320aic3x-hifi",
+    .ops            = &evm_ops,
+    .init           = evm_aic3x_init,
+    .dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM |
SND_SOC_DAIFMT_IB_NF,
+    },
+    {
+    .name        = "TLV320AIC3X c",
+    .stream_name    = "AIC3X",
+    .codec_dai_name    = "tlv320aic3x-hifi",
+    .ops            = &evm_ops,
+    .init           = evm_aic3x_init,
+    .dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM |
SND_SOC_DAIFMT_IB_NF,
+    },
+    {
+    .name        = "TLV320AIC3X d",
+    .stream_name    = "AIC3X",
+    .codec_dai_name    = "tlv320aic3x-hifi",
+    .ops            = &evm_ops,
+    .init           = evm_aic3x_init,
+    .dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM |
SND_SOC_DAIFMT_IB_NF,
+    },
+    {
+    .name        = "TLV320AIC3X e",
+    .stream_name    = "AIC3X",
+    .codec_dai_name    = "tlv320aic3x-hifi",
+    .ops            = &evm_ops,
+    .init           = evm_aic3x_init,
+    .dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM |
SND_SOC_DAIFMT_IB_NF,
+    },
+    {
+    .name        = "TLV320AIC3X f",
+    .stream_name    = "AIC3X",
+    .codec_dai_name    = "tlv320aic3x-hifi",
+    .ops            = &evm_ops,
+    .init           = evm_aic3x_init,
+    .dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM |
SND_SOC_DAIFMT_IB_NF,
+    },
+    {
+    .name        = "TLV320AIC3X g",
+    .stream_name    = "AIC3X",
+    .codec_dai_name    = "tlv320aic3x-hifi",
+    .ops            = &evm_ops,
+    .init           = evm_aic3x_init,
+    .dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM |
SND_SOC_DAIFMT_IB_NF,
+    },
+    {
+    .name        = "TLV320AIC3X h",
+    .stream_name    = "AIC3X",
+    .codec_dai_name    = "tlv320aic3x-hifi",
+    .ops            = &evm_ops,
+    .init           = evm_aic3x_init,
+    .dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM |
SND_SOC_DAIFMT_IB_NF,
+    },
 };

 static const struct of_device_id davinci_evm_dt_ids[] = {
@@ -355,6 +424,8 @@ static struct snd_soc_card evm_soc_card = {
     .num_links = 1,
 };

+static struct snd_soc_codec_conf evm_codec_confs[16];
+
 static int davinci_evm_probe(struct platform_device *pdev)
 {
     struct device_node *np = pdev->dev.of_node;
@@ -364,18 +435,36 @@ static int davinci_evm_probe(struct platform_device *pdev)
     struct snd_soc_card_drvdata_davinci *drvdata = NULL;
     struct clk *mclk;
     int ret = 0;
+    int i;

     evm_soc_card.dai_link = dai;
-
-    dai->codec_of_node = of_parse_phandle(np, "ti,audio-codec", 0);
-    if (!dai->codec_of_node)
+
+    evm_soc_card.codec_conf = evm_codec_confs;
+
+    for (i = 0;
+         (of_parse_phandle(np, "ti,audio-codec", i) != NULL) &&
+         (i < ARRAY_SIZE(evm_dai_tlv320aic3x)-1);
+         i++) {
+        char *name_prefix = kzalloc(4, GFP_KERNEL);
+
+        dai[i].codec_of_node = of_parse_phandle(np, "ti,audio-codec", i);
+
+        if (!dai[i].codec_of_node)
         return -EINVAL;

-    dai->cpu_of_node = of_parse_phandle(np, "ti,mcasp-controller", 0);
-    if (!dai->cpu_of_node)
+        evm_codec_confs[i].of_node = dai[i].codec_of_node;
+        snprintf(name_prefix, 4, "%c", 'a'+i);
+        evm_codec_confs[i].name_prefix = name_prefix;
+
+        dai[i].cpu_of_node = of_parse_phandle(np, "ti,mcasp-controller", 0);
+        if (!dai[i].cpu_of_node)
         return -EINVAL;

-    dai->platform_of_node = dai->cpu_of_node;
+        dai[i].platform_of_node = dai[i].cpu_of_node;
+    }
+    evm_soc_card.num_configs=i;
+    evm_soc_card.num_links  =i;
+

     evm_soc_card.dev = &pdev->dev;
     ret = snd_soc_of_parse_card_name(&evm_soc_card, "ti,model");
diff --git a/arch/arm/boot/dts/am335x-boneblack.dts
b/arch/arm/boot/dts/am335x-boneblack.dts
index 6335072..19af41f 100644
--- a/arch/arm/boot/dts/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/am335x-boneblack.dts
+&i2c1 {
+    clock-frequency = <100000>;
+    status = "okay";
+    pinctrl-names = "default";
+    pinctrl-0 = <&i2c1_pins_default>;
+    status="okay";
+
+    tlv320aic3x_a: tlv320aic3x@18 {
+        compatible = "ti,tlv320aic3x";
+        reg = <0x18>;
+        tdm-offset = <0>;
+        status = "okay";
+    };
+
+    tlv320aic3x_b: tlv320aic3x@19 {
+        compatible = "ti,tlv320aic3x";
+        reg = <0x19>;
+        tdm-offset = <32>;
+        status = "okay";
+    };
+
+    tlv320aic3x_c: tlv320aic3x@1a {
+        compatible = "ti,tlv320aic3x";
+        reg = <0x1a>;
+        tdm-offset = <64>;
+        status = "okay";
+    };
+
+    tlv320aic3x_d: tlv320aic3x@1b {
+        compatible = "ti,tlv320aic3x";
+        reg = <0x1b>;
+        tdm-offset = <96>;
+        status = "okay";
+    };
+
+};
+
+&mcasp0 {
+    pinctrl-names = "default";
+    pinctrl-0 = <&mcasp_0_pins_default>;
+    status = "okay";
+
+    op-mode = <0>;          /* MCASP_IIS_MODE */
+    tdm-slots = <16>;
+    num-serializer = <16>;
+    serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
+        0 0 1 2
+        0 0 0 0
+        0 0 0 0
+        0 0 0 0
+    >;
+    tx-num-evt = <1>;
+    rx-num-evt = <1>;
 };

+
 / {
+    sound {
+        compatible = "ti,da830-evm-audio";
+        ti,model = "PUPPY-AUDIO";
+        ti,audio-codec = <
+                   &tlv320aic3x_a
+                   &tlv320aic3x_b
+                   &tlv320aic3x_c
+                   &tlv320aic3x_d
+                   >;
+        ti,mcasp-controller = <&mcasp0>;
+        ti,codec-clock-rate = <12288000>;
+        ti,audio-routing =
+            "Headphone Jack",       "a HPLOUT",
+            "Headphone Jack",       "a HPROUT",
+            "a LINE1L",               "Line In",
+            "a LINE1R",               "Line In";
+        status="okay";
+    };
 };

 &rtc {
