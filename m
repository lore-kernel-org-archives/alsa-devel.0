From: Tim Cussins <timcussins@eml.cc>
Subject: Some thoughts on ALSA support for VCO audio clocks
Date: Fri, 10 Oct 2014 11:12:27 +0100
Message-ID: <5437B10B.9070702@eml.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 80EC02604F3
 for <alsa-devel@alsa-project.org>; Fri, 10 Oct 2014 12:12:43 +0200 (CEST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by gateway2.nyi.internal (Postfix) with ESMTP id 8D99B2092B
 for <alsa-devel@alsa-project.org>; Fri, 10 Oct 2014 06:12:42 -0400 (EDT)
Received: from [10.2.10.211] (unknown [195.59.102.251])
 by mail.messagingengine.com (Postfix) with ESMTPA id 3318CC00008
 for <alsa-devel@alsa-project.org>; Fri, 10 Oct 2014 06:12:42 -0400 (EDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

I thought I'd brain-dump my thoughts on VCO support. It's not as 
coherent as I'd like it to be, but it's important I get it out there as 
the mini summit is only a few days away.

Linn use-case
-------------

We make network media players, and support synchronised playback where a 
master device sends audio to several slave devices for simultaneous 
rendering.

On a given network there may be several masters, each coordinating 
several slaves. These masters might be recovering their clocks from one 
of many different types of external source: SPDIF or internet radio, for 
example.

By keeping the audio clocks synchronised using an appropriate network 
protocol, we can achieve simultaneous playback across many devices, 
which enable simultaneous start, and no drift.

Network devices can be dynamically configured as master/slave, and 
therefore must dynamically subscribe/unsubscribe to/from any master as 
appropriate. Incidentally, we use our own UPnP services to make this happen.

Our hardware
------------

Our SoC of choice has an event timer, a notion of an event clock. This 
allows signals from peripherals to be timestamped in hardware, and for 
signals from the event module to be raised at peripherals using compare 
registers. Think of it as a capture/compare module with multiple capture 
channels and compare registers for almost all peripherals.

To get synchronised start, We intend to drive the event timer using a 
VCO, and trigger our I2S module (with preloaded output fifo) using the 
appropriate compare register in the event module.

Handwaving
----------

There are two use cases that are of interest here: VCO and PTP. The pure 
VCO model implies that the PCM driver *owns* the VCO. The PTP model 
implies that the PCM is a slave to a PTP clock, governed elsewhere.

As our SoC event clock is system-wide, other drivers/processes may be 
timestamping using this clock. Therefore this proposal seeks to address 
the PTP model (PCM doesn't own VCO).

The Linux kernel provides a kernel framework for supporting VCO-based 
clocks, the PCH framework, which exposes such clocks to userspace with a 
common API. This API isn't PTP-specific however, and would allow for 
other synchronisation mechanisms.

The kernel refers to these as 'ptp' clocks, so I'll use PTP from here on 
in: This doesn't imply IEEE-1588 however.

Takashi added support for the selection of timestamp type at runtime. 
These types currently correspond to posix clock types, and don't allow 
for other time-sources such as PTP clocks.

I imagine that PCM modules should be able to advertise their supported 
timestamp types: In our case, our driver would additionally advertise 
some unique PTP clock.

It would be ideal if we could uniquely identify a PTP clock using a 
posix clockid_t, the value of which could be meaningfully shared amongst 
userspace processes, for example over D-Bus. However it's not 
immediately clear that you can establish such a value. So for now let's 
design as though we can't.

Unique clocks from userspace might be represented as some tuple of a 
_clock protocol_ (e.g. POSIX, PTP), and a _clock id_ that represents a 
specific clock (e.g. CLOCK_MONOTONIC, CLOCK_REALTIME, "/dev/ptp0"). I'll 
admit that a path to a device node is not ideal, but you get the idea: 
It's a conversation starter. Maybe major/minor number would be better. 
Either way, kernel-side ALSA must be able to timestamp using the 
information.

Takashi's work presumes that the clock protocol is posix: I would 
advocate for allowing other protocols. No surprise there :)

Timestamp Clock Enumeration
---------------------------

PCM devices could be probed for supported timestamps. Some enumeration 
mechanism, akin to snd_pcm_query_chmaps_from_hw(), could return an array 
of snd_pcm_clock_descriptor_t*, as in:

     typedef struct _snd_pcm_clock_descriptor {
         /* enum indicating type of chewy center */
         snd_pcm_clock_protocol_t protocol;
         union {
             /* Essentially a clockid_t */
             struct snd_pcm_clock_posix  *posix_data;
             /* Perhaps "/dev/ptp0", or a major/minor number. */
             struct snd_pcm_clock_ptp    *ptp_data;
         } id;
     } snd_pcm_clock_descriptor_t;

A revised version of Takashi's snd_pcm_sw_params_set_tstamp_type() would 
take a snd_pcm_clock_descriptor_t*. This allows for existing posix clock 
types, PTP clock types, and allows further clock types without an API 
(ABI?) change.

Summary
-------

This document focuses on using a VCO as the output clock for a PCM 
device, and hints at userspace API amendments that would support such a 
configuration. It mentions:

- Allowing the timestamp type to support other clock protocols
- PCM devices can be probed for a list of supported clock protocol/id 
tuples.
- These tuples are sufficient to uniquely identify clocks from userspace.
- Proposal scales to multiple PTP clocks, with no implied relationship 
to the system clock.

It doesn't attempt to tackle configurations where the VCO is owned by 
the PCM hardware: In this case, I would advocate for using the PTP 
interface anyway, rather than adding an ALSA API for controlling the VCO.

Any comments and feedback would be very welcome.

Cheers,
Tim
