From: Liam Girdwood <lrg@ti.com>
Subject: Re: UCM files for tegra-wm8903 on seaboard
Date: Thu, 19 May 2011 14:19:17 +0100
Message-ID: <4DD518D5.8030509@ti.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0498A47B0F@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 8607510384B
	for <alsa-devel@alsa-project.org>;
	Thu, 19 May 2011 15:19:22 +0200 (CEST)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0498A47B0F@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Mark Brown (broonie@opensource.wolfsonmicro.com)" <broonie@opensource.wolfsonmicro.com>, "jiesun@chromium.org" <jiesun@chromium.org>
List-Id: alsa-devel@alsa-project.org

On 18/05/11 23:40, Stephen Warren wrote:
> Liam,
> 
> I've come up with a basic set of UCM files for Tegra Seaboard, included
> below. I briefly tested parts of them with alsaucm.
> 
> I do have a few questions on UCM and how to write these files before I
> go too far:
> 
> Some of the answers may depend on, or be impacted by, policy decisions
> by the user of UCM; general desktop PulseAudio may have different
> requirements to a more tightly controlled ChromeOS configuration. I'm
> not sure how much that impacts the UCM files themselves, or whether the
> UCM files are supposed to be fully general and hence the same for all
> OSs and policy setups.
> 
> 1) Can multiple verbs be active at once? In other words, I have cases
> defined for HiFi (playback) and Record (capture). Should these be merged
> together such that both playback and capture can operate at once, or can
> an application just active both verbs at once when it wants to do
> multiple things?
> 

No, only 1 verb is active at a time. Verbs can support both playback and capture streams to multiple devices. Verbs can also support a modifier for when you need to do things like play system tones etc. 

> 2) In the ChromeOS kernel, there's a separate PCM for playback to WM8903
> and playback to the SPDIF controller, and hence on to HDMI. Since these
> use different values for PlaybackPCM, I defined separate use-cases for
> analog and HDMI/SPDIF playback. Is this the typical way of splitting
> things up, or would one typically have a unified use-case with the
> PlaybackPCM Value being part of the SectionDevice?

If the use case is the same, e.g. "Music", I would just add them as different Music devices and have a PlaybackPCM for each of them.

> 
> 3) For the HiFi case, there are a couple of volume controls in serial;
> i.e. "Digital Playback Volume" affects both speaker/headphone output
> whereas "Speaker Volume" and "Headphone Volume" affect just one of the
> devices. I've defined a PlaybackVolume Value for the overall verb and
> the same Value for each device. Are applications able to query the
> Value separately for verb and devices, or will using the same name
> cause conflicts? Is there any kind of (de-facto) standard for how to
> represent this situation?

I think the idea here is to set the common volume in the verb (this could also be exported as the master volume) and then export the device specific volumes in the device descriptions. That way your app would be told about the device volumes and also the verb master volume if it required it.

Liam

> 
> Thanks very much for any feedback.
> 
> ------------------
> tegra-wm8903-seaboard.conf:
> 
> # UCM configuration for Tegra WM8903 driver for Seaboard
> 
> SectionUseCase."Record" {
>     File "record"
>     Comment "Record"
> }
> 
> SectionUseCase."HiFi" {
>     File "hifi"
>     Comment "Play HiFi quality Music"
> }
> 
> SectionUseCase."HiFi HDMI" {
>     File "hdmi"
>     Comment "Play HiFi quality Music over HDMI"
> }
> 
> SectionDefaults [
>     cdev "hw:0"
> 
>     cset "name='Headphone Switch' off,off"
>     cset "name='Left Output Mixer DACL Switch' on"
>     cset "name='Left Output Mixer DACR Switch' off"
>     cset "name='Left Output Mixer Left Bypass Switch' off"
>     cset "name='Left Output Mixer Right Bypass Switch' off"
>     cset "name='Right Output Mixer DACL Switch' off"
>     cset "name='Right Output Mixer DACR Switch' on"
>     cset "name='Right Output Mixer Left Bypass Switch' off"
>     cset "name='Right Output Mixer Right Bypass Switch' off"
> 
>     cset "name='Int Spk Switch' off"
>     cset "name='Speaker Switch' off,off"
>     cset "name='Left Speaker Mixer DACL Switch' on"
>     cset "name='Left Speaker Mixer DACR Switch' off"
>     cset "name='Left Speaker Mixer Left Bypass Switch' off"
>     cset "name='Left Speaker Mixer Right Bypass Switch' off"
>     cset "name='Right Speaker Mixer DACL Switch' off"
>     cset "name='Right Speaker Mixer DACR Switch' on"
>     cset "name='Right Speaker Mixer Left Bypass Switch' off"
>     cset "name='Right Speaker Mixer Right Bypass Switch' off"
> 
>     cset "name='Left Input PGA Switch' off"
>     cset "name='Right Input PGA Switch' off"
>     cset "name='Right Inverting Input Mux' 'IN2R'"
> ]
> 
> ------------------
> hifi:
> 
> SectionVerb {
>     Value {
>         PlaybackPCM "hw:0,0"
>         PlaybackVolume "Digital Playback Volume"
>     }
> }
> 
> SectionDevice."Speakers".0 {
>     Comment "Internal Speakers"
> 
>     EnableSequence [
>         cdev "hw:0"
>         cset "name='Speaker Switch' on,on"
>         cset "name='Int Spk Switch' on"
>     ]
> 
>     DisableSequence [
>         cdev "hw:0"
>         cset "name='Speaker Switch' off,off"
>         cset "name='Int Spk Switch' off"
>     ]
> 
>     Value {
>         PlaybackVolume "Speaker Volume"
>         PlaybackSwitch "Speaker Switch"
>     }
> }
> 
> SectionDevice."Headphones".0 {
>     Comment "Headphone Jack"
> 
>     EnableSequence [
>         cdev "hw:0"
>         cset "name='Headphone Switch' on,on"
>     ]
> 
>     DisableSequence [
>         cdev "hw:0"
>         cset "name='Headphone Switch' off,off"
>     ]
> 
>     Value {
>         PlaybackVolume "Headphone Volume"
>         PlaybackSwitch "Headphone Switch"
>     }
> }
> 
> ------------------
> hifi-hdmi:
> 
> SectionVerb {
>     Value {
>         PlaybackPCM "hw:0,1"
>     }
> }
> 
> SectionDevice."HDMI".0 {
>     Comment "HDMI"
> }
> 
> ------------------
> record:
> 
> SectionVerb {
>     Value {
>         CapturePCM "hw:0,0"
>         CaptureVolume "Digital Capture Volume"
>     }
> }
> 
> SectionDevice."AMIC".0 {
>     Comment "Analog Microphone Jack"
> 
>     EnableSequence [
>         cdev "hw:0"
>         cset "name='ADC Input' 'ADC'"
>         cset "name='Left Capture Mux' 'Right'"
>         cset "name='Right Capture Mux' 'Right'"
>     ]
> 
>     Value {
>         CaptureVolume "Right Input PGA Volume"
>     }
> }
> 
> SectionDevice."DMIC".0 {
>     Comment "Internal Digital Microphone"
> 
>     EnableSequence [
>         cdev "hw:0"
>         cset "name='ADC Input' 'DMIC'"
>         cset "name='Left Capture Mux' 'Left'"
>         cset "name='Right Capture Mux' 'Right'"
>     ]
> 
>     Value {
>     }
> }
> 
