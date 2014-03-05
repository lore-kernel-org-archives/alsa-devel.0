From: RongJun Ying <rjying@gmail.com>
Subject: Re: [PATCH v4-resend 1/7] ASoC: sirf: Add SiRF
 internal audio codec driver
Date: Wed, 5 Mar 2014 13:34:12 +0800
Message-ID: <CAByv0RMpvwOJcjdFBKN8YRAyP22xOARGfNh7ZRnpzu6Ufb4zjw@mail.gmail.com>
References: <1393399342-31177-1-git-send-email-rongjun.ying@csr.com>
 <1393399342-31177-2-git-send-email-rongjun.ying@csr.com>
 <20140227053339.GU9383@sirena.org.uk>
 <86130EF012BDF348AA0D464A4F449478012AE51755@SHAASIEXM01.ASIA.ROOT.PRI>
 <20140301031646.GJ29849@sirena.org.uk>
 <86130EF012BDF348AA0D464A4F449478012AE52440@SHAASIEXM01.ASIA.ROOT.PRI>
 <20140303050745.GP2411@sirena.org.uk>
 <CAGsJ_4xjCsVuySJdarevvJ5qgMxKFNyDZi_nb_Gh6+DBd4uKrQ@mail.gmail.com>
 <20140304045815.GL2411@sirena.org.uk>
 <CAByv0RPTqUrB_8ojMWKAXk8H_GChryWHuK0NW+e=-Srx2L31sA@mail.gmail.com>
 <20140305033419.GX13126@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 00F0C261A3F
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 06:34:13 +0100 (CET)
Received: by mail-qc0-f179.google.com with SMTP id m20so610242qcx.38
 for <alsa-devel@alsa-project.org>; Tue, 04 Mar 2014 21:34:13 -0800 (PST)
In-Reply-To: <20140305033419.GX13126@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Barry Song <21cnbao@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Rongjun Ying <Rongjun.Ying@csr.com>
List-Id: alsa-devel@alsa-project.org

2014-03-05 11:34 GMT+08:00 Mark Brown <broonie@kernel.org>:
> On Tue, Mar 04, 2014 at 01:11:50PM +0800, RongJun Ying wrote:
>> 2014-03-04 12:58 GMT+08:00 Mark Brown <broonie@kernel.org>:
>> > On Mon, Mar 03, 2014 at 03:48:02PM +0800, Barry Song wrote:
>
>> >> here the clock is an internal clock in the internal codec. the
>> >> external clock of audio controller is managed in system suspend/resume
>> >> as you see. but they are not managed in runtime suspend/resume here
>> >> because the external clock is always enabled to make sure the charge
>> >> pump to be working to make the board have stable current and voltage.
>> >> otherwise, touchscreen ADC will not be accurate.
>
>> > Why aren't these drivers keeping the clock enabled themselves?
>
>> The charge pump register is a part of  the audio controller.
>> But this register is impacted the touchscreen ADC stable.
>> So when the audio codec driver probe, It always enable the audio
>> controller's clock,
>> and must be set the charge pump register.
>
> I'm sorry but I just can't follow what you're talking about at all.  In
> one mail above you were talking about an external clock but here you're
> talking about the charge pump.

The SiRF internal audio system has two clocks. The one is the audio
module clock.
The I2S, internal audio and AC97 module use same clock. This clock is
managed by clock
controller. And use the clock API to enable/disable it.
       ret = clk_prepare_enable(sirf_audio_codec->clk);
....
     clk_disable_unprepare(sirf_audio_codec->clk);
This clock need keeping enabled. The reason is the charge pump need
alway set. Otherwise,
the touch ADC  is unstable.

The other clock is the internal audio codec clock. This clock is not
managed by clock controller.
Enable and disable this clock need update the audio codec's register.
When runtime resume, this clock is enabled and reset it:

+static int sirf_audio_codec_runtime_resume(struct device *dev)
+{
+       struct sirf_audio_codec *sirf_audio_codec = dev_get_drvdata(dev);
+       regmap_update_bits(sirf_audio_codec->regmap, AUDIO_IC_CODEC_CTRL1,
+               (1 << sirf_audio_codec->reg_bits->codec_clk_en_bits) |
+               (1 << sirf_audio_codec->reg_bits->por_bits),
+               (1 << sirf_audio_codec->reg_bits->codec_clk_en_bits));
+       msleep(20);
+       regmap_update_bits(sirf_audio_codec->regmap, AUDIO_IC_CODEC_CTRL1,
+               (1 << sirf_audio_codec->reg_bits->por_bits),
+               (1 << sirf_audio_codec->reg_bits->por_bits));
+       return 0;
+}

And runtime suspend, this clock is disabled:

+static int sirf_audio_codec_runtime_suspend(struct device *dev)
+{
+       struct sirf_audio_codec *sirf_audio_codec = dev_get_drvdata(dev);
+       regmap_update_bits(sirf_audio_codec->regmap, AUDIO_IC_CODEC_CTRL1,
+               (1 << sirf_audio_codec->reg_bits->codec_clk_en_bits),
+               0);
+       return 0;
+}

In v5, I use the codecclk supply to instead the runtime resume/suspend:

+static void enable_and_reset_codec(struct regmap *regmap,
+               u32 codec_enable_bits, u32 codec_reset_bits)
+{
+       regmap_update_bits(regmap, AUDIO_IC_CODEC_CTRL1,
+                       codec_enable_bits | codec_reset_bits,
+                       codec_enable_bits | ~codec_reset_bits);
+       msleep(20);
+       regmap_update_bits(regmap, AUDIO_IC_CODEC_CTRL1,
+                       codec_reset_bits, codec_reset_bits);
+}
+
+static int atlas6_codec_enable_and_reset_event(struct snd_soc_dapm_widget *w,
+               struct snd_kcontrol *kcontrol, int event)
+{
+#define ATLAS6_CODEC_ENABLE_BITS (1 << 29)
+#define ATLAS6_CODEC_RESET_BITS (1 << 28)
+       struct sirf_audio_codec *sirf_audio_codec =
dev_get_drvdata(w->codec->dev);
+       switch (event) {
+       case SND_SOC_DAPM_PRE_PMU:
+               enable_and_reset_codec(sirf_audio_codec->regmap,
+                       ATLAS6_CODEC_ENABLE_BITS, ATLAS6_CODEC_RESET_BITS);
+               break;
+       case SND_SOC_DAPM_POST_PMD:
+               regmap_update_bits(sirf_audio_codec->regmap,
+                       AUDIO_IC_CODEC_CTRL1, ATLAS6_CODEC_ENABLE_BITS,
+                       ~ATLAS6_CODEC_ENABLE_BITS);
+               break;
+       default:
+               break;
+       }
+
+       return 0;
+}
+
+static int prima2_codec_enable_and_reset_event(struct snd_soc_dapm_widget *w,
+               struct snd_kcontrol *kcontrol, int event)
+{
+#define PRIMA2_CODEC_ENABLE_BITS (1 << 27)
+#define PRIMA2_CODEC_RESET_BITS (1 << 26)
+       struct sirf_audio_codec *sirf_audio_codec =
dev_get_drvdata(w->codec->dev);
+       switch (event) {
+       case SND_SOC_DAPM_POST_PMU:
+               enable_and_reset_codec(sirf_audio_codec->regmap,
+                       PRIMA2_CODEC_ENABLE_BITS, PRIMA2_CODEC_RESET_BITS);
+               break;
+       case SND_SOC_DAPM_POST_PMD:
+               regmap_update_bits(sirf_audio_codec->regmap,
+                       AUDIO_IC_CODEC_CTRL1, PRIMA2_CODEC_ENABLE_BITS,
+                       ~PRIMA2_CODEC_ENABLE_BITS);
+               break;
+       default:
+               break;
+       }
+
+       return 0;
+}

+static const struct snd_soc_dapm_widget atlas6_codec_clock_dapm_widget =
+       SND_SOC_DAPM_SUPPLY("codecclk", SND_SOC_NOPM, 0, 0,
+                       atlas6_codec_enable_and_reset_event,
+                       SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD);
+
+static const struct snd_soc_dapm_widget prima2_codec_clock_dapm_widget =
+       SND_SOC_DAPM_SUPPLY("codecclk", SND_SOC_NOPM, 0, 0,
+                       prima2_codec_enable_and_reset_event,
+                       SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD);

Thanks
-- 
------------------------------
Rongjun Ying
