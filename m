From: Josh Green <josh@resonance.org>
Subject: Re: Intel Azalia problems
Date: Fri, 15 Apr 2005 01:40:26 -0700
Message-ID: <1113554426.15571.14.camel@SillyPuddy.localdomain>
References: <1113394027.16526.3.camel@SillyPuddy.localdomain>
	 <s5hll7mg30n.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-7gc5Bdn7yQvy+ZEYacrt"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hll7mg30n.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-7gc5Bdn7yQvy+ZEYacrt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-04-13 at 16:33 +0200, Takashi Iwai wrote: 
> Hi Josh,
> 
> At Wed, 13 Apr 2005 05:07:07 -0700,
> Josh Green wrote:
> > 
> > Hello, I recently purchased a new laptop which has an Intel Azalia sound
> > interface.  I noticed that this is a pretty recent addition to the ALSA
> > drivers.  Although it seems to be basically working, I'm having a couple
> > problems.
> > 
> > The first problem has to do with the headphone jack, which on this
> > laptop is an SPDIF/output combo jack. I can hear output on the built in
> > speakers (after un-muting and turning up the "Front" level), but when I
> > plug in headphones I don't hear anything (despite the fact that the
> > "Headphone" mixer is turned up and unmuted).
> 
> Which HDA codec?  Please attach /proc/asound/card0/codec#*/* file.
> (I guess it's CM9880, though..)
> Anyway, try the latest CVS version.  Some improvement has been done
> since rc2.
> 

cat /proc/asound/card0/codec#0 >/tmp/hda_intel_codec.txt attached.  I
suppose "Codec: Realtek ALC880" is what you are asking about.  I just
checked out alsa-driver, alsa-kernel, alsa-lib cvs, same results though.
I think the clicking problem is due to the 48Khz fixed rate, since it
seems like it only affects programs that try to play at other rates
(such as 44.1Khz).  I'll do my homework and figure out how to setup
sample rate conversion, but if someone wants to offer me some tips for
adding this to the default device in asound.conf I'd appreciate it :)

The headphone jack is still an issue though, no output from there.  I'll
get familiar with the source code to get an idea of things to mess with
(trying other mixer targets, etc).

> > The other problem is with certain applications which use oss.  Quake3
> > for example prints the following in the terminal it is started from:
> > 
> > ------- sound initialization -------
> > Could not mmap dma buffer PROT_WRITE|PROT_READ
> > trying mmap PROT_WRITE (with associated better compatibility / less
> > performance code)
> > /dev/dsp: Input/output error
> > Could not mmap /dev/dsp
> > ------------------------------------
> 
> If your codec is CM9880, it supports only 48/96/192kHz while quake
> prefers 44.1kHz.  This conflict can't be solved in the OSS mmap mode.
> 
> Try to tune via oss proc file as described in
> Documentation/OSS-Emulation.txt.
> 

Gave this a try, Quake3 starts up and I hear sound for the initial "ID"
stamp intro, but the game locks up when you start a level (not a hard
lockup, can still change to virtual terminal and kill).

> 
> Takashi
> 

Thanks for the help.  Maybe I'll see you at the Linux Audio Developers
Conference?  Cheers!
	Josh Green


--=-7gc5Bdn7yQvy+ZEYacrt
Content-Disposition: attachment; filename=hda_intel_codec.txt
Content-Type: text/plain; name=hda_intel_codec.txt; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Codec: Realtek ALC880
Address: 0
Vendor Id: 0x10ec0880
Subsystem Id: 0x0
Revision Id: 0x90500
Default PCM: rates 0x560, bits 0x0e, types 0x1
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
Node 0x02 [Audio Output] wcaps 0x411: Stereo
  PCM: rates 0x560, bits 0x0e, types 0x1
Node 0x03 [Audio Output] wcaps 0x411: Stereo
  PCM: rates 0x560, bits 0x0e, types 0x1
Node 0x04 [Audio Output] wcaps 0x411: Stereo
  PCM: rates 0x160, bits 0x0e, types 0x1
Node 0x05 [Audio Output] wcaps 0x411: Stereo
  PCM: rates 0x160, bits 0x0e, types 0x1
Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
  PCM: rates 0x160, bits 0x1e, types 0x1
Node 0x07 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x23, stepsize=0x03, mute=1
  Amp-In vals: 0x00 0x00
  PCM: rates 0x160, bits 0x06, types 0x1
  Connection: 7
     0x18 0x19 0x1a* 0x1b 0x1c 0x14 0x15
Node 0x08 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x23, stepsize=0x03, mute=1
  Amp-In vals: 0x00 0x00
  PCM: rates 0x160, bits 0x06, types 0x1
  Connection: 7
     0x18 0x19 0x1a* 0x1b 0x1c 0x14 0x15
Node 0x09 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x23, stepsize=0x03, mute=1
  Amp-In vals: 0x00 0x00
  PCM: rates 0x160, bits 0x06, types 0x1
  Connection: 10
     0x18 0x19 0x1a 0x1b 0x1c* 0x0b 0x14 0x15 0x16 0x17
Node 0x0a [Audio Input] wcaps 0x100391: Stereo Digital
  PCM: rates 0x160, bits 0x1e, types 0x1
  Connection: 1
     0x1f
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x23, nsteps=0x41, stepsize=0x03, mute=1
  Amp-In vals: 0x00 0x00
  Connection: 8
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15
Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals: 0x00 0x00
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals: 0x36 0x36
  Connection: 2
     0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals: 0x00 0x00
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals: 0x35 0x35
  Connection: 2
     0x03 0x0b
Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals: 0x00 0x00
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals: 0x35 0x30
  Connection: 2
     0x04 0x0b
Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals: 0x00 0x00
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals: 0x2e 0x2e
  Connection: 2
     0x05 0x0b
Node 0x10 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 4
     0x0c* 0x0d 0x0e 0x0f
Node 0x11 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 4
     0x0c 0x0d* 0x0e 0x0f
Node 0x12 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 4
     0x0c* 0x0d 0x0e 0x0f
Node 0x13 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 4
     0x0c* 0x0d 0x0e 0x0f
Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals: 0x00 0x00
  Pincap 0x083f: IN OUT HP
  Pin Default 0x00000000: Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0c
Node 0x15 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals: 0x80 0x80
  Pincap 0x083f: IN OUT HP
  Pin Default 0x00000000: Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0d
Node 0x16 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals: 0x80 0x80
  Pincap 0x083f: IN OUT HP
  Pin Default 0x00000000: Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0e
Node 0x17 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals: 0x80 0x80
  Pincap 0x083f: IN OUT HP
  Pin Default 0x00000000: Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0f
Node 0x18 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals: 0x00 0x00
  Pincap 0x08133f: IN OUT HP
  Pin Default 0x00000000: Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x24: IN
  Connection: 1
     0x10
Node 0x19 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals: 0x00 0x00
  Pincap 0x08133f: IN OUT HP
  Pin Default 0x00000000: Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x11
Node 0x1a [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals: 0x00 0x00
  Pincap 0x08133f: IN OUT HP
  Pin Default 0x00000000: Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x20: IN
  Connection: 1
     0x12
Node 0x1b [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals: 0x80 0x80
  Pincap 0x08133f: IN OUT HP
  Pin Default 0x00000000: Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x24: IN
  Connection: 1
     0x13
Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x00000000: Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
Node 0x1d [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x0820: IN
  Pin Default 0x00000000: Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
  Pincap 0x0810: OUT
  Pin Default 0x00000000: Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Connection: 1
     0x06
Node 0x1f [Pin Complex] wcaps 0x400200: Mono Digital
  Pincap 0x0820: IN
  Pin Default 0x00000000: Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
Node 0x21 [Volume Knob Widget] wcaps 0x600080: Mono

--=-7gc5Bdn7yQvy+ZEYacrt--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
