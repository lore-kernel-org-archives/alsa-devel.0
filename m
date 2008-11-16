From: Dmitry Nezhevenko <dion@inhex.net>
Subject: ALC883 recording broken
Date: Sun, 16 Nov 2008 02:58:06 +0200
Message-ID: <20081116005806.GA8987@laptop.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2832682732566441462=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from inhex.net (inhex.net [193.33.178.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 30E8E103819
	for <alsa-devel@alsa-project.org>; Sun, 16 Nov 2008 01:58:21 +0100 (CET)
Received: from laptop.vpn.local ([192.168.250.6]:59132 helo=laptop.local)
	by inhex.net with esmtp (Exim 4.63) (envelope-from <dion@inhex.net>)
	id 1L1Vxv-0001mu-4w
	for alsa-devel@alsa-project.org; Sun, 16 Nov 2008 02:58:18 +0200
Received: from dion by laptop.local with local (Exim 4.69)
	(envelope-from <dion@inhex.net>) id 1L1Vxm-0002LY-J7
	for alsa-devel@alsa-project.org; Sun, 16 Nov 2008 02:58:06 +0200
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


--===============2832682732566441462==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline


--WYTEVAkct0FjGQmd
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi. I'm trying to get sound recording work on my MSI M673 laptop.
Currently I'm running 2.6.27 kernel with in-kernel alsa.=20

It looks like something going really wrong. I've connected headphones to
laptop, unmuted mic and configured it's gain to maximum. After this I've
tried to change "Mic boost" value.=20

First of all, "Mic boost" under "Capture" view of alsamixer don't work at
all (I can't hear any changes). "Mic boost" under "Playback" works (at
least I can hear less noise with 0%, more noise with 33%, more with 67%.
and, that's strange, but less with 100%. (100% looks like same as 33%).

I've tried all model=3Dxxx variants for my ALC883 codec but with no success.
arecord just records silence. (Mic was unmuted and Mic boost is set to
maximum). Also just after modprobing snd_hda_intel with model=3Dacer-aspire
some led in headphones jack lights.. I don't know what does this means.

Ubuntu 7.10 with 2.6.22 kernel and alsa 1.0.14 works a bit different.
Recording works with model=3Dacer-aspire but playback is broken (just
silence).

It really looks like some codec misconfiguration (probably it tries to
record from incorrect line or something like this). I've found one thread
at LKML (http://lkml.org/lkml/2008/6/9/331) about this codec. And it
refers to some hda-verb utility that should be able to adjust some codec
settings.=20

Is there any manual available? Or any other suggestions, what I should try
to debug this?

I'm attaching alsa-info.sh output

--=20
WBR, Dmitry

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="alsa-info.txt"
Content-Transfer-Encoding: quoted-printable

upload=3Dtrue&script=3Dtrue&cardinfo=3D
!!################################
!!ALSA Information Script v 0.4.52
!!################################

!!Script ran on: Sun Nov 16 01:38:42 EET 2008


!!Linux Distribution
!!------------------

Debian GNU/Linux lenny/sid \n \l


!!Kernel Information
!!------------------

Kernel release:    2.6.27.2
Operating System:  GNU/Linux
Architecture:      i686
Processor:         unknown
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.17
Library version:   =20
Utilities version:  1.0.16


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [NVidia         ]: HDA-Intel - HDA NVidia
                      HDA NVidia at 0xfdfb8000 irq 23


!!PCI Soundcards installed in the system
!!--------------------------------------

00:10.1 Audio device: nVidia Corporation MCP51 High Definition Audio (rev a=
2)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:10.1 0403: 10de:026c (rev a2)
	Subsystem: 1462:3fdf


!!Modprobe options (Sound related)
!!--------------------------------

snd-atiixp-modem: index=3D-2
snd-intel8x0m: index=3D-2
snd-via82xx-modem: index=3D-2
snd-pcsp: index=3D-2


!!Loaded sound module options
!!--------------------------

!!Module: snd_hda_intel
bdl_pos_adj : 32,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-=
1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
enable_msi : 0
id : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,=
<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL=
>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NU=
LL>
index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-=
1,-1,-1,-1,-1,-1,-1,-1,-1,-1
model : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NUL=
L>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<N=
ULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,=
<NULL>
position_fix : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,=
0,0
power_save : 10
power_save_controller : Y
probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1=
,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
single_cmd : N


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Realtek ALC883
Address: 0
Vendor Id: 0x10ec0883
Subsystem Id: 0x14623fdf
Revision Id: 0x100002
No Modem Function Group found
Default PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=3D2, o=3D0, i=3D0, unsolicited=3D1, wake=3D0
  IO[0]: enable=3D1, dir=3D1, wake=3D0, sticky=3D0, data=3D1
  IO[1]: enable=3D1, dir=3D1, wake=3D0, sticky=3D0, data=3D1
Node 0x02 [Audio Output] wcaps 0x11: Stereo
  Converter: stream=3D0, channel=3D0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x03 [Audio Output] wcaps 0x11: Stereo
  Converter: stream=3D0, channel=3D0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x04 [Audio Output] wcaps 0x11: Stereo
  Converter: stream=3D0, channel=3D0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x05 [Audio Output] wcaps 0x11: Stereo
  Converter: stream=3D0, channel=3D0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
  Converter: stream=3D0, channel=3D0
  Digital: Enabled
  Digital category: 0x0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0x1e]: 16 20 24 32
    formats [0x1]: PCM
Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Amp-In caps: ofs=3D0x08, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
  Amp-In vals:  [0x9f 0x9f]
  Converter: stream=3D0, channel=3D0
  SDI-Select: 0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Connection: 1
     0x23
Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Amp-In caps: ofs=3D0x08, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
  Amp-In vals:  [0x9f 0x9f]
  Converter: stream=3D0, channel=3D0
  SDI-Select: 0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Connection: 1
     0x22
Node 0x0a [Audio Input] wcaps 0x100391: Stereo Digital
  Converter: stream=3D0, channel=3D0
  SDI-Select: 0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0x1e]: 16 20 24 32
    formats [0x1]: PCM
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 1
     0x1f
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=3D0x17, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
  Amp-In vals:  [0x1f 0x1f] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]=
 [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 10
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17
Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05, mute=3D0
  Amp-Out vals:  [0x1f 0x1f]
  Connection: 2
     0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05, mute=3D0
  Amp-Out vals:  [0x1f 0x1f]
  Connection: 2
     0x03 0x0b
Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05, mute=3D0
  Amp-Out vals:  [0x16 0x1f]
  Connection: 2
     0x04 0x0b
Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05, mute=3D0
  Amp-Out vals:  [0x00 0x00]
  Connection: 2
     0x05 0x0b
Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x12 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x14 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x083e: IN OUT HP Detect Trigger
  Pin Default 0x0121441f: [Jack] HP Out at Ext Rear
    Conn =3D 1/8, Color =3D Green
    DefAssociation =3D 0x1, Sequence =3D 0xf
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=3D04, enabled=3D1
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x15 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x083e: IN OUT HP Detect Trigger
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 5
     0x0c 0x0d* 0x0e 0x0f 0x26
Node 0x16 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x083e: IN OUT HP Detect Trigger
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 5
     0x0c 0x0d 0x0e* 0x0f 0x26
Node 0x17 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x083e: IN OUT HP Detect Trigger
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 5
     0x0c 0x0d 0x0e 0x0f* 0x26
Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x03 0x03]
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08173e: IN OUT HP Detect Trigger
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x01a19c3f: [Jack] Mic at Ext Rear
    Conn =3D 1/8, Color =3D Pink
    DefAssociation =3D 0x3, Sequence =3D 0xf
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 5
     0x0c 0x0d 0x0e* 0x0f 0x26
Node 0x19 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08173e: IN OUT HP Detect Trigger
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x99a30930: [Fixed] Mic at Int ATAPI
    Conn =3D ATAPI, Color =3D Unknown
    DefAssociation =3D 0x3, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08173e: IN OUT HP Detect Trigger
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x01813431: [Jack] Line In at Ext Rear
    Conn =3D 1/8, Color =3D Blue
    DefAssociation =3D 0x3, Sequence =3D 0x1
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 5
     0x0c 0x0d* 0x0e 0x0f 0x26
Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x08173e: IN OUT HP Detect Trigger
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x99130110: [Fixed] Speaker at Int ATAPI
    Conn =3D ATAPI, Color =3D Unknown
    DefAssociation =3D 0x1, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x40: OUT VREF_HIZ
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x593301f0: [N/A] CD at Int ATAPI
    Conn =3D ATAPI, Color =3D Unknown
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x00:
Node 0x1d [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x0820: IN
  Pin Default 0x598301f0: [N/A] Line In at Int ATAPI
    Conn =3D ATAPI, Color =3D Unknown
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x00:
Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
  Pincap 0x0810: OUT
  Pin Default 0x01454120: [Jack] SPDIF Out at Ext Rear
    Conn =3D Optical, Color =3D Green
    DefAssociation =3D 0x2, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x00:
  Connection: 1
     0x06
Node 0x1f [Pin Complex] wcaps 0x400200: Mono Digital
  Pincap 0x0820: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x00:
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
  Processing caps: benign=3D0, ncoeff=3D17
Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x22 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x80 0x80] [0x00 0x00]=
 [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Amp-Out caps: N/A
  Amp-Out vals:  [0x00 0x00]
  Connection: 11
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x23 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x80 0x80] [0x00 0x00]=
 [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Amp-Out caps: N/A
  Amp-Out vals:  [0x00 0x00]
  Connection: 11
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x24 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x25 [Audio Output] wcaps 0x11: Stereo
  Converter: stream=3D0, channel=3D0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x26 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05, mute=3D0
  Amp-Out vals:  [0x00 0x00]
  Connection: 2
     0x25 0x0b
Codec: LSI Si3054
Address: 1
Vendor Id: 0x11c13026
Subsystem Id: 0x11c13026
Revision Id: 0x100700
Modem Function Group: 0x1
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw---- 1 root audio 116, 12 2008-11-16 01:31 /dev/snd/controlC0
crw-rw---- 1 root audio 116, 11 2008-11-16 01:31 /dev/snd/hwC0D0
crw-rw---- 1 root audio 116, 10 2008-11-16 01:31 /dev/snd/hwC0D1
crw-rw---- 1 root audio 116,  9 2008-11-16 01:31 /dev/snd/pcmC0D0c
crw-rw---- 1 root audio 116,  8 2008-11-16 01:31 /dev/snd/pcmC0D0p
crw-rw---- 1 root audio 116,  7 2008-11-16 01:31 /dev/snd/pcmC0D1p
crw-rw---- 1 root audio 116,  6 2008-11-16 01:31 /dev/snd/pcmC0D2c
crw-rw---- 1 root audio 116,  5 2008-11-16 01:31 /dev/snd/pcmC0D6c
crw-rw---- 1 root audio 116,  4 2008-11-16 01:31 /dev/snd/pcmC0D6p
crw-rw---- 1 root audio 116,  3 2008-11-15 21:42 /dev/snd/seq
crw-rw---- 1 root audio 116,  2 2008-11-15 21:42 /dev/snd/timer


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: NVidia [HDA NVidia], device 0: ALC883 Analog [ALC883 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: NVidia [HDA NVidia], device 1: ALC883 Digital [ALC883 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: NVidia [HDA NVidia], device 6: Si3054 Modem [Si3054 Modem]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: NVidia [HDA NVidia], device 0: ALC883 Analog [ALC883 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: NVidia [HDA NVidia], device 2: ALC883 Analog [ALC883 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: NVidia [HDA NVidia], device 6: Si3054 Modem [Si3054 Modem]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [NVidia]

Card hw:0 'NVidia'/'HDA NVidia at 0xfdfb8000 irq 23'
  Mixer name	: 'Realtek ALC883'
  Components	: 'HDA:10ec0883 HDA:11c13026'
  Controls      : 34
  Simple ctrls  : 21
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 31 [100%] [0.00dB] [on]
Simple mixer control 'Headphone',0
  Capabilities: pswitch
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [on]
  Front Right: Playback [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 245 [96%] [-2.00dB]
  Front Right: Playback 245 [96%] [-2.00dB]
Simple mixer control 'Front',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [0.00dB] [on]
  Front Right: Playback 31 [100%] [0.00dB] [on]
Simple mixer control 'Surround',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [0.00dB] [on]
  Front Right: Playback 31 [100%] [0.00dB] [on]
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 22 [71%] [-13.50dB] [on]
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 31 [100%] [0.00dB] [on]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'CD',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [12.00dB] [on]
  Front Right: Playback 31 [100%] [12.00dB] [on]
Simple mixer control 'Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 3 [100%]
  Front Right: 3 [100%]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958 Default PCM',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 31 [100%] [34.50dB] [off]
  Front Right: Capture 31 [100%] [34.50dB] [off]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 31 [100%] [34.50dB] [off]
  Front Right: Capture 31 [100%] [34.50dB] [off]
Simple mixer control 'Caller ID',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Channel Mode',0
  Capabilities: enum
  Items: '2ch' '4ch' '6ch'
  Item0: '2ch'
Simple mixer control 'Digital',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 120
  Front Left: Capture 120 [100%] [30.00dB]
  Front Right: Capture 120 [100%] [30.00dB]
Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Mic' 'Front Mic' 'Line' 'CD'
  Item0: 'Mic'
Simple mixer control 'Input Source',1
  Capabilities: cenum
  Items: 'Mic' 'Front Mic' 'Line' 'CD'
  Item0: 'Mic'
Simple mixer control 'Off-hook',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]


!!Alsactl output
!!-------------

--startcollapse--
state.NVidia {
	control.1 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -4650
		comment.dbmax 0
		iface MIXER
		name 'Front Playback Volume'
		value.0 31
		value.1 31
	}
	control.2 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Headphone Playback Switch'
		value.0 true
		value.1 true
	}
	control.3 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Front Playback Switch'
		value.0 true
		value.1 true
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -4650
		comment.dbmax 0
		iface MIXER
		name 'Surround Playback Volume'
		value.0 31
		value.1 31
	}
	control.5 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Surround Playback Switch'
		value.0 true
		value.1 true
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		comment.dbmin -4650
		comment.dbmax 0
		iface MIXER
		name 'Center Playback Volume'
		value 22
	}
	control.7 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		comment.dbmin -4650
		comment.dbmax 0
		iface MIXER
		name 'LFE Playback Volume'
		value 31
	}
	control.8 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Center Playback Switch'
		value true
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'LFE Playback Switch'
		value true
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'CD Playback Volume'
		value.0 0
		value.1 0
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'CD Playback Switch'
		value.0 false
		value.1 false
	}
	control.12 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'Line Playback Volume'
		value.0 0
		value.1 0
	}
	control.13 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Line Playback Switch'
		value.0 false
		value.1 false
	}
	control.14 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'Mic Playback Volume'
		value.0 31
		value.1 31
	}
	control.15 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 3'
		comment.dbmin 0
		comment.dbmax 3000
		iface MIXER
		name 'Mic Boost'
		value.0 3
		value.1 3
	}
	control.16 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Mic Playback Switch'
		value.0 true
		value.1 true
	}
	control.17 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -1200
		comment.dbmax 3450
		iface MIXER
		name 'Capture Volume'
		value.0 31
		value.1 31
	}
	control.18 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		value.0 false
		value.1 false
	}
	control.19 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -1200
		comment.dbmax 3450
		iface MIXER
		name 'Capture Volume'
		index 1
		value.0 31
		value.1 31
	}
	control.20 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		index 1
		value.0 false
		value.1 false
	}
	control.21 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic
		comment.item.1 'Front Mic'
		comment.item.2 Line
		comment.item.3 CD
		iface MIXER
		name 'Input Source'
		value Mic
	}
	control.22 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic
		comment.item.1 'Front Mic'
		comment.item.2 Line
		comment.item.3 CD
		iface MIXER
		name 'Input Source'
		index 1
		value Mic
	}
	control.23 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 '2ch'
		comment.item.1 '4ch'
		comment.item.2 '6ch'
		iface MIXER
		name 'Channel Mode'
		value '2ch'
	}
	control.24 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff00000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000'
	}
	control.25 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f0000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000'
	}
	control.26 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Default'
		value '040000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000'
	}
	control.27 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Switch'
		value true
	}
	control.28 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Default PCM Playback Switch'
		value true
	}
	control.29 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		comment.dbmin -4650
		comment.dbmax 0
		iface MIXER
		name 'Master Playback Volume'
		value 31
	}
	control.30 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Master Playback Switch'
		value true
	}
	control.31 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Off-hook Switch'
		value false
	}
	control.32 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Caller ID Switch'
		value false
	}
	control.33 {
		comment.access 'read write user'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 255'
		comment.tlv '0000000100000008ffffec1400000014'
		comment.dbmin -5100
		comment.dbmax 0
		iface MIXER
		name 'PCM Playback Volume'
		value.0 245
		value.1 245
	}
	control.34 {
		comment.access 'read write user'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 120'
		comment.tlv '0000000100000008fffff44800000032'
		comment.dbmin -3000
		comment.dbmax 3000
		iface MIXER
		name 'Digital Capture Volume'
		value.0 120
		value.1 120
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
snd_hda_intel
udf
rt61pci
rt2x00pci
rt2x00lib
mac80211
eeprom_93cx6
button
usblp
usb_storage
libusual
ppp_async
ppp_generic
slhc
ipt_REJECT
iptable_filter
ip_tables
x_tables
vboxdrv
cpufreq_powersave
cpufreq_stats
cpufreq_userspace
cpufreq_ondemand
cpufreq_conservative
ipv6
tun
ext3
jbd
powernow_k8
freq_table
sbp2
loop
usbhid
hid
ff_memless
cdc_acm
sg
arc4
ecb
crypto_blkcipher
mousedev
pata_acpi
firewire_ohci
firewire_core
crc_itu_t
snd_pcm
snd_page_alloc
rfkill
snd_hwdep
snd_seq
led_class
rtc_cmos
snd_timer
pata_amd
rtc_core
snd_seq_device
sdhci_pci
ohci_hcd
ohci1394
yenta_socket
sdhci
cfg80211
snd
isp1760
ieee1394
k8temp
psmouse
mmc_core
ata_generic
ssb
rtc_lib
rsrc_nonstatic
ehci_hcd
soundcore
usbcore
serio_raw
pcspkr
i2c_nforce2
hwmon
pcmcia
pcmcia_core
i2c_core
firmware_class
battery
ac
video
output
r8169
evdev
dm_mirror
dm_log
dm_snapshot
dm_mod
thermal
processor
fan
sata_nv
libata
dock
reiserfs
tuxonice_userui
tuxonice_compress
tuxonice_swap
tuxonice_block_io
tuxonice_core
lzf



--BXVAT5kNtrzKuDFl--

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkfcB4ACgkQ0T/aIlRaJQaNHACbBfWBEXO02s++v4kuNBt6xYtv
2T8AnAyImytVNDQEJM56+QEXMcpg9wxf
=X7Z1
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--

--===============2832682732566441462==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2832682732566441462==--
