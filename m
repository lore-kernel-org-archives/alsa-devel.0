From: Mark Zealey <mz234@cam.ac.uk>
Subject: Re: intel8x0 no sound in 2.6.12
Date: Wed, 7 Sep 2005 16:16:24 +0100
Message-ID: <200509071616.25024.mz234@cam.ac.uk>
References: <200509071557.02218.mz234@cam.ac.uk> <s5hirxc7vvl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_JRwHDDhFXCNeLEy"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hirxc7vvl.wl%tiwai@suse.de>
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

--Boundary-00=_JRwHDDhFXCNeLEy
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Laptop is an IBM thinkpad R50e. Attached are the 2 files 
in /proc/asound/card0/codec97#0/ and asound.state. lspci output:

0000:00:00.0 Host bridge: Intel Corporation 82852/82855 GM/GME/PM/GMV 
Processor to I/O Controller (rev 02)
0000:00:00.1 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV 
Processor to I/O Controller (rev 02)
0000:00:00.3 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV 
Processor to I/O Controller (rev 02)
0000:00:02.0 VGA compatible controller: Intel Corporation 82852/855GM 
Integrated Graphics Device (rev 02)
0000:00:02.1 Display controller: Intel Corporation 82852/855GM Integrated 
Graphics Device (rev 02)
0000:00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 01)
0000:00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 01)
0000:00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 01)
0000:00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 
EHCI Controller (rev 01)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 81)
0000:00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC Interface 
Bridge (rev 01)
0000:00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE Controller 
(rev 01)
0000:00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
SMBus Controller (rev 01)
0000:00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
0000:00:1f.6 Modem: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
AC'97 Modem Controller (rev 01)
0000:02:00.0 CardBus bridge: Texas Instruments PCI1510 PC card Cardbus 
Controller
0000:02:08.0 Ethernet controller: Intel Corporation 82801DB PRO/100 VE (MOB) 
Ethernet Controller (rev 81)


On Wednesday 07 September 2005 4:14 pm, you wrote:
> At Wed, 7 Sep 2005 15:57:02 +0100,
>
> Mark Zealey wrote:
> > Hi there,
> >
> > I've just bought a laptop and put linux on it, however the sound does not
> > work. Everythnig installs fine, the channels are all as they should be
> > but there is no sound out of either the speakers or the headphone jack.
> > The problem looks to be the same as
> > http://www.ussg.iu.edu/hypermail/linux/kernel/0502.2/0755.html however
> > I've been unable to find how that was resolved. The only thnig which
> > looks vaguely like an error is:
> >
> > Sep  6 12:23:35 isaiah intel8x0_measure_ac97_clock: measured 51192 usecs
> > Sep  6 12:23:35 isaiah intel8x0: clocking to 48000
> > Sep  6 12:23:36 isaiah ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB]
> > -> GSI 11 (level, low) -> IRQ 11
> > Sep  6 12:23:36 isaiah PCI: Setting latency timer of device 0000:00:1f.6
> > to 64 Sep  6 12:23:36 isaiah
> > ALSA
> > /var/tmp/portage/alsa-driver-1.0.9b/work/alsa-driver-1.0.9b/alsa-kernel/p
> >ci/ac97/ac97_codec.c:1993: MC'97 1 converters and GPIO not ready (0xff00)
> >
> >
> > Dump of appropriate stuff following this, any help would be appreciated.
> > I'm using gentoo and I've tried using the kernel drivers and also the
> > drivers in alsa 1.0.9b but to no avail.
>
> All the important information is missing: what is your machine, which
> codecs are used, and how is the mixer status.
> About the last two, show /proc/asound/card0/codec97#0/* files and
> /etc/asound.state after running "alsactl store".  The
> /etc/asound.state might be in a different place depending on the
> distribution.
>
>
> Takashi

-- 

Mark Zealey
http://zealey.org/mark

--Boundary-00=_JRwHDDhFXCNeLEy
Content-Type: text/plain;
  charset="iso-8859-1";
  name="ac97#0-0"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ac97#0-0"

0-0/0: Analog Devices AD1981B

Capabilities     : -headphone out-
DAC resolution   : 20-bit
ADC resolution   : 16-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=1 AMAP DSA=0 VRA
Extended status  : VRA
PCM front DAC    : 44100Hz
PCM ADC          : 48000Hz



AD18XX configuration
Unchained        : 0x1000,0x0000,0x0000
Chained          : 0x0000,0x0000,0x0000

--Boundary-00=_JRwHDDhFXCNeLEy
Content-Type: text/plain;
  charset="iso-8859-1";
  name="ac97#0-0+regs"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ac97#0-0+regs"

0:00 = 0090
0:02 = 0707
0:04 = 0c0c
0:06 = 0007
0:08 = 0000
0:0a = 0000
0:0c = 8009
0:0e = 8007
0:10 = 0303
0:12 = 0a0a
0:14 = 0000
0:16 = 8f0f
0:18 = 0a0a
0:1a = 0606
0:1c = 0b0b
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 0601
0:2a = 0031
0:2c = ac44
0:2e = 0000
0:30 = 0000
0:32 = bb80
0:34 = 0000
0:36 = 0000
0:38 = 0000
0:3a = 2000
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 4000
0:5e = 0000
0:60 = 8080
0:62 = 0000
0:64 = 8000
0:66 = 0000
0:68 = 0000
0:6a = 0000
0:6c = 0000
0:6e = 0000
0:70 = 0000
0:72 = 0008
0:74 = 1001
0:76 = 0010
0:78 = 0000
0:7a = 0000
0:7c = 4144
0:7e = 5374

--Boundary-00=_JRwHDDhFXCNeLEy
Content-Type: text/plain;
  charset="iso-8859-1";
  name="asound.state"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="asound.state"

state.I82801DBICH4 {
	control.1 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Master Playback Switch'
		value.0 true
		value.1 true
	}
	control.2 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'Master Playback Volume'
		value.0 24
		value.1 24
	}
	control.3 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Headphone Playback Switch'
		value.0 true
		value.1 true
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'Headphone Playback Volume'
		value.0 19
		value.1 19
	}
	control.5 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Master Mono Playback Switch'
		value true
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		iface MIXER
		name 'Master Mono Playback Volume'
		value 24
	}
	control.7 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Phone Playback Switch'
		value false
	}
	control.8 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		iface MIXER
		name 'Phone Playback Volume'
		value 22
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Mic Playback Switch'
		value false
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		iface MIXER
		name 'Mic Playback Volume'
		value 24
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Mic Boost (+20dB)'
		value false
	}
	control.12 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Line Playback Switch'
		value.0 true
		value.1 true
	}
	control.13 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'Line Playback Volume'
		value.0 28
		value.1 28
	}
	control.14 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'CD Playback Switch'
		value.0 true
		value.1 true
	}
	control.15 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'CD Playback Volume'
		value.0 21
		value.1 21
	}
	control.16 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Aux Playback Switch'
		value.0 false
		value.1 false
	}
	control.17 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'Aux Playback Volume'
		value.0 16
		value.1 16
	}
	control.18 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'PCM Playback Switch'
		value.0 true
		value.1 true
	}
	control.19 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'PCM Playback Volume'
		value.0 21
		value.1 21
	}
	control.20 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 2
		comment.item.0 Mic
		comment.item.1 CD
		comment.item.2 Video
		comment.item.3 Aux
		comment.item.4 Line
		comment.item.5 Mix
		comment.item.6 'Mix Mono'
		comment.item.7 Phone
		iface MIXER
		name 'Capture Source'
		value.0 'Mix Mono'
		value.1 'Mix Mono'
	}
	control.21 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		value.0 true
		value.1 true
	}
	control.22 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 15'
		iface MIXER
		name 'Capture Volume'
		value.0 11
		value.1 11
	}
	control.23 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mix
		comment.item.1 Mic
		iface MIXER
		name 'Mono Output Select'
		value Mix
	}
	control.24 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic1
		comment.item.1 Mic2
		iface MIXER
		name 'Mic Select'
		value Mic1
	}
	control.25 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Stereo Mic'
		value false
	}
	control.26 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Headphone Jack Sense'
		value false
	}
	control.27 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Line Jack Sense'
		value false
	}
	control.28 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'External Amplifier'
		value true
	}
}
state.Modem {
	control.1 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Off-hook Switch'
		value false
	}
}

--Boundary-00=_JRwHDDhFXCNeLEy--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
