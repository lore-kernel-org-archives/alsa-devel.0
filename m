From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] hda: add support for jack detection on
	IDT/Sigmatel
Date: Wed, 15 Oct 2008 16:44:02 +0100
Message-ID: <20081015154402.GE14068@sirena.org.uk>
References: <48F60190.5060601@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0DC3C2477D
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Oct 2008 17:44:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48F60190.5060601@embeddedalley.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Matthew Ranostay <mranostay@embeddedalley.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 15, 2008 at 10:43:28AM -0400, Matthew Ranostay wrote:

> @@ -3639,6 +3640,12 @@ static int stac92xx_init(struct hda_codec *codec)
>  		stac92xx_auto_set_pinctl(codec, spec->autocfg.line_out_pins[0],
>  					 AC_PINCTL_OUT_EN);
>  		stac92xx_auto_init_hp_out(codec);
> +		/* jack detection */
> +		err = snd_jack_new(codec->bus->card,
> +			"Headphone Jack Detection",
> +			SND_JACK_HEADPHONE, &codec->jack);
> +		if (err < 0)

That should probably just be "Headphone Jack".

> +			return err;

...

> +	if (codec->jack)
> +		snd_jack_report(codec->jack,
> +			presence ? SND_JACK_HEADPHONE : 0);
> +

Since you appear to fail init if you can't create the jack there should
be no need to check for the jack being initialised here.  For ease of
use I'll just submit a patch folding that check into snd_jack_report(),
though.
