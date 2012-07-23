From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: Re: [pulseaudio-discuss] Using UCM with PulseAudio
Date: Mon, 23 Jul 2012 09:08:40 +0530
Message-ID: <1343014720.6131.21.camel@localhost>
References: <1339728813.5228.48.camel@localhost>
 <1339762287.3007.127.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.135.160])
 by alsa0.perex.cz (Postfix) with ESMTP id 1390126501B
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 05:38:19 +0200 (CEST)
In-Reply-To: <1339762287.3007.127.camel@laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tanu Kaskinen <tanuk@iki.fi>
Cc: lrg@ti.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, pulseaudio-discuss@lists.freedesktop.org, jankovac503@gmail.com
List-Id: alsa-devel@alsa-project.org

[not sure if this is still interesting to alsa-devel, but keeping the CC
anyway]

On Fri, 2012-06-15 at 15:11 +0300, Tanu Kaskinen wrote:
> On Fri, 2012-06-15 at 08:23 +0530, Arun Raghavan wrote:
> > Hello,
> > I've been working on porting PulseAudio to Android on the OMAP4-based
> > Galaxy Nexus, and have recently looking at the policy-bits. The basic
> > porting has been greatly simplified with Wei Feng's work to renew
> > PulseAudio UCM integration and  Liam's help with fixing up some of the
> > UCM config for the Galaxy Nexus. I am, however, facing some trouble
> > mapping how the hardware is used to how UCM presents it (or, perhaps,
> > the UCM-PA mapping does).
> > 
> > Some simplified background: the devices of interest on the OMAP4 SoC are
> > the main hifi PCM which can be routed to various outputs, the modem PCM
> > which is not used for actual output but to enable use of the modem
> > during calls, and the tones PCM which is intended to be used for playing
> > ringtones, aiui.
> 
> Sorry for hijacking the thread. The following wall of text won't help
> Arun with his immediate problems, but I wanted to share my thoughts
> about the planned routing system in pulseaudio and how OMAP4-style
> hardware affects it.
> 
> I asked in IRC for a clarification about what "is not used for actual
> output but to enable use of the modem during calls" means. Arun means
> that opening the modem playback PCM opens a direct audio path from the
> modem to the earpiece. Pulseaudio doesn't see the audio data at all.
> There's a corresponding capture PCM that opens a direct audio path to
> the other direction.
> 
> This sort of hardware causes trouble for the planned routing system, at
> least as I have envisioned it to behave. My vision has been that the
> routing logic in pulseaudio would enable and disable ports based on the
> streams that exist and their properties. In the OMAP4 case, there aren't
> any streams created when a cellular call starts, and therefore the
> routing logic doesn't know that it should do something.
> 
> Arun has made an "Android policy module", which I suppose activates the
> VoiceCall profile when a call starts and prevents the associated sink
> and source from suspending even though they appear to be idle. In the
> brave new generic routing policy world, the ports/profiles should not be
> touched by anything else than the generic routing logic. Therefore,
> Arun's solution will have to be eventually replaced somehow.
> 
> As I described, my vision for the routing logic falls short with OMAP4,
> if there are no streams associated with the cellular audio. So, what's
> the solution? One solution would be to create virtual streams for the
> in-hardware audio paths. Another would be to introduce entirely new
> concepts in pulseaudio for the in-hardware audio paths.
> 
> Regarding the virtual streams solution, it's still unclear what would
> trigger the virtual streams to be created. I think they should be
> created by module-alsa-card when the relevant ports are activated, but
> what activates the ports, if the routing system only does anything when
> streams are created? The cellular adaptation module should tell the
> routing system that "a call is starting, it would be nice to open the
> call audio path now". I was hoping that the virtual stream solution
> would avoid adding any further complexity to the routing system, but it
> seems that the routing system must anyway be aware of the special
> in-hardware audio paths so that other modules can request them to be
> activated.
> 
> So, maybe it's not worth the effort to create virtual streams, since
> they don't actually help with the routing.
> 
> After spending a while thinking about this, my proposal is that the
> routing logic should play with more abstract inputs and outputs than
> streams and ports. All streams and ports, and the cellular modem that is
> not directly accessible by Pulseaudio, would be just inputs and outputs
> from the routing system point of view.
> 
> For example, when a music player creates a new playback stream, the
> server-side stream implementation would create a new input and register
> it in the routing system. After that, the stream implementation would
> submit a "routing request" to the routing system: "connect input id:4 to
> somewhere". The application didn't specify where the stream should be
> routed, so based on the routing request properties (like media role),
> the routing system would select the best output that is available.
> 
> Routing requests would exist as long as they are needed. In case of
> normal streams, that would be as long as the stream exists. If it
> becomes impossible to fulfill the request at some point, the stream gets
> removed.
> 
> Routing requests would have a priority - in the music player's case, the
> priority would probably be derived from the stream media role. Phone
> stream routing requests would have a higher priority.
> 
> Another example: there's a cellular call on an OMAP4 platform. The
> cellular adaptation module notices that, and creates two routing
> requests: "connect input type:cellular_modem to somewhere" and "connect
> output type:cellular_modem to somewhere". The alsa card would have
> created, based on the UCM data, an input and an output with label
> "type:cellular_modem". Those would have very limited routing options:
> for example, the cellular modem input might be routable only to the
> earpiece or the main speaker. module-alsa-card would inform the routing
> system about the limitations, and the routing system would pick the best
> alternative from the two available choices.
> 
> On some other platform where the cellular modem audio interface is
> directly accessible, "type:cellular_modem" would point to an input or
> output that is implemented by a normal port. I don't know if UCM
> provides the information about whether the VoiceCall PCMs implement a
> real audio interface or are they just a hack to enable the in-hardware
> audio path. If that information is not available, I'd say that it's then
> something that needs to be fixed.

This likely means we need to add a mechanism to UCM to signal that a PCM
is a virtual/fake PCM. This would be needed for whatever solution I
devise to solve the problem immediately as well.

> After the routing system has decided what input will be routed to what
> output, it will have to somehow make the connection happen. The problem
> is that only the alsa module knows how to connect the cellular modem to
> the earpiece. Maybe the input and output structs could have a type that
> said whether the input or output is a stream, a port, or something
> custom. If it's something custom, the struct would have a function
> pointer for doing the connection, otherwise normal stream connection
> code can be used.

The system you describe sounds generic enough to catch most things we'd
want to do, but I think it makes sense to enumerate the kinds of uses
that we are not able to elegantly handle right now. Here's what I have:

1. Virtual devices that represent paths that are not in the CPU domain
(like the phone PCMs above)

2. Devices that require a loopback to be useful, like an FM radio or
A2DP source

3. Devices that have a loopback path in hardware/DSP (this is a request
I've seen, but I'm not aware of hardware that does this)

I'm sure there's more stuff, so please do add to this list.

While (1) is probably easy to take care of cleanly with whatever we have
currently, having some routing awareness in the PA ALSA modules, and an
ability to express this to the routing logic seems to be necessary to
deal with (2) and (3).

-- Arun
