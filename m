From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: [PATCH v2] ASoC: Handle multiple codecs with split
 playback / capture
Date: Fri, 21 Aug 2015 09:11:16 +0200
Message-ID: <alpine.DEB.2.02.1508210849260.10202@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1508191717300.27635@lnxricardw1.se.axis.com>
 <55D5F611.9090205@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id B32942604C3
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2015 09:11:33 +0200 (CEST)
In-Reply-To: <55D5F611.9090205@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


On Thu, 20 Aug 2015, Pierre-Louis Bossart wrote:

> >   /**
> >    * snd_soc_runtime_activate() - Increment active count for PCM runtim=
e components
> >    * @rtd: ASoC PCM runtime that is activated
> > @@ -371,6 +389,20 @@ static void soc_pcm_init_runtime_hw(struct snd_pcm=
_substream *substream)
> >
> >   	/* first calculate min/max only for CODECs in the DAI link */
> >   	for (i =3D 0; i < rtd->num_codecs; i++) {
> > +
> > +		/*
> > +		 * Skip CODECs which don't support the current stream type.
> > +		 * Otherwise, since the rate, channel, and format values will
> > +		 * zero in that case, we would have no usable settings left,
> > +		 * causing the resulting setup to fail.
> > +		 * At least one CODEC should match, otherwise we should have
> > +		 * bailed out on a higher level, since there would be no
> > +		 * CODEC to support the transfer direction in that case.
> > +		 */
> > +		if (!snd_soc_dai_stream_valid(rtd->codec_dais[i],
> > +					      substream->stream))
> =

> Maybe I misunderstood but shouldn't there be some sort of verification =

> that the codecs can use the same number of slots between playback and =

> capture if they share the same LRCLK/FS? e.g. it's not uncommon to have =

> 4 mic capture and 2 ch playback. If the capture and playback is handled =

> by different chips you'd still need to maintain some level of consistency.

You're probably right, although it may be that that sort of thing is =

handled at a higher level, e.g. the machine driver in such a setup would =

configure both codecs to use TDM before we even get to this function, I =

don't know.

I think we'd have to take care of that situation if and when it arises. =

The setup I have here doesn't allow me to test it.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
