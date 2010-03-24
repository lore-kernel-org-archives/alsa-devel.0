From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix passing platform_data to
	ac97	bus users and fix a leak.
Date: Wed, 24 Mar 2010 13:06:12 +0000
Message-ID: <20100324130611.GA26910@sirena.org.uk>
References: <4BA99514.8020708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 03DED2438E
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2010 14:06:13 +0100 (CET)
Content-Disposition: inline
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

On Wed, Mar 24, 2010 at 02:59:08PM +1030, Graham Gower wrote:
> snd_soc_new_ac97_codec() allocates for codec->ac97, snd_soc_new_pcms()
> then sets the platform_data. However, snd_ac97_mixer() overwrites
> codec->ac97 with its own allocated struct snd_ac97.

Please remember to CC maintainers on patches, this helps avoid patches
getting lost in mailing lists - the procedure in SubmittingPatches
should generally be followed.

> @@ -118,11 +120,21 @@ static int ac97_soc_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		goto bus_err;
>  
> +	/* free the ac97 here so that we don't leak it in snd_ac97_mixer */
> +	snd_soc_free_ac97_codec(codec);
> +

Like Liam says this seems wrong - why would we have allocated this early
on in the probe() only to free it later?

Note also that this code needs to work with both ASoC-native AC97
drivers and the ac97.c bodge.
