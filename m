From: abraham duenas <aduejazz@gmail.com>
Subject: Re: ALSA UCM
Date: Thu, 4 Nov 2010 06:57:19 -0600
Message-ID: <AANLkTim1Aopc2ALEXoWorPjzua0gGoSef8CpH+At4_cp@mail.gmail.com>
References: <AANLkTimFdKg=_KDv8fbSJry6XTEsZqyQz7GhzaPxXDYP@mail.gmail.com>
	<1288865349.3277.14.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1376110384D
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 13:57:21 +0100 (CET)
Received: by wye20 with SMTP id 20so1879243wye.38
	for <alsa-devel@alsa-project.org>; Thu, 04 Nov 2010 05:57:20 -0700 (PDT)
In-Reply-To: <1288865349.3277.14.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Sure,
I put the following files under /usr/shara/alsa/ucm/SDP4430/ :
- SDP4430.conf
- hifi

SDP4430.conf looks like this:

# UCM configuration for SDP4430
SectionUseCase."HiFi" {
                File "hifi"
                Comment "Play and record HiFi quality Music."
}

SectionDefaults [
                cset "name='Capture Preamplifier Volume',index=2 0,0"
                exec "echo Im setting defaults"
                cset "name='Capture Volume',index=2 0,0"
                cset "name='Aux FM Volume',index=2 0,0"
                cset "name='Headset Playback Volume',index=2 0,0"
                cset "name='Handsfree Playback Volume',index=2 0,0"
                cset "name='Earphone Playback Volume',index=1 0"
                cset "name='Earphone Driver Switch',index=1 0"
                cset "name='HS Right Playback',index=1 0"
                cset "name='HS Left Playback',index=1 0"
                cset "name='HF Right Playback',index=1 0"
                cset "name='HF Left Playback',index=1 0"
                cset "name='Analog Right Capture Route',index=1 3"
		cset "name='Analog Left Capture Route',index=1 3"
		cset "name='DL1 Media Playback Volume',index=1 0"
		cset "name='DL1 Tones Playback Volume',index=1 0"
		cset "name='DL1 Voice Playback Volume',index=1 0"
		cset "name='DL1 Capture Playback Volume',index=1 0"
		cset "name='DL2 Media Playback Volume',index=1 0"
		cset "name='DL2 Tones Playback Volume',index=1 0"
		cset "name='DL2 Voice Playback Volume',index=1 0"
		cset "name='DL2 Capture Playback Volume',index=1 0"
		cset "name='MM_EXT_UL Capture Switch',index=1 0"
		cset "name='MM_EXT_DL Playback Switch',index=1 0"
		cset "name='BT_VX_DL Playback Switch',index=1 0"
		cset "name='PDM_DL Playback Switch',index=1 0"
		cset "name='Sidetone Mixer Capture',index=1 0"
		cset "name='Sidetone Mixer Playback',index=1 0"
		cset "name='Capture Mixer Tones',index=1 0"
		cset "name='Capture Mixer Voice Playback',index=1 0"
		cset "name='Capture Mixer Voice Capture',index=1 0"
		cset "name='Capture Mixer Media Playback',index=1 0"
		cset "name='Voice Capture Mixer Tones Playback',index=1 0"
		cset "name='Voice Capture Mixer Media Playback',index=1 0"
		cset "name='Voice Capture Mixer Capture',index=1 0"
		cset "name='DL2 Mixer Tones',index=1 0"
		cset "name='DL2 Mixer Voice',index=1 0"
		cset "name='DL2 Mixer Capture',index=1 0"
		cset "name='DL2 Mixer Multimedia',index=1 0"
		cset "name='DL1 Mixer Tones',index=1 0"
		cset "name='DL1 Mixer Voice',index=1 0"
		cset "name='DL1 Mixer Capture',index=1 0"
		cset "name='DL1 Mixer Multimedia',index=1 0"
		cset "name='MUX_VX1',index=1 0"
		cset "name='MUX_VX0',index=1 0"
		cset "name='MUX_UL11',index=1 0"
		cset "name='MUX_UL10',index=1 0"
		cset "name='MUX_UL07',index=1 0"
		cset "name='MUX_UL06',index=1 0"
		cset "name='MUX_UL05',index=1 0"
		cset "name='MUX_UL04',index=1 0"
		cset "name='MUX_UL03',index=1 0"
		cset "name='MUX_UL02',index=1 0"
		cset "name='MUX_UL01',index=1 0"
		cset "name='MUX_UL00',index=1 0"
		cset "name='TWL6040 Power Mode',index=1 0"
]

and my "hifi" file:

# Use case Configuration for TI SDP4430 HiFi Music

SectionVerb {
  	EnableSequence [
		cset "name='DL1 Media Playback Volume',index=1 90"
		cset "name-'DL2 Media Playback Volume',index=1 90"
	]

	DisableSequence [
		cset "name='DL1 Media Playback Volume',index=1 0"
		cset "name='DL2 Media Playback Volume',index=1 0"
	]

	# QoS and ALSA PCMs
	Value {
	      TQ HiFi
	      CapturePCM "hw:0"
	      PlaybackPCM "hw:0"
	}
}

SectionDevice."Headset".0 {
	Comment "SDP4430 3.5mm Headset"
	
	EnableSequence [
		cset "name='DL1 Mixer Multimedia',index=0 0"
		cset "name='Sidetone Mixer Playback',index=1 1"
		cset "name='HS Right Playback',index=1 0"
		cset "name='HS Left Playback',index=1 0"
		cset "name='MUX_UL11',index=1 9"
		cset "name='MUX_UL10',index=1 10"
	]

	DisableSequence [
		cset "name='DL1 Mixer Multimedia',index=1 0"
		cset "name='MUX_UL11',index=1 0"
		cset "name='MUX_UL10',index=1 0"
		cset "name='HS Right Playback',index=1 0"
		cset "name='HS Left Playback',index=1 0"
		cset "name='Sidetone Mixer Playback',index=1 0"
	]

	Value {
	      MasterPlaybackVolume "name='Headset Playback Volume' 1"
	      MasterCaptureVolume "name='Capture Volume' 1"
	}
}


On Thu, Nov 4, 2010 at 4:09 AM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> On Wed, 2010-11-03 at 14:38 -0600, abraham duenas wrote:
>> Hello,
>>
>> I recently cloned:
>> git clone git://git.alsa-project.org/alsa-lib.git alsa-lib
>> git clone git://git.alsa-project.org/alsa-utils.git alsa-utils
>> and switched to the "ucm" branch to give it try. I have a panda board
>> (pandaboard.org it is just a TI OMAP4 platform).
>>
>
> Ok, this is the correct repository.
>
>> I created some configuration files for my card. My conf file is
>> 'SDP4430.conf' and my verb is on 'hifi'.
>> I came with a simple program to set my verb and configure it for a
>> simple device. I'm calling this sequence:
>> 1. open it.... snd_use_case_mgr_open(&uc_mgr,"SDP4430")
>> 2. reset it ....snd_use_case_mgr_reset(uc_mgr)
>> 3. query for my verb.... snd_use_case_get_list(uc_mgr,"_verbs",&mylist)
>> 4. set my verb ... snd_use_case_set(uc_mgr,"_verb",*mylist)
>> 5. set my created device... snd_use_case_set(uc_mgr,"_enadev","Headset.0")
>> 6. close it... snd_use_case_mgr_close(uc_mgr)
>>
>> Seems to work ok (without any errors) but I can't see any of my amixer
>> controls set/changed accordingly to my verb/device.
>> Is this a right sequence to follow? may be my files are not well written?
>>
>
> This sequence looks correct. Can you share with us the relevant parts of
> your configuration files.
>
> Jaroslav did make some changes to the config file format so maybe we
> have a formatting problem here.
>
> Liam
>
> --
> Freelance Developer, SlimLogic Ltd
> ASoC and Voltage Regulator Maintainer.
> http://www.slimlogic.co.uk
>
>
