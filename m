From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: [PATCH] ASoc: Handle multiple codecs with split
 playback / capture
Date: Wed, 19 Aug 2015 16:15:26 +0200
Message-ID: <alpine.DEB.2.02.1508190955150.27635@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1508131605170.27635@lnxricardw1.se.axis.com>
 <20150814155223.GO10748@sirena.org.uk>
 <alpine.DEB.2.02.1508170922420.27635@lnxricardw1.se.axis.com>
 <20150817204448.GC10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id C95F6265054
 for <alsa-devel@alsa-project.org>; Wed, 19 Aug 2015 16:15:42 +0200 (CEST)
In-Reply-To: <20150817204448.GC10748@sirena.org.uk>
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


On Mon, 17 Aug 2015, Mark Brown wrote:

> On Mon, Aug 17, 2015 at 10:02:29AM +0200, Ricard Wanderlof wrote:
> > On Fri, 14 Aug 2015, Mark Brown wrote:
> > > On Thu, Aug 13, 2015 at 04:12:56PM +0200, Ricard Wanderlof wrote:
> =

> > Should the commit message have any information as to which specific =

> > use case led to the creation of the patch?
> =

> That's often good to mention, yes.

Ok, will do.

> > > > +	return !!codec_stream->rates;
> =

> > > The !! is redundant here.
> =

> > I still felt it made sense as rates is an int and the function =

> > actually returns a bool, i.e. the !! indicates to a human reader that =

> > the author of the function is aware that rates is not a bool yet the =

> > function is declared as one.
> =

> It's sufficiently obvious that you're just checking if rates has anything =

> set at all here I think.

Ok. I will change it then.

> > > > +		/* Skip codecs which don't support the current stream =

> type. */
> > > > +		if (!snd_soc_dai_stream_valid(codec_dai, =

> substream->stream))
> > > > +			continue;
> =

> > > >  		/* copy params for each codec */
> > > >  		codec_params =3D *params;
> =

> > > We're still calling hw_params() for all CODECs, even ones that =

> > > happen to not be suitable...  is that sensible?
> =

> > Hm, how so, the soc_dai_hw_params(..., codec_dai) is further on inside =

> > the loop so the continue skips over it?
> =

> > However, if nothing matches, soc_dai_hw_params(..., cpu_dai) would =

> > still be called, just after the loop, which might not make sense.
> =

> I think that's the bit I was thinking of, sorry.

[in light of this, rephrasing Mark's comment to:]
We're still calling soc_dai_hw_params() even if no CODEC DAI matches.
> > > ...  is that sensible? It might be in a =

> > > case where the CODEC for one direction clocks everything but I can =

> > > see problems occurring if the transmit and receive paths are =

> > > separately clocked which is going to be quite common for things like =

> > > i.MX systems.  If the two are tied together there's going to be =

> > > constraints between the two directions.
> =

> > > I'd expect that we could take a pretty good guess as to what the =

> > > best thing to do is based on the symmetry constraints we have for =

> > > the link but I think we do want to think about this early.
> =

> > I guess it would be better just to 'goto out' after the loop if a =

> > suitable codec could not be found.
> =

> Well, there's two things here: one is if we've got a completely invalid =

> configuration with no CODECs being configured and the other is if we =

> should only be configuring matching CODECs in the first place.  For =

> systems where the LRCLK and BCLK are shared between playback and capture =

> we may want to always configure them even if the CODEC driving the clocks =

> isn't the one handling the audio.

Considering the first thing, i.e. a completely invalid configuration, such =

as trying to play back on a capture-only DAI link, then I would expect =

that would be taken care of long before we get to even attempt to =

configure anything, resulting in something like 'Unknown PCM' at the user =

level. We could of course bail out of this function before attempting to =

set up the CPU DAI in the event that that type of situation occurs anyway. =

I can add code to do just that.

The second thing is which codecs to configure. Should we attempt to =

configure all of them, even those that don't match the stream type, or (as =

the patch is currently written) only the ones that match the stream type. =

Let me see if I get the issues right here:

In the former case, IIUC, this might be needed if we have a codec that is =

generating clocks even though it is not actually used for the transfer, =

e.g. a playback codec generating LRCLK and/or BCLK for the whole link, =

including the capture codec. In this case we would want to set up both =

codecs even though only one is actually used.

In the latter case there might be systems which need to set up different =

clocking configurations for playback and capture on the CPU DAI, in which =

case we only want to configure matching codecs.

So how do we differentiate between these two cases? It seems to me that we =

cannot determine this using software means as it is really part of how the =

hardware is designed, so it must either be specified in the machine driver =

or via DT.

Since the current situation is that we can't support separate playback =

and capture codecs on a DAI link at all without this patch, my suggestion =

is to let the patch handle the case at hand, and add a comment as to which =

considerations have been made regarding which codecs are to be configured =

in soc_pcm_hw_params(), so that when the need arises to handle cases with =

different CPU DAI settings for both directions that can be handled =

appropriately.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
