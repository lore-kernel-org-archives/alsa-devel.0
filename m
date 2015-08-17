From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: [PATCH] ASoc: Handle multiple codecs with split
 playback / capture
Date: Mon, 17 Aug 2015 10:02:29 +0200
Message-ID: <alpine.DEB.2.02.1508170922420.27635@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1508131605170.27635@lnxricardw1.se.axis.com>
 <20150814155223.GO10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 069FB260547
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 10:02:31 +0200 (CEST)
In-Reply-To: <20150814155223.GO10748@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


On Fri, 14 Aug 2015, Mark Brown wrote:

> On Thu, Aug 13, 2015 at 04:12:56PM +0200, Ricard Wanderlof wrote:
> =

> > (Referring to this thread:
> > http://mailman.alsa-project.org/pipermail/alsa-devel/2015-June/093214.h=
tml)
> =

> I shouldn't need to read another mailing list thread as the first part
> of a commit log, and if referring to external information you should
> always include a human readable description of what you're referring to
> so that people can understand your message without having to start
> another program.  As it is I'm in a plane over the Atlantic so I can't
> tell what you're talking about here, sorry.

The reference isn't necessary for the patch, it was intended to provide a =

link to a previous discussion that led up to it.

I'll restructure it to keep links out of the commit message.

Should the commit message have any information as to which specific use =

case led to the creation of the patch?

> >  /**
> > + * snd_soc_dai_stream_valid() - check if a DAI supports the given stre=
am
> > + *
> > + * @dai: The DAI to check for stream support
> > + * @stream: The stream type (playback / capture) to check for
> =

> You're adding externally readable kerneldoc on a static function so
> nothing outside this file can use it.

My mistake. Probably started out by having it global then realized =

it was not necessary as it is not needed anywhere else for the moment at =

least.

> > + *
> > + * Checks if the DAI in question supports the indicated stream type.
> > + * Needed to skip over codecs when iterating over
> > + * snd_soc_pcm_runtime->codec_dais in order to skip codecs that are pl=
ayback-
> > + * or capture-only, which would otherwise inhibit capture or playback,
> > + * respectively, to the other codec in a multiple codec / common I2S b=
us
> > + * environment.
> > + */
> =

> This mostly seems to describe a potential use of this function, not what
> it is supposed to do.

Ok, I'll rephrase it.

> > +	return !!codec_stream->rates;
> =

> The !! is redundant here.

I still felt it made sense as rates is an int and the function actually =

returns a bool, i.e. the !! indicates to a human reader that the author of =

the function is aware that rates is not a bool yet the function is =

declared as one.

> >  	/* first calculate min/max only for CODECs in the DAI link */
> >  	for (i =3D 0; i < rtd->num_codecs; i++) {
> > +
> > +		/* Skip codecs which don't support the current stream type. */
> > +		if (!snd_soc_dai_stream_valid(rtd->codec_dais[i],
> > +					      substream->stream))
> > +			continue;
> > +
> >  		codec_dai_drv =3D rtd->codec_dais[i]->driver;
> >  		if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
> >  			codec_stream =3D &codec_dai_drv->playback;
> =

> So what happens if we end up in these loops and nothing matches?  It'd
> be good to document the considerations there.

Ok, I'll add this.

> > @@ -827,6 +859,10 @@ static int soc_pcm_hw_params(struct snd_pcm_substr=
eam *substream,
> >  		struct snd_soc_dai *codec_dai =3D rtd->codec_dais[i];
> >  		struct snd_pcm_hw_params codec_params;
> >  =

> > +		/* Skip codecs which don't support the current stream type. */
> > +		if (!snd_soc_dai_stream_valid(codec_dai, substream->stream))
> > +			continue;
> > +
> >  		/* copy params for each codec */
> >  		codec_params =3D *params;
> =

> We're still calling hw_params() for all CODECs, even ones that happen to
> not be suitable...  is that sensible? =


Hm, how so, the soc_dai_hw_params(..., codec_dai) is further on inside the =

loop so the continue skips over it?

However, if nothing matches, soc_dai_hw_params(..., cpu_dai) would still =

be called, just after the loop, which might not make sense. =


> It might be in a case where the CODEC for one direction clocks =

> everything but I can see problems occurring if the transmit and receive =

> paths are separately clocked which is going to be quite common for =

> things like i.MX systems.  If the two are tied together there's going to =

> be constraints between the two directions.
> =

> I'd expect that we could take a pretty good guess as to what the best
> thing to do is based on the symmetry constraints we have for the link
> but I think we do want to think about this early.

I guess it would be better just to 'goto out' after the loop if a suitable =

codec could not be found.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
