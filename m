From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [Minutes] ELCE Audio mini conf.
Date: Mon, 12 Oct 2015 14:49:46 +0100
Message-ID: <1444657786.2528.78.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id BEF1B261566
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2015 15:49:55 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

I've written up the minutes here below (including Vinod's minutes after
I left for my flight). Please do feel free to correct or add any missing
items.

If you intend to reply and discuss a topic in detail then it would
probably be helpful to include the topic in the $SUBJECT (so that it's
easy to track multiple topics that may arise from the minutes).

Jaroslav, I have some PDF slides from a few delegates. Can I post them
on to the Wiki ? This failed last time I tried after the Edinburgh audio
conference (Wiki could not upload PDFs ??). 
 

Soundwire: Pierre
=================

 - Slides to be posted. 
 - Shadow registers required for regamp. Mark: need to make sure we can
commit changes, and rules for witting. Reuse of codec drivers since reg
mapping should be similar to i2c regmaps. 
 - Some devices wont support run time clock changes. Need compatible
devices on bus. 
 - Each device has unique ID set by HW. Device enumeration can be auto
discovered. Can detect device but not capabilities. 
 - Device capabilities can come from hard coded driver data or ACPI/DT
data. Windows may use inf files for capabilities. 
 - Define bus api for master "controller".
 - Grouped triggers can be used for start duplex streams for
similtanious capture and playback. 
 - DAI is physical connection, logical links need to be worked out with
Routing config Mark: Redefining of ports/slots at runtime i.e. Leave up
to userspace for handling supported configurations of ports.



Energy efficiency: Alexander (Minutes also supplied by Alexander).
==================================================================

Power consumption of a SandyBridge-based Sony laptop has been measured
with a workload that does only audio playback. To ensure a reproducible
workload, the whole system has been constructed by a script using
debootstrap, and placed into an initramfs. Various versions of
PulseAudio were compared to CRAS and to the use of ALSA hw device, at
latencies 7 ms, 28 ms and 448 ms. Even in the best case (ALSA), going
from 448 to 28 ms means using extra 300 mW. For PulseAudio, the overhead
of using low latency is even higher, presumably because of a chatty
protocol. In version 7, there was some work (srbchannel) with the aim to
reduce this overhead, but there is still more way to go. There was a
suggestion to use perf to analyze the problem further. It should be
noted that latencies as high as 448 ms are not usable without the
ability to rewind, which PulseAudio posesses (at the cost of more
complex, and actually incorrect, code) and CRAS doesn't. So CRAS
decision to never do rewinds costs it 300 mW (448 ms latency is usable
only for benchmarking purposes). Note: at least two people in the
audience misunderstood this statement as originally formulated
(thinko?), and got it as "PulseAudio decision to do rewinds costs it 300
mW", which is of course wrong. The cost of rewinds is in code
complexity, real user-reported bugs and "how to test this code path"
questions from developers, which, in the opinion of Alexander Patrakov,
may outweigh the gains in energy efficiency (Arun Raghavan disagrees). A
proposal was made by P.-L. Bossart to introduce a hw param that the
application would set if it intends to never do rewinds, with the
implication that a SkyLake driver can use this information for
codec-side power saving (by prefetching audio data and powering the link
off). Arun Raghavan (presumably due to the above misunderstanding)
disagreed and instead proposed to make the device non-rewindable if this
means power savings. Alexander is in favor of the hw param, because it
would be useful for CRAS, but harmful for the current PulseAudio (it
would force abandoning high latency). A future version of PulseAudio
could, though, use a separate DSP stream for a music application (if
there is only one), and, because a new application never appears, and
the hardware volume is precise enough, there would never be a need to
rewind. This, though, would need eliminating the support for rewinds
from the client API (the last two parameters for pa_stream_write()),
which can be done by ignoring these parameters.



Documentation: Takashi
======================
 - Patches that introduce new functionality should also include
documentation.
 - Caretaker required for docs. Who ?
 - Uploading materials, in central location, ask kernel.org. 
 - Charles and Rakesh voluntered to write some docs.



Alsa-lib: release schedule: Vinod.
================================== 
 - Request for more frequent release. Release inline with 1 - 2 kernel
releases.
 - Integrate tinycompress into alsa release.



Testing/QA: Liam, Takashi, Mark, Pierre
=======================================
 - BAT tool: Now upstream, WiP for review comments docs and new
features. 
 - Mark doing brute force tool for kcontrol testing.  Kcontrol status
can be watched via debubFS. Multiple threads. 
 - Takashi: Need unit testing codec drivers. Some codec vendors have
tools for this but something generic would be good. QA unit test could
use topology readback to check topology in userspace.
 - Pierre: Latency testing, USB device to toggle GPIO (to indicate
stream start) and audio latency measured from this point. Available on
01.org latency tools. To be extended to BAT. 



HDA/gfx: relevant people not in room.
=====================================
 - Pierre: Hotplug DP over USB C required. Needs input from GFX folks.



BATCH flag for USB: Arun.
=========================
 - Flag does not respond to reality, lets deprecate it. no users.
 - Dylan: need to know transfer size for CRAS (uses extra samples for
buffering). 
 - BATCH flag means period size transfers, applications that use new
granularity API can ignore batch flag. Pierre: to implement.



Splitting out controls: Takashi
===============================

 - Restricted access.  Consensus to restrict access to some controls due
to possibility of breaking HW at kernel level. i.e. prevent feeding
digital Mic into HP amp to prevent speaker over heating.
 - Some clamping APIs already exist, but these should be extended to
include DAPM. 



Simple card: ACPI support. Vinod
================================

 - Clock drivers required alongside helper functions to help initialise
DAI links etc.
 - Vinod to publish spec as RFC in Q4.
 - Doubts of using DMI names for differentiation.



Topology: Liam, Mengdong
========================
 - Proposals to use debugFS/ioctl/media controller for exporting
topology data to userspace. Drawbacks with all three approaches, but are
aimed at different end users i.e. debugFS aimed at kernel audio
developers/integrators/testers and media aimed at userspace developers
and end users. Will probably support both debugFS (or other kernel file)
and media API. Mark to discuss at Media team in Seoul. ASoC internals to
gather data for debugFS and Media API will be the same code so nothing
blocking initial development. 



Tiny-fication. Keyon, Liam
==========================

 - IoT devices have tight memory footprints so audio kernel and
userspace can be very limited.
 - Userspace is fine with tinyalsa. 
 - Currently Keyon has worked on some IoT device options to disable ALSA
functions. e.g. code saving of 13k for refinement, but some IoT options
can break existing userpsace.
 - Suggestion is to research tinycompress API for general PCM usage.
 - Look at removing DAPM strings (will need topology dump tool to
automate this though).
 - Some structures can also be shrunk.


Android configuration consolidation
===================================

- different configuration formats XML, ucm, This tool takes Android XML
and converts to UCM 
- uses Sony Xperia 
- generates UCM file from XML 
- Android: Try to converge to a HAL, but diverges quickly. Quirks for
modem etc cant be represented well. 
- Arun will send the link to his work


HDA Restructuring: Vinod & Rakesh
=================================

- Discussed HW and SW overview
- Future HDA work and codec conversion discussion
<dont have detailed notes here as I was talking>



DPMST: Mengdong
================
- One DVI port can be used to transmit multiple independent streams. 
- Three display pipelines in HW, so at most 3 streams can be supported
across all ports
- Need to modify representation to have stream on device rather than per
pin.
- While moving the monitor can be incompatible so should be modified
- display should tell us unplug/plug on move. Sound server reacts to it.
- This notification thru Component fwk.
- Various options are discussed. Needs more offline discussion on
approach and to solve this issue



ALSA Core Challenges:
======================
- ALSA Core locking is complicated. Core code is quite difficult to
understand.
- PCM linking makes things complex
- Add documentation for locks. 
 - Controls can be hidden in UI tools through iface_cards.
 - DPCM hidden PCMs should not be shown in usermode, hide them from
Usermode


Multi Channel ASoC Controls;
=============================
- channel maps dont make sense for ASoC as asoc paths dont have channel
information
- conclusion: add channel maps on HDMI edge. 
- we can add multi-channel controls to the asoc


Liam
