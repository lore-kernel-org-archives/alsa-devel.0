From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Different codecs for playback and capture?
Date: Thu, 4 Jun 2015 17:20:37 +0200
Message-ID: <alpine.DEB.2.02.1506041700100.15001@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1506031045380.22011@lnxricardw1.se.axis.com>
 <556F0E7F.80802@metafoo.de>
 <alpine.DEB.2.02.1506041343450.15001@lnxricardw1.se.axis.com>
 <55705831.7060305@metafoo.de>
 <alpine.DEB.2.02.1506041607040.15001@lnxricardw1.se.axis.com>
 <557066A3.7090804@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F6892606C8
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 17:20:39 +0200 (CEST)
In-Reply-To: <557066A3.7090804@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Thu, 4 Jun 2015, Lars-Peter Clausen wrote:

> > Ideally it would have been some sort of 'if (!codec_stream->defined)' b=
ut
> > there isn't such a member in struct snd_soc_dai . I've gone with 'if
> > (!codec_stream->rates && !codec_stream->formats)', thinking that if a
> > codec doesn't support any rates or formats, it probably doesn't support
> > that mode at all (else it's rather meaningless). In fact, one of these
> > (rates or formats) would probably suffice, with a comment explaining wh=
at
> > we're really trying to do.
> >
> > The next problem is that when trying to set hw params, something in the
> > framework or the individual codec driver hw_params() bails out saying it
> > can't set the intended parameters. Looking at that right now to see if =
it
> > can be solved in a similar way.
> =

> The best way to solve this is probably to introduce a helper function boo=
l =

> snd_soc_dai_stream_valid(struct snd_soc_dai *dai, int stream) that =

> implements the logic for detecting whether a DAI supports a playback or =

> capture stream. And then whenever iterating over the codec_dais field for =

> stream operations skip those which don't support the stream.

Yes. The question is, exactly what should the helper function use to =

determine stream support. Is it sufficient to check for =

dai->driver->playback/capture->rates !=3D 0 ?

I'm a bit worried at the 'whenever iterating over the codec_dais field'. =

There are 50+ places which iterate over codec_dais, mostly in soc-pcm.c =

and soc-core.c . Of course code could be added to all locations, but it =

starts to feel like the wrong approach, i.e. like the iteration itself =

should be done in a separate function (which doesn't really seem viable in =

itself; this isn't glib).

For the hardware I have here, there are two places where it is necessary; =

admittedly, this particular hardware is pretty simple (on the other hand, =

I would suppose that most situations with this type of split =

playback/capture would be for cases where there are simple codecs or I2S =

microphones that only support one of the modes).

What I'm getting at is that, disregarding the helper function which is =

needed anyway, perhaps I should just fix the two locations needed for now, =

and leave the rest to be fixed when the need arises? I'm not sure they all =

need to be modified in this way.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
