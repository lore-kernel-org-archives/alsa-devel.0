From: Caleb Crome <caleb@crome.org>
Subject: Re: Imx6 i2s master driver without i2c
Date: Tue, 17 May 2016 09:51:44 -0700
Message-ID: <CAG5mAdzxC2HQY+kNMLttxjR+_Uf-g=szWiNiC9FG2C12kKBDhQ@mail.gmail.com>
References: <CABPh3UNhKMGUoiDvHn9paXVNvtpwzbzkbCwBhtSCm72jxkh3CA@mail.gmail.com>
 <CABPh3UMMvVKvHL0g52NqP-E8dpxoZHfwgR_t1WY08OFMSYt9tg@mail.gmail.com>
 <CABPh3UMJ4gOtNN3FJg0fF7Mm+Lpw0=jXGk_+ejsHaGLG9UvWAQ@mail.gmail.com>
 <CABPh3UNi79pMZPgJBisaq9Qo847MV-6riCEQ=Akt_RoLdqeVpw@mail.gmail.com>
 <CABPh3UPLR20WbV0NuYLA4RZ7XB-0+RdFrB-SpDLa0T+wOxqQ+g@mail.gmail.com>
 <CAG5mAdzJyTdsBTnz8FZ8Ay278j1bYJHHqkOTGY+_Ck9sSPhQoQ@mail.gmail.com>
 <CABPh3UN1ZoGAVF1y_5vi_DbkARfopbe5tc5SSy0HQbiYe8MERA@mail.gmail.com>
 <CAG5mAdw1erm=4RjMfP-hf1Vkw73KCWSaLbU3DtditMfsFQNRdQ@mail.gmail.com>
 <CABPh3UN2157eMxwr6i8-vPfdyr3L0DOrpVt7ChTUrPTCbCzCBA@mail.gmail.com>
 <CABPh3UNk9xa=K7QiVV3pZba7o287AyOrjufUGd1QWUxnHNHLOg@mail.gmail.com>
 <CAG5mAdyCAgtFBCbAyLVtqtLgOtCgkB9=yV+YEY8a3oeL2yJDHA@mail.gmail.com>
 <CABPh3UPzP1iFYsy_Ni1fcfimnoVDUWfdn8ht5On_mx0xN1w8Mg@mail.gmail.com>
 <CAG5mAdyceKw_H7zNfx-KTSUUMc81UiLu3feLBcB+vjjjpuhetQ@mail.gmail.com>
 <CABPh3UNPDS+4H60eeL79etF70O0-Xp2T_oNBkYL2m4g6jpeSWA@mail.gmail.com>
 <CAG5mAdw8oWy38SBzYTKi9DeCS5UzcMNjY5VsFCARp6yDb76cFg@mail.gmail.com>
 <CABPh3UOUf=wsw5uRKP3pJO+Z5CCMcdJCOyQmExCucYrK-4-84w@mail.gmail.com>
 <CABPh3UOnt9ZWYn4dA6xf0DzFdRvNY7QsSv5mzD2Z5UufU3gVhg@mail.gmail.com>
 <CAG5mAdwv0dwVgdnPoAmet9b9goQKPD31T34Owo33ES0A5KBruQ@mail.gmail.com>
 <CABPh3UNtYXG7OdgVU+aM+y5Vf-daTiaB6zTmHkg7v+6Rw+DJ0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
 [209.85.218.68])
 by alsa0.perex.cz (Postfix) with ESMTP id BF230260483
 for <alsa-devel@alsa-project.org>; Tue, 17 May 2016 18:52:04 +0200 (CEST)
Received: by mail-oi0-f68.google.com with SMTP id t140so4521561oie.0
 for <alsa-devel@alsa-project.org>; Tue, 17 May 2016 09:52:04 -0700 (PDT)
In-Reply-To: <CABPh3UNtYXG7OdgVU+aM+y5Vf-daTiaB6zTmHkg7v+6Rw+DJ0Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: nick83ola <nick83ola@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, May 17, 2016 at 7:51 AM, nick83ola <nick83ola@gmail.com> wrote:
> Ok I'm almost there

> Now I have an audio driver that works in both recording / playing
>
> The only bug that I have is this:
>
> I have this function that set the clock based on the stream properties
> i tested it with:   speaker-test -r 48000
>
> Playback device is default
> Stream parameters are 48000Hz, S16_LE, 1 channels
> Using 16 octaves of pink noise
> Rate set to 48000Hz (requested 48000Hz)
> Buffer size range from 3840 to 17280
> Period size range from 1920 to 1920
> Using max buffer size 17280
>
>
> but my function get everytime 44100 no matter what I put in -r parameter as
> playback frequency!!!!
>
> configuration rate=44100, format=2, channels=2, bclk=2822400
> fsl-ssi-dai 202c000.ssi: set tdm slots channels=2
> fsl-ssi-dai 202c000.ssi: set ssi bclk NAME=202c000.ssi
>
> what I'm missing??
>
> and the function
>
> snd_soc_dai_set_pll(cpu_dai, 0, 0, 24000000, itel_audio_fmts[i].sysclk);

>
> is correct??? I need to set pll4 frequency based on rate

I'm not terribly sure how this stuff is supposed to work, but it looks
like the clock frequency should be set in

 fsl_ssi_set_bclk
(http://lxr.free-electrons.com/source/sound/soc/fsl/fsl_ssi.c#L650)

It looks like the it can (depending on settings) call clk_set_rate.  I
really should read the docs on the clock system.  It's all a mystery
to me.  But, I suspect that'll eventually call a FSL specific clock
setter, which should automatically get to the clocks you need and set
the values you need.  I think there's a big table that describes how
all the clocks are interrelated.

I'm sure somebody else knows how this works :-)

Let me know what you discover.

-Caleb


>
> /*****************************************************************************************************************************************************
> static int imx_itel_hw_params(struct snd_pcm_substream *substream,
>                               struct snd_pcm_hw_params *params)
> {
>     struct snd_soc_pcm_runtime *rtd = substream->private_data;
>     struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>     snd_pcm_format_t format = params_format(params);
>     u32 channels = params_channels(params);
>     u32 rate     = params_rate(params);
>     u32 bclk = rate * channels * 32;
>     int ret = 0, i;
>
>     dev_info(cpu_dai->dev, "set cpu DAI configuration rate=%d, format=%d,
> channels=%d, bclk=%d\n", rate, format, channels, bclk);
>
>     /* find the correct audio parameters */
>     for (i = 0; i < ARRAY_SIZE(itel_audio_fmts); i++) {
>         if (rate == itel_audio_fmts[i].rate)
>         {
>             ret = 1;
>             break;
>         }
>     }
>     if (!ret)
>         return -EINVAL;
>
>     /* codec FLL input is 14.75 MHz from MCLK */
>     /**
>      * snd_soc_dai_set_pll - configure DAI PLL.
>      * @dai: DAI
>      * @pll_id: DAI specific PLL ID
>      * @source: DAI specific source for the PLL
>      * @freq_in: PLL input clock frequency in Hz
>      * @freq_out: requested PLL output clock frequency in Hz
>      *
>      * Configures and enables PLL to generate output clock based on input
> clock.
>      */
>     // snd_soc_dai_set_pll(struct snd_soc_dai *dai, int pll_id, int source,
> unsigned int freq_in, unsigned int freq_out);
>
>     snd_soc_dai_set_pll(cpu_dai, 0, 0, 24000000, itel_audio_fmts[i].sysclk);
>
>     /* set cpu DAI configuration */
>     ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
> SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
>     if (ret) {
>         dev_err(cpu_dai->dev, "failed to set dai fmt\n");
>         return ret;
>     }
>
>     dev_info(cpu_dai->dev, "set tdm slots channels=%d", channels);
>
>     ret = snd_soc_dai_set_tdm_slot(cpu_dai, channels == 1 ? 0xfffffffe :
> 0xfffffffc, channels == 1 ? 0xfffffffe : 0xfffffffc, 2, 32);
>     if (ret) {
>         dev_err(cpu_dai->dev, "failed to set dai tdm slot\n");
>         return ret;
>     }
>
>     dev_info(cpu_dai->dev, "set ssi bclk NAME=%s \n",cpu_dai->name);
>     /* set clock */
>     ret = snd_soc_dai_set_sysclk(cpu_dai, IMX_SSP_SYS_CLK, bclk,
> SND_SOC_CLOCK_OUT);
>     if (ret)
>         dev_err(cpu_dai->dev, "failed to set sysclk\n");
>
>     return ret;
> }
>
>
>
> 2016-05-13 21:30 GMT+02:00 Caleb Crome <caleb@crome.org>:
>>
>>
>>
>> On Fri, May 13, 2016 at 12:59 AM, nick83ola <nick83ola@gmail.com> wrote:
>>>
>>> Caleb thanks for your help!!!! the documentation is really orrible!!!!
>>>
>>> but now I'm getting something out of TXD!!!!
>>
>>
>> Wooo!
>>
>>>
>>>
>>> only no clock and very fast (I think that I need to configure the
>>> oscillator/pll and iomux???)
>>
>>
>> Right, I wish I understood how to do that.  I don't.  It's got something
>> to do with some function called 'clock' I bet :-)  Or maybe 'clk'.  Or maybe
>> in the DTS and not a function call...
>>
>>>
>>>
>>> In my kernel (3.14.28-1.0.0_ga+g91cf351) some of the statement in you dts
>>> are not supported in simple driver so I stripped down the imx-si476 driver
>>> and use with your dummy codec driver
>>
>>
>> Yeah, that's the problem with old kernels.  I try to just look towards the
>> future :-)
>>
>> I'm glad things are working, and thanks for posting your working DTS.
>> Having your DTS here may help the next guy with an old kernel.
>>
>> Cheers
>> -Caleb
>>
>>>
>>>
>>> &audmux {
>>>     pinctrl-names = "default";
>>>     pinctrl-0 = <&pinctrl_audmux_4>;
>>>     status = "okay";
>>> };
>>>
>>> &ssi2 {
>>>     assigned-clocks = <&clks IMX6QDL_CLK_SSI2_SEL>;
>>>     assigned-clock-parents = <&clks IMX6QDL_CLK_PLL4_AUDIO_DIV>;
>>>     assigned-clock-rates = <0>;
>>>     fsl,mode = "i2s-master";
>>>     status = "okay";
>>> };
>>>
>>>
>>> / {
>>>     model = "Engicam i.CoreM6 DualLite/Solo starterkit";
>>>     compatible = "fsl,imx6-icore", "fsl,imx6dl";
>>>
>>>     codec_test: codec_test {
>>>         compatible = "linux,snd-soc-dummy";
>>>         status = "okay";
>>>     };
>>>
>>>     sound {
>>>         compatible = "fsl,imx-audio-itel";
>>>         model = "imx-itel";
>>>         ssi-controller = <&ssi2>;
>>>         audio-codec = <&codec_test>;
>>>         mux-int-port = <4>;
>>>         mux-ext-port = <2>;
>>>         status = "okay";
>>>     };
>>>
>>>     sound-hdmi {
>>>         status = "disabled";
>>>     };
>>> };
>>>
>>>
>>> &iomuxc {
>>>     audmux {
>>>         pinctrl_audmux_4: audmux-4 {
>>>             fsl,pins = <
>>>                 MX6QDL_PAD_DISP0_DAT20__AUD4_TXC  0x130b0
>>>                 MX6QDL_PAD_DISP0_DAT21__AUD4_TXD 0x110b0
>>>                 MX6QDL_PAD_DISP0_DAT22__AUD4_TXFS  0x130b0
>>>                 MX6QDL_PAD_DISP0_DAT23__AUD4_RXD  0x130b0
>>>             >;
>>>         };
>>>     };
>>> };
>>>
>>>
>>> ======================================================================================================================
>>> imx-itel.c
>>>
>>> ======================================================================================================================
>>>
>>>
>>> /*
>>>  * Copyright (C) 2013 Freescale Semiconductor, Inc.
>>>  *
>>>  * The code contained herein is licensed under the GNU General Public
>>>  * License. You may obtain a copy of the GNU General Public License
>>>  * Version 2 or later at the following locations:
>>>  *
>>>  * http://www.opensource.org/licenses/gpl-license.html
>>>  * http://www.gnu.org/copyleft/gpl.html
>>>  */
>>>
>>> #define DEBUG 1
>>>
>>> #include <linux/module.h>
>>> #include <linux/of.h>
>>> #include <linux/of_platform.h>
>>> #include <linux/device.h>
>>> #include <linux/clk.h>
>>> #include <sound/core.h>
>>> #include <sound/pcm.h>
>>> #include <sound/soc.h>
>>> #include <sound/initval.h>
>>> #include <sound/pcm_params.h>
>>>
>>> #include "imx-audmux.h"
>>>
>>> struct imx_itel_data {
>>>     struct snd_soc_dai_link dai;
>>>     struct snd_soc_card card;
>>> };
>>>
>>>
>>> static int imx_audmux_config(int slave, int master)
>>> {
>>>     unsigned int ptcr, pdcr;
>>>     slave = slave - 1;
>>>     master = master - 1;
>>>
>>>     ptcr = IMX_AUDMUX_V2_PTCR_SYN |
>>>         IMX_AUDMUX_V2_PTCR_TFSDIR |
>>>         IMX_AUDMUX_V2_PTCR_TFSEL(slave) |
>>>         IMX_AUDMUX_V2_PTCR_TCLKDIR |
>>>         IMX_AUDMUX_V2_PTCR_TCSEL(slave);
>>>     pdcr = IMX_AUDMUX_V2_PDCR_RXDSEL(slave);
>>>
>>>     imx_audmux_v2_configure_port(master, ptcr, pdcr);
>>>
>>>     /*
>>>      * According to RM, RCLKDIR and SYN should not be changed at same
>>> time.
>>>      * So separate to two step for configuring this port.
>>>      */
>>>     ptcr |= IMX_AUDMUX_V2_PTCR_RFSDIR |
>>>         IMX_AUDMUX_V2_PTCR_RFSEL(slave) |
>>>         IMX_AUDMUX_V2_PTCR_RCLKDIR |
>>>         IMX_AUDMUX_V2_PTCR_RCSEL(slave);
>>>     imx_audmux_v2_configure_port(master, ptcr, pdcr);
>>>
>>>     printk(KERN_ERR "--> ITEL imx-audmux-confic ext-port port=%#010x
>>> ptcr=%#010x pdcr=%#010x\n", master, ptcr, pdcr);
>>>
>>>     ptcr = IMX_AUDMUX_V2_PTCR_SYN;
>>>     pdcr = IMX_AUDMUX_V2_PDCR_RXDSEL(master);
>>>
>>>     printk(KERN_ERR "--> ITEL imx-audmux-config int-port port=%#010x
>>> ptcr=%#010x pdcr=%#010x\n", master, ptcr, pdcr);
>>>     imx_audmux_v2_configure_port(slave, ptcr, pdcr);
>>>
>>>     return 0;
>>> }
>>>
>>>
>>> static int imx_itel_hw_params(struct snd_pcm_substream *substream,
>>>                               struct snd_pcm_hw_params *params)
>>> {
>>>     struct snd_soc_pcm_runtime *rtd = substream->private_data;
>>>     struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>>>     u32 channels = params_channels(params);
>>>     u32 rate = params_rate(params);
>>>     u32 bclk = rate * channels * 32;
>>>     int ret = 0;
>>>
>>>     printk(KERN_ERR "--> ITEL imx-itel-hw-params NAME=%s  \n VALUE=%#010x
>>> "
>>>                         "SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
>>> SND_SOC_DAIFMT_CBS_CFS\n",
>>>                         cpu_dai->name,
>>>                         (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
>>> SND_SOC_DAIFMT_CBS_CFS));
>>>
>>>     /* set cpu DAI configuration */
>>>     ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S
>>>             | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
>>>     if (ret) {
>>>         dev_err(cpu_dai->dev, "failed to set dai fmt\n");
>>>         return ret;
>>>     }
>>>     printk(KERN_ERR "--> ITEL imx-itel-hw-params set tdm slots
>>> channels=%d", channels);
>>>
>>>     ret = snd_soc_dai_set_tdm_slot(cpu_dai,
>>>             channels == 1 ? 0xfffffffe : 0xfffffffc,
>>>             channels == 1 ? 0xfffffffe : 0xfffffffc,
>>>             2, 32);
>>>     if (ret) {
>>>         dev_err(cpu_dai->dev, "failed to set dai tdm slot\n");
>>>         return ret;
>>>     }
>>>
>>>     printk(KERN_ERR "--> ITEL imx-audmux-config set sysclk NAME=%s
>>> \n",cpu_dai->name);
>>>
>>>     ret = snd_soc_dai_set_sysclk(cpu_dai, 0, bclk, SND_SOC_CLOCK_OUT);
>>>     if (ret)
>>>         dev_err(cpu_dai->dev, "failed to set sysclk\n");
>>>
>>>     return ret;
>>> }
>>>
>>>
>>> static struct snd_soc_ops imx_itel_ops = {
>>>     .hw_params = imx_itel_hw_params,
>>> };
>>>
>>>
>>> static struct snd_soc_dai_link imx_itel_dai[] = {
>>>     {
>>>         .name            = "Hifi",
>>>         .stream_name     = "Hifi",
>>>         .codec_dai_name     = "snd-soc-dummy-dai",
>>>         //.codec_name         = "snd-soc-dummy",
>>>         .ops             = &imx_itel_ops,
>>>         // .symmetric_rates = 1,
>>>     },
>>> };
>>>
>>> static struct snd_soc_card snd_soc_card_imx_itel = {
>>>     .name       = "imx-audio-itel",
>>>     .dai_link   = imx_itel_dai,
>>>     .num_links    = ARRAY_SIZE(imx_itel_dai),
>>>     .owner      = THIS_MODULE,
>>> };
>>>
>>>
>>> static int imx_itel_probe(struct platform_device *pdev)
>>> {
>>>     struct snd_soc_card *card = &snd_soc_card_imx_itel;
>>>     struct device_node *ssi_np;
>>>     struct platform_device *ssi_pdev;
>>>     struct device_node *codec_np;
>>>     // struct imx_itel_data *data = NULL;
>>>     int int_port, ext_port, ret;
>>>
>>>     printk(KERN_ERR "--> ITEL imx_itel_probe");
>>>
>>>     ret = of_property_read_u32(pdev->dev.of_node, "mux-int-port",
>>> &int_port);
>>>     if (ret) {
>>>         dev_err(&pdev->dev, "mux-int-port missing or invalid\n");
>>>         return ret;
>>>     }
>>>
>>>
>>>     ret = of_property_read_u32(pdev->dev.of_node, "mux-ext-port",
>>> &ext_port);
>>>     if (ret) {
>>>         dev_err(&pdev->dev, "mux-ext-port missing or invalid\n");
>>>         return ret;
>>>     }
>>>
>>>     printk(KERN_ERR "--> ITEL Configuro audmux\n");
>>>     imx_audmux_config(int_port, ext_port);
>>>
>>>     /* find value in devicetree for ssi controller */
>>>     ssi_np = of_parse_phandle(pdev->dev.of_node, "ssi-controller", 0);
>>>     if (!ssi_np) {
>>>         dev_err(&pdev->dev, "ssi-controller missing or invalid\n");
>>>         ret = -EINVAL;
>>>         goto fail;
>>>     }
>>>
>>>     /* find SSI platform driver */
>>>     ssi_pdev = of_find_device_by_node(ssi_np);
>>>     if (!ssi_pdev) {
>>>         dev_err(&pdev->dev, "failed to find SSI platform device\n");
>>>         ret = -EPROBE_DEFER;
>>>         goto fail;
>>>     }
>>>
>>>     codec_np = of_parse_phandle(pdev->dev.of_node, "audio-codec", 0);
>>>     if (!codec_np) {
>>>         dev_err(&pdev->dev, "codec missing or invalid\n");
>>>         ret = -EINVAL;
>>>         goto fail;
>>>     }
>>>
>>>     // codec_dev = NULL;
>>>
>>>     card->dev = &pdev->dev;
>>>     card->dai_link->cpu_dai_name = dev_name(&ssi_pdev->dev);
>>>     card->dai_link->platform_of_node = ssi_np;
>>>     card->dai_link->codec_of_node = codec_np;
>>>
>>>     platform_set_drvdata(pdev, card);
>>>     snd_soc_card_set_drvdata(card, &snd_soc_card_imx_itel);
>>>
>>>     printk(KERN_ERR "--> ITEL imx-probe registro card\n");
>>>
>>>     ret = snd_soc_register_card(card);
>>>     if (ret) {
>>>         dev_err(&pdev->dev, "Failed to register card: %d\n", ret);
>>>         goto fail;
>>>     }
>>>
>>>     printk(KERN_ERR "--> ITEL imx-probe of ssi\n");
>>>     of_node_put(ssi_np);
>>>     printk(KERN_ERR "--> ITEL imx-probe of codec\n");
>>>     of_node_put(codec_np);
>>>
>>>     return 0;
>>>
>>> fail:
>>>     if (ssi_np)
>>>         of_node_put(ssi_np);
>>>     if (codec_np)
>>>         of_node_put(codec_np);
>>>
>>>     return ret;
>>> }
>>>
>>> static int imx_itel_remove(struct platform_device *pdev)
>>> {
>>>     struct snd_soc_card *card = &snd_soc_card_imx_itel;
>>>
>>>     snd_soc_unregister_card(card);
>>>
>>>     return 0;
>>> }
>>>
>>> static const struct of_device_id imx_itel_dt_ids[] = {
>>>     { .compatible = "fsl,imx-audio-itel", },
>>>     { /* sentinel */ }
>>> };
>>> MODULE_DEVICE_TABLE(of, imx_itel_dt_ids);
>>>
>>> static struct platform_driver imx_itel_driver = {
>>>     .driver = {
>>>         .name = "imx-itel",
>>>         .owner = THIS_MODULE,
>>>         .pm = &snd_soc_pm_ops,
>>>         .of_match_table = imx_itel_dt_ids,
>>>     },
>>>     .probe = imx_itel_probe,
>>>     .remove = imx_itel_remove,
>>> };
>>>
>>> module_platform_driver(imx_itel_driver);
>>>
>>> MODULE_AUTHOR("Nicola Lunghi");
>>> MODULE_DESCRIPTION("ITEL I2S Platform Driver");
>>> MODULE_LICENSE("GPL v2");
>>> MODULE_ALIAS("platform:imx-itel");
>>>
>>> 2016-05-12 9:55 GMT+02:00 nick83ola <nick83ola@gmail.com>:
>>>>
>>>> I am using ssi1 because I have an example of setting master mode on
>>>> sabre board dts
>>>>
>>>> I have a problem with iomux/pinctrl  I think because
>>>>
>>>> root@icorem6solo:/sys/kernel/debug/pinctrl/20e0000.iomuxc# cat
>>>> pinmux-pins |grep audmux
>>>> pin 57 (MX6DL_PAD_DISP0_DAT20): 2028000.ssi (GPIO UNCLAIMED) function
>>>> audmux group audmux-4
>>>> pin 58 (MX6DL_PAD_DISP0_DAT21): 2028000.ssi (GPIO UNCLAIMED) function
>>>> audmux group audmux-4
>>>> pin 59 (MX6DL_PAD_DISP0_DAT22): 2028000.ssi (GPIO UNCLAIMED) function
>>>> audmux group audmux-4
>>>> pin 60 (MX6DL_PAD_DISP0_DAT23): 2028000.ssi (GPIO UNCLAIMED) function
>>>> audmux group audmux-4
>>>>
>>>> says: GPIO_UNCLAIMED? it is correct??
>>>>
>>>> /sys/kernel/debug/pinctrl/20e0000.iomuxc# cat pinconf-groups |grep -A 1
>>>> audmux
>>>> 1 (audmux-1):
>>>> MX6DL_PAD_SD2_DAT0: 0x17070MX6DL_PAD_SD2_DAT3:
>>>> 0x17070MX6DL_PAD_SD2_DAT2: 0x17070MX6DL_PAD_SD2_DAT1: 0x17070
>>>> 2 (audmux-2):
>>>> MX6DL_PAD_CSI0_DAT7: 0x1b0b0MX6DL_PAD_CSI0_DAT4:
>>>> 0x1b0b0MX6DL_PAD_CSI0_DAT5: 0x1b0b0MX6DL_PAD_CSI0_DAT6: 0x1b0b0
>>>> 3 (audmux-3):
>>>> MX6DL_PAD_DISP0_DAT16: 0x10MX6DL_PAD_DISP0_DAT18:
>>>> 0x1b0b0MX6DL_PAD_DISP0_DAT19: 0x1b0b0
>>>> 4 (audmux-4):
>>>> MX6DL_PAD_DISP0_DAT20: 0x130b0MX6DL_PAD_DISP0_DAT21:
>>>> 0x110b0MX6DL_PAD_DISP0_DAT22: 0x130b0MX6DL_PAD_DISP0_DAT23: 0x130b0
>>>>
>>>> 0x130b0?
>>>>
>>>> audmux# cat ssi0
>>>>     PDCR: 0000a000
>>>>     PTCR: ad400800
>>>>     TxFS output from SSI6, TxClk output from SSI6
>>>>     Port is symmetric
>>>>     Data received from SSI6
>>>> root@icorem6solo:/sys/kernel/debug/audmux# cat ssi1
>>>>     PDCR: 00008000
>>>>     PTCR: 00000800
>>>>     TxFS input, TxClk input
>>>>     Port is symmetric
>>>>     Data received from SSI5
>>>> root@icorem6solo:/sys/kernel/debug/audmux# cat ssi2
>>>>     PDCR: 00006000
>>>>     PTCR: 9cc00800
>>>>     TxFS output from SSI4, TxClk output from SSI4
>>>>     Port is symmetric
>>>>     Data received from SSI4
>>>> root@icorem6solo:/sys/kernel/debug/audmux# cat ssi3
>>>>     PDCR: 00004000
>>>>     PTCR: 00000800
>>>>     TxFS input, TxClk input
>>>>     Port is symmetric
>>>>     Data received from SSI3
>>>> root@icorem6solo:/sys/kernel/debug/audmux# cat ssi4
>>>>     PDCR: 00002000
>>>>     PTCR: 8c400800
>>>>     TxFS output from imx-ssi.1, TxClk output from imx-ssi.1
>>>>     Port is symmetric
>>>>     Data received from imx-ssi.1
>>>> root@icorem6solo:/sys/kernel/debug/audmux# cat ssi5
>>>>     PDCR: 00000000
>>>>     PTCR: 00000800
>>>>     TxFS input, TxClk input
>>>>     Port is symmetric
>>>>     Data received from imx-ssi.0
>>>> root@icorem6solo:/sys/kernel/debug/audmux# cat ssi6
>>>>     PDCR: 0000c000
>>>>     PTCR: 00000800
>>>>     TxFS input, TxClk input
>>>>     Port is symmetric
>>>>     Data received from UNKNOWN
>>>>
>>>>
>>>
>>>
>>>
>>> --
>>>
>>> P.S. Le informazioni trasmesse attraverso la presente comunicazione sono
>>> di esclusiva
>>> spettanza dell'effettivo destinatario. Nel caso in cui le stesse
>>> raggiungessero, per
>>> qualunque motivo, soggetti non interessati, questi ultimi vorranno darne
>>> immediata
>>> notizia al mittente. In ogni caso, eventuali soggetti diversi dai
>>> legittimi destinatari
>>> della presente comunicazione e dei dati contenuti negli allegati, possono
>>> essere
>>> sanzionati ai sensi del T.U. sul trattamento dei dati personali d.lgs.
>>> 196/2003, sia ai
>>> sensi dell'art. 616 del Codice Penale che disciplina la violazione del
>>> segreto sulla
>>> corrispondenza.
>>
>>
>
>
>
> --
>
> P.S. Le informazioni trasmesse attraverso la presente comunicazione sono di
> esclusiva
> spettanza dell'effettivo destinatario. Nel caso in cui le stesse
> raggiungessero, per
> qualunque motivo, soggetti non interessati, questi ultimi vorranno darne
> immediata
> notizia al mittente. In ogni caso, eventuali soggetti diversi dai legittimi
> destinatari
> della presente comunicazione e dei dati contenuti negli allegati, possono
> essere
> sanzionati ai sensi del T.U. sul trattamento dei dati personali d.lgs.
> 196/2003, sia ai
> sensi dell'art. 616 del Codice Penale che disciplina la violazione del
> segreto sulla
> corrispondenza.
