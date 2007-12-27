From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: intel-hd on an intel G33 motherboard
Date: Wed, 26 Dec 2007 16:47:27 -0800
Message-ID: <1198716447.3732.193.camel@razman.gruemaster.com>
References: <BAY109-W10EC413FC1F19625739A28A95B0@phx.gbl>
	<1198697428.3732.176.camel@razman.gruemaster.com>
	<BAY109-W373CBC57EE1663E94F98D8A9540@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id BF66E2435C
	for <alsa-devel@alsa-project.org>; Thu, 27 Dec 2007 01:47:31 +0100 (CET)
In-Reply-To: <BAY109-W373CBC57EE1663E94F98D8A9540@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: De Fuuss <fuuss@hotmail.com>
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Ok, the second codec is the HDMI port.  For some reason, it is getting
assigned to be primary sound device.  Try "alsamixer -D hw:1.0" to see
if it can control the realtek device.

Oddly enough, I used to work at Intel as a contractor, developing audio
drivers for their boards.  They stopped supporting Linux when my
contract ended.

I'll see what I can do over the next couple of weeks.

Tobin

On Thu, 2007-12-27 at 00:33 +0000, De Fuuss wrote:

> Hi Tobin,
> 
> Thanks for you quick reply.
> 
> I tried both 3stack-6ch and 3stack-6ch-dig (the card has a spdif out). I found out that when putting on headphones on a separate headphone jack I get some sound with both settings. Hoever, the front out l/r, center/bass sourround back l/r and side sourround l/r port remain silent.
> 
> I set all channels to 80-100% in alsamixer.
> 
> A few more details from my  setup:
> Shuttle XPC SG33G5M
> Intel G33 Express + ICH9DH
> 
> Interestingly, when I run alsamixer, it identifies the Chip as "Generic 1095 ID 1392", in other words in points to codec#1. I thought it should point to codec#0, e.g. RealTek ALC888
> 
> I have the strong impression that the channels are not truly set by alsamixer as they point to the wrong codec. I'm only a layman in ALSA, and I have no idea how to tell alsamixer to consider codec#0 instead codec#1.
> 
> Do you have any idea on how to crack this nut?
> 
> Below is the output of both codecs:
> 
> Thank you.
> 
> Best regards,
> 
> Patrick
> 
> ____________________
> #cat /proc/asound/cards
> 
> 0 [Intel          ]: HDA-Intel - HDA Intel
> HDA Intel at 0xfdff8000 irq 22
> 
> # cat /proc/asound/Intel/codec#0
> Codec: Realtek ALC888
> Address: 0
> Vendor Id: 0x10ec0888
> Subsystem Id: 0x12970888
> Revision Id: 0x100001
> No Modem Function Group found
> Default PCM:
>     rates [0x560]: 44100 48000 96000 192000
>     bits [0xe]: 16 20 24
>     formats [0x1]: PCM
> Default Amp-In caps: N/A
> Default Amp-Out caps: N/A
> Node 0x02 [Audio Output] wcaps 0x11: Stereo
>   PCM:
>     rates [0x560]: 44100 48000 96000 192000
>     bits [0xe]: 16 20 24
>     formats [0x1]: PCM
> Node 0x03 [Audio Output] wcaps 0x11: Stereo
>   PCM:
>     rates [0x560]: 44100 48000 96000 192000
>     bits [0xe]: 16 20 24
>     formats [0x1]: PCM
> Node 0x04 [Audio Output] wcaps 0x11: Stereo
>   PCM:
>     rates [0x560]: 44100 48000 96000 192000
>     bits [0xe]: 16 20 24
>     formats [0x1]: PCM
> Node 0x05 [Audio Output] wcaps 0x11: Stereo
>   PCM:
>     rates [0x560]: 44100 48000 96000 192000
>     bits [0xe]: 16 20 24
>     formats [0x1]: PCM
> Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
>   PCM:
>     rates [0x5e0]: 44100 48000 88200 96000 192000
>     bits [0x1e]: 16 20 24 32
>     formats [0x1]: PCM
> Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In
>   Amp-In caps: ofs=0x0b, nsteps=0x1f, stepsize=0x05, mute=1
>   Amp-In vals:  [0x9f 0x9f]
>   PCM:
>     rates [0x160]: 44100 48000 96000
>     bits [0x6]: 16 20
>     formats [0x1]: PCM
>   Connection: 1
>      0x23
> Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In
>   Amp-In caps: ofs=0x0b, nsteps=0x1f, stepsize=0x05, mute=1
>   Amp-In vals:  [0x9f 0x9f]
>   PCM:
>     rates [0x160]: 44100 48000 96000
>     bits [0x6]: 16 20
>     formats [0x1]: PCM
>   Connection: 1
>      0x22
> Node 0x0a [Audio Input] wcaps 0x100391: Stereo Digital
>   PCM:
>     rates [0x560]: 44100 48000 96000 192000
>     bits [0x1e]: 16 20 24 32
>     formats [0x1]: PCM
>   Connection: 1
>      0x1f
> Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>   Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
>   Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x9d 0x9d] [0x80 0x80] [0x9f 0x9f] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
>   Connection: 10
>      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17
> Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
>   Amp-Out vals:  [0x1d 0x1d]
>   Connection: 2
>      0x02 0x0b
> Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
>   Amp-Out vals:  [0x1f 0x1f]
>   Connection: 2
>      0x03 0x0b
> Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
>   Amp-Out vals:  [0x1f 0x1f]
>   Connection: 2
>      0x04 0x0b
> Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x80 0x80] [0x80 0x80]
>   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
>   Amp-Out vals:  [0x00 0x00]
>   Connection: 2
>      0x05 0x0b
> Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x12 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x14 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Pincap 0x083e: IN OUT HP Detect
>   Pin Default 0x01014010: [Jack] Line Out at Ext Rear
>     Conn = 1/8, Color = Green
>   Pin-ctls: 0x40: OUT
>   Connection: 5
>      0x0c* 0x0d 0x0e 0x0f 0x26
> Node 0x15 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Pincap 0x083e: IN OUT HP Detect
>   Pin Default 0x01011012: [Jack] Line Out at Ext Rear
>     Conn = 1/8, Color = Black
>   Pin-ctls: 0x40: OUT
>   Connection: 5
>      0x0c 0x0d* 0x0e 0x0f 0x26
> Node 0x16 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Pincap 0x0836: IN OUT Detect
>   Pin Default 0x01016011: [Jack] Line Out at Ext Rear
>     Conn = 1/8, Color = Orange
>   Pin-ctls: 0x40: OUT
>   Connection: 5
>      0x0c 0x0d 0x0e* 0x0f 0x26
> Node 0x17 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Pincap 0x0836: IN OUT Detect
>   Pin Default 0x01012014: [Jack] Line Out at Ext Rear
>     Conn = 1/8, Color = Grey
>   Pin-ctls: 0x40: OUT
>   Connection: 5
>      0x0c 0x0d 0x0e 0x0f* 0x26
> Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Pincap 0x08373e: IN OUT HP Detect
>   Pin Default 0x01813040: [Jack] Line In at Ext Rear
>     Conn = 1/8, Color = Blue
>   Pin-ctls: 0x40: OUT
>   Connection: 5
>      0x0c 0x0d 0x0e* 0x0f 0x26
> Node 0x19 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x80 0x80]
>   Pincap 0x08373e: IN OUT HP Detect
>   Pin Default 0x02a19850: [Jack] Mic at Ext Front
>     Conn = 1/8, Color = Pink
>   Pin-ctls: 0x24: IN
>   Connection: 5
>      0x0c* 0x0d 0x0e 0x0f 0x26
> Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Pincap 0x08373e: IN OUT HP Detect
>   Pin Default 0x9993014f: [Fixed] Aux at Int ATAPI
>     Conn = ATAPI, Color = Unknown
>   Pin-ctls: 0x40: OUT
>   Connection: 5
>      0x0c 0x0d* 0x0e 0x0f 0x26
> Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Pincap 0x08373e: IN OUT HP Detect
>   Pin Default 0x02214020: [Jack] HP Out at Ext Front
>     Conn = 1/8, Color = Green
>   Pin-ctls: 0xc0: OUT HP
>   Connection: 5
>      0x0c* 0x0d 0x0e 0x0f 0x26
> Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
>   Pincap 0x0820: IN
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>   Pin-ctls: 0x20: IN
> Node 0x1d [Pin Complex] wcaps 0x400000: Mono
>   Pincap 0x0820: IN
>   Pin Default 0x4005a603: [N/A] Line Out at Ext N/A
>     Conn = Optical, Color = UNKNOWN
>   Pin-ctls: 0x20: IN
> Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
>   Pincap 0x0810: OUT
>   Pin Default 0x01451130: [Jack] SPDIF Out at Ext Rear
>     Conn = Optical, Color = Black
>   Pin-ctls: 0x40: OUT
>   Connection: 1
>      0x06
> Node 0x1f [Pin Complex] wcaps 0x400200: Mono Digital
>   Pincap 0x0820: IN
>   Pin Default 0x01c59160: [Jack] SPDIF In at Ext Rear
>     Conn = Optical, Color = Pink
>   Pin-ctls: 0x20: IN
> Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
> Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x22 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x80 0x80] [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
>   Connection: 11
>      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
> Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x80 0x80] [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
>   Connection: 11
>      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
> Node 0x24 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x25 [Audio Output] wcaps 0x11: Stereo
>   PCM:
>     rates [0x560]: 44100 48000 96000 192000
>     bits [0xe]: 16 20 24
>     formats [0x1]: PCM
> Node 0x26 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x80 0x80]
>   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
>   Amp-Out vals:  [0x00 0x00]
>   Connection: 2
>      0x25 0x0b
> 
> A second codec sits at /proc/asound/Intel/codec#0. A cat results in:
> 
> Codec: Generic 1095 ID 1392
> Address: 1
> Vendor Id: 0x10951392
> Subsystem Id: 0xffffffff
> Revision Id: 0x100000
> No Modem Function Group found
> Default PCM:
>     rates [0x0]:
>     bits [0x0]:
>     formats [0x0]:
> Default Amp-In caps: N/A
> Default Amp-Out caps: N/A
> Node 0x02 [Audio Output] wcaps 0x6211: Stereo Digital
>   PCM:
>     rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
>     bits [0x1e]: 16 20 24 32
>     formats [0x5]: PCM AC3
> Node 0x03 [Pin Complex] wcaps 0x40738d: Stereo Digital Amp-Out
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x80 0x80]
>   Pincap 0x0894: OUT Detect
>   Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
>     Conn = Digital, Color = Unknown
>   Pin-ctls: 0x00:
>   Connection: 1
>      0x02
> 
> 
> > From: tdavis@dsl-only.net
> > To: fuuss@hotmail.com
> > Date: Wed, 26 Dec 2007 11:30:28 -0800
> > CC: alsa-devel@alsa-project.org
> > Subject: Re: [alsa-devel] intel-hd on an intel G33 motherboard
> >
> > Try "model=3stack-6ch". Also, if you look in the
> > alsa-driver-1.0.15/alsa-kernel/Documentation/Alsa-Configuration.txt
> > file, there are other models you can select for the alc883/888 codec.
> >
> > Let me know if this works and I'll add your system to the driver.
> >
> > Tobin
> >
> > On Wed, 2007-12-26 at 18:42 +0000, De Fuuss wrote:
> >
> >> Hi,
> >>
> >> Maybe I'm missing something, but I've failed to get even the slightest
> >> noise out of the onboard sound card from a Intel G33 motherboard. I
> >> tried the alsa drivers from the alsa-driver-1.0.15 package as well as
> >> the the alsa drivers provided by kernel 2.6.23 (built as modules), to
> >> no avail.
> >>
> >> The sound chip is identified as a Intel HDA / Realtek ALC888 on the Intel G33 ICH9 motherboard.
> >>
> >> After reading some of the documentation from the ALSA site and googling through half the internet I haven't found out yet if this specific sound card is supported by ALSA and if some module options must be passed (such as options snd-intel-hda model=.....).
> >>
> >> Could somebody be so kind as to point me into the right direction?
> >>
> >> Thank you.
> >>
> >> Best regards,
> >>
> >> Patrick
> >>
> >> _________________________________________________________________
> >> Express yourself instantly with MSN Messenger! Download today it's FREE!
> >> http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
> >> _______________________________________________
> >> Alsa-devel mailing list
> >> Alsa-devel@alsa-project.org
> >> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
> > --
> > Tobin Davis
> >
> >
> > TONY RANDALL! Is YOUR life a PATIO of FUN??
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
> _________________________________________________________________
> Express yourself instantly with MSN Messenger! Download today it's FREE!
> http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis  


 glDisable (GL_BUGS);
 heh
 Is that in 1.2? :)
