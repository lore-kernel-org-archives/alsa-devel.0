From: Tim Cussins <timcussins@eml.cc>
Subject: Re: Some thoughts on ALSA support for VCO audio clocks
Date: Thu, 16 Oct 2014 14:01:45 +0100
Message-ID: <543FC1B9.7020002@eml.cc>
References: <5437B10B.9070702@eml.cc> <543C5510.6070603@linux.intel.com>
Reply-To: Tim Cussins <timcussins@eml.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id BD12326057D
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 15:01:49 +0200 (CEST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by gateway2.nyi.internal (Postfix) with ESMTP id 563AA20886
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 09:01:47 -0400 (EDT)
In-Reply-To: <543C5510.6070603@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Pierre,

Thanks heaps for the feedback. Sorry it's taken a few days to get back 
to you.

On Tue, Oct 14, 2014, at 12:41 AM, Pierre-Louis Bossart wrote:
> On 10/10/14, 5:12 AM, Tim Cussins wrote:
> > Hi all,
> >
> > I thought I'd brain-dump my thoughts on VCO support. It's not as
> > coherent as I'd like it to be, but it's important I get it out there as
> > the mini summit is only a few days away.
> >
> > Linn use-case
> > -------------
> >
> > We make network media players, and support synchronised playback where a
> > master device sends audio to several slave devices for simultaneous
> > rendering.
> >
> > On a given network there may be several masters, each coordinating
> > several slaves. These masters might be recovering their clocks from one
> > of many different types of external source: SPDIF or internet radio, for
> > example.
> >
> > By keeping the audio clocks synchronised using an appropriate network
> > protocol, we can achieve simultaneous playback across many devices,
> > which enable simultaneous start, and no drift.
> >
> > Network devices can be dynamically configured as master/slave, and
> > therefore must dynamically subscribe/unsubscribe to/from any master as
> > appropriate. Incidentally, we use our own UPnP services to make this
> > happen.
> >
> > Our hardware
> > ------------
> >
> > Our SoC of choice has an event timer, a notion of an event clock. This
> > allows signals from peripherals to be timestamped in hardware, and for
> > signals from the event module to be raised at peripherals using compare
> > registers. Think of it as a capture/compare module with multiple capture
> > channels and compare registers for almost all peripherals.
> >
> > To get synchronised start, We intend to drive the event timer using a
> > VCO, and trigger our I2S module (with preloaded output fifo) using the
> > appropriate compare register in the event module.
> >
> > Handwaving
> > ----------
> >
> > There are two use cases that are of interest here: VCO and PTP. The pure
> > VCO model implies that the PCM driver *owns* the VCO. The PTP model
> > implies that the PCM is a slave to a PTP clock, governed elsewhere.
> >
> > As our SoC event clock is system-wide, other drivers/processes may be
> > timestamping using this clock. Therefore this proposal seeks to address
> > the PTP model (PCM doesn't own VCO).
> >
> > The Linux kernel provides a kernel framework for supporting VCO-based
> > clocks, the PCH framework, which exposes such clocks to userspace with a
> > common API. This API isn't PTP-specific however, and would allow for
> > other synchronisation mechanisms.
> I guess you meant PHC. PCH sounds very good for an Intel employee but
> that's a different area.

Gah. That's a shocker :D Yes, PHC is right.

> >
> > The kernel refers to these as 'ptp' clocks, so I'll use PTP from here on
> > in: This doesn't imply IEEE-1588 however.
> >
> > Takashi added support for the selection of timestamp type at runtime.
> > These types currently correspond to posix clock types, and don't allow
> > for other time-sources such as PTP clocks.
> >
> > I imagine that PCM modules should be able to advertise their supported
> > timestamp types: In our case, our driver would additionally advertise
> > some unique PTP clock.
> >
> > It would be ideal if we could uniquely identify a PTP clock using a
> > posix clockid_t, the value of which could be meaningfully shared amongst
> > userspace processes, for example over D-Bus. However it's not
> > immediately clear that you can establish such a value. So for now let's
> > design as though we can't.
> >
> > Unique clocks from userspace might be represented as some tuple of a
> > _clock protocol_ (e.g. POSIX, PTP), and a _clock id_ that represents a
> > specific clock (e.g. CLOCK_MONOTONIC, CLOCK_REALTIME, "/dev/ptp0"). I'll
> > admit that a path to a device node is not ideal, but you get the idea:
> > It's a conversation starter. Maybe major/minor number would be better.
> > Either way, kernel-side ALSA must be able to timestamp using the
> > information.
> >
> > Takashi's work presumes that the clock protocol is posix: I would
> > advocate for allowing other protocols. No surprise there :)
> >
> > Timestamp Clock Enumeration
> > ---------------------------
> >
> > PCM devices could be probed for supported timestamps. Some enumeration
> > mechanism, akin to snd_pcm_query_chmaps_from_hw(), could return an array
> > of snd_pcm_clock_descriptor_t*, as in:
> >
> >      typedef struct _snd_pcm_clock_descriptor {
> >          /* enum indicating type of chewy center */
> >          snd_pcm_clock_protocol_t protocol;
> >          union {
> >              /* Essentially a clockid_t */
> >              struct snd_pcm_clock_posix  *posix_data;
> >              /* Perhaps "/dev/ptp0", or a major/minor number. */
> >              struct snd_pcm_clock_ptp    *ptp_data;
> >          } id;
> >      } snd_pcm_clock_descriptor_t;
> >
> > A revised version of Takashi's snd_pcm_sw_params_set_tstamp_type() would
> > take a snd_pcm_clock_descriptor_t*. This allows for existing posix clock
> > types, PTP clock types, and allows further clock types without an API
> > (ABI?) change.
> >
> > Summary
> > -------
> >
> > This document focuses on using a VCO as the output clock for a PCM
> > device, and hints at userspace API amendments that would support such a
> > configuration. It mentions:
> >
> > - Allowing the timestamp type to support other clock protocols
> > - PCM devices can be probed for a list of supported clock protocol/id
> > tuples.
> > - These tuples are sufficient to uniquely identify clocks from userspace.
> > - Proposal scales to multiple PTP clocks, with no implied relationship
> > to the system clock.
> >
> > It doesn't attempt to tackle configurations where the VCO is owned by
> > the PCM hardware: In this case, I would advocate for using the PTP
> > interface anyway, rather than adding an ALSA API for controlling the VCO.
> >
> > Any comments and feedback would be very welcome.
>
> Couple of comments:
> - you really need to talk with Richard Cochran on this, he contributed
> the PHC framework.

Cool - I'll figure out what my questions are first, of course.

> - your point about POSIX/non-POSIX clocks is a bit misleading. Even if
> you use PHC, the framework will expose clocks that can be modified for
> some cases with POSIX clock_gettime/Settime calls. The only things you
> can't do with the POSIX calls is shift the clock and adjust the
> frequency. see http://lwn.net/Articles/420175/

Thanks for the link. From Section 4.2.3:

"After opening the character device, the file descriptor may be also 
used as a clock id by applying a simple transformation."

While _some_ clock ids are unique to all userspace, this is not true of 
dynamic clock ids, which are based on the fd. So if we're using PHCs, we 
can't pass clockid_t between processes :(

I'm interested in this because I'd like the PHC clock to be managed by a 
daemon who's purpose is to:

  - manage the clocks involvement in various audio clock domains 
(master/slave etc)
  - servo the clock if it's a slave.

I imagine other userspace apps might use D-Bus to *request* 
subscription/unsubscription of the audio clock from available audio 
clock domains. As it stands, they'll have to talk about PHC device 
nodes, not clock ids. Oh well :)

> - The 'ownership' is also a bit confusing, since the clock would be
> registered with the PHC core. Did you mean that somehow the audio driver
> would need to register with the PHC framework and provide access to
> counters, and the user makes changes to the clock using the PHC
> framework.

Not this option ;) ...

> Or did you mean that ALSA would report timestamps using a
> clock handled completely by another driver - and registered in the PHC
> framework as well.

... /this/ option. Our PCM driver would be instantiated with a parameter 
(module param? devicetree?) that describes which PHCs are available for 
timestamps.

This implies that the PCM driver will need to talk to the PHC framework 
at runtime. I certainly hope that's possible :) A question for Richard 
Cochran probably.

> - Did you want to report system time and trigger_time using this
> PTP-like clock?

Not this option :D ...

Or is the plan only to use the PHC framework to
> speed-up/slow-down the audio clock, and keep using the regular system
> time as usual.

The discussion at the mini summit settled on
... this one. I'm expecting that the audio (event) clock is only exposed 
as a PHC, and the system clock is untouched. I can't see a requirement 
for conflating the audio clock and the system clock, only that it might 
be /convenient/ for some implementations.

I would argue against conflation though: In an environment where some 
audio clock masters are buggy or misbehave, or simply believe they live 
in the distant past/future, it's probably a bit strange to have the 
system clock for all slaves yanked forwards/backwards willy nilly: The 
effect of this could propagate to the UI, for example, confusing 
customers. Keeping the audio and system clocks separate makes the most 
sense to me.

> Thanks,
> -Pierre
>
>

Cheers,
Tim
