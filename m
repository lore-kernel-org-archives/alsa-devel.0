From: Liam Girdwood <lrg@ti.com>
Subject: Re: [pulseaudio-discuss] Using UCM with PulseAudio
Date: Fri, 15 Jun 2012 18:28:51 +0100
Message-ID: <1339781331.7609.36.camel@odin>
References: <1339728813.5228.48.camel@localhost>
	<1339762287.3007.127.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog130.obsmtp.com (na3sys009aog130.obsmtp.com
	[74.125.149.143])
	by alsa0.perex.cz (Postfix) with ESMTP id C5572248A0
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jun 2012 19:28:59 +0200 (CEST)
Received: by werf3 with SMTP id f3so3084981wer.18
	for <alsa-devel@alsa-project.org>; Fri, 15 Jun 2012 10:28:54 -0700 (PDT)
In-Reply-To: <1339762287.3007.127.camel@laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tanu Kaskinen <tanuk@iki.fi>
Cc: Arun Raghavan <arun.raghavan@collabora.co.uk>, broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, jankovac503@gmail.com, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

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

No worries :)

> I asked in IRC for a clarification about what "is not used for actual
> output but to enable use of the modem during calls" means. Arun means
> that opening the modem playback PCM opens a direct audio path from the
> modem to the earpiece. Pulseaudio doesn't see the audio data at all.
> There's a corresponding capture PCM that opens a direct audio path to
> the other direction.

The OMAP4 audio PCM is used to configure and initiate the transfer of
PCM data to and from the MODEM. The audio PCM is basically routed from
the CODEC via the ABE to the MODEM and vice versa. The host CPU does not
move any PCM data around in this use case (except when another PCM is
opened to record the call etc.). 

> This sort of hardware causes trouble for the planned routing system, at
> least as I have envisioned it to behave. My vision has been that the
> routing logic in pulseaudio would enable and disable ports based on the
> streams that exist and their properties. In the OMAP4 case, there aren't
> any streams created when a cellular call starts, and therefore the
> routing logic doesn't know that it should do something.
> 

This is quite common in the smartphone voice call use case. A lot of
phones will not route voice PCM data across the CPU in order to save
power. The host CPU will typically setup the call (i.e. mixers, rate,
etc) and then start the call. In this case PA would configure and
initiate the call and then sleep. However PA would still be "active" wrt
the voice call as it would be required to perform any voice call actions
like capture the call or play music during the call.

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

UCM can help here a little since it can be used to give information
about the underlying hardware to PA. i.e. if there is a sink for the
voicecall, and if the sink is virtual, etc. 


> 
> On some other platform where the cellular modem audio interface is
> directly accessible, "type:cellular_modem" would point to an input or
> output that is implemented by a normal port. I don't know if UCM
> provides the information about whether the VoiceCall PCMs implement a
> real audio interface or are they just a hack to enable the in-hardware
> audio path. If that information is not available, I'd say that it's then
> something that needs to be fixed.
> 

As mentioned above we can add this to UCM to help with this sort of
logic.

Regards

Liam
