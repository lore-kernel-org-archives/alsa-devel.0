From: =?ISO-8859-1?Q?Andr=E1s_Tak=E1cs?= <atakacs@dension.com>
Subject: wm8727  and asoc atmel at91
Date: Mon, 30 Aug 2010 10:07:58 +0200
Message-ID: <4C7B66DE.7030803@dension.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ms.dension.com (ms.dension.com [195.56.193.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 4ABD924380
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Aug 2010 10:08:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by ms.dension.com (Postfix) with ESMTP id 120AA154E32
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Aug 2010 10:08:00 +0200 (CEST)
Received: from ms.dension.com ([127.0.0.1])
	by localhost (ms.dension.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HF7PkuD4SXKj for <alsa-devel@alsa-project.org>;
	Mon, 30 Aug 2010 10:07:59 +0200 (CEST)
Received: from [192.168.200.100] (digigw.dension.com [94.21.228.234])
	by ms.dension.com (Postfix) with ESMTPSA id 3523414BB4E
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Aug 2010 10:07:59 +0200 (CEST)
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

Dear All,

I would like to using a WM8727 codec on my board, which has at Atmel =

AT91SAM9261 processor.
I implemented the board specific part of the ASoC driver:

I'm trying to test it with: cat /dev/urandom > /dev/dsp
I'm getting the following error message in dmesg:
[    7.140000] ASoC: SSC0 device request OK
[    7.140000] ASoC: wm8727 device allocation OK
[    7.160000] asoc: WM8727 <-> atmel-ssc0 mapping ok
[    7.160000] SoC IRF WM8727 init
[    7.220000] ASoC: wm8727 device registration OK
[   16.330000] atmel_ssc_startup: SSC_SR=3D0x204
[   16.440000] SoC IRF WM8727 hw_params: cpu_dai
[   16.440000] SoC IRF WM8727 hw_params OK
[   16.440000] atmel_ssc_hw_params: RCMR=3D00010721 RFMR=3D0000008f =

TCMR=3D00010702 TFMR=3D0000008f
[   16.440000] atmel_ssc_dai: Starting clock
[   16.440000] atmel_ssc_dai,hw_params: SSC initialized
[   16.440000] transmit enabled SSC_SR=3D0x000104cf
[  210.850000] ALSA sound/core/pcm_lib.c:1758: playback write error (DMA =

or IRQ trouble?)
[  210.850000] ALSA sound/core/pcm_lib.c:1758: playback write error (DMA =

or IRQ trouble?)
[  220.850000] ALSA sound/core/pcm_native.c:1492: playback drain error =

(DMA or IRQ trouble?)
[  220.850000] atmel_ssc_shutdown: transmit disabled SSC_SR=3D0x000000c0
[  220.850000] atmel_ssc_dau: Stopping clock

Did anybody used this codec before? What's missing from my code?

My source code:

static int soc_irf_wm8727_hw_params(struct snd_pcm_substream *substream, =

struct snd_pcm_hw_params *params)
{
     struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
     struct snd_soc_dai *cpu_dai =3D rtd->dai->cpu_dai;
     int ret;

     printk("SoC IRF WM8727 hw_params: cpu_dai\n");

     /* set cpu DAI configuration */
     ret =3D snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
         SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
     if (ret < 0)
         return ret;

     printk("SoC IRF WM8727 hw_params OK\n");

     return 0;
}

static struct snd_soc_ops soc_irf_wm8727_ops =3D {
     .hw_params =3D soc_irf_wm8727_hw_params,
};

static int soc_irf_wm8727_init(struct snd_soc_codec *codec)
{
     printk("SoC IRF WM8727 init\n");

     return 0;
}

static struct snd_soc_dai_link soc_irf_wm8727_dai[] =3D {
     {
         .name =3D "WM8727",
         .stream_name =3D "WM8727 PCM",
         .cpu_dai =3D &atmel_ssc_dai[0],
         .codec_dai =3D &wm8727_dai,
         .init =3D soc_irf_wm8727_init,
         .ops =3D &soc_irf_wm8727_ops,
     }
};

static struct snd_soc_card snd_soc_wm8727_irf =3D {
     .name =3D "SOC_IRF_WM8727",
     .platform =3D &atmel_soc_platform,
     .dai_link =3D soc_irf_wm8727_dai,
     .num_links =3D ARRAY_SIZE(soc_irf_wm8727_dai),
};

static struct snd_soc_device soc_irf_wm8727_snd_devdata =3D {
     .card =3D &snd_soc_wm8727_irf,
     .codec_dev =3D &soc_codec_dev_wm8727,
};

static struct platform_device *soc_irf_wm8727_snd_device;

static int __init soc_irf_init(void)
{
     struct atmel_ssc_info *ssc_p_wm8727 =3D =

soc_irf_wm8727_dai[0].cpu_dai->private_data;
     struct ssc_device *ssc =3D NULL;
     int ret;

     /* Request SSC device */
     ssc =3D ssc_request(0);
     if (IS_ERR(ssc)) {
         printk(KERN_ERR "ASoC: Failed to request SSC 0\n");
         ret =3D PTR_ERR(ssc);
         ssc =3D NULL;
         goto err;
     }
     ssc_p_wm8727->ssc =3D ssc;
     printk("ASoC: SSC0 device request OK\n");

     at91_set_B_periph(AT91_PIN_PA17, 1);
     at91_set_B_periph(AT91_PIN_PA18, 1);
     at91_set_B_periph(AT91_PIN_PA19, 1);

     /* WM8727 codec */
     soc_irf_wm8727_snd_device =3D platform_device_alloc("soc-audio", 1);
     if (!soc_irf_wm8727_snd_device) {
         printk(KERN_ERR "ASoC: Platform device allocation failed: =

wm8727\n");
         ret =3D -ENOMEM;
         goto err_ssc;
     }
     printk("ASoC: wm8727 device allocation OK\n");

     platform_set_drvdata(soc_irf_wm8727_snd_device, =

&soc_irf_wm8727_snd_devdata);
     soc_irf_wm8727_snd_devdata.dev =3D &soc_irf_wm8727_snd_device->dev;

     ret =3D platform_device_add(soc_irf_wm8727_snd_device);
     if (ret) {
         printk(KERN_ERR "ASoC: Platform device allocation failed: =

wm8727\n");
         ret =3D -ENODEV;
         goto err_wm8727;
     }
     printk("ASoC: wm8727 device registration OK\n");

     return ret;

err_ssc:
     ssc_free(ssc);
     ssc_p_wm8727->ssc =3D NULL;
err:
     return ret;
}

static void __exit soc_irf_exit(void)
{
     struct atmel_ssc_info *ssc_p_wm8727 =3D =

soc_irf_wm8727_dai[0].cpu_dai->private_data;
     struct ssc_device *ssc;

     if (ssc_p_wm8727 !=3D NULL) {
         ssc =3D ssc_p_wm8727->ssc;
         if (ssc !=3D NULL)
             ssc_free(ssc);
         ssc_p_wm8727->ssc =3D NULL;
     }

     platform_device_unregister(soc_irf_wm8727_snd_device);
     soc_irf_wm8727_snd_device =3D NULL;
}

module_init(soc_irf_init);
module_exit(soc_irf_exit);

Thank you for your help!

BR,
Andr=E1s
