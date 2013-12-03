From: Li Xiubo <Li.Xiubo@freescale.com>
Subject: RE: [PATCH v2] ASoC: SGTL5000: Fix kernel failed while trying to
 get optional VDDD supply.
Date: Tue, 3 Dec 2013 09:49:47 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F828E3D21@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1385621219-20652-1-git-send-email-Li.Xiubo@freescale.com>
 <20131129183855.GI27568@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131129183855.GI27568@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, Fabio Estevam <Fabio.Estevam@freescale.com>, "LW@KARO-electronics.de" <LW@KARO-electronics.de>, "oskar@scara.com" <oskar@scara.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

> > +static int sgtl5000_external_vddd_used(struct snd_soc_codec *codec) {
> > +	struct regulator *consumer;
> > +	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
> > +
> > +	consumer = regulator_get_optional(codec->dev,
> > +			sgtl5000->supplies[VDDD].supply);
> > +	if (IS_ERR(consumer))
> > +		return 0;
> > +
> > +	regulator_put(consumer);
> > +
> > +	return 1;
> > +}
> 
> This is broken with respect to deferred probe, deferred probe returns an
> error when an external regulator is in use but not yet registered.
> The driver needs to at least handle -EPROBE_DEFER specially here.
> 

Well, as we can see that:
1, If the dev has no regulator dt node, a -ENODEV error will be returned. 
2, If the regulator dt node is exist but the optional VDDD is absent (i.e.
The external VDDD is not used), a -EPROBE_DEFER will be returned, if just
return the -EPROBE_DEFER to the probe(and then the probe deferral
mechanism will do the probe again later, is that right ?), and then the
regulator_get_optional() will be called later again, and the -EPROBE_DEFER
will be returned again too, and now how should I handle -EPROBE_DEFER error
twice ? Or should there be a counter about this ? That to say when the
-EPROBE_DEFER error is the second time returned from regulator_get_optional()
can we ensure that the optional VDDD is really not in use.

That's also to say, the regulator_get_optional() must be called twice then
could we know whether the optional external VDDD is really in use or not by
using one counter here.

Or maybe adding a counter in regulator_get_optional() is better.

And do you have any other suggestions to deal with this ?




> It's also not nice to get the regulator, release it and get it again which
> you end up needing to do because...
> 

I have also considered about this. Because if the regulator_bulk_get()
has failed to get the other supplies, the optional one should be released too.
And it can be more easy to deal with.

Yes, this is not very nice and I will revise this.


> > -	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(sgtl5000->supplies),
> > +	if (sgtl5000_external_vddd_used(codec)) {
> > +		ret = regulator_bulk_get(codec->dev,
> > +				ARRAY_SIZE(sgtl5000->supplies),
> >  				sgtl5000->supplies);
> 
> ...I think my previous comments about this code being poorly structured in
> the existing driver stand.  The bulk get should be used for the supplies
> that are always needed and a separate optional get should be used for this
> one.

Yes, it's.

--
Best Regards,
