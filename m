From: Freek de Kruijf <freek@opensuse.org>
Subject: Re: Sound to HDMI device delayed
Date: Fri, 05 Jan 2018 12:23:10 +0100
Message-ID: <2807364.JErTqOgqL8@eiktum>
References: <189291619.ZYY3cy48X2@eiktum> <s5h8tddbqhw.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lb2-smtp-cloud7.xs4all.net (lb2-smtp-cloud7.xs4all.net
 [194.109.24.28])
 by alsa0.perex.cz (Postfix) with ESMTP id E74E22677F1
 for <alsa-devel@alsa-project.org>; Fri,  5 Jan 2018 12:23:17 +0100 (CET)
In-Reply-To: <s5h8tddbqhw.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Op donderdag 4 januari 2018 16:19:55 CET schreef Takashi Iwai:
> On Tue, 26 Dec 2017 15:32:21 +0100,
> 
> Freek de Kruijf wrote:
> > I have the following sound devices:
> > 
> > hwinfo --sound
> > Absolute path to 'hwinfo' is '/usr/sbin/hwinfo', so running it may require
> > superuser privileges (eg. root).
> > freek@eiktum:~> /usr/sbin/hwinfo --sound
> > 16: PCI 14.2: 0403 Audio device
> > 
> >   [Created at pci.378]
> >   Unique ID: 5Dex.BDUuYMOWyw7
> >   SysFS ID: /devices/pci0000:00/0000:00:14.2
> >   SysFS BusID: 0000:00:14.2
> >   Hardware Class: sound
> >   Model: "ATI SBx00 Azalia (Intel HDA)"
> >   Vendor: pci 0x1002 "ATI Technologies Inc"
> >   Device: pci 0x4383 "SBx00 Azalia (Intel HDA)"
> >   SubVendor: pci 0x1002 "ATI Technologies Inc"
> >   SubDevice: pci 0x4383
> >   Revision: 0x40
> >   Memory Range: 0xfe6f8000-0xfe6fbfff (rw,non-prefetchable)
> >   IRQ: 10 (no events)
> >   Module Alias: "pci:v00001002d00004383sv00001002sd00004383bc04sc03i00"
> >   
> >   Driver Info #0:
> >     Driver Status: snd_hda_intel is active
> >     Driver Activation Cmd: "modprobe snd_hda_intel"
> >   
> >   Config Status: cfg=yes, avail=yes, need=no, active=unknown
> > 
> > 26: PCI 500.1: 0403 Audio device
> > 
> >   [Created at pci.378]
> >   Unique ID: 5yAR.dhjYDcGDBr3
> >   Parent ID: _Znp.ZJmKoWxd6BF
> >   SysFS ID: /devices/pci0000:00/0000:00:02.0/0000:05:00.1
> >   SysFS BusID: 0000:05:00.1
> >   Hardware Class: sound
> >   Model: "ATI RV770 HDMI Audio [Radeon HD 4850/4870]"
> >   Vendor: pci 0x1002 "ATI Technologies Inc"
> >   Device: pci 0xaa30 "RV770 HDMI Audio [Radeon HD 4850/4870]"
> >   SubVendor: pci 0x1787 "Hightech Information System Ltd."
> >   SubDevice: pci 0xaa30
> >   Driver: "snd_hda_intel"
> >   Driver Modules: "snd_hda_intel"
> >   Memory Range: 0xfe9ec000-0xfe9effff (rw,non-prefetchable)
> >   IRQ: 36 (1104 events)
> >   Module Alias: "pci:v00001002d0000AA30sv00001787sd0000AA30bc04sc03i00"
> >   
> >   Driver Info #0:
> >     Driver Status: snd_hda_intel is active
> >     Driver Activation Cmd: "modprobe snd_hda_intel"
> >   
> >   Config Status: cfg=yes, avail=yes, need=no, active=unknown
> >   Attached to: #18 (PCI bridge)
> > 
> > I have my monitor connected via HDMI and that monitor has speakers. The
> > monitor is:
> > 
> > hwinfo --monitor
> > 29: None 00.0: 10002 LCD Monitor
> > 
> >   [Created at monitor.125]
> >   Unique ID: rdCR.ukgc1_4VzS0
> >   Parent ID: Ddhb.zvQlrOmSRQ8
> >   Hardware Class: monitor
> >   Model: "R231"
> >   Vendor: ACR
> >   Device: eisa 0x0504 "R231"
> >   Serial ID: "T6GEE0012400"
> >   Resolution: 720x400@70Hz
> >   Resolution: 640x480@60Hz
> >   Resolution: 640x480@67Hz
> >   Resolution: 800x600@56Hz
> >   Resolution: 800x600@60Hz
> >   Resolution: 1024x768@60Hz
> >   Resolution: 1024x768@70Hz
> >   Resolution: 1152x864@75Hz
> >   Resolution: 1280x1024@60Hz
> >   Resolution: 1280x720@60Hz
> >   Resolution: 1920x1080@60Hz
> >   Size: 509x286 mm
> >   Year of Manufacture: 2016
> >   Week of Manufacture: 4
> >   
> >   Detailed Timings #0:
> >      Resolution: 1920x1080
> >      Horizontal: 1920 2008 2052 2200 (+88 +132 +280) +hsync
> >      
> >        Vertical: 1080 1084 1089 1125 (+4 +9 +45) +vsync
> >     
> >     Frequencies: 148.50 MHz, 67.50 kHz, 60.00 Hz
> >   
> >   Driver Info #0:
> >     Max. Resolution: 1920x1080
> >     Vert. Sync Range: 56-75 Hz
> >     Hor. Sync Range: 31-75 kHz
> >     Bandwidth: 148 MHz
> >   
> >   Config Status: cfg=no, avail=yes, need=no, active=unknown
> >   Attached to: #8 (VGA compatible controller)
> > 
> > The sound is working OK, however the problem is that the sound is delayed
> > by about one second compared to the picture on the screen.
> > Most visible/hearable by using Musescore, where a music note is
> > highlighted
> > when it is played. Using VGA and the other sound card there is no delay.
> 
> I don't know of such a problem, and I can't think that such a long
> delay happens in the hardware side.
> 
> Which sound backend are you using?  Does the same delay happen even if
> you play directly via aplay with -Dplughw?

I use the Phonon GStreamer as backend.

Using aplay does not reveal the delay between the pictures on the screen and  
playing the sound. It is most apparent when using Musescore and playing the 
music notes in the score.

This triggered to take a closer look in Musescore. I found a setting which 
routes the sound directly to ALSA and not to pulseaudio. Now the sound is 
synchronized with the picture on the screen. So the problem must be in 
pulseaudio.

Many thanks for your answer.

-- 
fr.gr.

member openSUSE
Freek de Kruijf
