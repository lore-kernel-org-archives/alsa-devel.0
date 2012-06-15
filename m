From: Liam Girdwood <lrg@ti.com>
Subject: Re: Using UCM with PulseAudio
Date: Fri, 15 Jun 2012 18:08:30 +0100
Message-ID: <1339780110.7609.21.camel@odin>
References: <1339728813.5228.48.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog113.obsmtp.com (na3sys009aog113.obsmtp.com
	[74.125.149.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 3530A24885
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jun 2012 19:08:38 +0200 (CEST)
Received: by wibhr14 with SMTP id hr14so668509wib.15
	for <alsa-devel@alsa-project.org>; Fri, 15 Jun 2012 10:08:36 -0700 (PDT)
In-Reply-To: <1339728813.5228.48.camel@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arun Raghavan <arun.raghavan@collabora.co.uk>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, pulseaudio-discuss@lists.freedesktop.org, Feng Wei <feng.wei@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2012-06-15 at 08:23 +0530, Arun Raghavan wrote:
> Hello,
> I've been working on porting PulseAudio to Android on the OMAP4-based
> Galaxy Nexus, and have recently looking at the policy-bits. The basic
> porting has been greatly simplified with Wei Feng's work to renew
> PulseAudio UCM integration and  Liam's help with fixing up some of the
> UCM config for the Galaxy Nexus. I am, however, facing some trouble
> mapping how the hardware is used to how UCM presents it (or, perhaps,
> the UCM-PA mapping does).
> 
> Some simplified background: the devices of interest on the OMAP4 SoC are
> the main hifi PCM which can be routed to various outputs, the modem PCM
> which is not used for actual output but to enable use of the modem
> during calls, and the tones PCM which is intended to be used for playing
> ringtones, aiui.

You understanding is correct :)

> 
> The first problem is mutual exclusivity of verbs. From what I can
> understand, verbs are intended to be mutually exclusive -- if you have a
> HiFi verb and a VoiceCall verb, only one may be used at a time. We have
> mapped verbs to card profiles, which offer the same guarantee. However,
> on Android (which is a fair example of the kind of audio policy we might
> want), the HiFi verb PCMs maybe used while the VoiceCall PCMs are open.
> This is done, for example, to play an end-of-call tone from the CPU
> while the modem PCMs are still held open. Is there some way to do this
> with UCM?
> 

A verb is not tied to any specific PCM device here. It's intended to be
the highest level of audio use case where it can configure any audio
resource (including multiple cards) to enable the use case action.

So for OMAP4 we would have the HiFi verb for all use case where we are
playing or capturing HiFi quality and the voice call verb where we are
making a telephone voice call.

UCM provides the "modifier" to allow ad-hoc modifications to the audio
use case like above where we want to play an end of call tone. In this
case the verb is still VoiceCall, but PA would enable the "PlayTone"
modifer to play the tone (UCM can also tell Pulseaudio the sink PCM and
volume control for the tone data).

> The second problem is having separate PCMs for modifiers. In the OMAP4
> profile, ringtone playback is exposed via a PlayTone modifier which
> corresponds to a separate PCM from regular HiFi playback. In the UCM-PA
> mapping we decided on, modifiers were implemented as device intended
> roles on a sink, so that when a stream with that role came in, we could
> enable the modifier, and disable it when such a stream ends. However,
> this doesn't account for switching the PCM on which playback is
> occurring. Should we be creating a separate sink for such modifiers
> (with lower priority, so they're not routed to unless there's a stream
> with the required role coming in)? Or should we be reopening the PCM for
> this?

The intention for modifiers that use separate ALSA PCM sinks/sources
from the verb is to keep the main stream on the verb PCM source/sink and
the modifier stream will use the modifier PCM sink/source (this can be
the same PCM for some hardware).

e.g. MP3 will be played to pcm 0 sink and ringtone to pcm 1 sink. The HW
will then mix both streams before they are rendered.

> 
> Finally, a question also related to modifiers -- is it expected that
> there will never be a case where a stream that requires no modifier is
> being played while a stream that does require a modifier also exists? If
> not, what kind of policy should we have for enabling the modifier or
> not?

Some verbs will not specify modifiers. In this case we should mix any
tones etc within the Pulseaudio stream  and render on the main
sink/source.

It's intended that we will try and enable a modifier for a verb (if the
modifier exists) when a new PA client stream is opened and it's type can
be matched to a modifier. Otherwise I would just mix the streams in PA
and render to the current sink.

Regards

Liam

> 
> Cheers,
> Arun
> 
