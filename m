From: Marc Garnier <marc.garnier@heig-vd.ch>
Subject: Re: capturing data from the microphone
Date: Wed, 6 Jan 2010 10:09:19 +0100
Message-ID: <4B44533F.8000401@heig-vd.ch>
References: <4B4227BC.70705@gmail.com>
	<4B4359A5.5060207@heig-vd.ch>	<4f3252891001051707n7e740ea5gcc217595ee354278@mail.gmail.com>	<4B444292.5070702@heig-vd.ch>
	<4f3252891001060046v798a4d42k5f3e1303323a64e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heig-vd.ch (mailcl1.heig-vd.ch [193.134.216.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D11A24509
	for <alsa-devel@alsa-project.org>; Wed,  6 Jan 2010 10:09:20 +0100 (CET)
Received: from [10.192.41.20] (helo=eintfe01.einet.ad.eivd.ch)
	by mailcl1.heig-vd.ch stage1 with esmtp (Exim MailCleaner)
	id 1NSRtG-0001pt-Fi for <alsa-devel@alsa-project.org>
	from <Marc.Garnier@heig-vd.ch>; Wed, 06 Jan 2010 10:09:18 +0100
In-Reply-To: <4f3252891001060046v798a4d42k5f3e1303323a64e2@mail.gmail.com>
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

Yep, as I said in previous post, actually no interrupt occur and I 
wonder why...
"AIC ss0" counter remains at zero :
# cat /proc/interrupts
           CPU0
  1:     275059         AIC  at91_tick, rtc0, ttyS0
  7:        179         AIC  ttyS2
  9:         11         AIC  mmc0
 13:          0         AIC  atmel_spi.1
 14:          0         AIC  ssc0
 82:          1        GPIO  alerte
107:       9464        GPIO  eth0

My sound divice is very simple, there isn't I2C ou SPI control bus, only 
PCM. Clock is always provided by this device (SND_SOC_DAIFMT_CBM_CFM). 
There are my driver files :

sound/soc/atmel/myplateform_q2686.c :

#include ...
[....]

#include "../codecs/q2686.h"
#include "atmel-pcm.h"
#include "atmel_ssc_dai.h"

#define CODEC_CLOCK 12000000

static int provabox_hw_params(struct snd_pcm_substream *substream,
    struct snd_pcm_hw_params *params)
{
    struct snd_soc_pcm_runtime *rtd = substream->private_data;
    struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
    struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;

    int ret;

    /* set codec DAI configuration */
    ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
        SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
    if (ret < 0)
        return ret;

    /* set cpu DAI configuration */
    ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
        SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
    if (ret < 0)
        return ret;

    return 0;
}

static struct snd_soc_ops provabox_ops = {
    .hw_params = provabox_hw_params,
};

/*
 * Logic for a q2686 as connected on a provabox board.
 */
static int provabox_q2686_init(struct snd_soc_codec *codec)
{
    printk(KERN_DEBUG
            "provabox_q2686 "
            ": provabox_q2686_init() called\n");

    return 0;
}

static struct snd_soc_dai_link provabox_dai = {
    .name = "Q2686",
    .stream_name = "Q2686 PCM",
    .cpu_dai = &atmel_ssc_dai[0],
    .codec_dai = &q2686_dai,
    .init = provabox_q2686_init,
    .ops = &provabox_ops,
};

static struct snd_soc_card snd_soc_provabox = {
    .name = "PROVABOX",
    .platform = &atmel_soc_platform,
    .dai_link = &provabox_dai,
    .num_links = 1,
};

static struct snd_soc_device provabox_snd_devdata = {
    .card = &snd_soc_provabox,
    .codec_dev = &soc_codec_dev_q2686,
};

static struct platform_device *provabox_snd_device;

static int __init provabox_init(void)
{
    struct atmel_ssc_info *ssc_p = provabox_dai.cpu_dai->private_data;
    struct ssc_device *ssc = NULL;
    int ret;

    /*
     * Request SSC device
     */
    ssc = ssc_request(0);
    if (IS_ERR(ssc)) {
        printk(KERN_ERR "ASoC: Failed to request SSC 0\n");
        ret = PTR_ERR(ssc);
        ssc = NULL;
        goto err_ssc;
    }
    ssc_p->ssc = ssc;

    provabox_snd_device = platform_device_alloc("soc-audio", -1);
    if (!provabox_snd_device) {
        printk(KERN_ERR "ASoC: Platform device allocation failed\n");
        ret = -ENOMEM;
    }

    platform_set_drvdata(provabox_snd_device,
            &provabox_snd_devdata);
    provabox_snd_devdata.dev = &provabox_snd_device->dev;

    ret = platform_device_add(provabox_snd_device);
    if (ret) {
        printk(KERN_ERR "ASoC: Platform device allocation failed\n");
        platform_device_put(provabox_snd_device);
    }

    return ret;

err_ssc:
    ssc_free(ssc);
    ssc_p->ssc = NULL;
    return ret;
}

static void __exit provabox_exit(void)
{
    struct atmel_ssc_info *ssc_p = provabox_dai.cpu_dai->private_data;
    struct ssc_device *ssc;

    if (ssc_p != NULL) {
        ssc = ssc_p->ssc;
        if (ssc != NULL)
            ssc_free(ssc);
        ssc_p->ssc = NULL;
    }

    platform_device_unregister(provabox_snd_device);
    provabox_snd_device = NULL;
}

module_init(provabox_init);
module_exit(provabox_exit);

/* Module information */
MODULE_AUTHOR("Marc Garnier");
MODULE_DESCRIPTION("ALSA SoC PROVABOX_Q2686");
MODULE_LICENSE("GPL");


----------------- codec file -----------------

sound/soc/codecs/q2686.c

#include ...
[...]

#include "q2686.h"

#define Q2686_VERSION "0.2"
#define Q2686_RATES (SNDRV_PCM_RATE_8000_192000)
#define Q2686_FORMATS (SNDRV_PCM_FMTBIT_S16_LE)

static int q2686_hw_params(struct snd_pcm_substream *substream,
    struct snd_pcm_hw_params *params,
    struct snd_soc_dai *dai)
{
    struct snd_soc_pcm_runtime *rtd = substream->private_data;
    struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
    int ret = 0;
    //ret = snd_soc_dai_set_tdm_slot(cpu_dai, );
    if (ret < 0)
        return ret;

    return 0;
}

static int q2686_set_dai_fmt(struct snd_soc_dai *codec_dai,
        unsigned int fmt)
{
    return 0;
}

static int q2686_pcm_prepare(struct snd_pcm_substream *substream,
                  struct snd_soc_dai *dai)
{
    return 0;
}

static int q2686_mute(struct snd_soc_dai *dai, int mute)
{
    return 0;
}

static void q2686_shutdown(struct snd_pcm_substream *substream,
                struct snd_soc_dai *dai)
{
}

static int q2686_set_dai_sysclk(struct snd_soc_dai *codec_dai,
        int clk_id, unsigned int freq, int dir)
{
    return 0;
}

static struct snd_soc_dai_ops q2686_dai_ops = {
    .prepare    = q2686_pcm_prepare,
    .hw_params    = q2686_hw_params,
    .shutdown    = q2686_shutdown,
    .digital_mute    = q2686_mute,
    .set_sysclk    = q2686_set_dai_sysclk,
    .set_fmt    = q2686_set_dai_fmt,
};

static int q2686_soc_probe(struct platform_device *pdev)
{
    struct snd_soc_device *socdev = platform_get_drvdata(pdev);
    struct snd_soc_codec *codec;
    int ret = 0;

    printk(KERN_INFO "Q2686 SoC Audio Codec %s\n", Q2686_VERSION);

    socdev->card->codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
    if (!socdev->card->codec)
        return -ENOMEM;

    codec = socdev->card->codec;
    mutex_init(&codec->mutex);

    codec->name = "Q2686";
    codec->owner = THIS_MODULE;
    codec->dai = &q2686_dai;
    codec->num_dai = 1;
    codec->write = NULL;
    codec->read = NULL;
    INIT_LIST_HEAD(&codec->dapm_widgets);
    INIT_LIST_HEAD(&codec->dapm_paths);

    /* Register PCMs. */
    ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
    if (ret < 0) {
        printk(KERN_ERR "Q2686: failed to create pcms\n");
        goto pcm_err;
    }

    /* Register Card. */
    ret = snd_soc_init_card(socdev);
    if (ret < 0) {
        printk(KERN_ERR "Q2686: failed to register card\n");
        goto card_err;
    }

    return ret;

card_err:
    snd_soc_free_pcms(socdev);
pcm_err:
    kfree(socdev->card->codec);

    return ret;
}

static int q2686_soc_remove(struct platform_device *pdev)
{
    struct snd_soc_device *socdev = platform_get_drvdata(pdev);
    struct snd_soc_codec *codec = socdev->card->codec;

    if (!codec)
        return 0;

    snd_soc_free_pcms(socdev);
    kfree(socdev->card->codec);

    return 0;
}

struct snd_soc_dai q2686_dai = {
    .name = "Q2686",
    .playback = {
        .stream_name = "Playback",
        .channels_min = 1,
        .channels_max = 2,
        .rates = Q2686_RATES,
        .formats = Q2686_FORMATS,
    },
    .capture = {
        .stream_name = "Capture",
        .channels_min = 1,
        .channels_max = 2,
        .rates = Q2686_RATES,
        .formats = Q2686_FORMATS,},
    .ops = &q2686_dai_ops,
    .symmetric_rates = 1,
};
EXPORT_SYMBOL_GPL(q2686_dai);

static int q2686_soc_suspend(struct platform_device *pdev, pm_message_t 
state)
{
    return 0;
}

static int q2686_soc_resume(struct platform_device *pdev)
{
    return 0;
}

struct snd_soc_codec_device soc_codec_dev_q2686 = {
    .probe =     q2686_soc_probe,
    .remove =     q2686_soc_remove,
    .suspend =    q2686_soc_suspend,
    .resume =    q2686_soc_resume,
};
EXPORT_SYMBOL_GPL(soc_codec_dev_q2686);

static int __init q2686_modinit(void)
{
    return snd_soc_register_dai(&q2686_dai);
}
module_init(q2686_modinit);

static void __exit q2686_exit(void)
{
    snd_soc_unregister_dai(&q2686_dai);
}
module_exit(q2686_exit);

MODULE_DESCRIPTION("ASoC Q2686 driver");
MODULE_AUTHOR("Marc Garnier");
MODULE_LICENSE("GPL");

Raymond Yau wrote:
> arecord: pcm_read:1629: read error: Input/output error
>
> This usually mean hardware interrupt did not not occur ( driver bug )
>
>
> 2010/1/6 Marc Garnier <marc.garnier@heig-vd.ch>
>
>   
>> Ok, let me go into details. I work on a custom device platform based on
>> an Atmel at91sam9261. I wrote an alsa driver composed of 2 files
>> (sound/soc/atmel/myplateform_q2686.c and sound/soc/codecs/q2686.c) and I
>> also add this line into arch/arm/mach-at91/board-myplateform.c :
>>
>> at91_add_device_ssc(AT91SAM9261_ID_SSC0, ATMEL_SSC_TX | ATMEL_SSC_RX);
>>
>> When I boot my device I can see that :
>> Q2686 SoC Audio Codec 0.2
>> asoc: Q2686 <-> atmel-ssc0 mapping ok
>> ALSA device list:
>>  #0: MYPLATFORM (Q2686)
>>
>> And everything ok with playback :
>> # aplay -c 1 tone.wav
>>
>> But when I want to record a pcm stream I have this error:
>> # arecord -v -c 1 -t wav -f S16_LE -r 8000 -d 10 input.wav
>> arecord: pcm_read:1629: read error: Input/output error
>>
>> Any more idea?
>>
>> Raymond Yau wrote:
>>     
>>> which device are you using ?  ( pulseaudio , dmix or default device
>>>       
>> defined
>>     
>>> in /usr/share/alsa/cards/*.conf )
>>>
>>> post output of
>>>
>>> arecord -v -c 1 -t wav -f S16_LE -r 8000 -d 10 input.wav
>>>
>>> 2010/1/5 Marc Garnier <marc.garnier@heig-vd.ch>
>>>
>>>
>>>       
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>   
