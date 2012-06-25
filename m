From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: Re: Using UCM with PulseAudio
Date: Mon, 25 Jun 2012 07:01:33 +0530
Message-ID: <1340587893.5794.7.camel@localhost>
References: <1339728813.5228.48.camel@localhost>
	<1339780110.7609.21.camel@odin> <1340195448.8622.7.camel@localhost>
	<CAJ4+uhVuCAKZACJn5stP1ZM62dOQot-Jtu3bgqaNgVBVTzvKYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.135.160])
	by alsa0.perex.cz (Postfix) with ESMTP id 522B224577
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Jun 2012 03:31:39 +0200 (CEST)
In-Reply-To: <CAJ4+uhVuCAKZACJn5stP1ZM62dOQot-Jtu3bgqaNgVBVTzvKYw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Feng Wei <feng.wei@linaro.org>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, pulseaudio-discuss@lists.freedesktop.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2012-06-21 at 16:30 +0800, Feng Wei wrote:
> 2012/6/20 Arun Raghavan <arun.raghavan@collabora.co.uk>:
> > Liam,
> > Thanks for clearing things up.
> >
> > On Fri, 2012-06-15 at 18:08 +0100, Liam Girdwood wrote:
> > [...]
> >> > The first problem is mutual exclusivity of verbs. From what I can
> >> > understand, verbs are intended to be mutually exclusive -- if you have a
> >> > HiFi verb and a VoiceCall verb, only one may be used at a time. We have
> >> > mapped verbs to card profiles, which offer the same guarantee. However,
> >> > on Android (which is a fair example of the kind of audio policy we might
> >> > want), the HiFi verb PCMs maybe used while the VoiceCall PCMs are open.
> >> > This is done, for example, to play an end-of-call tone from the CPU
> >> > while the modem PCMs are still held open. Is there some way to do this
> >> > with UCM?
> >> >
> >>
> >> A verb is not tied to any specific PCM device here. It's intended to be
> >> the highest level of audio use case where it can configure any audio
> >> resource (including multiple cards) to enable the use case action.
> >>
> >> So for OMAP4 we would have the HiFi verb for all use case where we are
> >> playing or capturing HiFi quality and the voice call verb where we are
> >> making a telephone voice call.
> >>
> >> UCM provides the "modifier" to allow ad-hoc modifications to the audio
> >> use case like above where we want to play an end of call tone. In this
> >> case the verb is still VoiceCall, but PA would enable the "PlayTone"
> >> modifer to play the tone (UCM can also tell Pulseaudio the sink PCM and
> >> volume control for the tone data).
> >
> > Just as an observation, I think the Android HAL just uses PCM 0 and not
> > the PCM 3, but in the PA case, I'll do it the way you describe since
> > that makes more sense.
> >
> >> > The second problem is having separate PCMs for modifiers. In the OMAP4
> >> > profile, ringtone playback is exposed via a PlayTone modifier which
> >> > corresponds to a separate PCM from regular HiFi playback. In the UCM-PA
> >> > mapping we decided on, modifiers were implemented as device intended
> >> > roles on a sink, so that when a stream with that role came in, we could
> >> > enable the modifier, and disable it when such a stream ends. However,
> >> > this doesn't account for switching the PCM on which playback is
> >> > occurring. Should we be creating a separate sink for such modifiers
> >> > (with lower priority, so they're not routed to unless there's a stream
> >> > with the required role coming in)? Or should we be reopening the PCM for
> >> > this?
> >>
> >> The intention for modifiers that use separate ALSA PCM sinks/sources
> >> from the verb is to keep the main stream on the verb PCM source/sink and
> >> the modifier stream will use the modifier PCM sink/source (this can be
> >> the same PCM for some hardware).
> >>
> >> e.g. MP3 will be played to pcm 0 sink and ringtone to pcm 1 sink. The HW
> >> will then mix both streams before they are rendered.
> >
> > Okay, so what this means is that we need to extend the current UCM work
> > to create a second, lower priority sink for each modifier that has a
> > distinct PlaybackPCM, and let the role-based routing pick that in cases
> > where it makes sense. It's good that this doesn't change how we've
> > mapped existing concepts -- just adds to it.
> Sounds fine to me. The only problem is can we always open the modifier
> pcm when modifier is not enabled. If not, I prefer to create/destroy
> the sink by events.

The alternative is to always add the sink and enable/disable the
modifier in the I/O thread since we will get a message when a sink-input
is added/removed. I'm just hacking this bit up, and will post patches if
it all works out.

There is another question here -- whether the modifier sink should have
any ports or not. If I understand this correctly, we could let the
actual routing be handled by the "main" sink's port and have the
modifier sinks not touch that at all by not having any ports. In the
ideal world though, it would be nice to have the ability to mark ports
as being "dependent" somehow, so that port changes on the main sink
would reflect in all others. This would be particularly useful for sinks
and sources that have correlated paths like they do in the OMAP4 case.

-- Arun
