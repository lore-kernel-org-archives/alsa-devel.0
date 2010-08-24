From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC] ASoC: multi-component: Add optional kcontrol
 prefix name for a DAI link
Date: Tue, 24 Aug 2010 10:23:43 +0300
Message-ID: <20100824102343.4dfaafe1.jhnikula@gmail.com>
References: <1281943770-2990-1-git-send-email-jhnikula@gmail.com>
	<20100816100705.GA3276@rakim.wolfsonmicro.main>
	<20100816135328.077b5ea3.jhnikula@gmail.com>
	<20100816110902.GA10354@sirena.org.uk>
	<20100819144451.1d827367.jhnikula@gmail.com>
	<20100819135413.GA19582@opensource.wolfsonmicro.com>
	<20100819182049.3ecdd0bc.jhnikula@gmail.com>
	<20100820115144.451b474f.jhnikula@gmail.com>
	<20100823152145.GD14504@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id F24E024339
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Aug 2010 09:23:05 +0200 (CEST)
Received: by eyd9 with SMTP id 9so3072104eyd.38
	for <alsa-devel@alsa-project.org>; Tue, 24 Aug 2010 00:23:05 -0700 (PDT)
In-Reply-To: <20100823152145.GD14504@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, 23 Aug 2010 16:21:45 +0100
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > +int _snd_soc_dapm_new_controls(struct snd_soc_codec *codec,
> > +	const struct snd_soc_dapm_widget *widget,
> > +	int num, const char *name_prefix);
> 
> Best not in the header; these are not things individual drivers should
> be worrying their pretty little heads about.  If they should be used by
> individual drivers then we need better names than just _.
> 
Yeah, I picked up _ prefix so that name indicates that these functions
are more like for internal use and drivers should use them only
exceptionally. What I'm thinking if we can rid of them completely.

>From your commit 26b01cc it looks like there's a work in progress to
support DAI-less codecs/amplifiers. If that would be possible then
there is no need to register controls from other drivers in machine DAI
init. Well, CPU DAI controls are possible but they don't need a prefix
I think.

> > @@ -539,6 +543,7 @@ struct snd_soc_dai_link {
> >  	const char *platform_name;	/* for multi-platform */
> >  	const char *cpu_dai_name;
> >  	const char *codec_dai_name;
> > +	const char *kcontrol_prefix;	/* kcontrol prefix for multi-codec */
> >  
> >  	/* Keep DAI active over suspend */
> >  	unsigned int ignore_suspend:1;
> 
> I don't see how a DAI link can ever be used to configure prefix names -
> there's just not any real association between DAI links and controls,
> and as soon as you hit mixing any that does exist gets lost.  Probably a
> table of CODEC to prefix mappings would be better.
> 
Sorry, I didn't emphasis this well enough that this hack was
temporary just after your comment to first version and it got finally
removed in yesterday's version :-)

> > +			if (codec->kcontrol_prefix && !w->prefixed) {
> > +				name_len += 1 + strlen(codec->kcontrol_prefix);
> > +				snprintf(prefix, sizeof(prefix), "%s.",
> > +					 codec->kcontrol_prefix);
> 
> A space would probably be more idiomatic for the separator.
> 
Ok, makes sense.

> > +int _snd_soc_dapm_add_routes(struct snd_soc_codec *codec,
> > +			    const struct snd_soc_dapm_route *route, int num,
> > +			    const char *name_prefix)
> >  {
> >  	int i, ret;
> >  
> >  	for (i = 0; i < num; i++) {
> > -		ret = snd_soc_dapm_add_route(codec, route);
> > +		ret = snd_soc_dapm_add_route(codec, route, name_prefix);
> 
> This one is a bit more fun.  For this to work properly we need to
> consider what happens with the cross-device links in the DAI maps which
> means we need to able to cope with separate prefixes for the source and
> the sink.

Prefixing is not problem I think since we can specify them in
machine's audio map (like two mono amplifiers registered to 1st codec
are prefixed below) but how to link DAPMs of two codec together?

static const struct snd_soc_dapm_route audio_map1[] = {
	{"Left AMP input", NULL, "LLOUT"},
	{"Right AMP input, NULL, "RLOUT"},
	{"Speaker", NULL, "Left AMP output"},
	{"Speaker, NULL, "Right AMP output"},

	{"Codec B Left input"}, NULL, "LLOUT"},
	{"Codec B Right input"}, NULL, "RLOUT"},
};

static const struct snd_soc_dapm_route audio_map2[] = {
	{"foo bar", NULL, "Codec B Left input"},
	{"foo bar", NULL, "Codec B Right input"},
};


-- 
Jarkko
