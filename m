From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] ASoC: multi-component: Add optional kcontrol
 prefix name for a DAI link
Date: Mon, 23 Aug 2010 16:21:45 +0100
Message-ID: <20100823152145.GD14504@rakim.wolfsonmicro.main>
References: <1281943770-2990-1-git-send-email-jhnikula@gmail.com>
	<20100816100705.GA3276@rakim.wolfsonmicro.main>
	<20100816135328.077b5ea3.jhnikula@gmail.com>
	<20100816110902.GA10354@sirena.org.uk>
	<20100819144451.1d827367.jhnikula@gmail.com>
	<20100819135413.GA19582@opensource.wolfsonmicro.com>
	<20100819182049.3ecdd0bc.jhnikula@gmail.com>
	<20100820115144.451b474f.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8220B2414F
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Aug 2010 17:21:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100820115144.451b474f.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 20, 2010 at 11:51:44AM +0300, Jarkko Nikula wrote:
> Jarkko Nikula <jhnikula@gmail.com> wrote:

> +int _snd_soc_dapm_new_control(struct snd_soc_codec *codec,
> +	const struct snd_soc_dapm_widget *widget,
> +	const char *name_prefix);
>  int snd_soc_dapm_new_control(struct snd_soc_codec *codec,
>  	const struct snd_soc_dapm_widget *widget);
> +int _snd_soc_dapm_new_controls(struct snd_soc_codec *codec,
> +	const struct snd_soc_dapm_widget *widget,
> +	int num, const char *name_prefix);

Best not in the header; these are not things individual drivers should
be worrying their pretty little heads about.  If they should be used by
individual drivers then we need better names than just _.

> @@ -539,6 +543,7 @@ struct snd_soc_dai_link {
>  	const char *platform_name;	/* for multi-platform */
>  	const char *cpu_dai_name;
>  	const char *codec_dai_name;
> +	const char *kcontrol_prefix;	/* kcontrol prefix for multi-codec */
>  
>  	/* Keep DAI active over suspend */
>  	unsigned int ignore_suspend:1;

I don't see how a DAI link can ever be used to configure prefix names -
there's just not any real association between DAI links and controls,
and as soon as you hit mixing any that does exist gets lost.  Probably a
table of CODEC to prefix mappings would be better.

> +			if (codec->kcontrol_prefix && !w->prefixed) {
> +				name_len += 1 + strlen(codec->kcontrol_prefix);
> +				snprintf(prefix, sizeof(prefix), "%s.",
> +					 codec->kcontrol_prefix);

A space would probably be more idiomatic for the separator.

> +int _snd_soc_dapm_add_routes(struct snd_soc_codec *codec,
> +			    const struct snd_soc_dapm_route *route, int num,
> +			    const char *name_prefix)
>  {
>  	int i, ret;
>  
>  	for (i = 0; i < num; i++) {
> -		ret = snd_soc_dapm_add_route(codec, route);
> +		ret = snd_soc_dapm_add_route(codec, route, name_prefix);

This one is a bit more fun.  For this to work properly we need to
consider what happens with the cross-device links in the DAI maps which
means we need to able to cope with separate prefixes for the source and
the sink.
