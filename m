From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] Allow passing platform_data to devices
	attached to AC97 bus
Date: Tue, 21 Jul 2009 17:11:03 +0200
Message-ID: <87ocre2hrs.fsf@free.fr>
References: <200907211633.14388.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	by alsa0.perex.cz (Postfix) with ESMTP id 69D1A24368
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jul 2009 17:11:11 +0200 (CEST)
In-Reply-To: <200907211633.14388.marek.vasut@gmail.com> (Marek Vasut's message
	of "Tue\, 21 Jul 2009 16\:33\:14 +0200")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Marek Vasut <marek.vasut@gmail.com> writes:

> diff --git a/arch/arm/mach-pxa/include/mach/audio.h b/arch/arm/mach-pxa/include/mach/audio.h
> index 16eb025..8825b18 100644
> --- a/arch/arm/mach-pxa/include/mach/audio.h
> +++ b/arch/arm/mach-pxa/include/mach/audio.h
> @@ -20,6 +20,7 @@ typedef struct {
>  	void (*resume)(void *);
>  	void *priv;
>  	int reset_gpio;
> +	void *codec_pdata[4];
I don't understand where that '4' comes from. Would you explain ?

> diff --git a/sound/arm/pxa2xx-ac97.c b/sound/arm/pxa2xx-ac97.c
> index c570ebd..cfab74e 100644
> --- a/sound/arm/pxa2xx-ac97.c
> +++ b/sound/arm/pxa2xx-ac97.c
> @@ -170,6 +170,8 @@ static int __devinit pxa2xx_ac97_probe(struct platform_device *dev)
>  	struct snd_ac97_bus *ac97_bus;
>  	struct snd_ac97_template ac97_template;
>  	int ret;
> +	pxa2xx_audio_ops_t *pdata = dev->dev.platform_data;
> +	int id = dev->id < 0 ? 0 : dev->id;
>  
>  	ret = snd_card_create(SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
>  			      THIS_MODULE, 0, &card);
> @@ -200,6 +202,7 @@ static int __devinit pxa2xx_ac97_probe(struct platform_device *dev)
>  	snprintf(card->longname, sizeof(card->longname),
>  		 "%s (%s)", dev->dev.driver->name, card->mixername);
>  
> +	snd_ac97_dev_add_pdata(ac97_bus->codec[id], pdata->codec_pdata[id]);
Is there something that grants that dev->id is lesser than 4 ?

Cheers.

-- 
Robert
