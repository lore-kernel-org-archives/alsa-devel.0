From: "Adriano Grassi" <califalcon@gmail.com>
Subject: Re: This is a nudge. This is only a nudge. In the
	event of actual emergency...
Date: Thu, 30 Aug 2007 13:29:05 -0400
Message-ID: <5cd1dd0708301029m38f6347fk2f124fdeccd19042@mail.gmail.com>
References: <20070829215435.52C8F3C08D8@snark.thyrsus.com>
	<46D673FB.3040806@gmail.com>
	<Pine.LNX.4.61.0708301017140.10136@tm8103.perex-int.cz>
	<20070830153850.GA21434@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 5545A24348
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Aug 2007 19:29:08 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id f40so429933fka
	for <alsa-devel@alsa-project.org>; Thu, 30 Aug 2007 10:29:07 -0700 (PDT)
In-Reply-To: <20070830153850.GA21434@thyrsus.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: perex@suse.cz
Cc: esr@thyrsus.com, alsa-devel@alsa-project.org, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

Is this new release going to include support for Acer 9810 hda-intel Realtek
ALC883 HiDefinition Audio?


*** here is the output from my system, sound only works thru the spdif
headphone jack not the speakers.

Also see
http://www.linuxquestions.org/questions/showthread.php?t=565080&highlight=9810for
a post i made and nobody could answer it.

Thanks for your help and time.
Regards.

Califalcon

  Here is the output of lspci -s 0:1b -vn
00:1b.0 0403: 8086:27d8 (rev 02)
Subsystem: 1025:006c
Flags: bus master, fast devsel, latency 0, IRQ 23
Memory at d2300000 (64-bit, non-prefetchable) [size=16K]
Capabilities: [50] Power Management version 2
Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0
Enable-
Capabilities: [70] Express Unknown type IRQ 0


And output of cat /proc/asound/card0/codec* | head
Codec: Realtek ALC883
Address: 0
Vendor Id: 0x10ec0883
Subsystem Id: 0x1025162d
Revision Id: 0x100002
Default PCM: rates 0x560, bits 0x0e, types 0x1
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
Node 0x02 [Audio Output] wcaps 0x11: Stereo
PCM: rates 0x560, bits 0x0e, types 0x1



Full card0/codec#0
Codec: Realtek ALC883
Address: 0
Vendor Id: 0x10ec0883
Subsystem Id: 0x1025162d
Revision Id: 0x100002
Default PCM: rates 0x560, bits 0x0e, types 0x1
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
Node 0x02 [Audio Output] wcaps 0x11: Stereo
PCM: rates 0x560, bits 0x0e, types 0x1
Node 0x03 [Audio Output] wcaps 0x11: Stereo
PCM: rates 0x560, bits 0x0e, types 0x1
Node 0x04 [Audio Output] wcaps 0x11: Stereo
PCM: rates 0x560, bits 0x0e, types 0x1
Node 0x05 [Audio Output] wcaps 0x11: Stereo
PCM: rates 0x560, bits 0x0e, types 0x1
Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
PCM: rates 0x560, bits 0x1e, types 0x1
Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In
Amp-In caps: ofs=0x08, nsteps=0x1f, stepsize=0x05, mute=1
Amp-In vals: [0x98 0x98]
PCM: rates 0x160, bits 0x06, types 0x1
Connection: 1
0x23
Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In
Amp-In caps: ofs=0x08, nsteps=0x1f, stepsize=0x05, mute=1
Amp-In vals: [0x18 0x18]
PCM: rates 0x160, bits 0x06, types 0x1
Connection: 1
0x22
Node 0x0a [Audio Input] wcaps 0x100391: Stereo Digital
PCM: rates 0x560, bits 0x1e, types 0x1
Connection: 1
0x1f
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
Amp-In vals: [0x98 0x98] [0x90 0x90] [0x1f 0x1f] [0x00 0x00] [0x1f 0x1f]
[0x1f 0x1f] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
Connection: 10
0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17
Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Amp-In vals: [0x00 0x00] [0x00 0x00]
Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
Amp-Out vals: [0x1f 0x1f]
Connection: 2
0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Amp-In vals: [0x00 0x00] [0x00 0x00]
Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
Amp-Out vals: [0x18 0x18]
Connection: 2
0x03 0x0b
Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Amp-In vals: [0x00 0x00] [0x00 0x00]
Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
Amp-Out vals: [0x18 0x18]
Connection: 2
0x04 0x0b
Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Amp-In vals: [0x00 0x00] [0x00 0x00]
Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
Amp-Out vals: [0x18 0x18]
Connection: 2
0x05 0x0b
Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x12 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x14 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
Amp-In vals: [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Amp-Out vals: [0x00 0x00]
Pincap 0x083e: IN OUT HP Detect
Pin Default 0x01214110: [Jack] HP Out at Ext Rear
Conn = 1/8, Color = Green
Pin-ctls: 0x40: OUT
Connection: 5
0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x15 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
Amp-In vals: [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Amp-Out vals: [0x00 0x00]
Pincap 0x083e: IN OUT HP Detect
Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
Conn = 1/8, Color = Black
Pin-ctls: 0x40: OUT
Connection: 5
0x0c 0x0d* 0x0e 0x0f 0x26
Node 0x16 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
Amp-In vals: [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Amp-Out vals: [0x00 0x00]
Pincap 0x083e: IN OUT HP Detect
Pin Default 0x99130120: [Fixed] Speaker at Int ATAPI
Conn = ATAPI, Color = Unknown
Pin-ctls: 0x40: OUT
Connection: 5
0x0c 0x0d 0x0e* 0x0f 0x26
Node 0x17 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
Amp-In vals: [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Amp-Out vals: [0x00 0x00]
Pincap 0x083e: IN OUT HP Detect
Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
Conn = 1/8, Color = Black
Pin-ctls: 0x40: OUT
Connection: 5
0x0c 0x0d 0x0e 0x0f* 0x26
Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
Amp-In vals: [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Amp-Out vals: [0x80 0x80]
Pincap 0x08173e: IN OUT HP Detect
Pin Default 0x01a19940: [Jack] Mic at Ext Rear
Conn = 1/8, Color = Pink
Pin-ctls: 0x24: IN
Connection: 5
0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x19 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
Amp-In vals: [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Amp-Out vals: [0x80 0x80]
Pincap 0x08173e: IN OUT HP Detect
Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
Conn = 1/8, Color = Black
Pin-ctls: 0x24: IN
Connection: 5
0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
Amp-In vals: [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Amp-Out vals: [0x80 0x80]
Pincap 0x08173e: IN OUT HP Detect
Pin Default 0x0181314f: [Jack] Line In at Ext Rear
Conn = 1/8, Color = Blue
Pin-ctls: 0x20: IN
Connection: 5
0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
Amp-In vals: [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Amp-Out vals: [0x00 0x00]
Pincap 0x08173e: IN OUT HP Detect
Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
Conn = 1/8, Color = Black
Pin-ctls: 0xc0: OUT HP
Connection: 5
0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
Pincap 0x0820: IN
Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
Conn = 1/8, Color = Black
Pin-ctls: 0x00:
Node 0x1d [Pin Complex] wcaps 0x400000: Mono
Pincap 0x0820: IN
Pin Default 0x4016162d: [N/A] Speaker at Ext N/A
Conn = Digital, Color = Black
Pin-ctls: 0x00:
Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
Pincap 0x0810: OUT
Pin Default 0x01454130: [Jack] SPDIF Out at Ext Rear
Conn = Optical, Color = Green
Pin-ctls: 0x00:
Connection: 1
0x06
Node 0x1f [Pin Complex] wcaps 0x400200: Mono Digital
Pincap 0x0820: IN
Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
Conn = 1/8, Color = Black
Pin-ctls: 0x00:
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x22 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Amp-In vals: [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x80 0x80] [0x00 0x00]
[0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
Amp-Out caps: N/A
Amp-Out vals: [0x00 0x00]
Connection: 11
0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x23 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Amp-In vals: [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x80 0x80] [0x00 0x00]
[0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
Amp-Out caps: N/A
Amp-Out vals: [0x00 0x00]
Connection: 11
0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x24 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x25 [Audio Output] wcaps 0x11: Stereo
PCM: rates 0x560, bits 0x0e, types 0x1
Node 0x26 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Amp-In vals: [0x00 0x00] [0x80 0x80]
Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
Amp-Out vals: [0x00 0x00]
Connection: 2
0x25 0x0b



Full Card0/Codec#1 -- dunno if this matter
Codec: Generic 14f1 ID 2bfa
Address: 1
Vendor Id: 0x14f12bfa
Subsystem Id: 0x1025006c
Revision Id: 0x90000


I also have all these directories under /proc/asound/card0/
codec#0 codec#1 id oss_mixer pcm0c/ pcm0p/ pcm1c/


pcm0c/info
card: 0
device: 0
subdevice: 0
stream: CAPTURE
id: ALC883 Analog
name: ALC883 Analog
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 2
subdevices_avail: 2


/pcm0p/info
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: ALC883 Analog
name: ALC883 Analog
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

/pcm1c/info
card: 0
device: 1
subdevice: 0
stream: CAPTURE
id: ALC883 Analog
name: ALC883 Analog
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 2
subdevices_avail: 2


On 8/30/07, Eric S. Raymond <esr@thyrsus.com> wrote:
>
> Jaroslav Kysela <perex@suse.cz>:
> > Yes, I see this demand. I'll release 1.0.15rc1 today and I'm going to
> have
> > only few rc versions for 1.0.15 to have final 1.0.15 package in two
> weeks.
>
> Thanks for the cooperation.  I'll post notices of the upcoming release
> in a couple of appropriate fora, including ThinkWiki and the Ubuntu
> forum thread on the X61.
>
> Note for anybody who was worried, like me, that Lenovo might start
> cutting engineering corners on the ThinkPads and wreck the brand: it
> doesn't appear to be happening.  My brand spankin' new X61 seems to be
> just as well constructed as the IBM ThinkPads were.
>
> Now I need to go through the same dance with Intel about its wireless
> drivers...
> --
>                 <a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>



-- 
Thank you for your time.

Best regards,
