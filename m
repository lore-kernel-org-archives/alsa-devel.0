From: Sergio Serrano <sergio.badalona@gmail.com>
Subject: TLV320AIC3106 + DM3730 soc doens't capture audio (no
	BLCK, no WLCK)
Date: Mon, 17 Nov 2014 09:15:07 +0100
Message-ID: <CAK-SLvB+XLLu=68NBzUufJufFuz3Hcna2s=cTHkfTLXTnyv2zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
 [209.85.212.170])
 by alsa0.perex.cz (Postfix) with ESMTP id EC6522614E2
 for <alsa-devel@alsa-project.org>; Mon, 17 Nov 2014 09:15:07 +0100 (CET)
Received: by mail-wi0-f170.google.com with SMTP id bs8so2213033wib.5
 for <alsa-devel@alsa-project.org>; Mon, 17 Nov 2014 00:15:07 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear members,

Please, let me explain my setup: I'm using DM3730 soc
<https://www.isee.biz/products/igep-processor-boards/igepv2-dm3730> with
McBSP3 and I2C2 to drive audio and control to the TLV320AIC3106 codec
(which it is acting as master). Currently I'm using 2.6.37 kernel version
<http://git.isee.biz/?p=pub/scm/linux-omap-2.6.git;a=tree>.

For reference I've used BBB Audio Cape
<http://elinux.org/CircuitCo:Audio_Cape_RevA> as base design.

Right now I've got playback working as expected (codec generates BCLK and
WCLK). Whenever I try to record using "arecor,d -f cd -Dhw:1,0" it's only
showing wave header but no audio is captured at all. I can not see any
clocks running on the codec.

How can I debug or go further with this issue?
Any thoughts will be appreciated!!

BTW this is the init code:

static int TLV320AIC3106_hw_params(struct snd_pcm_substream *substream,
    struct snd_pcm_hw_params *params)
{
    struct snd_soc_pcm_runtime *rtd = substream->private_data;
    struct snd_soc_dai *codec_dai = rtd->codec_dai;
    struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
    int ret;

    printk(KERN_ERR "+tlv_hw_params(%p,%p) %p, %p, %p\n", substream,
params, rtd, codec_dai, cpu_dai);

    // Set codec DAI configuration
    ret = snd_soc_dai_set_fmt(codec_dai,
                  SND_SOC_DAIFMT_I2S |
                  SND_SOC_DAIFMT_NB_NF |
                  SND_SOC_DAIFMT_CBM_CFM);
    if (ret < 0) {
        printk(KERN_ERR "tlv_hw_params: can't set codec DAI
configuration\n");
        return ret;
    }

    // Set cpu DAI configuration
    ret = snd_soc_dai_set_fmt(cpu_dai,
                  SND_SOC_DAIFMT_I2S |
                  SND_SOC_DAIFMT_NB_NF |
                  SND_SOC_DAIFMT_CBM_CFM);

    if (ret < 0) {
        printk(KERN_ERR "tlv_hw_params: can't set cpu DAI configuration\n");
        return ret;
    }

    // Set the codec system clock for DAC and ADC
    ret = snd_soc_dai_set_sysclk(codec_dai, 0, 12000000, SND_SOC_CLOCK_IN);
     if (ret < 0) {
        printk(KERN_ERR "tlv_hw_params: can't set codec system clock\n");
        return ret;
    }

    printk(KERN_ERR "-tlv_hw_params\n");
    return 0;
}

BR,
Sergio
