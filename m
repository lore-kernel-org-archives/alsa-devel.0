From: George Stefan <stefan.george87@gmail.com>
Subject: Re: SAIF configuration on imx28
Date: Wed, 22 Aug 2012 11:25:27 +0300
Message-ID: <CAACwST+=owJQ+KGAKYLgpGY4k1hGNSC4ptSGMyVObSRpUightQ@mail.gmail.com>
References: <CAACwSTK-fzSy+HG+u5H0aNU_wfSa7gvAsH2fVMdczssnYtpJXw@mail.gmail.com>
 <CAOMZO5C9ezzU7S0M-AN0f8gk7SBWs3WNbA6cG2S+7BF8j+dVxA@mail.gmail.com>
 <CAACwSTKiN17gAHnUs5BoHZH_K5NNo0z7X9QbVRFu9FZGCUw2mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
 [209.85.215.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 80DD5265205
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2012 10:25:26 +0200 (CEST)
Received: by eaa13 with SMTP id 13so166486eaa.38
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2012 01:25:27 -0700 (PDT)
In-Reply-To: <CAACwSTKiN17gAHnUs5BoHZH_K5NNo0z7X9QbVRFu9FZGCUw2mg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dong Aisheng <b29396@freescale.com>, Lauri Hintsala <lauri.hintsala@bluegiga.com>
List-Id: alsa-devel@alsa-project.org

2012/8/21 George Stefan <stefan.george87@gmail.com>

>
>
> 2012/8/21 Fabio Estevam <festevam@gmail.com>
>
>> Hi George,
>>
>> On Tue, Aug 21, 2012 at 8:24 AM, George Stefan
>> <stefan.george87@gmail.com> wrote:
>>
>> > My problem is, although i am receiving dma irqs when i record ( arecord
>> -f
>> > S16_LE -r 8000 -c 1 <file>.wav), when i play the resulting file its just
>> > silence.
>> >
>> > [ 5295.890000] dump @ mxs_saif_trigger
>> > [ 5295.890000] scr 101  , 107
>> > [ 5295.890000] stat 80010041    , 80010071
>> > [ 5295.890000] data 0   , ffffffff
>> > [ 5295.890000] version 1010000  , 1010000
>> > This  is a dump for arecord!
>> >
>> > Do you have any ideeas?
>>
>> Can you please to record as:
>> arecord -D hw:0,1 -d 5 -f S16_LE -r 44100 -c 2 1.wav
>>
>> ,as suggested here:
>> http://www.spinics.net/lists/arm-kernel/msg186015.html
>>
>> Regards,
>>
>> Fabio Estevam
>>
> I don't think thats the issue.
> In order to be more clear i will attach the code:
>
> /* This is the codec code */
> static struct snd_soc_codec *cinterion_codec;
> /*
>  * Line discpline related code
>  *
>  * Any of the callback functions below can be used in two ways:
>  * 1) registerd by a machine driver as one of line discipline operations,
>  * 2) called from a machine's provided line discipline callback function
>  *    in case when extra machine specific code must be run as well.
>  */
>
> static const char *init_audio_mode = "AT^SNFS=6/r";
> /* Please see pg 422 of AHS3-W AT Command Set */
> static const char *init_pcm_audio = "AT^SAIC=1,1,1,1,0,0,1/r";
>
> /* Line discipline .open() */
> static int cinterion_tty_open(struct tty_struct *tty)
> {
>         int len = strlen(init_audio_mode);
>         int ret;
>         struct snd_soc_codec *codec = cinterion_codec;
>
> /* Doesn't make sense without write callback */
> if (!tty->ops->write)
>  return -EINVAL;
>
> /* Pass the codec structure address for use by other ldisc callbacks */
> tty->disc_data = codec;
>
> if (tty->ops->write(tty, init_audio_mode, len) != len) {
> ret = -EIO;
> return ret;
>  }
>
> len = strlen(init_pcm_audio);
> if (tty->ops->write(tty, init_pcm_audio, len) != len) {
>  ret = -EIO;
> return ret;
> }
> /* Actual setup will be performed after the modem responds. */
>  return 0;
>
> err:
> tty->disc_data = NULL;
> return ret;
> }
>
>
> /* Line discipline .receive_buf() */
> static void cinterion_tty_receive(struct tty_struct *tty,
> const unsigned char *cp, char *fp, int count)
> {
> struct snd_soc_codec *codec = tty->disc_data;
> if (!codec)
> return;
>
> if (!codec->control_data) {
> /* First modem response, complete setup procedure */
>
>  /* Set up codec driver access to modem controls */
> codec->control_data = tty;
> codec->hw_write = (hw_write_t)tty->ops->write;
>  codec->pop_time = 1;
> }
> }
>
> /* Line discipline .close() */
> static void cinterion_tty_close(struct tty_struct *tty)
> {
> struct snd_soc_codec *codec = tty->disc_data;
>
> tty->disc_data = NULL;
>
>  if (!codec)
> return;
>
> /* Prevent the codec driver from further accessing the modem */
>  codec->hw_write = NULL;
> codec->control_data = NULL;
> codec->pop_time = 0;
> }
>
> struct tty_ldisc_ops cinterion_tty_ops = {
> .magic = TTY_LDISC_MAGIC,
> .name  = "cinterion-ahs3w",
>  .owner = THIS_MODULE,
> .open  = cinterion_tty_open,
> .close = cinterion_tty_close,
>  .receive_buf = cinterion_tty_receive,
> };
> EXPORT_SYMBOL_GPL(cinterion_tty_ops);
>
> struct snd_soc_dai cinterion_codec_dai = {
>  .name            = "cinterion",
> .playback        = {
> .channels_min = 1,
>  .channels_max = 2,
> .rates =  SNDRV_PCM_RATE_8000,
> .formats = SNDRV_PCM_FMTBIT_S16_LE,
>  },
> .capture = {
> .channels_min = 1,
> .channels_max = 2,
>  .rates =  SNDRV_PCM_RATE_8000,
> .formats = SNDRV_PCM_FMTBIT_S16_LE,
> },
> };
> EXPORT_SYMBOL_GPL(cinterion_codec_dai);
>
> static int cinterion_soc_probe(struct platform_device *pdev)
> {
>
> struct snd_soc_device *socdev = platform_get_drvdata(pdev);
>  struct snd_soc_codec *codec;
> int ret = 0;
>
> if (!cinterion_codec) {
>  dev_err(&pdev->dev, "cinterion codec not yet discovered\n");
> return -ENODEV;
> }
>  codec = cinterion_codec;
> socdev->card->codec = codec;
>
> ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
>  if (ret < 0) {
> printk(KERN_ERR "cinterion: failed to create pcms\n");
> goto pcm_err;
>  }
> return ret;
>
> pcm_err:
> return ret;
> }
>
> static int cinterion_soc_remove(struct platform_device *pdev)
> {
>
> struct snd_soc_device *socdev = platform_get_drvdata(pdev);
>
> snd_soc_free_pcms(socdev);
>
> return 0;
> }
>
> struct snd_soc_codec_device soc_codec_dev_cinterion = {
>  .probe =        cinterion_soc_probe,
> .remove =       cinterion_soc_remove,
> };
> EXPORT_SYMBOL_GPL(soc_codec_dev_cinterion);
>
> static __devinit int cinterion_codec_probe(struct platform_device *pdev)
> {
> struct snd_soc_codec *codec;
> int ret;
>
> if (cinterion_codec) {
> printk(KERN_ERR "Cinterion is allready registered\n");
> return -EBUSY;
>  }
>
> codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
> if(codec == NULL)
>  return -ENOMEM;
>
>
> codec->control_data = NULL;
> codec->hw_write = NULL;
>  codec->pop_time = 0;
>
> cinterion_codec = codec;
>
> platform_set_drvdata(pdev, codec);
>  mutex_init(&codec->mutex);
> codec->dev = &pdev->dev;
> codec->name = "cinterion";
>  codec->owner = THIS_MODULE;
> codec->dai = &cinterion_codec_dai;
> codec->num_dai = 1;
>  INIT_LIST_HEAD(&codec->dapm_widgets);
> INIT_LIST_HEAD(&codec->dapm_paths);
>
> cinterion_codec_dai.dev = &pdev->dev;
>
> ret = snd_soc_register_codec(codec);
> if (ret != 0) {
> dev_err(&pdev->dev, "Failed to register CODEC: %d\n", ret);
>  goto err;
> }
>
> ret = snd_soc_register_dai(&cinterion_codec_dai);
>  if (ret != 0) {
> dev_err(&pdev->dev, "Failed to register DAI: %d\n", ret);
> goto err_codec;
>  }
> return 0;
>
>
> err_codec:
> snd_soc_unregister_codec(codec);
> err:
> kfree(codec);
> return ret;
> }
>
>
> static __devexit int cinterion_codec_remove(struct platform_device *pdev)
> {
> snd_soc_unregister_dai(&cinterion_codec_dai);
> snd_soc_unregister_codec(platform_get_drvdata(pdev));
>  return 0;
> }
>
> static struct platform_driver cinterion_codec_driver = {
> .driver = {
>  .name = DRV_NAME,
> .owner = THIS_MODULE,
>  },
>
> .probe = cinterion_codec_probe,
> .remove = __devexit_p(cinterion_codec_remove),
> };
>
> static int __init cinterion_codec_modinit(void)
> {
> return platform_driver_register(&cinterion_codec_driver);
> }
>
> static void __exit cinterion_codec_exit(void)
> {
> platform_driver_unregister(&cinterion_codec_driver);
> }
>
> module_init(cinterion_codec_modinit);
> module_exit(cinterion_codec_exit);
>
>
> mxs-devb.c code
> #include "../codecs/cinterion-ahs3w.h"
>
> struct mxs_evk_priv {
> int sysclk;
> int hw;
> struct platform_device *pdev;
> };
>
> static struct mxs_evk_priv card_priv;
>
> /* this should be implemented */
> static int mxs_acu2_audio_hw_params(struct snd_pcm_substream *substream,
>        struct snd_pcm_hw_params *params)
> {
> struct snd_soc_pcm_runtime *rtd = substream->private_data;
>         struct snd_soc_dai_link *machine = rtd->dai;
>         struct snd_soc_dai *cpu_dai = machine->cpu_dai;
>         struct mxs_evk_priv *priv = &card_priv;
>
> unsigned int rate = params_rate(params);
>  int ret = 0;
>
> u32 dai_format;
> /* only need to do this once as capture and playback are sync */
> #if 0
> if (priv->hw)
> return 0;
>
> priv->hw = 1;
>  priv->sysclk = 512 * rate;
>
>         printk("sysclk %lu\n", priv->sysclk);
>         snd_soc_dai_set_clkdiv(cpu_dai, IMX_SSP_SYS_MCLK, 256);
> #endif
>         /* set cpu_dai to master mode for playback, slave mode for record
> */
>         //       dai_format = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
>         //       SND_SOC_DAIFMT_CBM_CFM;
>
>         dai_format = SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_IB_NF |
>              SND_SOC_DAIFMT_CBM_CFM;
>  /* set cpu DAI configuration */
> ret = snd_soc_dai_set_fmt(cpu_dai, dai_format);
> if (ret < 0)
>              return ret;
> #if 0
>         /* set the SAIF system clock as output */
> snd_soc_dai_set_sysclk(cpu_dai, IMX_SSP_SYS_CLK, priv->sysclk,  \
>  SND_SOC_CLOCK_OUT);
>         snd_soc_dai_set_sysclk(cpu_dai, IMX_SSP_SYS_CLK, 256000,
> SND_SOC_CLOCK_OUT);
> #endif
>
>         snd_soc_dai_set_sysclk(cpu_dai, IMX_SSP_SYS_CLK, 0,
> SND_SOC_CLOCK_IN);
>         return 0;
> }
>
> /*
>  * mxs_acu2 Cinterion audio DAI operations.
>  */
> static struct snd_soc_ops mxs_acu2_ops = {
> .hw_params = mxs_acu2_audio_hw_params,
> };
>
> /* Line discipline .open() */
> static int cinterion_ahs3w_open(struct tty_struct *tty)
> {
>   return cinterion_tty_ops.open(tty);
> }
>
> /* Line discipline .receive_buf() */
> static void cinterion_ahs3w_receive(struct tty_struct *tty,
> const unsigned char *cp, char *fp, int count)
> {
> struct snd_soc_codec *codec = tty->disc_data;
> const unsigned char *c;
> int apply, ret;
>
> /* First modem response...must complete setup */
> if (!codec->control_data) {
> cinterion_tty_ops.receive_buf(tty, cp, fp, count);
>  return ;
> }
>       cinterion_tty_ops.receive_buf(tty, cp, fp, count);
>         printk("count %d\n", count);
> }
>
> /* Line discipline .close() */
> static void cinterion_ahs3w_close(struct tty_struct *tty)
> {
> struct snd_soc_codec *codec = tty->disc_data;
>  cinterion_tty_ops.close(tty);
> }
>
> static struct tty_ldisc_ops cinterion_ahs3w_ops = {
> .magic = TTY_LDISC_MAGIC,
>  .name = "cinterion_ahs3w",
> .owner = THIS_MODULE,
> .open = cinterion_ahs3w_open,
>  .close = cinterion_ahs3w_close,
> .receive_buf = cinterion_ahs3w_receive,
> };
>
> /*
>  * Card initialization
>  */
> static int mxs_cinterion_init(struct snd_soc_codec *codec)
> {
> struct snd_soc_dai *codec_dai = codec->dai;
>  int ret;
>
>             /* Register optional line discipline for over the modem
> control */
>
> ret = tty_register_ldisc(N_V253, &cinterion_ahs3w_ops);
>  if (ret)
> printk(KERN_ERR,
>                        "Failed to register line discipline, "
>                        "will continue without any controls.\n");
>         return ret;
> }
>
> /* mxs_evk digital audio interface glue - connects codec <--> CPU */
> static struct snd_soc_dai_link acu2_dai = {
> .name = "cinterion",
>  .stream_name = "cinterion pcm",
> .codec_dai = &cinterion_codec_dai,
>         .init = mxs_cinterion_init,
>  .ops = &mxs_acu2_ops,
> };
>
> /* SoC machine structure */
> static struct snd_soc_card acu2_snd_soc_card = {
> .name = "mxs-evk",
>  .platform = &mxs_soc_platform,
> .dai_link = &acu2_dai,
> .num_links = 1,
> };
>
> static struct snd_soc_device acu2_snd_soc_device = {
>         .card = &acu2_snd_soc_card,
>         .codec_dev = &soc_codec_dev_cinterion,
> };
>
> static int __devinit mxs_evk_cinterion_probe(struct platform_device *pdev)
> {
> struct mxs_audio_platform_data *plat = pdev->dev.platform_data;
>  struct mxs_saif *saif_select;
> int ret = -EINVAL;
>
>         /* saif 0 and 1 clocks and stuff */
>  if (plat->init && plat->init())
>           goto err_plat_init;
>
>         acu2_dai.cpu_dai = &mxs_saif_dai[0]; /* adds the cpu dai */
>         acu2_dai.cpu_dai->name = "imx28-dai";
> saif_select = (struct mxs_saif *)acu2_dai.cpu_dai->private_data;
> saif_select->stream_mapping = PLAYBACK_SAIF0_CAPTURE_SAIF1;
>  saif_select->saif_mclk = plat->saif_mclock;
> saif_select->saif_clk = SAIF0;
> return 0;
> err_plat_init:
> if (plat->finit)
> plat->finit();
> return ret;
> }
>
>
> static int mxs_evk_cinterion_remove(struct platform_device *pdev)
> {
> struct mxs_audio_platform_data *plat = pdev->dev.platform_data;
>
> if (plat->finit)
> plat->finit();
> return 0;
> }
>
> /* audio platform driver */
> static struct platform_driver acu2_cinterion_audio_driver = {
> .probe = mxs_evk_cinterion_probe,
>  .remove = mxs_evk_cinterion_remove,
> .driver = {
>    .name = "mxs-sgtl5000",
>     },
> };
>
> static struct platform_device *acu2_snd_platform_device;
> static struct platform_device *cinterion_codec_platform_device;
>
> static int __init mxs_acu2_init(void)
> {
> int ret;
>
> ret = platform_driver_register(&acu2_cinterion_audio_driver);
>  if (ret)
> return -ENOMEM;
>
> acu2_snd_platform_device = platform_device_alloc("soc-audio", 1);
>  if (!acu2_snd_platform_device) {
>                  printk(KERN_ERR "Platform device allocation failed\n");
> return -ENOMEM;
>         }
>
> platform_set_drvdata(acu2_snd_platform_device, &acu2_snd_soc_device);
> acu2_snd_soc_device.dev = &acu2_snd_platform_device->dev;
>  ret = platform_device_add(acu2_snd_platform_device);
> if (ret)
>              platform_device_put(acu2_snd_platform_device);
>
>         cinterion_codec_platform_device =
> platform_device_register_simple("cinterion",
>                                                                 -1, NULL,
> 0);
>
>  return ret;
> }
>
> static void __exit mxs_acu2_exit(void)
> {
>      platform_device_unregister(acu2_snd_platform_device);
> }
>
> module_init(mxs_acu2_init);
> module_exit(mxs_acu2_exit);
>
> Also the dump of arecord -d 5 -f S16_LE -r 8000 -c 2 1.wav
> hexdump -C test.wav
> 00000000  52 49 46 46 04 ca 55 00  57 41 56 45 66 6d 74 20
>  |RIFF..U.WAVEfmt |
> 00000010  10 00 00 00 01 00 02 00  44 ac 00 00 10 b1 02 00
>  |........D.......|
> 00000020  04 00 10 00 64 61 74 61  e0 c9 55 00 00 00 00 00
>  |....data..U.....|
> 00000030  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
>  |................|
> *
> 00562020
>

Also, the output from aplay and arecord.
aplay -l**** List of PLAYBACK Hardware Devices ****card 0: mxsevk
[mxs-evk], device 0: cinterion pcm cinterion-0 []  Subdevices: 1/1
Subdevice #0: subdevice #0

~ # arecord -l
**** List of CAPTURE Hardware Devices ****
card 0: mxsevk [mxs-evk], device 0: cinterion pcm cinterion-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0

What is the cause of receiving just FF ?
>From my perspective its something related to the configuration of the SAIF.

Regards,
George
