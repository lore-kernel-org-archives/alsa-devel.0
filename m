From: ccku <ccku1025@gmail.com>
Subject: soc_pcm_trigger
Date: Thu, 2 Jul 2009 11:35:24 +0800
Message-ID: <90a1645d0907012035r61500045pe03f257bedf76821@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f176.google.com (mail-pz0-f176.google.com
	[209.85.222.176])
	by alsa0.perex.cz (Postfix) with ESMTP id AEB9C24587
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Jul 2009 05:35:25 +0200 (CEST)
Received: by pzk6 with SMTP id 6so391934pzk.16
	for <alsa-devel@alsa-project.org>; Wed, 01 Jul 2009 20:35:24 -0700 (PDT)
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

in soc-core.c ,soc_pcm_trigger(),

The function only calls three sub-functions
codec_dai->ops->trigger
platform->pcm_ops->trigger
cpu_dai->ops->trigger

why not give machine a chance to run its trigger??
like machine->ops->trigger.
Thanks


static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
{
        struct snd_soc_pcm_runtime *rtd = substream->private_data;
        struct snd_soc_device *socdev = rtd->socdev;
        struct snd_soc_dai_link *machine = rtd->dai;
        struct snd_soc_card *card = socdev->card;
        struct snd_soc_platform *platform = card->platform;
        struct snd_soc_dai *cpu_dai = machine->cpu_dai;
        struct snd_soc_dai *codec_dai = machine->codec_dai;
        struct snd_soc_codec *codec = card->codec;
        mutex_lock(&pcm_mutex);
        /* apply codec digital mute */
        if (!codec->active)
                snd_soc_dai_digital_mute(codec_dai, 1);
        /* free any machine hw params */
        if (machine->ops && machine->ops->hw_free)
                machine->ops->hw_free(substream);
        /* free any DMA resources */
        if (platform->pcm_ops->hw_free)
                platform->pcm_ops->hw_free(substream);
        /* now free hw params for the DAI's  */
        if (codec_dai->ops->hw_free)
                codec_dai->ops->hw_free(substream, codec_dai);
        if (cpu_dai->ops->hw_free)
                cpu_dai->ops->hw_free(substream, cpu_dai);
        mutex_unlock(&pcm_mutex);
        return 0;
}
