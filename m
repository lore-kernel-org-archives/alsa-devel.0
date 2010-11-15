From: Grzegorz Daniluk <g.daniluk@elproma.com.pl>
Subject: ASoC: WM8804: fsi-wm8804
Date: Mon, 15 Nov 2010 13:26:37 +0100
Message-ID: <4CE126FD.7000407@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailmxout.mailmx.agnat.pl (mailmxout.mailmx.agnat.pl
	[193.239.44.238])
	by alsa0.perex.cz (Postfix) with ESMTP id A88E724498
	for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2010 13:26:45 +0100 (CET)
Received: from smtp.agnat.pl ([193.239.44.82])
	by mailmxout.mailmx.agnat.pl with esmtp (Exim 4.72)
	(envelope-from <g.daniluk@elproma.com.pl>) id 1PHy8r-000375-P5
	for alsa-devel@alsa-project.org; Mon, 15 Nov 2010 13:26:37 +0100
Received: from [83.19.137.3] (helo=[192.168.1.79])
	by smtp.agnat.pl with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.71) (envelope-from <g.daniluk@elproma.com.pl>)
	id 1PHy8r-000367-M8
	for alsa-devel@alsa-project.org; Mon, 15 Nov 2010 13:26:37 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
I'm trying to use the wm8804 codec in my SH4-based system (Renesas 
SH7724 to be precise). I have used the latest kernel 2.6.37-rc1 where 
there is the codec driver for wm8804. However, I have to write my own 
fsi-wm8804.c (like e.g. fsi-da7210.c). My code attached below. After 
compiling it with the rest of the kernel sources or compiling as an 
external module my alsa still does not see any soundcards. However, by 
running i2cdetect I can see that the device is correctly taken by the 
codec driver so the problem is somewhere with my fsi-wm8804 probably. 
Could you take a look at this ? Did I miss something from new ASoC api 
so that this module could correctly talk with wm8804 codec driver ? Also 
(when compiled as modules) after loading and doing lsmod I could see 
that the wm8804 module is not used by fsi-wm8804 module (as it was when 
I was playing with wm8940 on previous kernel versions).

best regards,
Greg

#include <linux/platform_device.h>
#include <sound/sh_fsi.h>

static int fsi_wm8804_init(struct snd_soc_codec *codec)
{

    return 0;
}

static int fsi_wm8804_hw_params(struct snd_pcm_substream *substream, 
struct snd_pcm_hw_params *params)
{
    struct snd_soc_pcm_runtime *rtd = substream->private_data;
    struct snd_soc_dai *dai = rtd->codec_dai;

    printk("%s\n", __FUNCTION__);

    if(substream->stream == SNDRV_PCM_STREAM_CAPTURE)
    {
        snd_soc_dai_set_pll(dai, 0, 0, 12000000, 94310400);
    }
    else if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
    {
        snd_soc_dai_set_pll(dai, 0, 0, 12000000, 98304000);
    }

    snd_soc_dai_set_fmt(dai, SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF 
|  SND_SOC_DAIFMT_CBM_CFM);

    return 0;
}

static struct snd_soc_ops fsi_wm8804_ops = {
    .hw_params    = fsi_wm8804_hw_params,
};

static struct snd_soc_dai_link fsi_wm8804_dai = {
    .name        = "WM8804",
    .stream_name    = "WM8804",
    .cpu_dai_name    = "fsib-dai", /* FSI B */
    .codec_dai_name    = "wm8804-spdif",
    .platform_name    = "sh_fsi.0",
    .codec_name    = "wm8804.0-003a",    /*0x3a is codec I2C addr*/
    .init        = fsi_wm8804_init,
    .ops        = &fsi_wm8804_ops,
};

static struct snd_soc_card fsi_soc_card = {
    .name        = "FSI (WM8804)",
    .dai_link    = &fsi_wm8804_dai,
    .num_links    = 1,
};

static struct platform_device *fsi_wm8804_snd_device;

static int __init fsi_wm8804_sound_init(void)
{
    int ret;

    printk("%s\n", __FUNCTION__);

    fsi_wm8804_snd_device = platform_device_alloc("soc-audio", FSI_PORT_B);
    if (!fsi_wm8804_snd_device)
        return -ENOMEM;

    platform_set_drvdata(fsi_wm8804_snd_device, &fsi_soc_card);
    ret = platform_device_add(fsi_wm8804_snd_device);
    if (ret)
        platform_device_put(fsi_wm8804_snd_device);

    return ret;
}

static void __exit fsi_wm8804_sound_exit(void)
{
    printk("%s\n", __FUNCTION__);

    platform_device_unregister(fsi_wm8804_snd_device);
}

module_init(fsi_wm8804_sound_init);
module_exit(fsi_wm8804_sound_exit);

/* Module information */
MODULE_DESCRIPTION("ALSA SoC FSI WM8804");
MODULE_LICENSE("GPL")
