From: Pietro <pxpert@gmail.com>
Subject: Re: Applied "ASoC: Intel: add bytct-rt5651 machine
	driver" to the asoc tree
Date: Tue, 31 May 2016 22:11:15 +0200
Message-ID: <1680237.irs5HCh7f7@wks-pdc-gentoo>
References: <1851514.XmzcdsvJt0@wks-pdc-gentoo>
 <bd2f5937-39bf-5892-959e-ec11cf2c5dba@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id E46782657B8
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 22:11:18 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id n129so549900wmn.1
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 13:11:18 -0700 (PDT)
In-Reply-To: <bd2f5937-39bf-5892-959e-ec11cf2c5dba@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Thanks for your reply.

I've tried to change the fw from fw_sst_0f28 to fw_sst_22a8, but I got an error -16 (obviously the firmware is present :) )

Anyway I followed your suggestions and patched bytcr_rt5651.c this way:

--- bytcr_rt5651.c.old  2016-05-31 22:00:46.424790660 +0200
+++ bytcr_rt5651.c      2016-05-31 21:56:25.908502708 +0200
@@ -31,11 +31,76 @@
 #include "../../codecs/rt5651.h"
 #include "../atom/sst-atom-controls.h"
 
+#define CHT_PLAT_CLK_3_HZ       19200000
+#define CHT_CODEC_DAI_5651   "rt5651-aif1"
+
+struct cht_acpi_card {
+        char *codec_id;
+        int codec_type;
+        struct snd_soc_card *soc_card;
+};
+
+struct cht_mc_private {
+        struct snd_soc_jack jack;
+        struct cht_acpi_card *acpi_card;
+};
+--- bytcr_rt5651.c.old  2016-05-31 22:00:46.424790660 +0200
+++ bytcr_rt5651.c      2016-05-31 21:56:25.908502708 +0200
@@ -31,11 +31,76 @@
 #include "../../codecs/rt5651.h"
 #include "../atom/sst-atom-controls.h"
 
+#define CHT_PLAT_CLK_3_HZ       19200000
+#define CHT_CODEC_DAI_5651   "rt5651-aif1"
+
+struct cht_acpi_card {
+        char *codec_id;
+        int codec_type;
+        struct snd_soc_card *soc_card;
+};
+
+struct cht_mc_private {
+        struct snd_soc_jack jack;
+        struct cht_acpi_card *acpi_card;
+};
+
+
+static inline struct snd_soc_dai *cht_get_codec_dai(struct snd_soc_card *card)
+{
+        struct snd_soc_pcm_runtime *rtd;
+
+        list_for_each_entry(rtd, &card->rtd_list, list) {
+                if (!strncmp(rtd->codec_dai->name, CHT_CODEC_DAI_5651,
+                             strlen(CHT_CODEC_DAI_5651)))
+                        return rtd->codec_dai;
+        }
+        return NULL;
+}
+
+static int platform_clock_control(struct snd_soc_dapm_widget *w,
+                struct snd_kcontrol *k, int  event)
+{
+        struct snd_soc_dapm_context *dapm = w->dapm;
+        struct snd_soc_card *card = dapm->card;
+        struct snd_soc_dai *codec_dai;
+        int ret;
+
+        codec_dai = cht_get_codec_dai(card);
+        if (!codec_dai) {
+                dev_err(card->dev, "Codec dai not found; Unable to set platform clock\n");
+                return -EIO;
+        }
+
+        if (!SND_SOC_DAPM_EVENT_OFF(event))
+                return 0;
+
+        /* Set codec sysclk source to its internal clock because codec PLL will
+         * be off when idle and MCLK will also be off by ACPI when codec is
+         * runtime suspended. Codec needs clock for jack detection and button
+         * press.
+         */
+        ret = snd_soc_dai_set_sysclk(codec_dai, RT5651_SCLK_S_RCCLK,
+                        0, SND_SOC_CLOCK_IN);
+        if (ret < 0) {
+                dev_err(card->dev, "can't set codec sysclk: %d\n", ret);
+                return ret;
+        }
+
+        return 0;
+}
+
+
+
+
 static const struct snd_soc_dapm_widget byt_rt5651_widgets[] = {
        SND_SOC_DAPM_HP("Headphone", NULL),
        SND_SOC_DAPM_MIC("Headset Mic", NULL),
        SND_SOC_DAPM_MIC("Internal Mic", NULL),
        SND_SOC_DAPM_SPK("Speaker", NULL),
+        SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
+                        platform_clock_control, SND_SOC_DAPM_POST_PMD),
+
 };
 
 static const struct snd_soc_dapm_route byt_rt5651_audio_map[] = {
@@ -52,6 +117,9 @@
        {"Headphone", NULL, "HPOR"},
        {"Speaker", NULL, "LOUTL"},
        {"Speaker", NULL, "LOUTR"},
+        {"Headphone", NULL, "Platform Clock"},
+       {"Speaker", NULL, "Platform Clock"},
+
 };
 
 static const struct snd_soc_dapm_route byt_rt5651_intmic_dmic1_map[] = {
@@ -93,7 +161,15 @@
        struct snd_soc_dai *codec_dai = rtd->codec_dai;
        int ret;
 
-       snd_soc_dai_set_bclk_ratio(codec_dai, 50);
+        /* set codec PLL source to the 19.2MHz platform clock (MCLK) */
+        ret = snd_soc_dai_set_pll(codec_dai, 0, RT5651_PLL1_S_MCLK,
+                                  CHT_PLAT_CLK_3_HZ, params_rate(params) * 512);
+        if (ret < 0) {
+                dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
+                return ret;
+        }
+
+//     snd_soc_dai_set_bclk_ratio(codec_dai, 50);
 
        ret = snd_soc_dai_set_sysclk(codec_dai, RT5651_SCLK_S_PLL1,
                                     params_rate(params) * 512,
@@ -103,13 +179,13 @@
                return ret;
        }
 
-       ret = snd_soc_dai_set_pll(codec_dai, 0, RT5651_PLL1_S_BCLK1,
-                                 params_rate(params) * 50,
-                                 params_rate(params) * 512);
-       if (ret < 0) {
-               dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
-               return ret;
-       }
+//     ret = snd_soc_dai_set_pll(codec_dai, 0, RT5651_PLL1_S_BCLK1,
+//                               params_rate(params) * 50,
+//                               params_rate(params) * 512);
+//     if (ret < 0) {
+//             dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
+//             return ret;
+//     }
 
        return 0;
 }

+
+static inline struct snd_soc_dai *cht_get_codec_dai(struct snd_soc_card *card)
+{
+        struct snd_soc_pcm_runtime *rtd;
+
+        list_for_each_entry(rtd, &card->rtd_list, list) {
+                if (!strncmp(rtd->codec_dai->name, CHT_CODEC_DAI_5651,
+                             strlen(CHT_CODEC_DAI_5651)))
+                        return rtd->codec_dai;
+        }
+        return NULL;
+}
+
+static int platform_clock_control(struct snd_soc_dapm_widget *w,
+                struct snd_kcontrol *k, int  event)
+{
+        struct snd_soc_dapm_context *dapm = w->dapm;
+        struct snd_soc_card *card = dapm->card;
+        struct snd_soc_dai *codec_dai;
+        int ret;
+
+        codec_dai = cht_get_codec_dai(card);
+        if (!codec_dai) {
+                dev_err(card->dev, "Codec dai not found; Unable to set platform clock\n");
+                return -EIO;
+        }
+
+        if (!SND_SOC_DAPM_EVENT_OFF(event))
+                return 0;
+
+        /* Set codec sysclk source to its internal clock because codec PLL will
+         * be off when idle and MCLK will also be off by ACPI when codec is
+         * runtime suspended. Codec needs clock for jack detection and button
+         * press.
+         */
+        ret = snd_soc_dai_set_sysclk(codec_dai, RT5651_SCLK_S_RCCLK,
+                        0, SND_SOC_CLOCK_IN);
+        if (ret < 0) {
+                dev_err(card->dev, "can't set codec sysclk: %d\n", ret);
+                return ret;
+        }
+
+        return 0;
+}
+
+
+
+
 static const struct snd_soc_dapm_widget byt_rt5651_widgets[] = {
        SND_SOC_DAPM_HP("Headphone", NULL),
        SND_SOC_DAPM_MIC("Headset Mic", NULL),
        SND_SOC_DAPM_MIC("Internal Mic", NULL),
        SND_SOC_DAPM_SPK("Speaker", NULL),
+        SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
+                        platform_clock_control, SND_SOC_DAPM_POST_PMD),
+
 };
 
 static const struct snd_soc_dapm_route byt_rt5651_audio_map[] = {
@@ -52,6 +117,9 @@
        {"Headphone", NULL, "HPOR"},
        {"Speaker", NULL, "LOUTL"},
        {"Speaker", NULL, "LOUTR"},
+        {"Headphone", NULL, "Platform Clock"},
+       {"Speaker", NULL, "Platform Clock"},
+
 };
 
 static const struct snd_soc_dapm_route byt_rt5651_intmic_dmic1_map[] = {
@@ -93,7 +161,15 @@
        struct snd_soc_dai *codec_dai = rtd->codec_dai;
        int ret;
 
-       snd_soc_dai_set_bclk_ratio(codec_dai, 50);
+        /* set codec PLL source to the 19.2MHz platform clock (MCLK) */
+        ret = snd_soc_dai_set_pll(codec_dai, 0, RT5651_PLL1_S_MCLK,
+                                  CHT_PLAT_CLK_3_HZ, params_rate(params) * 512);
+        if (ret < 0) {
+                dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
+                return ret;
+        }
+
+//     snd_soc_dai_set_bclk_ratio(codec_dai, 50);
 
        ret = snd_soc_dai_set_sysclk(codec_dai, RT5651_SCLK_S_PLL1,
                                     params_rate(params) * 512,
@@ -103,13 +179,13 @@
                return ret;
        }
 
-       ret = snd_soc_dai_set_pll(codec_dai, 0, RT5651_PLL1_S_BCLK1,
-                                 params_rate(params) * 50,
-                                 params_rate(params) * 512);
-       if (ret < 0) {
-               dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
-               return ret;
-       }
+//     ret = snd_soc_dai_set_pll(codec_dai, 0, RT5651_PLL1_S_BCLK1,
+//                               params_rate(params) * 50,
+//                               params_rate(params) * 512);
+//     if (ret < 0) {
+//             dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
+//             return ret;
+//     }
 
        return 0;
 }


But I still have the same problem: Audio plays slowly.

It seems the DSP is clocked at 19.2, but the system is still clocked for 25, and these changes doesn't seem to have effects...


On Tuesday 31 May 2016 07:29:19 Pierre-Louis Bossart wrote:
> On 5/31/16 3:43 AM, Pietro wrote:
> > Hi,
> >
> > I'm an owner of a 2 in 1 Netbook with an Atom X5 Z8300 SoC with rt5651 codec (Cube iWork 11).
> >
> > To get audio working I Added these lines of code to the ./soc/intel/atom/sst/sst_acpi.c file:
> >
> > --- ./soc/intel/atom/sst/sst_acpi.c.old 2016-05-31 09:05:40.045682194 +0200
> > +++ ./soc/intel/atom/sst/sst_acpi.c     2016-05-31 09:07:26.829324148 +0200
> > @@ -342,9 +342,12 @@
> >                                                 &chv_platform_data },
> >         {"193C9890", "cht-bsw-max98090", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
> >                                                 &chv_platform_data },
> > +       {"10EC5651", "bytcr_rt5651", "intel/fw_sst_0f28.bin", "bytcr_rt5651", NULL,
> > +                                               &byt_rvp_platform_data },
> >         {},
> >  };
> 
> use the same as for rt5640 on cht:
> 
> /* some CHT-T platforms rely on RT5640, use Baytrail machine driver */
> {"10EC5640", "bytcr_rt5640", "intel/fw_sst_22a8.bin", "bytcr_rt5640", 
> NULL, &chv_platform_data },
> 
> >
> > +
> >  static const struct acpi_device_id sst_acpi_ids[] = {
> >         { "80860F28", (unsigned long)&sst_acpi_bytcr},
> >         { "808622A8", (unsigned long) &sst_acpi_chv},
> >
> >
> >
> >
> > Then i added the UCM files linked in these archive:
> > https://github.com/plbossart/UCM/tree/master/bytcr-rt5651
> >
> >
> >
> > With this configuration, audio seems to work, but is 'slow': Playback speed is at slow motion, and seconds move slowly (Tried with aplay and audacious with many sound files, using directly Alsa and Pulseaudio with no differencies).
> >
> > This seems to be a DSP Clock problem. Have you got any suggestions to solve this problem?
> 
> we've had this report before with rt5640 but it's unclear what might 
> cause this. the codec is configured as slave and uses the bit clock as 
> source for its PLL.
> the easiest fix in this case would be to use the 19.2 MCLK which is 
> enabled by default on CHT, see examples in cht-bsw-rt5645 (look at 
> platform clock control and everything with set_sys_clk, but keep the 2 
> slots). We will add this on baytrail as well at some point when we have 
> a clock framework driver for the MCLK control.
> 
