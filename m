From: Patrick Lai <plai@codeaurora.org>
Subject: 2014 ALSA micro-conference meeting notes - 10/14
	Dussedorf
Date: Mon, 27 Oct 2014 12:52:44 -0700
Message-ID: <544EA28C.90704@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.11.231])
 by alsa0.perex.cz (Postfix) with ESMTP id 02518261510
 for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2014 20:52:49 +0100 (CET)
Received: from [10.73.181.68] (pat_11.qualcomm.com [192.35.156.11])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: plai@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 5DABA14149C
 for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2014 19:52:46 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Attendees:
Takashi Iwai, Mark Brown, Vinod Koul, Patrick Lai, Lars-Peter Clausen,
Eric Laurent, David Henningsson, Tanu Kaskinen, Arun Raghavan, Paul 
Handrigan, Daniel Mack, Dylan Reid, Charles Keepax, Nariman Poushin,
Peter Meerwald, Alexander Patrakov, Hui Wang, Tim Cussins, Nick Stoughton

Topic: ASoC componentization

Motivation - hardware is becoming more complex as CPU and CODEC
functionality are overlapping. Codec now has DSP. DSP on CPU need DAPM
and IO. Current ASoC APIs are based on clearly distinguished component
type, platform, CPU, CODEC. It makes difficult to support complex
configuration such as CPU -> CODEC -> CODEC or DSP with DAC, ADC, SRC

Points discussed
- Componentization is coming on V 3.18.

- Lars-Peter is cleaning up suspend/resume logic in ASoC framework as
conflicting with individual driver suspend/resume. Goal is to move
toward bus suspend/resume

- Grand scheme is to treat hardware module as component instead of
clearly distinguish component type(platform/cpu/codec). Russel King
introduced component framework recently - one master with many slave
components. ASoC could adopt component framework. Sound card would be
the master while individual drivers register slave components. Moving
to use component framework would help unbinding of drivers cleanly as
well.

- Discuss possible phasing out/refactor DPCM, DAI-LINK and add support
to DAPM for PCM configuration propagation.

Topic: Dynamic FW framework

Motivation: It is very common for SoC/CODEC vendors putting DSP onto
their hardware. Topology/functionality can change based on DSP image
being loaded. Dynamic FW framework is designed to address the need to
run-time create DSP topology graph without hard coding into the driver

- For DSP with large memory case, swapping DSP image at run-time might
not be a concern so firmware download can happen once after boot up but
CODEC DSP tend to be memory constraint. Run-time swapping requiring
deregister of existing controls and register with new one. ALSA
framework does not have good support for this requirement currently.

- DFW tool allows each solution vendor to develop its own plug-in and
can convert static description to DFW binary format. Through this way,
solution vendor can specify its own data and associate with ASoC
component such as DAPM widget.

Topic: Mapping channels through DAI links in ASoC

Motivation: Currently, it is difficult to track how each channel get
propagated from one component to another i.e 8 channel streams from CPU
to CODECs with stereo channels in TDM interface

- Consensus that there is value to track the channel mapping
- Possible solution is to create widget per channel of PCM object

Topic: ALSA test

- Discussed test ALSA core framework on virtual platform and patch
submission should go through testing. For embedded system, the benefit
may not be significant as bug tend to show up during use case transition

- David demonstrated HDA CODEC test. Perhaps, this test can be
leveraged for ALSA core test framework

- There is no ALSA compliance test right now. There is small tool
called alsa-time-test which could potentially be part of ALSA test
suite. Another way to validate conformance is to run PulseAudio as
PulseAudio exercises a lot of alsa-lib API

- Vinod suggested a test framework Liam has been developing, to compare
the sign wave form with the captured one. Contribution is welcome and 
can be merged to any public repo. In addition, for *any* other test 
programs or metrics, contribution is welcomed.

Topic: ALSA documentation

- For mixer control related query, 
Documentation/sound/alsa/ControlNames.txt in kernel tree is a good 
resource to read

- Each kernel function can have a Javadoc style comment.  This can be
formated through DocBook directory in kernel tree as PDF or HTML (or
anything else).  So, from now on, the javadoc style comment is
mandatory for each patch including exported symbols.

- the root DocBook template file is missing for ASoC. Presentation
given by Mark in ELC few years back could be a good supplement for
someone to get a quick intro to develop drivers to plug into ASoC
framework

Topic: ALSA control names

- Even though in embedded world, SoC architecture from different
vendors are not so consistent enough to come up with common name. There
is still value to come up with standard name for different types of
controls such as Volume, Ramp up/down time (in unit of DB per ms or
sample count)

- Media controller discussion came up again as it can be solution to
help user-space recognize mixer control for the topology

- General consensus is that each vendor should have control definition
document to describe what each control do

- As part of user case transition, user-space often execute mute as
well. Instead of ASoC framework handles digital mute as part of
startup/shutdown sequence, let user-space have the control through
mixer control command.

- Suggest to have volume, mute control per PCM object which takes the
same approach as channel MAP API by exposing mixer control with name
"<pcm device id> volume"

Topic: ALSA code removal

- Can OSS be removed? Anyone is still using OSS? Perhaps, OSS emulation
can be done in user-space

- Add warning to notify people to contact usage of APIs to prevent
deprecation

- Discuss removal of old driver but does not look safe to remove

- Suggestion to remove ADPCM support in ALSA core framework

- Removal in alsa-library: aserver, shm, and share plugins were
discussed. The decision seems to be putting them under a ./configure
switch now and remove later

Topic: DSP effect library/more DSP support

- For DSP effect, Intel goes through mixer control approach which
controls are defined in the dynamic firmware. It is not clear how
Android effect would be associate stream to corresponding mixer
controls for the DSP effect

- Discuss couple issues when dealing with DSP architecture. These
problems surfaces on PulseAudio
1. DSP DMA data as soon as it can put into its internal memory. Hence,
hw_ptr does not reflect actual consumption point in DSP. This causes
rewinding logic not function properly. It would be ideal if ALSA could
allow driver expose granularity of hardware pointer

2. DSP continuous latency can vary. ALSA should have mechanism to allow
driver expose latency information to user-space

Topic: consolidate jack report mechanism

Currently, there are K-control, input event, extcon mechanism to report
headset jack events. Intel would like to see k-control as final solution 
in order to align with DSP notification through k-control
Discussed to consolidate into one mechanism. One proposal from Mark is 
making a common in-kernel framework which all driver would use this jack 
framework, the framework would in turn expose this jack through 
different user-space interfaces depending on kernel configuration

Topic: Convergence of single configuration file format UCM vs mixer_path

Single format would make vendors who supports both UCM and mixer_path
systems life easier. PulseAudio extract use cases list from UCM while
mixer_path does not have such support yet.

Action item: Arun to look into the convergence effort

Topic: scheduled trigger start of PCM

- Nick to submit snd_pcm_start_at() patch. The change is software based
solution but margin of error is acceptable for the use case in mind

- Brought up the use case which time stamp is sent along with every
buffer so DSP knows to drop when the buffer is given pass the deadline.

Topic: ACPI

Intel is moving system-level device configuration file toward ACPI.
Device specific data(_DSD) section defined in ACPI 5.1 specification
allows device vendor to pass device specific data. (i.e CODEC device
data).

Topic: synchronization of HDMI/USB hot-plug and configuration events

- Instead of waiting for USB hotplug event, Android should wait for
udev event to notify new USB sound card is created
- Discuss making HDMI a separate sound card. However, HDMI could simply
be another routing path in a sound card for embedded architecture.

- Suggest to return error when reading EDID info is HDMI is not ready

Topic: Sharing hardware component between ALSA framework and other drivers

- When hot word is detected, go through DAPM to enable mic path.

Topic: Rewindng in ALSA PCM plugins

1. Discussion of the method to calculate the amount of samples that
should not be rewound over after the hardware pointer. Result: the
audience demonstrated general understanding of the issue. Lars
suggested having two hardware pointers, because there are two
boundaries that are unsafe to cross when overwriting samples: one from
the left (normal write path), and one from the right (rewind path). No
action items.

2. Discussion of the criteria when to enable timer-based scheduling.
Suggestion: do not enumerate badness [*] when deciding whether to
enable tsched in PulseAudio, because the bad things tend to go
unreported by the drivers and people treat these as PulseAudio bugs.
Move to a whitelist-based approach. The suggestion was rejected.

[*] BLOCK_TRANSFER (unimplemented), BATCH (implemented), huge FIFO
(unimplemented), completely unrewindable (unimplemented, but a
workaround for ioplug exists), what else?

3. Suggestion to revive the snd_pcm_hw_params_can_rewind() API
function. Approved by Takashi.

4. Discussion whether the snd_pcm_rewindable() function is useful at
all. The uselessness comes from the need to call snd_pcm_avail_update()
beforehand, and the position of Clemens Ladisch that the result of
snd_pcm_rewindable() must not take pointer granularity and other
reasons why non-rewindable samples exist into account. That way, the
caller can just deduce the result from the snd_pcm_avail_update()
return value. David Henningsson does not like this situation. Mark
Brown suggests reporting the DMA transfer size, with the possibility
for architectures to override the returned value with something larger
such as the cache line size.

5. Status report on rewind support in PCM plugins. Summary: at least 10
plugins out of 26 have known problems and should have rewind support
either fixed (which is not always possible) or disabled.

Thanks
Patrick

-- 
Patrick Lai
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,a Linux Foundation Collaborative Project
