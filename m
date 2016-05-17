From: nick83ola <nick83ola@gmail.com>
Subject: Re: Imx6 i2s master driver without i2c
Date: Tue, 17 May 2016 16:51:38 +0200
Message-ID: <CABPh3UNtYXG7OdgVU+aM+y5Vf-daTiaB6zTmHkg7v+6Rw+DJ0Q@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=047d7b3a83960e13f405330ae23a
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f195.google.com (mail-lb0-f195.google.com
 [209.85.217.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 93D67265DAA
 for <alsa-devel@alsa-project.org>; Tue, 17 May 2016 16:51:59 +0200 (CEST)
Received: by mail-lb0-f195.google.com with SMTP id qf3so1160788lbb.0
 for <alsa-devel@alsa-project.org>; Tue, 17 May 2016 07:51:59 -0700 (PDT)
In-Reply-To: <CAG5mAdwv0dwVgdnPoAmet9b9goQKPD31T34Owo33ES0A5KBruQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--047d7b3a83960e13f405330ae23a
Content-Type: text/plain; charset=UTF-8

Ok I'm almost there

Now I have an audio driver that works in both recording / playing

The only bug that I have is this:

I have this function that set the clock based on the stream properties
i tested it with:   speaker-test -r 48000

Playback device is default
Stream parameters are 48000Hz, S16_LE, 1 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 3840 to 17280
Period size range from 1920 to 1920
Using max buffer size 17280


but my function get everytime 44100 no matter what I put in -r parameter as
playback frequency!!!!

configuration rate=44100, format=2, channels=2, bclk=2822400
fsl-ssi-dai 202c000.ssi: set tdm slots channels=2
fsl-ssi-dai 202c000.ssi: set ssi bclk NAME=202c000.ssi

what I'm missing??

and the function

snd_soc_dai_set_pll(cpu_dai, 0, 0, 24000000, itel_audio_fmts[i].sysclk);

is correct??? I need to set pll4 frequency based on rate

/*****************************************************************************************************************************************************
static int imx_itel_hw_params(struct snd_pcm_substream *substream,
                              struct snd_pcm_hw_params *params)
{
    struct snd_soc_pcm_runtime *rtd = substream->private_data;
    struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
    snd_pcm_format_t format = params_format(params);
    u32 channels = params_channels(params);
    u32 rate     = params_rate(params);
    u32 bclk = rate * channels * 32;
    int ret = 0, i;

    dev_info(cpu_dai->dev, "set cpu DAI configuration rate=%d, format=%d,
channels=%d, bclk=%d\n", rate, format, channels, bclk);

    /* find the correct audio parameters */
    for (i = 0; i < ARRAY_SIZE(itel_audio_fmts); i++) {
        if (rate == itel_audio_fmts[i].rate)
        {
            ret = 1;
            break;
        }
    }
    if (!ret)
        return -EINVAL;

    /* codec FLL input is 14.75 MHz from MCLK */
    /**
     * snd_soc_dai_set_pll - configure DAI PLL.
     * @dai: DAI
     * @pll_id: DAI specific PLL ID
     * @source: DAI specific source for the PLL
     * @freq_in: PLL input clock frequency in Hz
     * @freq_out: requested PLL output clock frequency in Hz
     *
     * Configures and enables PLL to generate output clock based on input
clock.
     */
    // snd_soc_dai_set_pll(struct snd_soc_dai *dai, int pll_id, int source,
unsigned int freq_in, unsigned int freq_out);

    snd_soc_dai_set_pll(cpu_dai, 0, 0, 24000000, itel_audio_fmts[i].sysclk);

    /* set cpu DAI configuration */
    ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
    if (ret) {
        dev_err(cpu_dai->dev, "failed to set dai fmt\n");
        return ret;
    }

    dev_info(cpu_dai->dev, "set tdm slots channels=%d", channels);

    ret = snd_soc_dai_set_tdm_slot(cpu_dai, channels == 1 ? 0xfffffffe :
0xfffffffc, channels == 1 ? 0xfffffffe : 0xfffffffc, 2, 32);
    if (ret) {
        dev_err(cpu_dai->dev, "failed to set dai tdm slot\n");
        return ret;
    }

    dev_info(cpu_dai->dev, "set ssi bclk NAME=%s \n",cpu_dai->name);
    /* set clock */
    ret = snd_soc_dai_set_sysclk(cpu_dai, IMX_SSP_SYS_CLK, bclk,
SND_SOC_CLOCK_OUT);
    if (ret)
        dev_err(cpu_dai->dev, "failed to set sysclk\n");

    return ret;
}



2016-05-13 21:30 GMT+02:00 Caleb Crome <caleb@crome.org>:

>
>
> On Fri, May 13, 2016 at 12:59 AM, nick83ola <nick83ola@gmail.com> wrote:
>
>> Caleb thanks for your help!!!! the documentation is really orrible!!!!
>>
>> but now I'm getting something out of TXD!!!!
>>
>
> Wooo!
>
>
>>
>> only no clock and very fast (I think that I need to configure the
>> oscillator/pll and iomux???)
>>
>
> Right, I wish I understood how to do that.  I don't.  It's got something
> to do with some function called 'clock' I bet :-)  Or maybe 'clk'.  Or
> maybe in the DTS and not a function call...
>
>
>>
>> In my kernel (3.14.28-1.0.0_ga+g91cf351) some of the statement in you dts
>> are not supported in simple driver so I stripped down the imx-si476 driver
>> and use with your dummy codec driver
>>
>
> Yeah, that's the problem with old kernels.  I try to just look towards the
> future :-)
>
> I'm glad things are working, and thanks for posting your working DTS.
> Having your DTS here may help the next guy with an old kernel.
>
> Cheers
> -Caleb
>
>
>>
>> &audmux {
>>     pinctrl-names = "default";
>>     pinctrl-0 = <&pinctrl_audmux_4>;
>>     status = "okay";
>> };
>>
>> &ssi2 {
>>     assigned-clocks = <&clks IMX6QDL_CLK_SSI2_SEL>;
>>     assigned-clock-parents = <&clks IMX6QDL_CLK_PLL4_AUDIO_DIV>;
>>     assigned-clock-rates = <0>;
>>     fsl,mode = "i2s-master";
>>     status = "okay";
>> };
>>
>>
>> / {
>>     model = "Engicam i.CoreM6 DualLite/Solo starterkit";
>>     compatible = "fsl,imx6-icore", "fsl,imx6dl";
>>
>>     codec_test: codec_test {
>>         compatible = "linux,snd-soc-dummy";
>>         status = "okay";
>>     };
>>
>>     sound {
>>         compatible = "fsl,imx-audio-itel";
>>         model = "imx-itel";
>>         ssi-controller = <&ssi2>;
>>         audio-codec = <&codec_test>;
>>         mux-int-port = <4>;
>>         mux-ext-port = <2>;
>>         status = "okay";
>>     };
>>
>>     sound-hdmi {
>>         status = "disabled";
>>     };
>> };
>>
>>
>> &iomuxc {
>>     audmux {
>>         pinctrl_audmux_4: audmux-4 {
>>             fsl,pins = <
>>                 MX6QDL_PAD_DISP0_DAT20__AUD4_TXC  0x130b0
>>                 MX6QDL_PAD_DISP0_DAT21__AUD4_TXD 0x110b0
>>                 MX6QDL_PAD_DISP0_DAT22__AUD4_TXFS  0x130b0
>>                 MX6QDL_PAD_DISP0_DAT23__AUD4_RXD  0x130b0
>>             >;
>>         };
>>     };
>> };
>>
>>
>> ======================================================================================================================
>> imx-itel.c
>>
>> ======================================================================================================================
>>
>>
>> /*
>>  * Copyright (C) 2013 Freescale Semiconductor, Inc.
>>  *
>>  * The code contained herein is licensed under the GNU General Public
>>  * License. You may obtain a copy of the GNU General Public License
>>  * Version 2 or later at the following locations:
>>  *
>>  * http://www.opensource.org/licenses/gpl-license.html
>>  * http://www.gnu.org/copyleft/gpl.html
>>  */
>>
>> #define DEBUG 1
>>
>> #include <linux/module.h>
>> #include <linux/of.h>
>> #include <linux/of_platform.h>
>> #include <linux/device.h>
>> #include <linux/clk.h>
>> #include <sound/core.h>
>> #include <sound/pcm.h>
>> #include <sound/soc.h>
>> #include <sound/initval.h>
>> #include <sound/pcm_params.h>
>>
>> #include "imx-audmux.h"
>>
>> struct imx_itel_data {
>>     struct snd_soc_dai_link dai;
>>     struct snd_soc_card card;
>> };
>>
>>
>> static int imx_audmux_config(int slave, int master)
>> {
>>     unsigned int ptcr, pdcr;
>>     slave = slave - 1;
>>     master = master - 1;
>>
>>     ptcr = IMX_AUDMUX_V2_PTCR_SYN |
>>         IMX_AUDMUX_V2_PTCR_TFSDIR |
>>         IMX_AUDMUX_V2_PTCR_TFSEL(slave) |
>>         IMX_AUDMUX_V2_PTCR_TCLKDIR |
>>         IMX_AUDMUX_V2_PTCR_TCSEL(slave);
>>     pdcr = IMX_AUDMUX_V2_PDCR_RXDSEL(slave);
>>
>>     imx_audmux_v2_configure_port(master, ptcr, pdcr);
>>
>>     /*
>>      * According to RM, RCLKDIR and SYN should not be changed at same
>> time.
>>      * So separate to two step for configuring this port.
>>      */
>>     ptcr |= IMX_AUDMUX_V2_PTCR_RFSDIR |
>>         IMX_AUDMUX_V2_PTCR_RFSEL(slave) |
>>         IMX_AUDMUX_V2_PTCR_RCLKDIR |
>>         IMX_AUDMUX_V2_PTCR_RCSEL(slave);
>>     imx_audmux_v2_configure_port(master, ptcr, pdcr);
>>
>>     printk(KERN_ERR "--> ITEL imx-audmux-confic ext-port port=%#010x
>> ptcr=%#010x pdcr=%#010x\n", master, ptcr, pdcr);
>>
>>     ptcr = IMX_AUDMUX_V2_PTCR_SYN;
>>     pdcr = IMX_AUDMUX_V2_PDCR_RXDSEL(master);
>>
>>     printk(KERN_ERR "--> ITEL imx-audmux-config int-port port=%#010x
>> ptcr=%#010x pdcr=%#010x\n", master, ptcr, pdcr);
>>     imx_audmux_v2_configure_port(slave, ptcr, pdcr);
>>
>>     return 0;
>> }
>>
>>
>> static int imx_itel_hw_params(struct snd_pcm_substream *substream,
>>                               struct snd_pcm_hw_params *params)
>> {
>>     struct snd_soc_pcm_runtime *rtd = substream->private_data;
>>     struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>>     u32 channels = params_channels(params);
>>     u32 rate = params_rate(params);
>>     u32 bclk = rate * channels * 32;
>>     int ret = 0;
>>
>>     printk(KERN_ERR "--> ITEL imx-itel-hw-params NAME=%s  \n
>> VALUE=%#010x  "
>>                         "SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
>> SND_SOC_DAIFMT_CBS_CFS\n",
>>                         cpu_dai->name,
>>                         (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
>> SND_SOC_DAIFMT_CBS_CFS));
>>
>>     /* set cpu DAI configuration */
>>     ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S
>>             | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
>>     if (ret) {
>>         dev_err(cpu_dai->dev, "failed to set dai fmt\n");
>>         return ret;
>>     }
>>     printk(KERN_ERR "--> ITEL imx-itel-hw-params set tdm slots
>> channels=%d", channels);
>>
>>     ret = snd_soc_dai_set_tdm_slot(cpu_dai,
>>             channels == 1 ? 0xfffffffe : 0xfffffffc,
>>             channels == 1 ? 0xfffffffe : 0xfffffffc,
>>             2, 32);
>>     if (ret) {
>>         dev_err(cpu_dai->dev, "failed to set dai tdm slot\n");
>>         return ret;
>>     }
>>
>>     printk(KERN_ERR "--> ITEL imx-audmux-config set sysclk NAME=%s
>> \n",cpu_dai->name);
>>
>>     ret = snd_soc_dai_set_sysclk(cpu_dai, 0, bclk, SND_SOC_CLOCK_OUT);
>>     if (ret)
>>         dev_err(cpu_dai->dev, "failed to set sysclk\n");
>>
>>     return ret;
>> }
>>
>>
>> static struct snd_soc_ops imx_itel_ops = {
>>     .hw_params = imx_itel_hw_params,
>> };
>>
>>
>> static struct snd_soc_dai_link imx_itel_dai[] = {
>>     {
>>         .name            = "Hifi",
>>         .stream_name     = "Hifi",
>>         .codec_dai_name     = "snd-soc-dummy-dai",
>>         //.codec_name         = "snd-soc-dummy",
>>         .ops             = &imx_itel_ops,
>>         // .symmetric_rates = 1,
>>     },
>> };
>>
>> static struct snd_soc_card snd_soc_card_imx_itel = {
>>     .name       = "imx-audio-itel",
>>     .dai_link   = imx_itel_dai,
>>     .num_links    = ARRAY_SIZE(imx_itel_dai),
>>     .owner      = THIS_MODULE,
>> };
>>
>>
>> static int imx_itel_probe(struct platform_device *pdev)
>> {
>>     struct snd_soc_card *card = &snd_soc_card_imx_itel;
>>     struct device_node *ssi_np;
>>     struct platform_device *ssi_pdev;
>>     struct device_node *codec_np;
>>     // struct imx_itel_data *data = NULL;
>>     int int_port, ext_port, ret;
>>
>>     printk(KERN_ERR "--> ITEL imx_itel_probe");
>>
>>     ret = of_property_read_u32(pdev->dev.of_node, "mux-int-port",
>> &int_port);
>>     if (ret) {
>>         dev_err(&pdev->dev, "mux-int-port missing or invalid\n");
>>         return ret;
>>     }
>>
>>
>>     ret = of_property_read_u32(pdev->dev.of_node, "mux-ext-port",
>> &ext_port);
>>     if (ret) {
>>         dev_err(&pdev->dev, "mux-ext-port missing or invalid\n");
>>         return ret;
>>     }
>>
>>     printk(KERN_ERR "--> ITEL Configuro audmux\n");
>>     imx_audmux_config(int_port, ext_port);
>>
>>     /* find value in devicetree for ssi controller */
>>     ssi_np = of_parse_phandle(pdev->dev.of_node, "ssi-controller", 0);
>>     if (!ssi_np) {
>>         dev_err(&pdev->dev, "ssi-controller missing or invalid\n");
>>         ret = -EINVAL;
>>         goto fail;
>>     }
>>
>>     /* find SSI platform driver */
>>     ssi_pdev = of_find_device_by_node(ssi_np);
>>     if (!ssi_pdev) {
>>         dev_err(&pdev->dev, "failed to find SSI platform device\n");
>>         ret = -EPROBE_DEFER;
>>         goto fail;
>>     }
>>
>>     codec_np = of_parse_phandle(pdev->dev.of_node, "audio-codec", 0);
>>     if (!codec_np) {
>>         dev_err(&pdev->dev, "codec missing or invalid\n");
>>         ret = -EINVAL;
>>         goto fail;
>>     }
>>
>>     // codec_dev = NULL;
>>
>>     card->dev = &pdev->dev;
>>     card->dai_link->cpu_dai_name = dev_name(&ssi_pdev->dev);
>>     card->dai_link->platform_of_node = ssi_np;
>>     card->dai_link->codec_of_node = codec_np;
>>
>>     platform_set_drvdata(pdev, card);
>>     snd_soc_card_set_drvdata(card, &snd_soc_card_imx_itel);
>>
>>     printk(KERN_ERR "--> ITEL imx-probe registro card\n");
>>
>>     ret = snd_soc_register_card(card);
>>     if (ret) {
>>         dev_err(&pdev->dev, "Failed to register card: %d\n", ret);
>>         goto fail;
>>     }
>>
>>     printk(KERN_ERR "--> ITEL imx-probe of ssi\n");
>>     of_node_put(ssi_np);
>>     printk(KERN_ERR "--> ITEL imx-probe of codec\n");
>>     of_node_put(codec_np);
>>
>>     return 0;
>>
>> fail:
>>     if (ssi_np)
>>         of_node_put(ssi_np);
>>     if (codec_np)
>>         of_node_put(codec_np);
>>
>>     return ret;
>> }
>>
>> static int imx_itel_remove(struct platform_device *pdev)
>> {
>>     struct snd_soc_card *card = &snd_soc_card_imx_itel;
>>
>>     snd_soc_unregister_card(card);
>>
>>     return 0;
>> }
>>
>> static const struct of_device_id imx_itel_dt_ids[] = {
>>     { .compatible = "fsl,imx-audio-itel", },
>>     { /* sentinel */ }
>> };
>> MODULE_DEVICE_TABLE(of, imx_itel_dt_ids);
>>
>> static struct platform_driver imx_itel_driver = {
>>     .driver = {
>>         .name = "imx-itel",
>>         .owner = THIS_MODULE,
>>         .pm = &snd_soc_pm_ops,
>>         .of_match_table = imx_itel_dt_ids,
>>     },
>>     .probe = imx_itel_probe,
>>     .remove = imx_itel_remove,
>> };
>>
>> module_platform_driver(imx_itel_driver);
>>
>> MODULE_AUTHOR("Nicola Lunghi");
>> MODULE_DESCRIPTION("ITEL I2S Platform Driver");
>> MODULE_LICENSE("GPL v2");
>> MODULE_ALIAS("platform:imx-itel");
>>
>> 2016-05-12 9:55 GMT+02:00 nick83ola <nick83ola@gmail.com>:
>>
>>> I am using ssi1 because I have an example of setting master mode on
>>> sabre board dts
>>>
>>> I have a problem with iomux/pinctrl  I think because
>>>
>>> root@icorem6solo:/sys/kernel/debug/pinctrl/20e0000.iomuxc# cat
>>> pinmux-pins |grep audmux
>>> pin 57 (MX6DL_PAD_DISP0_DAT20): 2028000.ssi (GPIO UNCLAIMED) function
>>> audmux group audmux-4
>>> pin 58 (MX6DL_PAD_DISP0_DAT21): 2028000.ssi (GPIO UNCLAIMED) function
>>> audmux group audmux-4
>>> pin 59 (MX6DL_PAD_DISP0_DAT22): 2028000.ssi (GPIO UNCLAIMED) function
>>> audmux group audmux-4
>>> pin 60 (MX6DL_PAD_DISP0_DAT23): 2028000.ssi (GPIO UNCLAIMED) function
>>> audmux group audmux-4
>>>
>>> says: GPIO_UNCLAIMED? it is correct??
>>>
>>> /sys/kernel/debug/pinctrl/20e0000.iomuxc# cat pinconf-groups |grep -A 1
>>> audmux
>>> 1 (audmux-1):
>>> MX6DL_PAD_SD2_DAT0: 0x17070MX6DL_PAD_SD2_DAT3:
>>> 0x17070MX6DL_PAD_SD2_DAT2: 0x17070MX6DL_PAD_SD2_DAT1: 0x17070
>>> 2 (audmux-2):
>>> MX6DL_PAD_CSI0_DAT7: 0x1b0b0MX6DL_PAD_CSI0_DAT4:
>>> 0x1b0b0MX6DL_PAD_CSI0_DAT5: 0x1b0b0MX6DL_PAD_CSI0_DAT6: 0x1b0b0
>>> 3 (audmux-3):
>>> MX6DL_PAD_DISP0_DAT16: 0x10MX6DL_PAD_DISP0_DAT18:
>>> 0x1b0b0MX6DL_PAD_DISP0_DAT19: 0x1b0b0
>>> 4 (audmux-4):
>>> MX6DL_PAD_DISP0_DAT20: 0x130b0MX6DL_PAD_DISP0_DAT21:
>>> 0x110b0MX6DL_PAD_DISP0_DAT22: 0x130b0MX6DL_PAD_DISP0_DAT23: 0x130b0
>>>
>>> 0x130b0?
>>>
>>> audmux# cat ssi0
>>>     PDCR: 0000a000
>>>     PTCR: ad400800
>>>     TxFS output from SSI6, TxClk output from SSI6
>>>     Port is symmetric
>>>     Data received from SSI6
>>> root@icorem6solo:/sys/kernel/debug/audmux# cat ssi1
>>>     PDCR: 00008000
>>>     PTCR: 00000800
>>>     TxFS input, TxClk input
>>>     Port is symmetric
>>>     Data received from SSI5
>>> root@icorem6solo:/sys/kernel/debug/audmux# cat ssi2
>>>     PDCR: 00006000
>>>     PTCR: 9cc00800
>>>     TxFS output from SSI4, TxClk output from SSI4
>>>     Port is symmetric
>>>     Data received from SSI4
>>> root@icorem6solo:/sys/kernel/debug/audmux# cat ssi3
>>>     PDCR: 00004000
>>>     PTCR: 00000800
>>>     TxFS input, TxClk input
>>>     Port is symmetric
>>>     Data received from SSI3
>>> root@icorem6solo:/sys/kernel/debug/audmux# cat ssi4
>>>     PDCR: 00002000
>>>     PTCR: 8c400800
>>>     TxFS output from imx-ssi.1, TxClk output from imx-ssi.1
>>>     Port is symmetric
>>>     Data received from imx-ssi.1
>>> root@icorem6solo:/sys/kernel/debug/audmux# cat ssi5
>>>     PDCR: 00000000
>>>     PTCR: 00000800
>>>     TxFS input, TxClk input
>>>     Port is symmetric
>>>     Data received from imx-ssi.0
>>> root@icorem6solo:/sys/kernel/debug/audmux# cat ssi6
>>>     PDCR: 0000c000
>>>     PTCR: 00000800
>>>     TxFS input, TxClk input
>>>     Port is symmetric
>>>     Data received from UNKNOWN
>>>
>>>
>>>
>>
>>
>> --
>>
>> P.S. Le informazioni trasmesse attraverso la presente comunicazione sono
>> di esclusiva
>> spettanza dell'effettivo destinatario. Nel caso in cui le stesse
>> raggiungessero, per
>> qualunque motivo, soggetti non interessati, questi ultimi vorranno darne
>> immediata
>> notizia al mittente. In ogni caso, eventuali soggetti diversi dai
>> legittimi destinatari
>> della presente comunicazione e dei dati contenuti negli allegati, possono
>> essere
>> sanzionati ai sensi del T.U. sul trattamento dei dati personali d.lgs.
>> 196/2003, sia ai
>> sensi dell'art. 616 del Codice Penale che disciplina la violazione del
>> segreto sulla
>> corrispondenza.
>>
>
>


-- 

P.S. Le informazioni trasmesse attraverso la presente comunicazione sono di
esclusiva
spettanza dell'effettivo destinatario. Nel caso in cui le stesse
raggiungessero, per
qualunque motivo, soggetti non interessati, questi ultimi vorranno darne
immediata
notizia al mittente. In ogni caso, eventuali soggetti diversi dai legittimi
destinatari
della presente comunicazione e dei dati contenuti negli allegati, possono
essere
sanzionati ai sensi del T.U. sul trattamento dei dati personali d.lgs.
196/2003, sia ai
sensi dell'art. 616 del Codice Penale che disciplina la violazione del
segreto sulla
corrispondenza.

--047d7b3a83960e13f405330ae23a
Content-Type: audio/vnd.dts; name="imx6dl-icore.dts"
Content-Disposition: attachment; filename="imx6dl-icore.dts"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iobjwj4k0

LyoKICogQ29weXJpZ2h0IChDKSAyMDEzIEZyZWVzY2FsZSBTZW1pY29uZHVjdG9yLCBJbmMuCiAq
CiAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBp
dCBhbmQvb3IgbW9kaWZ5CiAqIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwg
UHVibGljIExpY2Vuc2UgdmVyc2lvbiAyIGFzCiAqIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0
d2FyZSBGb3VuZGF0aW9uLgogKi8KCi9kdHMtdjEvOwoKI2luY2x1ZGUgPGR0LWJpbmRpbmdzL3Nv
dW5kL2ZzbC1pbXgtYXVkbXV4Lmg+CiNpbmNsdWRlICJpbXg2ZGwuZHRzaSIKI2luY2x1ZGUgImlt
eDZxZGwtaWNvcmUuZHRzaSIKCiNkZWZpbmUgU1NJX1RFU1RfTUFTVEVSCi8qCiAqIERlZmluZSBw
b3J0OiAoc2VlIGRhdGFzaGVldCBwYWdlIDQ4MikKICogSW50ZXJuYWwgcG9ydCA9IChzc2kyKSA9
PiBwb3J0IDIgPT4gMi0xID0gMSAKICogRXh0ZXJuYWwgcG9ydCA9IChwb3J0IDQpID0+IDQtMSA9
IDMgCiAqLwojZGVmaW5lIEFVRE1VWF9FWFRfUE9SVCAzCiNkZWZpbmUgQVVETVVYX0VYVF9QT1JU
X05BTUUgcG9ydDQKI2RlZmluZSBBVURNVVhfSU5UX1BPUlQgMQoKLy8jZGVmaW5lIFBMTDRfQ1VT
VE9NX0ZSRVEgIDgzNTUwMDgwMAovLyNkZWZpbmUgU1NJX0NVU1RPTV9GUkVRICAgNDE3NzUwNDAw
Ci8vI2RlZmluZSBTU0lfQ1VTVE9NX0ZSRVEgICAyNDU3NjAwMAovLyNkZWZpbmUgUExMNF9DVVNU
T01fRlJFUSAgICA2ODgxMjgwMDAKLy8jZGVmaW5lIFNTSV9DVVNUT01fRlJFUSAgICAgMTIyODgw
MDAKI2RlZmluZSBQTEw0X0NVU1RPTV9GUkVRICAgIDYzMjIxNzYwMAojZGVmaW5lIFNTSV9DVVNU
T01fRlJFUSAgICAgMTEyODk2MDAKCi8qJmNsa3MgewoJYXNzaWduZWQtY2xvY2tzID0gPCZjbGtz
IElNWDZRRExfUExMNF9CWVBBU1NfU1JDPiwKCQkJICA8JmNsa3MgSU1YNlFETF9QTEw0X0JZUEFT
Uz4sCgkJCSAgPCZjbGtzIElNWDZRRExfQ0xLX1BMTDRfUE9TVF9ESVY+OwoJYXNzaWduZWQtY2xv
Y2stcGFyZW50cyA9IDwmY2xrcyBJTVg2UURMX0NMS19MVkRTMl9JTj4sCgkJCQk8JmNsa3MgSU1Y
NlFETF9QTEw0X0JZUEFTU19TUkM+OwoJYXNzaWduZWQtY2xvY2stcmF0ZXMgPSA8MD4sIDwwPiwg
PDI0NTc2MDAwPjsKfTsqLwoKJmNsa3MgewoJYXNzaWduZWQtY2xvY2tzID0gPCZjbGtzIElNWDZR
RExfUExMNF9CWVBBU1NfU1JDPiwgPCZjbGtzIElNWDZRRExfUExMNF9CWVBBU1M+LCA8JmNsa3Mg
SU1YNlFETF9DTEtfUExMNF9QT1NUX0RJVj47CgkvKmFzc2lnbmVkLWNsb2NrLXBhcmVudHMgPSA8
JmNsa3MgSU1YNlFETF9DTEtfTFZEUzJfSU4+LCA8JmNsa3MgSU1YNlFETF9QTEw0X0JZUEFTU19T
UkM+OyovCiAgICBhc3NpZ25lZC1jbG9jay1wYXJlbnRzID0gPCZjbGtzIElNWDZRRExfQ0xLX1BM
TDRfQVVESU9fRElWPjsKCWFzc2lnbmVkLWNsb2NrLXJhdGVzID0gPDA+LCA8MD4sIDxQTEw0X0NV
U1RPTV9GUkVRPjsKfTsKCgovKiZjbGtzIHsKYXNzaWduZWQtY2xvY2tzID0gPCZjbGtzIElNWDZR
RExfUExMNF9CWVBBU1NfU1JDPiwKICAgICAgICAgICAgICAgIDwmY2xrcyBJTVg2UURMX1BMTDRf
QllQQVNTPiwKICAgICAgICAgICAgICAgIDwmY2xrcyBJTVg2UURMX0NMS19QTEw0X1BPU1RfRElW
PjsKCWFzc2lnbmVkLWNsb2NrLXBhcmVudHMgPSA8JmNsa3MgSU1YNlFETF9DTEtfUExMNF9BVURJ
T19ESVY+OwoJYXNzaWduZWQtY2xvY2stcmF0ZXMgPSA8MD4sIDwwPiwgPDI0NTc2MDAwPjsKCgoJ
YXNzaWduZWQtY2xvY2tzID0gPCZjbGtzIElNWDZRRExfQ0xLX1NTSTJfU0VMPjsKCWFzc2lnbmVk
LWNsb2NrLXBhcmVudHMgPSA8JmNsa3MgSU1YNlFETF9DTEtfUExMNF9BVURJT19ESVY+OwogICAg
YXNzaWduZWQtY2xvY2stcmF0ZXMgPSA8MD4sIDw0OTE1MjAwMD47Cn07Ki8KCiZhdWRtdXggewoJ
cGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsKCXBpbmN0cmwtMCA9IDwmcGluY3RybF9hdWRtdXhf
ND47CglzdGF0dXMgPSAib2theSI7CgogICAgc3NpMiB7CiAgICAgICAgZnNsLGF1ZG11eC1wb3J0
ID0gPEFVRE1VWF9JTlRfUE9SVD47CiAgICAgICAgZnNsLHBvcnQtY29uZmlnID0gPAojaWZkZWYg
U1NJX1RFU1RfTUFTVEVSCiAgICAgICAgICAgIElNWF9BVURNVVhfVjJfUFRDUl9TWU4JCiAgICAj
ZWxzZQogICAgICAgICAgICAoSU1YX0FVRE1VWF9WMl9QVENSX1RGU0RJUiB8CiAgICAgICAgICAg
IElNWF9BVURNVVhfVjJfUFRDUl9URlNFTChBVURNVVhfRVhUX1BPUlQpIHwKICAgICAgICAgICAg
SU1YX0FVRE1VWF9WMl9QVENSX1RDTEtESVIgfAogICAgICAgICAgICBJTVhfQVVETVVYX1YyX1BU
Q1JfVENTRUwoQVVETVVYX0VYVF9QT1JUKSB8CiAgICAgICAgICAgIElNWF9BVURNVVhfVjJfUFRD
Ul9TWU4JCiAgICAgICAgICAgICkKICAgICNlbmRpZgogICAgICAgICAgICBJTVhfQVVETVVYX1Yy
X1BEQ1JfUlhEU0VMKEFVRE1VWF9FWFRfUE9SVCkKICAgICAgICA+OwogICAgfTsKCiAgICBBVURN
VVhfRVhUX1BPUlRfTkFNRSB7CiAgICAgICAgZnNsLGF1ZG11eC1wb3J0ID0gPEFVRE1VWF9FWFRf
UE9SVD47CiAgICAgICAgZnNsLHBvcnQtY29uZmlnID0gPAojaWZkZWYgU1NJX1RFU1RfTUFTVEVS
CiAgICAgICAgICAgIChJTVhfQVVETVVYX1YyX1BUQ1JfVEZTRElSIHwKICAgICAgICAgICAgSU1Y
X0FVRE1VWF9WMl9QVENSX1RGU0VMKEFVRE1VWF9JTlRfUE9SVCkgfAogICAgICAgICAgICBJTVhf
QVVETVVYX1YyX1BUQ1JfVENMS0RJUiB8CiAgICAgICAgICAgIElNWF9BVURNVVhfVjJfUFRDUl9U
Q1NFTChBVURNVVhfSU5UX1BPUlQpIHwKICAgICAgICAgICAgSU1YX0FVRE1VWF9WMl9QVENSX1NZ
TgkKICAgICAgICAgICAgKQojZWxzZQogICAgICAgICAgICBJTVhfQVVETVVYX1YyX1BUQ1JfU1lO
CQojZW5kaWYKICAgICAgICAgICAgSU1YX0FVRE1VWF9WMl9QRENSX1JYRFNFTChBVURNVVhfSU5U
X1BPUlQpCiAgICAgICAgPjsKICAgIH07Cn07Cgomc3NpMiB7CiAgICAvLyBzZWxlY3QgdGhlIGEg
Y2xvY2sgcGFyZW50IHN1aXRhYmxlIGZvciA0ODAwMCBIeiBzYW1wbGluZyByYXRlCiAgICBhc3Np
Z25lZC1jbG9ja3MgPSA8JmNsa3MgSU1YNlFETF9DTEtfU1NJMl9TRUw+LCA8JmNsa3MgSU1YNlFE
TF9DTEtfU1NJMj47Cglhc3NpZ25lZC1jbG9jay1wYXJlbnRzID0gPCZjbGtzIElNWDZRRExfQ0xL
X1BMTDRfQVVESU9fRElWPjsKICAgIGFzc2lnbmVkLWNsb2NrLXJhdGVzICAgPSA8MD4sIDwwPiwg
PFNTSV9DVVNUT01fRlJFUT47Cglmc2wsbW9kZSA9ICJpMnMtbWFzdGVyIjsKCXN0YXR1cyA9ICJv
a2F5IjsKfTsKCgovIHsKCW1vZGVsID0gIkVuZ2ljYW0gaS5Db3JlTTYgRHVhbExpdGUvU29sbyBz
dGFydGVya2l0IjsKCWNvbXBhdGlibGUgPSAiZnNsLGlteDYtaWNvcmUiLCAiZnNsLGlteDZkbCI7
CgogICAgY29kZWNfdGVzdDogY29kZWNfdGVzdCB7CiAgICAgICAgY29tcGF0aWJsZSA9ICJmc2ws
c25kLXNvYy1pdGVsIjsKICAgIAlzdGF0dXMgPSAib2theSI7CiAgICB9OwoKCXNvdW5kIHsKCQlj
b21wYXRpYmxlID0gImZzbCxpbXgtYXVkaW8taXRlbCI7CgkJbW9kZWwgPSAiaW14LWl0ZWwiOwoJ
CXNzaS1jb250cm9sbGVyID0gPCZzc2kyPjsKCQlhdWRpby1jb2RlYyA9IDwmY29kZWNfdGVzdD47
CgkJc3RhdHVzID0gIm9rYXkiOwoJfTsKCglzb3VuZC1oZG1pIHsKCQlzdGF0dXMgPSAiZGlzYWJs
ZWQiOwoJfTsKfTsKCiZsZGIgewoJaXB1X2lkID0gPDA+OwoJc2VjX2lwdV9pZCA9IDwwPjsKfTsK
CiZteGNmYjEgewoJc3RhdHVzID0gIm9rYXkiOwp9OwoKJm14Y2ZiMiB7CglzdGF0dXMgPSAib2th
eSI7Cn07CgovKiBUbyBiZSBlbmFibGVkIGZvciBQQ0kgcGVyaXBoZXJhbC4KICAgUGxlYXNlIGVu
YWJsZSBhbHNvIHRoZSBQQ0kgc3VwcG9ydCBrZXJuZWwgb3B0aW9uczoKICAgQ09ORklHX1BDSSBh
bmQgUENJX0lNWDYKJnBjaWUgewoJc3RhdHVzID0gIm9rYXkiOwp9OwoqLwoKJmkyYzEgewoKCW1h
eDExODAxQDQ4IHsKCQljb21wYXRpYmxlID0gIm1heGltLG1heDExODAxIjsKCQlyZWcgPSA8MHg0
OD47CgkJaW50ZXJydXB0LXBhcmVudCA9IDwmZ3BpbzM+OwoJCWludGVycnVwdHMgPSA8MzEgMj47
CgkJd29yay1tb2RlID0gPDA+Oy8qRENNIG1vZGUqLwogICAgICAgIHN0YXR1cyA9ICJkaXNhYmxl
ZCI7Cgl9OwoKfTsKCiZpMmMyIHsKCgloZG1pOiBlZGlkQDUwIHsKCQljb21wYXRpYmxlID0gImZz
bCxpbXg2LWhkbWktaTJjIjsKCQlyZWcgPSA8MHg1MD47Cgl9OwoKfTsKCgomaTJjMyB7CgoJY29k
ZWM6IHNndGw1MDAwQDBhIHsKCQljb21wYXRpYmxlID0gImZzbCxzZ3RsNTAwMCI7CgkJcmVnID0g
PDB4MGE+OwoJCWNsb2NrcyA9IDwmY2xrcyAyMDE+OwoJCVZEREEtc3VwcGx5ID0gPCZyZWdfMnA1
dj47CgkJVkRESU8tc3VwcGx5ID0gPCZyZWdfM3Azdj47CgkJVkRERC1zdXBwbHkgPSA8JnJlZ18x
cDh2PjsKICAgICAgICBzdGF0dXMgPSAiZGlzYWJsZWQiOwoJfTsKCglwb2x5dG91Y2g6IGVkdC1m
dDV4MDZAMzggewoJCWNvbXBhdGlibGUgPSAiZWR0LGVkdC1mdDU0MDYiOwoJCXJlZyA9IDwweDM4
PjsKCQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOwkJCgkJcGluY3RybC0wID0gPCZwaW5jdHJs
X2VkdF9mdDV4MDY+OwoJCWludGVycnVwdC1wYXJlbnQgPSA8JmdwaW81PjsKCQlpbnRlcnJ1cHRz
ID0gPDMwIDA+OwkKCQlyZXNldC1ncGlvcyA9IDwmZ3BpbzYgMCAxPjsKCX07CgoJYWR2NzE4MDog
YWR2NzE4MEAyMSB7CgkJY29tcGF0aWJsZSA9ICJhZHYsYWR2NzE4MCI7CgkJcmVnID0gPDB4MjE+
OwoJCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7CgkJcGluY3RybC0wID0gPCZwaW5jdHJsX2lw
dTFfNj47CgkJY2xvY2tzID0gPCZjbGtzIDIwMT47CgkJY2xvY2stbmFtZXMgPSAiY3NpX21jbGsi
OwoJCURPVkRELXN1cHBseSA9IDwmcmVnXzNwM3Y+OyAvKiAzLjN2LCBlbmFibGVkIHZpYSAyLjgg
VkdFTjYgKi8KCQlBVkRELXN1cHBseSA9IDwmcmVnXzNwM3Y+OyAgLyogMS44diAqLwoJCURWREQt
c3VwcGx5ID0gPCZyZWdfM3Azdj47ICAvKiAxLjh2ICovCgkJUFZERC1zdXBwbHkgPSA8JnJlZ18z
cDN2PjsgIC8qIDEuOHYgKi8KCQlwd24tZ3Bpb3MgPSA8JmdwaW8zIDE5IDA+OyAgLyogcHV0IG9u
IG5vdCB1c2VkIHBpbiAqLwoJCWNzaV9pZCA9IDwwPjsKCQltY2xrID0gPDI0MDAwMDAwPjsKCQlt
Y2xrX3NvdXJjZSA9IDwwPjsKCQljdmJzID0gPDE+OwoJfTsKfTsKCiZpb211eGMgewoJdG91Y2hw
YW5lbHsKCQlwaW5jdHJsX2VkdF9mdDV4MDY6ICBlZHQtZnQ1eDA2Z3JwICB7CgkJCWZzbCxwaW5z
ID0gPAoJCQkJTVg2UURMX1BBRF9DU0kwX0RBVDEyX19HUElPNV9JTzMwIDB4MWIwYjAgLyppbnRl
cnJ1cHQqLyAKCQkJCU1YNlFETF9QQURfQ1NJMF9EQVQxNF9fR1BJTzZfSU8wMCAweDFiMGIwIC8q
cmVzZXQgZWR0Ki8KCQkJPjsKCQl9OwoJfTsKfTsKCiZpb211eGMgewoKCWhvZyB7CgkJcGluY3Ry
bF9ob2c6IGhvZ2dycCB7CgkJCWZzbCxwaW5zID0gPAoJCQkJTVg2UURMX1BBRF9HUElPXzJfX0dQ
SU8xX0lPMDIgMHgxZjA1OQoJCQkJTVg2UURMX1BBRF9FSU1fRDE5X19HUElPM19JTzE5IDB4MWYw
NTkgLyogbm90IHVzZWQgcGluIGZvciBBRFY3MTgwIGRyaXZlciBjb21wYXRpYmlsaXR5ICovCgkJ
CT47CgkJfTsKCX07Cn07Cgo=
--047d7b3a83960e13f405330ae23a
Content-Type: text/x-csrc; charset=US-ASCII; name="imx-itel.c"
Content-Disposition: attachment; filename="imx-itel.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iobjwrgj1

LyoKICogQ29weXJpZ2h0IChDKSAyMDEzIEZyZWVzY2FsZSBTZW1pY29uZHVjdG9yLCBJbmMuCiAq
CiAqIFRoZSBjb2RlIGNvbnRhaW5lZCBoZXJlaW4gaXMgbGljZW5zZWQgdW5kZXIgdGhlIEdOVSBH
ZW5lcmFsIFB1YmxpYwogKiBMaWNlbnNlLiBZb3UgbWF5IG9idGFpbiBhIGNvcHkgb2YgdGhlIEdO
VSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCiAqIFZlcnNpb24gMiBvciBsYXRlciBhdCB0aGUgZm9s
bG93aW5nIGxvY2F0aW9uczoKICoKICogaHR0cDovL3d3dy5vcGVuc291cmNlLm9yZy9saWNlbnNl
cy9ncGwtbGljZW5zZS5odG1sCiAqIGh0dHA6Ly93d3cuZ251Lm9yZy9jb3B5bGVmdC9ncGwuaHRt
bAogKi8KI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgojaW5jbHVkZSA8bGludXgvb2YuaD4KI2lu
Y2x1ZGUgPGxpbnV4L29mX3BsYXRmb3JtLmg+CiNpbmNsdWRlIDxsaW51eC9kZXZpY2UuaD4KI2lu
Y2x1ZGUgPGxpbnV4L2Nsay5oPgojaW5jbHVkZSA8c291bmQvY29yZS5oPgojaW5jbHVkZSA8c291
bmQvcGNtLmg+CiNpbmNsdWRlIDxzb3VuZC9zb2MuaD4KI2luY2x1ZGUgPHNvdW5kL2luaXR2YWwu
aD4KI2luY2x1ZGUgPHNvdW5kL3BjbV9wYXJhbXMuaD4KCiNpbmNsdWRlICJpbXgtc3NpLmgiCgpz
dHJ1Y3QgaW14X2l0ZWxfZGF0YSB7CglzdHJ1Y3Qgc25kX3NvY19kYWlfbGluayBkYWk7CglzdHJ1
Y3Qgc25kX3NvY19jYXJkIGNhcmQ7Cn07CgoKc3RydWN0IF9pdGVsX2F1ZGlvX2ZtdHMgewoJdW5z
aWduZWQgaW50IHJhdGU7Cgl1bnNpZ25lZCBpbnQgc3lzY2xrOwp9OwoKLyogaW4gb3JkZXIgb2Yg
cG93ZXIgY29uc3VtcHRpb24gcGVyIHJhdGUgKGxvd2VzdCBmaXJzdCkgKi8Kc3RhdGljIGNvbnN0
IHN0cnVjdCBfaXRlbF9hdWRpb19mbXRzIGl0ZWxfYXVkaW9fZm10c1tdID0gewovKmNoYW5uZWxz
IGZvcm1hdCAgICAgICAgICAgICAgIHJhdGUJICAgIHN5c2NsayBkaXYyIHBzciBwbSBscl9yYXRl
OyAqLwogICAgLyogMTYgQml0IG11bHRpcGxlIG9mIDhrICovCgl7ODAwMCwgICAgICAxMjI4ODAw
MH0sCgl7MTYwMDAsICAgICAxMjI4ODAwMH0sCgl7MzIwMDAsICAgICAxMjI4ODAwMH0sCgl7NDgw
MDAsICAgICAxMjI4ODAwMH0sCgl7OTYwMDAsICAgICAyNDU3NjAwMH0sCgl7MTkyMDAwLCAgICA0
OTE1MjAwMH0sCgogICAgLyogMTYgYml0IDQ0MTAwIG11bHRpcGxlcyAqLwoJezExMDI1LCAgICAg
MTEyODk2MDB9LAoJezIyMDUwLCAgICAgMTEyODk2MDB9LAoJezQ0MTAwLCAgICAgMTEyODk2MDB9
LAoJezg4MjAwLCAgICAgMjI1NzkyMDB9LAp9OwoKCnN0YXRpYyBpbnQgaW14X2l0ZWxfaHdfcGFy
YW1zKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtLAogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBzdHJ1Y3Qgc25kX3BjbV9od19wYXJhbXMgKnBhcmFtcykKewoJc3RydWN0
IHNuZF9zb2NfcGNtX3J1bnRpbWUgKnJ0ZCA9IHN1YnN0cmVhbS0+cHJpdmF0ZV9kYXRhOwoJc3Ry
dWN0IHNuZF9zb2NfZGFpICpjcHVfZGFpID0gcnRkLT5jcHVfZGFpOwoJc25kX3BjbV9mb3JtYXRf
dCBmb3JtYXQgPSBwYXJhbXNfZm9ybWF0KHBhcmFtcyk7Cgl1MzIgY2hhbm5lbHMgPSBwYXJhbXNf
Y2hhbm5lbHMocGFyYW1zKTsKCXUzMiByYXRlICAgICA9IHBhcmFtc19yYXRlKHBhcmFtcyk7Cgl1
MzIgYmNsayA9IHJhdGUgKiBjaGFubmVscyAqIDMyOwoJaW50IHJldCA9IDAsIGk7CgogICAgZGV2
X2luZm8oY3B1X2RhaS0+ZGV2LCAic2V0IGNwdSBEQUkgY29uZmlndXJhdGlvbiByYXRlPSVkLCBm
b3JtYXQ9JWQsIGNoYW5uZWxzPSVkLCBiY2xrPSVkXG4iLCByYXRlLCBmb3JtYXQsIGNoYW5uZWxz
LCBiY2xrKTsKCgkvKiBmaW5kIHRoZSBjb3JyZWN0IGF1ZGlvIHBhcmFtZXRlcnMgKi8KCWZvciAo
aSA9IDA7IGkgPCBBUlJBWV9TSVpFKGl0ZWxfYXVkaW9fZm10cyk7IGkrKykgewoJCWlmIChyYXRl
ID09IGl0ZWxfYXVkaW9fZm10c1tpXS5yYXRlKQoJCXsKCQkgICAgcmV0ID0gMTsKCQkgICAgYnJl
YWs7CgkJfQoJfQoJaWYgKCFyZXQpCgkJcmV0dXJuIC1FSU5WQUw7CgoJLyogY29kZWMgRkxMIGlu
cHV0IGlzIDE0Ljc1IE1IeiBmcm9tIE1DTEsgKi8KICAgIC8qKgogICAgICogc25kX3NvY19kYWlf
c2V0X3BsbCAtIGNvbmZpZ3VyZSBEQUkgUExMLgogICAgICogQGRhaTogREFJCiAgICAgKiBAcGxs
X2lkOiBEQUkgc3BlY2lmaWMgUExMIElECiAgICAgKiBAc291cmNlOiBEQUkgc3BlY2lmaWMgc291
cmNlIGZvciB0aGUgUExMCiAgICAgKiBAZnJlcV9pbjogUExMIGlucHV0IGNsb2NrIGZyZXF1ZW5j
eSBpbiBIegogICAgICogQGZyZXFfb3V0OiByZXF1ZXN0ZWQgUExMIG91dHB1dCBjbG9jayBmcmVx
dWVuY3kgaW4gSHoKICAgICAqCiAgICAgKiBDb25maWd1cmVzIGFuZCBlbmFibGVzIFBMTCB0byBn
ZW5lcmF0ZSBvdXRwdXQgY2xvY2sgYmFzZWQgb24gaW5wdXQgY2xvY2suCiAgICAgKi8KICAgIC8v
IHNuZF9zb2NfZGFpX3NldF9wbGwoc3RydWN0IHNuZF9zb2NfZGFpICpkYWksIGludCBwbGxfaWQs
IGludCBzb3VyY2UsIHVuc2lnbmVkIGludCBmcmVxX2luLCB1bnNpZ25lZCBpbnQgZnJlcV9vdXQp
OwoKCXNuZF9zb2NfZGFpX3NldF9wbGwoY3B1X2RhaSwgMCwgMCwgMjQwMDAwMDAsIGl0ZWxfYXVk
aW9fZm10c1tpXS5zeXNjbGspOwoKCS8qIHNldCBjcHUgREFJIGNvbmZpZ3VyYXRpb24gKi8KCXJl
dCA9IHNuZF9zb2NfZGFpX3NldF9mbXQoY3B1X2RhaSwgU05EX1NPQ19EQUlGTVRfSTJTIHwgU05E
X1NPQ19EQUlGTVRfTkJfTkYgfCBTTkRfU09DX0RBSUZNVF9DQlNfQ0ZTKTsKCWlmIChyZXQpIHsK
CQlkZXZfZXJyKGNwdV9kYWktPmRldiwgImZhaWxlZCB0byBzZXQgZGFpIGZtdFxuIik7CgkJcmV0
dXJuIHJldDsKCX0KCiAgICBkZXZfaW5mbyhjcHVfZGFpLT5kZXYsICJzZXQgdGRtIHNsb3RzIGNo
YW5uZWxzPSVkIiwgY2hhbm5lbHMpOwoKCXJldCA9IHNuZF9zb2NfZGFpX3NldF90ZG1fc2xvdChj
cHVfZGFpLCBjaGFubmVscyA9PSAxID8gMHhmZmZmZmZmZSA6IDB4ZmZmZmZmZmMsIGNoYW5uZWxz
ID09IDEgPyAweGZmZmZmZmZlIDogMHhmZmZmZmZmYywgMiwgMzIpOwoJaWYgKHJldCkgewoJCWRl
dl9lcnIoY3B1X2RhaS0+ZGV2LCAiZmFpbGVkIHRvIHNldCBkYWkgdGRtIHNsb3RcbiIpOwoJCXJl
dHVybiByZXQ7Cgl9CgogICAgZGV2X2luZm8oY3B1X2RhaS0+ZGV2LCAic2V0IHNzaSBiY2xrIE5B
TUU9JXMgXG4iLGNwdV9kYWktPm5hbWUpOwogICAgLyogc2V0IGNsb2NrICovCglyZXQgPSBzbmRf
c29jX2RhaV9zZXRfc3lzY2xrKGNwdV9kYWksIElNWF9TU1BfU1lTX0NMSywgYmNsaywgU05EX1NP
Q19DTE9DS19PVVQpOwoJaWYgKHJldCkKCQlkZXZfZXJyKGNwdV9kYWktPmRldiwgImZhaWxlZCB0
byBzZXQgc3lzY2xrXG4iKTsKCglyZXR1cm4gcmV0Owp9CgoKc3RhdGljIHN0cnVjdCBzbmRfc29j
X29wcyBpbXhfaXRlbF9vcHMgPSB7CgkuaHdfcGFyYW1zID0gaW14X2l0ZWxfaHdfcGFyYW1zLAp9
OwoKCnN0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX3NvY19kYXBtX3dpZGdldCBpbXhfaXRlbF9kYXBt
X3dpZGdldHNbXSA9IHsKLy8JU05EX1NPQ19EQVBNX0xJTkUoIkxpbmUgT3V0IEphY2siLCBOVUxM
KSwKLy8JU05EX1NPQ19EQVBNX0xJTkUoIkxpbmUgSW4gSmFjayIsIE5VTEwpLAp9OwoKc3RhdGlj
IHN0cnVjdCBzbmRfc29jX2RhaV9saW5rIGlteF9pdGVsX2RhaVtdID0gewoJewoJCS5uYW1lICAg
ICAgICAgICAgPSAiSGlmaSIsCgkJLnN0cmVhbV9uYW1lCSA9ICJIaWZpIiwKCQkuY29kZWNfZGFp
X25hbWUJID0gInNuZC1zb2MtaXRlbC1kYWkiLAoJCS8vLmNvZGVjX25hbWUJICAgICA9ICJzbmQt
c29jLWl0ZWwiLAoJCS5vcHMJCSAgICAgPSAmaW14X2l0ZWxfb3BzLAoJCS5zeW1tZXRyaWNfcmF0
ZXMgPSAxLAoJfSwKfTsKCnN0YXRpYyBzdHJ1Y3Qgc25kX3NvY19jYXJkIHNuZF9zb2NfY2FyZF9p
bXhfaXRlbCA9IHsKCS5uYW1lICAgICAgICAgICAgICAgPSAiaW14LWF1ZGlvLWl0ZWwiLAoJLmRh
aV9saW5rICAgICAgICAgICA9IGlteF9pdGVsX2RhaSwKCS5udW1fbGlua3MJICAgICAgICA9IEFS
UkFZX1NJWkUoaW14X2l0ZWxfZGFpKSwKCS5kYXBtX3dpZGdldHMgICAgICAgPSBpbXhfaXRlbF9k
YXBtX3dpZGdldHMsCgkubnVtX2RhcG1fd2lkZ2V0cyAgID0gQVJSQVlfU0laRShpbXhfaXRlbF9k
YXBtX3dpZGdldHMpLAogICAgLm93bmVyICAgICAgICAgICAgICA9IFRISVNfTU9EVUxFLAp9OwoK
CnN0YXRpYyBpbnQgaW14X2l0ZWxfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikK
ewoJc3RydWN0IHNuZF9zb2NfY2FyZCAqY2FyZCA9ICZzbmRfc29jX2NhcmRfaW14X2l0ZWw7Cglz
dHJ1Y3QgZGV2aWNlX25vZGUgKnNzaV9ucDsKCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnNzaV9w
ZGV2OwoJc3RydWN0IGRldmljZV9ub2RlICpjb2RlY19ucDsKCXN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKmNvZGVjX3BkZXY7CgkvLyBzdHJ1Y3QgaW14X2l0ZWxfZGF0YSAqZGF0YSA9IE5VTEw7Cglp
bnQgaW50X3BvcnQsIGV4dF9wb3J0LCByZXQ7CgogICAgZGV2X2luZm8oJnBkZXYtPmRldiwiZW50
ZXIgaW14X2l0ZWxfcHJvYmUiKTsKCglyZXQgPSBvZl9wcm9wZXJ0eV9yZWFkX3UzMihwZGV2LT5k
ZXYub2Zfbm9kZSwgIm11eC1pbnQtcG9ydCIsICZpbnRfcG9ydCk7CglpZiAocmV0KSB7CgkJZGV2
X2VycigmcGRldi0+ZGV2LCAibXV4LWludC1wb3J0IG1pc3Npbmcgb3IgaW52YWxpZFxuIik7CgkJ
cmV0dXJuIHJldDsKCX0KICAgCgoJcmV0ID0gb2ZfcHJvcGVydHlfcmVhZF91MzIocGRldi0+ZGV2
Lm9mX25vZGUsICJtdXgtZXh0LXBvcnQiLCAmZXh0X3BvcnQpOwoJaWYgKHJldCkgewoJCWRldl9l
cnIoJnBkZXYtPmRldiwgIm11eC1leHQtcG9ydCBtaXNzaW5nIG9yIGludmFsaWRcbiIpOwoJCXJl
dHVybiByZXQ7Cgl9CgogICAgLyogZmluZCB2YWx1ZSBpbiBkZXZpY2V0cmVlIGZvciBzc2kgY29u
dHJvbGxlciAqLwoJc3NpX25wID0gb2ZfcGFyc2VfcGhhbmRsZShwZGV2LT5kZXYub2Zfbm9kZSwg
InNzaS1jb250cm9sbGVyIiwgMCk7CglpZiAoIXNzaV9ucCkgewoJCWRldl9lcnIoJnBkZXYtPmRl
diwgInNzaS1jb250cm9sbGVyIG1pc3Npbmcgb3IgaW52YWxpZFxuIik7CgkJcmV0ID0gLUVJTlZB
TDsKCQlnb3RvIGZhaWw7Cgl9CgogICAgLyogZmluZCBTU0kgcGxhdGZvcm0gZHJpdmVyICovCglz
c2lfcGRldiA9IG9mX2ZpbmRfZGV2aWNlX2J5X25vZGUoc3NpX25wKTsKCWlmICghc3NpX3BkZXYp
IHsKCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJmYWlsZWQgdG8gZmluZCBTU0kgcGxhdGZvcm0gZGV2
aWNlXG4iKTsKCQlyZXQgPSAtRVBST0JFX0RFRkVSOwoJCWdvdG8gZmFpbDsKCX0KCgljb2RlY19u
cCA9IG9mX3BhcnNlX3BoYW5kbGUocGRldi0+ZGV2Lm9mX25vZGUsICJhdWRpby1jb2RlYyIsIDAp
OwoJaWYgKCFjb2RlY19ucCkgewoJCWRldl9lcnIoJnBkZXYtPmRldiwgImNvZGVjIG1pc3Npbmcg
b3IgaW52YWxpZFxuIik7CgkJcmV0ID0gLUVJTlZBTDsKCQlnb3RvIGZhaWw7Cgl9CgogICAgLyog
ZmluZCBTU0kgcGxhdGZvcm0gZHJpdmVyICovCgljb2RlY19wZGV2ID0gb2ZfZmluZF9kZXZpY2Vf
Ynlfbm9kZShjb2RlY19ucCk7CglpZiAoIWNvZGVjX3BkZXYpIHsKCQlkZXZfZXJyKCZwZGV2LT5k
ZXYsICJmYWlsZWQgdG8gZmluZCBjb2RlYyBwbGF0Zm9ybSBkZXZpY2VcbiIpOwoJCXJldCA9IC1F
UFJPQkVfREVGRVI7CgkJZ290byBmYWlsOwoJfQoKCWNhcmQtPmRldiA9ICZwZGV2LT5kZXY7Cglj
YXJkLT5kYWlfbGluay0+Y3B1X2RhaV9uYW1lID0gZGV2X25hbWUoJnNzaV9wZGV2LT5kZXYpOwoJ
Y2FyZC0+ZGFpX2xpbmstPnBsYXRmb3JtX29mX25vZGUgPSBzc2lfbnA7CgljYXJkLT5kYWlfbGlu
ay0+Y29kZWNfb2Zfbm9kZSA9IGNvZGVjX25wOwoJY2FyZC0+ZGFpX2xpbmstPmRhaV9mbXQgPSBT
TkRfU09DX0RBSUZNVF9JMlMgfCBTTkRfU09DX0RBSUZNVF9OQl9ORiB8IFNORF9TT0NfREFJRk1U
X0NCU19DRlM7CgoKCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIGNhcmQpOwoJc25kX3NvY19j
YXJkX3NldF9kcnZkYXRhKGNhcmQsICZzbmRfc29jX2NhcmRfaW14X2l0ZWwpOwoKICAgIGRldl9p
bmZvKCZwZGV2LT5kZXYsInJlZ2lzdHJvIGxhIHNjaGVkYVxuIik7CgoJcmV0ID0gc25kX3NvY19y
ZWdpc3Rlcl9jYXJkKGNhcmQpOwoJaWYgKHJldCkgewoJCWRldl9lcnIoJnBkZXYtPmRldiwgIkZh
aWxlZCB0byByZWdpc3RlciBjYXJkOiAlZFxuIiwgcmV0KTsKCQlnb3RvIGZhaWw7CiAgICB9CgoJ
b2Zfbm9kZV9wdXQoc3NpX25wKTsKCW9mX25vZGVfcHV0KGNvZGVjX25wKTsKCglyZXR1cm4gMDsK
CQpmYWlsOgoJaWYgKHNzaV9ucCkKCQlvZl9ub2RlX3B1dChzc2lfbnApOwoJaWYgKGNvZGVjX25w
KQoJCW9mX25vZGVfcHV0KGNvZGVjX25wKTsKCglyZXR1cm4gcmV0Owp9CgpzdGF0aWMgaW50IGlt
eF9pdGVsX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQp7CglzdHJ1Y3Qgc25k
X3NvY19jYXJkICpjYXJkID0gJnNuZF9zb2NfY2FyZF9pbXhfaXRlbDsKCglzbmRfc29jX3VucmVn
aXN0ZXJfY2FyZChjYXJkKTsKCglyZXR1cm4gMDsKfQoKc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9k
ZXZpY2VfaWQgaW14X2l0ZWxfZHRfaWRzW10gPSB7Cgl7IC5jb21wYXRpYmxlID0gImZzbCxpbXgt
YXVkaW8taXRlbCIsIH0sCgl7IC8qIHNlbnRpbmVsICovIH0KfTsKTU9EVUxFX0RFVklDRV9UQUJM
RShvZiwgaW14X2l0ZWxfZHRfaWRzKTsKCnN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGlt
eF9pdGVsX2RyaXZlciA9IHsKCS5kcml2ZXIgPSB7CgkJLm5hbWUgPSAiaW14LWl0ZWwiLAoJCS5v
d25lciA9IFRISVNfTU9EVUxFLAoJCS5wbSA9ICZzbmRfc29jX3BtX29wcywKCQkub2ZfbWF0Y2hf
dGFibGUgPSBpbXhfaXRlbF9kdF9pZHMsCgl9LAoJLnByb2JlID0gaW14X2l0ZWxfcHJvYmUsCgku
cmVtb3ZlID0gaW14X2l0ZWxfcmVtb3ZlLAp9OwoKbW9kdWxlX3BsYXRmb3JtX2RyaXZlcihpbXhf
aXRlbF9kcml2ZXIpOwoKTU9EVUxFX0FVVEhPUigiTmljb2xhIEx1bmdoaSIpOwpNT0RVTEVfREVT
Q1JJUFRJT04oIklURUwgSTJTIFBsYXRmb3JtIERyaXZlciIpOwpNT0RVTEVfTElDRU5TRSgiR1BM
IHYyIik7Ck1PRFVMRV9BTElBUygicGxhdGZvcm06aW14LWl0ZWwiKTsK
--047d7b3a83960e13f405330ae23a
Content-Type: text/x-csrc; charset=US-ASCII; name="itel.c"
Content-Disposition: attachment; filename="itel.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iobjww792

LyoKICogaXRlbC5jICAtLSAgQUxTQSBTb0MgQXVkaW8gTGF5ZXIgdXRpbGl0eSBmdW5jdGlvbnMK
ICoKICogQ29weXJpZ2h0IDIwMDkgV29sZnNvbiBNaWNyb2VsZWN0cm9uaWNzIFBMQy4KICoKICog
QXV0aG9yOiBNYXJrIEJyb3duIDxicm9vbmllQG9wZW5zb3VyY2Uud29sZnNvbm1pY3JvLmNvbT4K
ICogICAgICAgICBMaWFtIEdpcmR3b29kIDxscmdAc2xpbWxvZ2ljLmNvLnVrPgogKiAgICAgICAg
IAogKgogKiAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmli
dXRlICBpdCBhbmQvb3IgbW9kaWZ5IGl0CiAqICB1bmRlciAgdGhlIHRlcm1zIG9mICB0aGUgR05V
IEdlbmVyYWwgIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieSB0aGUKICogIEZyZWUgU29m
dHdhcmUgRm91bmRhdGlvbjsgIGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlICBMaWNlbnNlLCBvciAo
YXQgeW91cgogKiAgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KICovCgojaW5jbHVkZSA8bGlu
dXgvbW9kdWxlLmg+CiNpbmNsdWRlIDxsaW51eC9tb2R1bGVwYXJhbS5oPgojaW5jbHVkZSA8bGlu
dXgvc2xhYi5oPgojaW5jbHVkZSA8c291bmQvc29jLmg+CiNpbmNsdWRlIDxzb3VuZC9wY20uaD4K
I2luY2x1ZGUgPHNvdW5kL2luaXR2YWwuaD4KI2luY2x1ZGUgPGxpbnV4L29mLmg+CgpzdGF0aWMg
c3RydWN0IHNuZF9zb2NfcGxhdGZvcm1fZHJpdmVyIGl0ZWxfcGxhdGZvcm0gPSB7CgkvLy5vcHMg
PSAmZHVtbXlfZG1hX29wcywKfTsKCiNkZWZpbmUgSVRFTF9SWF9SQVRFUwlTTkRSVl9QQ01fUkFU
RV84MDAwXzE5MjAwMAojZGVmaW5lIElURUxfUlhfRk9STUFUUwkoICAgU05EUlZfUENNX0ZNVEJJ
VF9TMTZfTEUgfCAgIFwKCQkJICAgICAgICAgICAgICAgIFNORFJWX1BDTV9GTVRCSVRfUzIwXzNM
RXwgICBcCgkJCSAgICAgICAgICAgICAgICBTTkRSVl9QQ01fRk1UQklUX1MyNF9MRSB8ICAgXAoJ
CQkgICAgICAgICAgICAgICAgU05EUlZfUENNX0ZNVEJJVF9TMzJfTEUgKQoKI2RlZmluZSBJVEVM
X1RYX1JBVEVTCVNORFJWX1BDTV9SQVRFXzgwMDBfMTkyMDAwCiNkZWZpbmUgSVRFTF9UWF9GT1JN
QVRTCSggICBTTkRSVl9QQ01fRk1UQklUX1MxNl9MRSB8ICAgXAoJCQkgICAgICAgICAgICAgICAg
U05EUlZfUENNX0ZNVEJJVF9TMjBfM0xFfCAgIFwKCQkJICAgICAgICAgICAgICAgIFNORFJWX1BD
TV9GTVRCSVRfUzI0X0xFIHwgICBcCgkJCSAgICAgICAgICAgICAgICBTTkRSVl9QQ01fRk1UQklU
X1MzMl9MRSkKCnN0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX3NvY19kYXBtX3dpZGdldCBpdGVsX3dp
ZGdldHNbXSA9IHsKCVNORF9TT0NfREFQTV9JTlBVVCgiaTJzLWluIiksCglTTkRfU09DX0RBUE1f
T1VUUFVUKCJpMnMtb3V0IiksCn07CgpzdGF0aWMgY29uc3Qgc3RydWN0IHNuZF9zb2NfZGFwbV9y
b3V0ZSBpdGVsX3JvdXRlc1tdID0gewoJeyAiQ2FwdHVyZSIsIE5VTEwsICJpMnMtaW4iIH0sCgl7
ICJpMnMtb3V0IiwgTlVMTCwgIlBsYXliYWNrIiB9LAp9OwoKc3RhdGljIHN0cnVjdCBzbmRfc29j
X2NvZGVjX2RyaXZlciBpdGVsX2NvZGVjID0gewoJLmRhcG1fd2lkZ2V0cyA9IGl0ZWxfd2lkZ2V0
cywKCS5udW1fZGFwbV93aWRnZXRzID0gQVJSQVlfU0laRShpdGVsX3dpZGdldHMpLAoJLmRhcG1f
cm91dGVzID0gaXRlbF9yb3V0ZXMsCgkubnVtX2RhcG1fcm91dGVzID0gQVJSQVlfU0laRShpdGVs
X3JvdXRlcyksCn07CgpzdGF0aWMgc3RydWN0IHNuZF9zb2NfZGFpX2RyaXZlciBpdGVsX2RhaSA9
IHsKCS5uYW1lID0gInNuZC1zb2MtaXRlbC1kYWkiLAoJLnBsYXliYWNrID0gewoJCS5zdHJlYW1f
bmFtZQk9ICJQbGF5YmFjayIsCgkJLmNoYW5uZWxzX21pbgk9IDEsCgkJLmNoYW5uZWxzX21heAk9
IDIsCgkJLnJhdGVzCQk9IElURUxfVFhfUkFURVMsCgkJLmZvcm1hdHMJPSBJVEVMX1RYX0ZPUk1B
VFMsCgl9LAoJLmNhcHR1cmUgPSB7CgkJLnN0cmVhbV9uYW1lCT0gIkNhcHR1cmUiLAoJCS5jaGFu
bmVsc19taW4JPSAxLAoJCS5jaGFubmVsc19tYXgJPSAyLAoJCS5yYXRlcyA9IElURUxfUlhfUkFU
RVMsCgkJLmZvcm1hdHMgPSBJVEVMX1JYX0ZPUk1BVFMsCgkgfSwKfTsKCnN0YXRpYyBpbnQgc25k
X3NvY19pdGVsX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCnsKCWludCByZXQ7
CgoJcmV0dXJuIHNuZF9zb2NfcmVnaXN0ZXJfY29kZWMoJnBkZXYtPmRldiwgJml0ZWxfY29kZWMs
ICZpdGVsX2RhaSwgMSk7CglpZiAocmV0IDwgMCkKCQlyZXR1cm4gcmV0OwoKCXJldCA9IHNuZF9z
b2NfcmVnaXN0ZXJfcGxhdGZvcm0oJnBkZXYtPmRldiwgJml0ZWxfcGxhdGZvcm0pOwoJaWYgKHJl
dCA8IDApIHsKCQlzbmRfc29jX3VucmVnaXN0ZXJfY29kZWMoJnBkZXYtPmRldik7CgkJcmV0dXJu
IHJldDsKCX0KCglyZXR1cm4gcmV0Owp9CgpzdGF0aWMgaW50IHNuZF9zb2NfaXRlbF9yZW1vdmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKewoJc25kX3NvY191bnJlZ2lzdGVyX3BsYXRm
b3JtKCZwZGV2LT5kZXYpOwoJc25kX3NvY191bnJlZ2lzdGVyX2NvZGVjKCZwZGV2LT5kZXYpOwoJ
cmV0dXJuIDA7Cn0KCiNpZmRlZiBDT05GSUdfT0YKc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZp
Y2VfaWQgc29jX2l0ZWxfaWRzW10gPSB7CiAgICB7IC5jb21wYXRpYmxlID0gImZzbCxzbmQtc29j
LWl0ZWwiLCB9LAogICAgeyB9Cn07Ck1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIHNvY19pdGVsX2lk
cyk7CiNlbmRpZgoKc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgc29jX2l0ZWxfZHJpdmVy
ID0gewoJLnByb2JlID0gc25kX3NvY19pdGVsX3Byb2JlLAoJLnJlbW92ZSA9IHNuZF9zb2NfaXRl
bF9yZW1vdmUsCgkuZHJpdmVyID0gewoJCS5uYW1lID0gInNuZC1zb2MtaXRlbCIsCgkJLm93bmVy
ID0gVEhJU19NT0RVTEUsCiAgICAgICAgLm9mX21hdGNoX3RhYmxlID0gb2ZfbWF0Y2hfcHRyKHNv
Y19pdGVsX2lkcyksCgl9LAp9OwoKbW9kdWxlX3BsYXRmb3JtX2RyaXZlcihzb2NfaXRlbF9kcml2
ZXIpOwoKTU9EVUxFX0FVVEhPUigiTmljb2xhIEx1bmdoaSA8bmljb2xhLmx1bmdoaUBpdGVsLml0
PiIpOwpNT0RVTEVfREVTQ1JJUFRJT04oIklURUwgSTJTIENvZGVjIERyaXZlciIpOwpNT0RVTEVf
TElDRU5TRSgiR1BMIik7Ck1PRFVMRV9BTElBUygicGxhdGZvcm06c25kLXNvYy1pdGVsIik7Cg==
--047d7b3a83960e13f405330ae23a
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--047d7b3a83960e13f405330ae23a--
