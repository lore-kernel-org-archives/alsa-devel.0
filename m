From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: ALSA UCM
Date: Thu, 04 Nov 2010 17:09:58 +0000
Message-ID: <1288890598.3277.81.camel@odin>
References: <AANLkTimFdKg=_KDv8fbSJry6XTEsZqyQz7GhzaPxXDYP@mail.gmail.com>
	<1288865349.3277.14.camel@odin>
	<AANLkTim1Aopc2ALEXoWorPjzua0gGoSef8CpH+At4_cp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DCE642433B
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 18:10:06 +0100 (CET)
Received: by wwi17 with SMTP id 17so172234wwi.20
	for <alsa-devel@alsa-project.org>; Thu, 04 Nov 2010 10:10:02 -0700 (PDT)
In-Reply-To: <AANLkTim1Aopc2ALEXoWorPjzua0gGoSef8CpH+At4_cp@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: abraham duenas <aduejazz@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-11-04 at 06:57 -0600, abraham duenas wrote:
> Sure,
> I put the following files under /usr/shara/alsa/ucm/SDP4430/ :
> - SDP4430.conf
> - hifi
> 

Btw, please don't top post here.

[snip]

> and my "hifi" file:
> 
> # Use case Configuration for TI SDP4430 HiFi Music
> 
> SectionVerb {
>   	EnableSequence [
> 		cset "name='DL1 Media Playback Volume',index=1 90"
> 		cset "name-'DL2 Media Playback Volume',index=1 90"
> 	]
> 
> 	DisableSequence [
> 		cset "name='DL1 Media Playback Volume',index=1 0"
> 		cset "name='DL2 Media Playback Volume',index=1 0"
> 	]
> 
> 	# QoS and ALSA PCMs
> 	Value {
> 	      TQ HiFi
> 	      CapturePCM "hw:0"
> 	      PlaybackPCM "hw:0"
> 	}
> }
> 
> SectionDevice."Headset".0 {
> 	Comment "SDP4430 3.5mm Headset"
> 	
> 	EnableSequence [
> 		cset "name='DL1 Mixer Multimedia',index=0 0"
> 		cset "name='Sidetone Mixer Playback',index=1 1"
> 		cset "name='HS Right Playback',index=1 0"
> 		cset "name='HS Left Playback',index=1 0"
> 		cset "name='MUX_UL11',index=1 9"
> 		cset "name='MUX_UL10',index=1 10"
> 	]
> 
> 	DisableSequence [
> 		cset "name='DL1 Mixer Multimedia',index=1 0"
> 		cset "name='MUX_UL11',index=1 0"
> 		cset "name='MUX_UL10',index=1 0"
> 		cset "name='HS Right Playback',index=1 0"
> 		cset "name='HS Left Playback',index=1 0"
> 		cset "name='Sidetone Mixer Playback',index=1 0"
> 	]
> 
> 	Value {
> 	      MasterPlaybackVolume "name='Headset Playback Volume' 1"
> 	      MasterCaptureVolume "name='Capture Volume' 1"
> 	}
> }
> 

This all looks fine to me.

> 
> On Thu, Nov 4, 2010 at 4:09 AM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> > On Wed, 2010-11-03 at 14:38 -0600, abraham duenas wrote:

> >
> >> I created some configuration files for my card. My conf file is
> >> 'SDP4430.conf' and my verb is on 'hifi'.
> >> I came with a simple program to set my verb and configure it for a
> >> simple device. I'm calling this sequence:
> >> 1. open it.... snd_use_case_mgr_open(&uc_mgr,"SDP4430")
> >> 2. reset it ....snd_use_case_mgr_reset(uc_mgr)
> >> 3. query for my verb.... snd_use_case_get_list(uc_mgr,"_verbs",&mylist)
> >> 4. set my verb ... snd_use_case_set(uc_mgr,"_verb",*mylist)
> >> 5. set my created device... snd_use_case_set(uc_mgr,"_enadev","Headset.0")
> >> 6. close it... snd_use_case_mgr_close(uc_mgr)
> >>
> >> Seems to work ok (without any errors) but I can't see any of my amixer
> >> controls set/changed accordingly to my verb/device.
> >> Is this a right sequence to follow? may be my files are not well written?
> >>
> >
> > This sequence looks correct. Can you share with us the relevant parts of
> > your configuration files.
> >
> > Jaroslav did make some changes to the config file format so maybe we
> > have a formatting problem here.
> >

Jaroslav, any ideas ?

Abraham, can you put some debug in here to see if we are changing the
kcontrols or not.

Thanks

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
