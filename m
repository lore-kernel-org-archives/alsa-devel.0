From: Rodolfo Giometti <giometti@enneenne.com>
Subject: SoC on PXA27x with two codecs
Date: Tue, 2 Feb 2010 10:58:18 +0100
Message-ID: <20100202095818.GH1854@enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.enneenne.com (81-174-11-161.static.ngi.it [81.174.11.161])
	by alsa0.perex.cz (Postfix) with ESMTP id 81EC6243BB
	for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2010 10:58:21 +0100 (CET)
Received: from tekkaman.enneenne.com ([192.168.32.37] helo=tekkaman)
	by mail.enneenne.com with esmtp (Exim 4.69)
	(envelope-from <giometti@enneenne.com>) id 1NcDeU-0004Su-5M
	for alsa-devel@alsa-project.org; Tue, 02 Feb 2010 08:58:28 +0100
Received: from giometti by tekkaman with local (Exim 4.69)
	(envelope-from <giometti@enneenne.com>) id 1NcFWU-0000ZQ-Cf
	for alsa-devel@alsa-project.org; Tue, 02 Feb 2010 10:58:18 +0100
Content-Disposition: inline
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

Hello,

on my custom board I have a PXA27x CPU and 2 codecs: one connected as
primary codec and one connected as secondary codec.

I modify the SoC support in order to allow defining two audio cards,
one to manage the first codec and one to manage the second one.

Here the SoC schema:

   static struct snd_soc_dai_link bt270p_dai[] = {
           {
                   .name = "AC97 HiFi",
                   .stream_name = "audio out",
                   .cpu_dai = &pxa_ac97_dai[PXA2XX_DAI_AC97_HIFI],
                   .codec_dai = &cs4299_dai[CS4299_DAI_AC97_HIFI],
                   .init = bt270_ac97_init,
                   .ops = &bt270_ops,
           },
           {
                   .name = "AC97 Aux",
                   .stream_name = "AC97 Aux",
                   .cpu_dai = &pxa_ac97_dai[PXA2XX_DAI_AC97_AUX],
                   .codec_dai = &cs4299_dai[CS4299_DAI_AC97_AUX],
                   .init = bt270_ac97_init,
                   .ops = &bt270_ops,
           },
   };

   static struct snd_soc_dai_link bt270s_dai[] = {
           {
                   .name = "AC97 HiFi",
                   .stream_name = "speakers",
                   .cpu_dai = &pxa_ac97_dai[PXA2XX_DAI_AC97_HIFI],
                   .codec_dai = &cs4299_dai[CS4299_DAI_AC97_HIFI],
                   .init = bt270_ac97_init,
                   .ops = &bt270_ops,
           },
   };

   static struct snd_soc_card bt270_asoc[] = {
           {
                   .name = "BT270 primary",
                   .platform = &pxa2xx_soc_platform,
                   .dai_link = bt270p_dai,
                   .num_links = ARRAY_SIZE(bt270p_dai),
           },
           {
                   .name = "BT270 secondary",
                   .platform = &pxa2xx_soc_platform,
                   .dai_link = bt270s_dai,
                   .num_links = ARRAY_SIZE(bt270s_dai),
           },
   };

   static struct cs4299_data cs4299_data[] = {
           {
                   .ac97_line = 0,
           },
           {
                   .ac97_line = 1,
           },
   };

   static struct snd_soc_device bt270_snd_devdata[2] = {
           {
                   .card = &bt270_asoc[0],
                   .codec_dev = &soc_codec_dev_cs4299,
                   .codec_data = &cs4299_data[0],
           },
           {
                   .card = &bt270_asoc[1],
                   .codec_dev = &soc_codec_dev_cs4299,
                   .codec_data = &cs4299_data[1],
           },
   };

   static struct platform_device *bt270_snd_device[2];

I'm using the ac97_line parameters into codec's code in order to
select the primary and the second codecs as follow:

   static int cs4299_soc_probe(struct platform_device *pdev)
   {
           struct snd_soc_device *socdev = platform_get_drvdata(pdev);
           struct cs4299_data *data = (struct cs4299_data *) socdev->codec_data;
           struct snd_soc_codec *codec;
           int ac97_line;
           int ret = 0;

           printk(KERN_INFO "CS4299 SoC Audio Codec %s\n", CS4299_VERSION);

           /* Check specific codec data or set default if not defined */
           ac97_line = 0;
           if (data)
                   ac97_line = data->ac97_line;

           socdev->card->codec = kzalloc(sizeof(struct snd_soc_codec),
                                         GFP_KERNEL);
           if (socdev->card->codec == NULL)
                   return -ENOMEM;
           codec = socdev->card->codec;
           mutex_init(&codec->mutex);

           codec->reg_cache = kmemdup(cs4299_reg, sizeof(cs4299_reg), GFP_KERNEL);

           if (codec->reg_cache == NULL) {
                   ret = -ENOMEM;
                   goto cache_err;
           }
           codec->reg_cache_size = sizeof(cs4299_reg);
           codec->reg_cache_step = 2;

           codec->name = "CS4299";
           codec->id = ac97_line;
           codec->owner = THIS_MODULE;
           codec->dai = cs4299_dai;
           codec->num_dai = ARRAY_SIZE(cs4299_dai);
           codec->write = ac97_write;
           codec->read = ac97_read;
           INIT_LIST_HEAD(&codec->dapm_widgets);
           INIT_LIST_HEAD(&codec->dapm_paths);

           ret = snd_soc_new_ac97_codec(codec, &soc_ac97_ops, ac97_line);
           if (ret < 0) {
                   printk(KERN_ERR "cs4299: failed to register AC97
   		codec\n");
                   goto codec_err;
           }

           /* register pcms */
           ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
           if (ret < 0)
                   goto pcm_err;

           ret = cs4299_reset(codec, 0);
           if (ret < 0) {
                   printk(KERN_ERR "Failed to reset CS4299: AC97 link
   		error\n");
                   goto reset_err;
           }

           snd_soc_add_controls(codec, cs4299_snd_ac97_controls,
                                   ARRAY_SIZE(cs4299_snd_ac97_controls));
           cs4299_add_widgets(codec);
           ret = snd_soc_init_card(socdev);
           if (ret < 0) {
                   printk(KERN_ERR "cs4299: failed to register card\n");
                   goto reset_err;
           }

           return 0;

Everything is working ok but the PCM play/record. In fact I can manage
both codecs' registers by using:

   alsamixer -c 0   and
   alsamixer -c 1

but when I try to play an MP3 file I can hear the music only on the
second codec no matter which audio card I select for playing.

I tested the hardware by defining just one codec at time, and doing in
this manner the music goes to the right codec.

Any suggeston? :)

Thanks in advance,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
