From: Sasza <warpme@o2.pl>
Subject: Re: 2.6.25-rc8: why #define SND_HDA_NEEDS_RESUMEis not
	set ?
Date: Fri, 25 Apr 2008 09:09:32 +0200
Message-ID: <fus03k$qjq$1@ger.gmane.org>
References: <loom.20080424T112202-229@post.gmane.org>	<s5htzhrb6id.wl%tiwai@suse.de>	<loom.20080424T165721-885@post.gmane.org>
	<s5hd4oe4f3d.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 156FD103834
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Apr 2008 09:10:15 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JpI4R-0000bi-8k
	for alsa-devel@alsa-project.org; Fri, 25 Apr 2008 07:10:11 +0000
Received: from ip-91.189.74.10.e-plan.pl ([91.189.74.10])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 25 Apr 2008 07:10:11 +0000
Received: from warpme by ip-91.189.74.10.e-plan.pl with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 25 Apr 2008 07:10:11 +0000
In-Reply-To: <s5hd4oe4f3d.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Thu, 24 Apr 2008 17:09:12 +0000 (UTC),
> warped wrote:
>> Takashi Iwai <tiwai <at> suse.de> writes:
>>
>>
>>> Hm?  It's just a define for #ifdefs.
>>> Your problem is likely irrelevant.
>>>
>>> thanks,
>>>
>>> Takashi
>>>
>>
>> Right,
>> I watch in wrong place :-(.
>> Anyway - is there any chance to fix my issue ?
>> I filled bug in Bugzilla month ago (10338) - no any results.
>> As this bug is blocking me with use of .25 kernel and .25 kernel 
>> is FIRST kernel offering me really 
>> stable s3 resume on SMP - I'm really upset as S3 & SMP 
>> are crucial for me
>> May You help me with this situation ?
> 
> Possibly some verbs aren't resumed after suspsend.
> Could you get /proc/asound/card0/codec#* files before and after
> resume and compare them?
> 
> Also, does this happen on both suspend and hibernate?
> 
> 
> Takashi

Takashi,

Thanx for trying help.
codec0 differs in so many places that I will attach both: after boot 
(with sound) and after resume (no sound). Pls use diff and see.
For files see below.
Regarding hibernate: my sys is diskless appliance so I can't use hibernate.

After boot:
---------------------------------
Codec: Realtek ALC888
Address: 0
Vendor Id: 0x10ec0888
Subsystem Id: 0x147ba601
Revision Id: 0x100001
No Modem Function Group found
Default PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=3, o=0, i=0, unsolicited=1, wake=0
   IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0
   IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0
   IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0
Node 0x02 [Audio Output] wcaps 0x11: Stereo
   Converter: stream=0, channel=0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Node 0x03 [Audio Output] wcaps 0x11: Stereo
   Converter: stream=0, channel=0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Node 0x04 [Audio Output] wcaps 0x11: Stereo
   Converter: stream=0, channel=0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Node 0x05 [Audio Output] wcaps 0x11: Stereo
   Converter: stream=0, channel=0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
   Converter: stream=0, channel=0
   Digital:
   Digital category: 0x0
   PCM:
     rates [0x5e0]: 44100 48000 88200 96000 192000
     bits [0x1e]: 16 20 24 32
     formats [0x1]: PCM
Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In
   Amp-In caps: ofs=0x0b, nsteps=0x1f, stepsize=0x05, mute=1
   Amp-In vals:  [0x00 0x00]
   Converter: stream=0, channel=0
   SDI-Select: 0
   PCM:
     rates [0x160]: 44100 48000 96000
     bits [0x6]: 16 20
     formats [0x1]: PCM
   Connection: 1
      0x23
Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In
   Amp-In caps: ofs=0x0b, nsteps=0x1f, stepsize=0x05, mute=1
   Amp-In vals:  [0x00 0x00]
   Converter: stream=0, channel=0
   SDI-Select: 0
   PCM:
     rates [0x160]: 44100 48000 96000
     bits [0x6]: 16 20
     formats [0x1]: PCM
   Connection: 1
      0x22
Node 0x0a [Audio Input] wcaps 0x100391: Stereo Digital
   Converter: stream=0, channel=0
   SDI-Select: 0
   Digital:
   Digital category: 0x0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0x1e]: 16 20 24 32
     formats [0x1]: PCM
   Unsolicited: tag=00, enabled=0
   Connection: 1
      0x1f
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
   Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
   Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 
0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
   Connection: 10
      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17
Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x00 0x00]
   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
   Amp-Out vals:  [0x19 0x19]
   Connection: 2
      0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x00 0x00]
   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
   Amp-Out vals:  [0x19 0x19]
   Connection: 2
      0x03 0x0b
Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x00 0x00]
   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
   Amp-Out vals:  [0x19 0x19]
   Connection: 2
      0x04 0x0b
Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x00 0x00]
   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
   Amp-Out vals:  [0x00 0x00]
   Connection: 2
      0x05 0x0b
Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x12 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x14 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x00 0x00]
   Pincap 0x083e: IN OUT HP Detect Trigger
   Pin Default 0x01014010: [Jack] Line Out at Ext Rear
     Conn = 1/8, Color = Green
     DefAssociation = 0x1, Sequence = 0x0
   Pin-ctls: 0x40: OUT
   Unsolicited: tag=00, enabled=0
   Connection: 5
      0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x15 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x00 0x00]
   Pincap 0x083e: IN OUT HP Detect Trigger
   Pin Default 0x01011012: [Jack] Line Out at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0x1, Sequence = 0x2
   Pin-ctls: 0x40: OUT
   Unsolicited: tag=00, enabled=0
   Connection: 5
      0x0c 0x0d* 0x0e 0x0f 0x26
Node 0x16 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x00 0x00]
   Pincap 0x0836: IN OUT Detect Trigger
   Pin Default 0x01016011: [Jack] Line Out at Ext Rear
     Conn = 1/8, Color = Orange
     DefAssociation = 0x1, Sequence = 0x1
   Pin-ctls: 0x40: OUT
   Unsolicited: tag=00, enabled=0
   Connection: 5
      0x0c 0x0d 0x0e* 0x0f 0x26
Node 0x17 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x00 0x00]
   Pincap 0x0836: IN OUT Detect Trigger
   Pin Default 0x01012014: [Jack] Line Out at Ext Rear
     Conn = 1/8, Color = Grey
     DefAssociation = 0x1, Sequence = 0x4
   Pin-ctls: 0x40: OUT
   Unsolicited: tag=00, enabled=0
   Connection: 5
      0x0c 0x0d 0x0e 0x0f* 0x26
Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x08373e: IN OUT HP Detect Trigger
     Vref caps: HIZ 50 GRD 80 100
   Pin Default 0x01a19830: [Jack] Mic at Ext Rear
     Conn = 1/8, Color = Pink
     DefAssociation = 0x3, Sequence = 0x0
   Pin-ctls: 0x24: IN VREF_80
   Unsolicited: tag=00, enabled=0
   Connection: 5
      0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x19 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x08373e: IN OUT HP Detect Trigger
     Vref caps: HIZ 50 GRD 80 100
   Pin Default 0x02a1983f: [Jack] Mic at Ext Front
     Conn = 1/8, Color = Pink
     DefAssociation = 0x3, Sequence = 0xf
   Pin-ctls: 0x24: IN VREF_80
   Unsolicited: tag=00, enabled=0
   Connection: 5
      0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x08373e: IN OUT HP Detect Trigger
     Vref caps: HIZ 50 GRD 80 100
   Pin Default 0x01813031: [Jack] Line In at Ext Rear
     Conn = 1/8, Color = Blue
     DefAssociation = 0x3, Sequence = 0x1
   Pin-ctls: 0x20: IN VREF_HIZ
   Unsolicited: tag=00, enabled=0
   Connection: 5
      0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x00 0x00]
   Pincap 0x08373e: IN OUT HP Detect Trigger
     Vref caps: HIZ 50 GRD 80 100
   Pin Default 0x02214c1f: [Jack] HP Out at Ext Front
     Conn = 1/8, Color = Green
     DefAssociation = 0x1, Sequence = 0xf
   Pin-ctls: 0xc0: OUT HP VREF_HIZ
   Unsolicited: tag=04, enabled=1
   Connection: 5
      0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
   Pincap 0x0820: IN
   Pin Default 0x99330132: [Fixed] CD at Int ATAPI
     Conn = ATAPI, Color = Unknown
     DefAssociation = 0x3, Sequence = 0x2
     Misc = NO_PRESENCE
   Pin-ctls: 0x20: IN
Node 0x1d [Pin Complex] wcaps 0x400000: Mono
   Pincap 0x0820: IN
   Pin Default 0x99830133: [Fixed] Line In at Int ATAPI
     Conn = ATAPI, Color = Unknown
     DefAssociation = 0x3, Sequence = 0x3
     Misc = NO_PRESENCE
   Pin-ctls: 0x20: IN
Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
   Pincap 0x0810: OUT
   Pin Default 0x01451120: [Jack] SPDIF Out at Ext Rear
     Conn = Optical, Color = Black
     DefAssociation = 0x2, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x40: OUT
   Connection: 1
      0x06
Node 0x1f [Pin Complex] wcaps 0x400200: Mono Digital
   Pincap 0x0820: IN
   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x20: IN
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
   Processing caps: benign=0, ncoeff=17
Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x22 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x80 0x80] [0x00 
0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 
0x80]
   Connection: 11
      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x80 0x80] [0x00 
0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 
0x80]
   Connection: 11
      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x24 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x25 [Audio Output] wcaps 0x11: Stereo
   Converter: stream=0, channel=0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Node 0x26 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x00 0x00]
   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
   Amp-Out vals:  [0x00 0x00]
   Connection: 2
      0x25 0x0b
root@FrontEnd3:/proc/asound/card0 #
------------------------------------------------------



After resume:
------------------------------------------------------
Codec: Realtek ALC888
Address: 0
Vendor Id: 0x10ec0888
Subsystem Id: 0x147ba601
Revision Id: 0x100001
No Modem Function Group found
Default PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=3, o=0, i=0, unsolicited=1, wake=0
   IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0
   IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0
   IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0
Node 0x02 [Audio Output] wcaps 0x11: Stereo
   Converter: stream=0, channel=0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Node 0x03 [Audio Output] wcaps 0x11: Stereo
   Converter: stream=0, channel=0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Node 0x04 [Audio Output] wcaps 0x11: Stereo
   Converter: stream=0, channel=0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Node 0x05 [Audio Output] wcaps 0x11: Stereo
   Converter: stream=0, channel=0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
   Converter: stream=0, channel=0
   Digital:
   Digital category: 0x0
   PCM:
     rates [0x5e0]: 44100 48000 88200 96000 192000
     bits [0x1e]: 16 20 24 32
     formats [0x1]: PCM
Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In
   Amp-In caps: ofs=0x0b, nsteps=0x1f, stepsize=0x05, mute=1
   Amp-In vals:  [0x00 0x00]
   Converter: stream=0, channel=0
   SDI-Select: 0
   PCM:
     rates [0x160]: 44100 48000 96000
     bits [0x6]: 16 20
     formats [0x1]: PCM
   Connection: 1
      0x23
Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In
   Amp-In caps: ofs=0x0b, nsteps=0x1f, stepsize=0x05, mute=1
   Amp-In vals:  [0x00 0x00]
   Converter: stream=0, channel=0
   SDI-Select: 0
   PCM:
     rates [0x160]: 44100 48000 96000
     bits [0x6]: 16 20
     formats [0x1]: PCM
   Connection: 1
      0x22
Node 0x0a [Audio Input] wcaps 0x100391: Stereo Digital
   Converter: stream=0, channel=0
   SDI-Select: 0
   Digital:
   Digital category: 0x0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0x1e]: 16 20 24 32
     formats [0x1]: PCM
   Unsolicited: tag=00, enabled=0
   Connection: 1
      0x1f
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
   Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
   Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 
0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
   Connection: 10
      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17
Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x00 0x00]
   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
   Amp-Out vals:  [0x19 0x19]
   Connection: 2
      0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x00 0x00]
   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
   Amp-Out vals:  [0x19 0x19]
   Connection: 2
      0x03 0x0b
Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x00 0x00]
   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
   Amp-Out vals:  [0x19 0x19]
   Connection: 2
      0x04 0x0b
Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x00 0x00]
   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
   Amp-Out vals:  [0x00 0x00]
   Connection: 2
      0x05 0x0b
Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x12 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x14 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x00 0x00]
   Pincap 0x083e: IN OUT HP Detect Trigger
   Pin Default 0x01014010: [Jack] Line Out at Ext Rear
     Conn = 1/8, Color = Green
     DefAssociation = 0x1, Sequence = 0x0
   Pin-ctls: 0x20: IN
   Unsolicited: tag=00, enabled=0
   Connection: 5
      0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x15 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x083e: IN OUT HP Detect Trigger
   Pin Default 0x01011012: [Jack] Line Out at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0x1, Sequence = 0x2
   Pin-ctls: 0x20: IN
   Unsolicited: tag=00, enabled=0
   Connection: 5
      0x0c 0x0d* 0x0e 0x0f 0x26
Node 0x16 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x0836: IN OUT Detect Trigger
   Pin Default 0x01016011: [Jack] Line Out at Ext Rear
     Conn = 1/8, Color = Orange
     DefAssociation = 0x1, Sequence = 0x1
   Pin-ctls: 0x20: IN
   Unsolicited: tag=00, enabled=0
   Connection: 5
      0x0c 0x0d 0x0e* 0x0f 0x26
Node 0x17 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x0836: IN OUT Detect Trigger
   Pin Default 0x01012014: [Jack] Line Out at Ext Rear
     Conn = 1/8, Color = Grey
     DefAssociation = 0x1, Sequence = 0x4
   Pin-ctls: 0x20: IN
   Unsolicited: tag=00, enabled=0
   Connection: 5
      0x0c 0x0d 0x0e 0x0f* 0x26
Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x08373e: IN OUT HP Detect Trigger
     Vref caps: HIZ 50 GRD 80 100
   Pin Default 0x01a19830: [Jack] Mic at Ext Rear
     Conn = 1/8, Color = Pink
     DefAssociation = 0x3, Sequence = 0x0
   Pin-ctls: 0x21: IN VREF_50
   Unsolicited: tag=00, enabled=0
   Connection: 5
      0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x19 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x08373e: IN OUT HP Detect Trigger
     Vref caps: HIZ 50 GRD 80 100
   Pin Default 0x02a1983f: [Jack] Mic at Ext Front
     Conn = 1/8, Color = Pink
     DefAssociation = 0x3, Sequence = 0xf
   Pin-ctls: 0x20: IN VREF_HIZ
   Unsolicited: tag=00, enabled=0
   Connection: 5
      0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x08373e: IN OUT HP Detect Trigger
     Vref caps: HIZ 50 GRD 80 100
   Pin Default 0x01813031: [Jack] Line In at Ext Rear
     Conn = 1/8, Color = Blue
     DefAssociation = 0x3, Sequence = 0x1
   Pin-ctls: 0x20: IN VREF_HIZ
   Unsolicited: tag=00, enabled=0
   Connection: 5
      0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x00 0x00]
   Pincap 0x08373e: IN OUT HP Detect Trigger
     Vref caps: HIZ 50 GRD 80 100
   Pin Default 0x02214c1f: [Jack] HP Out at Ext Front
     Conn = 1/8, Color = Green
     DefAssociation = 0x1, Sequence = 0xf
   Pin-ctls: 0x20: IN VREF_HIZ
   Unsolicited: tag=00, enabled=0
   Connection: 5
      0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
   Pincap 0x0820: IN
   Pin Default 0x99330132: [Fixed] CD at Int ATAPI
     Conn = ATAPI, Color = Unknown
     DefAssociation = 0x3, Sequence = 0x2
     Misc = NO_PRESENCE
   Pin-ctls: 0x20: IN
Node 0x1d [Pin Complex] wcaps 0x400000: Mono
   Pincap 0x0820: IN
   Pin Default 0x99830133: [Fixed] Line In at Int ATAPI
     Conn = ATAPI, Color = Unknown
     DefAssociation = 0x3, Sequence = 0x3
     Misc = NO_PRESENCE
   Pin-ctls: 0x20: IN
Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
   Pincap 0x0810: OUT
   Pin Default 0x01451120: [Jack] SPDIF Out at Ext Rear
     Conn = Optical, Color = Black
     DefAssociation = 0x2, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x40: OUT
   Connection: 1
      0x06
Node 0x1f [Pin Complex] wcaps 0x400200: Mono Digital
   Pincap 0x0820: IN
   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x20: IN
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
   Processing caps: benign=0, ncoeff=17
Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x22 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x80 0x80] [0x00 
0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 
0x80]
   Connection: 11
      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x80 0x80] [0x00 
0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 
0x80]
   Connection: 11
      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x24 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x25 [Audio Output] wcaps 0x11: Stereo
   Converter: stream=0, channel=0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Node 0x26 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x00 0x00]
   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
   Amp-Out vals:  [0x00 0x00]
   Connection: 2
      0x25 0x0b
root@FrontEnd3:/proc/asound/card0 #
---------------------------------------------------------------
