From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Some thoughts on ALSA support for VCO audio clocks
Date: Mon, 13 Oct 2014 17:41:20 -0500
Message-ID: <543C5510.6070603@linux.intel.com>
References: <5437B10B.9070702@eml.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F5342604F5
 for <alsa-devel@alsa-project.org>; Tue, 14 Oct 2014 00:41:45 +0200 (CEST)
In-Reply-To: <5437B10B.9070702@eml.cc>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tim Cussins <timcussins@eml.cc>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/10/14, 5:12 AM, Tim Cussins wrote:
> Hi all,
>
> I thought I'd brain-dump my thoughts on VCO support. It's not as
> coherent as I'd like it to be, but it's important I get it out there as
> the mini summit is only a few days away.
>
> Linn use-case
> -------------
>
> We make network media players, and support synchronised playback where a
> master device sends audio to several slave devices for simultaneous
> rendering.
>
> On a given network there may be several masters, each coordinating
> several slaves. These masters might be recovering their clocks from one
> of many different types of external source: SPDIF or internet radio, for
> example.
>
> By keeping the audio clocks synchronised using an appropriate network
> protocol, we can achieve simultaneous playback across many devices,
> which enable simultaneous start, and no drift.
>
> Network devices can be dynamically configured as master/slave, and
> therefore must dynamically subscribe/unsubscribe to/from any master as
> appropriate. Incidentally, we use our own UPnP services to make this
> happen.
>
> Our hardware
> ------------
>
> Our SoC of choice has an event timer, a notion of an event clock. This
> allows signals from peripherals to be timestamped in hardware, and for
> signals from the event module to be raised at peripherals using compare
> registers. Think of it as a capture/compare module with multiple capture
> channels and compare registers for almost all peripherals.
>
> To get synchronised start, We intend to drive the event timer using a
> VCO, and trigger our I2S module (with preloaded output fifo) using the
> appropriate compare register in the event module.
>
> Handwaving
> ----------
>
> There are two use cases that are of interest here: VCO and PTP. The pure
> VCO model implies that the PCM driver *owns* the VCO. The PTP model
> implies that the PCM is a slave to a PTP clock, governed elsewhere.
>
> As our SoC event clock is system-wide, other drivers/processes may be
> timestamping using this clock. Therefore this proposal seeks to address
> the PTP model (PCM doesn't own VCO).
>
> The Linux kernel provides a kernel framework for supporting VCO-based
> clocks, the PCH framework, which exposes such clocks to userspace with a
> common API. This API isn't PTP-specific however, and would allow for
> other synchronisation mechanisms.
I guess you meant PHC. PCH sounds very good for an Intel employee but 
that's a different area.

>
> The kernel refers to these as 'ptp' clocks, so I'll use PTP from here on
> in: This doesn't imply IEEE-1588 however.
>
> Takashi added support for the selection of timestamp type at runtime.
> These types currently correspond to posix clock types, and don't allow
> for other time-sources such as PTP clocks.
>
> I imagine that PCM modules should be able to advertise their supported
> timestamp types: In our case, our driver would additionally advertise
> some unique PTP clock.
>
> It would be ideal if we could uniquely identify a PTP clock using a
> posix clockid_t, the value of which could be meaningfully shared amongst
> userspace processes, for example over D-Bus. However it's not
> immediately clear that you can establish such a value. So for now let's
> design as though we can't.
>
> Unique clocks from userspace might be represented as some tuple of a
> _clock protocol_ (e.g. POSIX, PTP), and a _clock id_ that represents a
> specific clock (e.g. CLOCK_MONOTONIC, CLOCK_REALTIME, "/dev/ptp0"). I'll
> admit that a path to a device node is not ideal, but you get the idea:
> It's a conversation starter. Maybe major/minor number would be better.
> Either way, kernel-side ALSA must be able to timestamp using the
> information.
>
> Takashi's work presumes that the clock protocol is posix: I would
> advocate for allowing other protocols. No surprise there :)
>
> Timestamp Clock Enumeration
> ---------------------------
>
> PCM devices could be probed for supported timestamps. Some enumeration
> mechanism, akin to snd_pcm_query_chmaps_from_hw(), could return an array
> of snd_pcm_clock_descriptor_t*, as in:
>
>      typedef struct _snd_pcm_clock_descriptor {
>          /* enum indicating type of chewy center */
>          snd_pcm_clock_protocol_t protocol;
>          union {
>              /* Essentially a clockid_t */
>              struct snd_pcm_clock_posix  *posix_data;
>              /* Perhaps "/dev/ptp0", or a major/minor number. */
>              struct snd_pcm_clock_ptp    *ptp_data;
>          } id;
>      } snd_pcm_clock_descriptor_t;
>
> A revised version of Takashi's snd_pcm_sw_params_set_tstamp_type() would
> take a snd_pcm_clock_descriptor_t*. This allows for existing posix clock
> types, PTP clock types, and allows further clock types without an API
> (ABI?) change.
>
> Summary
> -------
>
> This document focuses on using a VCO as the output clock for a PCM
> device, and hints at userspace API amendments that would support such a
> configuration. It mentions:
>
> - Allowing the timestamp type to support other clock protocols
> - PCM devices can be probed for a list of supported clock protocol/id
> tuples.
> - These tuples are sufficient to uniquely identify clocks from userspace.
> - Proposal scales to multiple PTP clocks, with no implied relationship
> to the system clock.
>
> It doesn't attempt to tackle configurations where the VCO is owned by
> the PCM hardware: In this case, I would advocate for using the PTP
> interface anyway, rather than adding an ALSA API for controlling the VCO.
>
> Any comments and feedback would be very welcome.

Couple of comments:
- you really need to talk with Richard Cochran on this, he contributed 
the PHC framework.
- your point about POSIX/non-POSIX clocks is a bit misleading. Even if 
you use PHC, the framework will expose clocks that can be modified for 
some cases with POSIX clock_gettime/Settime calls. The only things you 
can't do with the POSIX calls is shift the clock and adjust the 
frequency. see http://lwn.net/Articles/420175/
- The 'ownership' is also a bit confusing, since the clock would be 
registered with the PHC core. Did you mean that somehow the audio driver 
would need to register with the PHC framework and provide access to 
counters, and the user makes changes to the clock using the PHC 
framework. Or did you mean that ALSA would report timestamps using a 
clock handled completely by another driver - and registered in the PHC 
framework as well.
- Did you want to report system time and trigger_time using this 
PTP-like clock? Or is the plan only to use the PHC framework to 
speed-up/slow-down the audio clock, and keep using the regular system 
time as usual.
Thanks,
-Pierre
