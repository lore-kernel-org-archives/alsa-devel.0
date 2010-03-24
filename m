From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Fix passing platform_data to ac97
 bus users and fix a leak.
Date: Wed, 24 Mar 2010 09:23:38 +0000
Message-ID: <1269422618.3798.7.camel@odin>
References: <4BA99514.8020708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f220.google.com (mail-bw0-f220.google.com
	[209.85.218.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E8A1103815
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2010 10:23:45 +0100 (CET)
Received: by bwz20 with SMTP id 20so8400973bwz.32
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2010 02:23:44 -0700 (PDT)
In-Reply-To: <4BA99514.8020708@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Graham Gower <graham.gower@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-03-24 at 14:59 +1030, Graham Gower wrote:
> snd_soc_new_ac97_codec() allocates for codec->ac97, snd_soc_new_pcms()
> then sets the platform_data. However, snd_ac97_mixer() overwrites
> codec->ac97 with its own allocated struct snd_ac97.
> 
> Signed-off-by: Graham Gower <graham.gower@gmail.com>
> ---
>  sound/soc/codecs/ac97.c |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
> index a1bbe16..64ec797 100644
> --- a/sound/soc/codecs/ac97.c
> +++ b/sound/soc/codecs/ac97.c
> @@ -80,9 +80,11 @@ static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
>  static int ac97_soc_probe(struct platform_device *pdev)
>  {
>  	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
> +	struct snd_soc_card *card = socdev->card;
>  	struct snd_soc_codec *codec;
>  	struct snd_ac97_bus *ac97_bus;
>  	struct snd_ac97_template ac97_template;
> +	int i;
>  	int ret = 0;
>  
>  	printk(KERN_INFO "AC97 SoC Audio Codec %s\n", AC97_VERSION);
> @@ -118,11 +120,21 @@ static int ac97_soc_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		goto bus_err;
>  
> +	/* free the ac97 here so that we don't leak it in snd_ac97_mixer */
> +	snd_soc_free_ac97_codec(codec);
> +

Can you try removing the call to snd_soc_new_ac97_codec() instead. I've
just had a quick look and the codec->ac97 is not used by any calls upto
this point except for snd_soc_new_pcms() adding the AC97 pdata (please
also add a check for valid codec->ac97 in snd_soc_new_pcms() before
setting pdata).

Sorry, I don't have any working AC97 hardware to test this myself today.

Thanks

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
