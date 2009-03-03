From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: Add GPIO support for jack reporting
	interface
Date: Tue, 3 Mar 2009 11:14:41 +0000
Message-ID: <20090303111440.GB27155@sirena.org.uk>
References: <2C7D3DF36ADFFC479B44490D912B616705ECD6D7C1@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DC2CB245AA
	for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2009 12:14:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705ECD6D7C1@dlee07.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 02, 2009 at 07:05:28PM -0600, Lopez Cruz, Misael wrote:

This is much better than last time, thanks!  Some issues do remain,
though (as well as those that Takashi mentioned):

> +int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
> +			  struct snd_soc_jack_gpio *gpios);
> +void snd_soc_jack_free_gpios(struct snd_soc_jack *jack);

snd_soc_jack_free_gpios() shouild take the same arguments as the add...

>  struct snd_soc_jack {
>  	struct snd_jack *jack;
>  	struct snd_soc_card *card;
>  	struct list_head pins;
> +	struct snd_soc_jack_gpio *gpios;
> +	int gpio_count;
>  	int status;
>  };

...so (as previously discussed) you don't have this.  The jack shouldn't
need this information and it's only used to free things at the minute.

Consider how this will scale: if the jack detection method for every
codec were to add back pointers to the snd_soc_jack structure then you'd
rapidly find that the bulk of the structure is taken up with these back
pointers.

> +	enable = gpio_get_value(gpio->gpio);
> +	if (gpio->invert)
> +		enable != enable;

I think you mean enable = !enable here (I'm surprised the compiler
doesn't warn about this).
