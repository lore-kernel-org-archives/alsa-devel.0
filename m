From: "Nathanael D. Noblet" <nathanael@gnat.ca>
Subject: Internal Mic Boost channel is unused
Date: Thu, 12 Sep 2013 09:52:40 -0600
Message-ID: <5231E348.8020204@gnat.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010101080505010800050903"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from titanium.nobletdesign.com (titanium.nobletdesign.com
 [64.34.172.148])
 by alsa0.perex.cz (Postfix) with ESMTP id 9AD4B2654C9
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2013 17:52:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010101080505010800050903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

    I have an issue I'd like to help completely solve. Unfortunately I 
only have a tenuous grasp of what is actually going on so some of this 
could be wrong/include errors.

   Here's what I know.

  1) I have the following hardware (alsa-info attached).
  2) The internal microphone requires that the mic boost channel be 
something other than 0 to function properly.
  3) Changing what pulseaudio expects things to be labelled causes the 
problem to go away. (via the attached patch to 
/usr/share/pulseaudio/paths/analog-input-mic.conf).

   From the discussion with David Henningsson (diwic on IRC). It seems 
that pulse doesn't expect a Mic Boost channel to be used with internal 
microphones. As such to fix this particular hardware, the driver would 
need to make the internal mic boost be labelled "Internal Mic Boost" as 
opposed to Mic Boost, which is then is used for both external and 
internal mics.

   I'd love to be able to help any way I can to get these fixed once and 
for all. Let me know if you need more information or what not.

-- 
Nathanael d. Noblet
t 403.875.4613

--------------010101080505010800050903
Content-Type: text/plain; charset=UTF-8;
 name="alsa.info.txt"
Content-Disposition: attachment;
 filename="alsa.info.txt"
Content-Transfer-Encoding: quoted-printable

upload=3Dtrue&script=3Dtrue&cardinfo=3D
!!################################
!!ALSA Information Script v 0.4.62
!!################################

!!Script ran on: Wed Sep 11 22:18:50 UTC 2013


!!Linux Distribution
!!------------------

Fedora release 19 (Schr=C3=B6dinger=E2=80=99s Cat) Fedora release 19 (Sch=
r=C3=B6dinger=E2=80=99s Cat) NAME=3DFedora ID=3Dfedora PRETTY_NAME=3D"Fed=
ora 19 (Schr=C3=B6dinger=E2=80=99s Cat)" CPE_NAME=3D"cpe:/o:fedoraproject=
:fedora:19" Fedora release 19 (Schr=C3=B6dinger=E2=80=99s Cat) Fedora rel=
ease 19 (Schr=C3=B6dinger=E2=80=99s Cat)


!!DMI Information
!!---------------

Manufacturer:      Acer
Product Name:      AO722
Product Version:   V1.08
Firmware Version:  V1.08


!!Kernel Information
!!------------------

Kernel release:    3.10.7-200.ns.fc19.i686.PAE
Operating System:  GNU/Linux
Architecture:      i686
Processor:         i686
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     k3.10.7-200.ns.fc19.i686.PAE
Library version:   =20
Utilities version:  1.0.27.2


!!Loaded ALSA modules
!!-------------------

snd_hda_intel
snd_hda_intel


!!Sound Servers on this system
!!----------------------------

Pulseaudio:
      Installed - Yes (/bin/pulseaudio)
      Running - Yes


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [Generic        ]: HDA-Intel - HD-Audio Generic
                      HD-Audio Generic at 0x90444000 irq 41
 1 [SB             ]: HDA-Intel - HDA ATI SB
                      HDA ATI SB at 0x90440000 irq 16


!!PCI Soundcards installed in the system
!!--------------------------------------

00:01.1 Audio device: Advanced Micro Devices [AMD] nee ATI Wrestler HDMI =
Audio [Radeon HD 6250/6310]
00:14.2 Audio device: Advanced Micro Devices [AMD] nee ATI SBx00 Azalia (=
Intel HDA) (rev 40)


!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!-------------------------------------------------------

00:01.1 0403: 1002:1314
	Subsystem: 1025:0598
--
00:14.2 0403: 1002:4383 (rev 40)
	Subsystem: 1025:0598


!!Loaded sound module options
!!---------------------------

!!Module: snd_hda_intel
	align_buffer_size : -1
	bdl_pos_adj : 32,32,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-=
1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	beep_mode : N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,=
N,N
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable_msi : -1
	id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(nul=
l),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),=
(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(nu=
ll),(null)
	index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-=
1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	jackpoll_ms : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,=
0,0,0
	model : (null),(null),(null),(null),(null),(null),(null),(null),(null),(=
null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(nul=
l),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),=
(null),(null)
	patch : (null),(null),(null),(null),(null),(null),(null),(null),(null),(=
null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(nul=
l),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),=
(null),(null)
	position_fix : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,=
-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	power_save : 0
	power_save_controller : Y
	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1=
,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	probe_only : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0=
,0,0
	single_cmd : N
	snoop : Y

!!Module: snd_hda_intel
	align_buffer_size : -1
	bdl_pos_adj : 32,32,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-=
1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	beep_mode : N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,=
N,N
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable_msi : -1
	id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(nul=
l),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),=
(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(nu=
ll),(null)
	index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-=
1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	jackpoll_ms : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,=
0,0,0
	model : (null),(null),(null),(null),(null),(null),(null),(null),(null),(=
null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(nul=
l),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),=
(null),(null)
	patch : (null),(null),(null),(null),(null),(null),(null),(null),(null),(=
null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(nul=
l),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),=
(null),(null)
	position_fix : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,=
-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	power_save : 0
	power_save_controller : Y
	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1=
,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	probe_only : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0=
,0,0
	single_cmd : N
	snoop : Y


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: ATI R6xx HDMI
Address: 0
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x1002aa01
Subsystem Id: 0x00aa0100
Revision Id: 0x100200
No Modem Function Group found
Default PCM:
    rates [0x70]: 32000 44100 48000
    bits [0x2]: 16
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
  Power states:  D0 D3
  Power: setting=3DD0, actual=3DD0
GPIO: io=3D0, o=3D0, i=3D0, unsolicited=3D0, wake=3D0
Node 0x02 [Audio Output] wcaps 0x201: Stereo Digital
  Converter: stream=3D1, channel=3D0
  Digital: Enabled
  Digital category: 0x0
  IEC Coding Type: 0x0
Node 0x03 [Pin Complex] wcaps 0x400381: Stereo Digital
  Control: name=3D"HDMI/DP,pcm=3D3 Jack", index=3D0, device=3D0
  Control: name=3D"IEC958 Playback Con Mask", index=3D0, device=3D0
  Control: name=3D"IEC958 Playback Pro Mask", index=3D0, device=3D0
  Control: name=3D"IEC958 Playback Default", index=3D0, device=3D0
  Control: name=3D"IEC958 Playback Switch", index=3D0, device=3D0
  Control: name=3D"ELD", index=3D0, device=3D3
  Pincap 0x00000094: OUT Detect HDMI
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn =3D Digital, Color =3D Unknown
    DefAssociation =3D 0x1, Sequence =3D 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=3D01, enabled=3D1
  Connection: 1
     0x02
Codec: Conexant CX20588
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x14f1506c
Subsystem Id: 0x10250598
Revision Id: 0x100003
No Modem Function Group found
Default PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
  Power states:  D0 D1 D2 D3 D3cold CLKSTOP EPSS
  Power: setting=3DD0, actual=3DD0
GPIO: io=3D4, o=3D0, i=3D0, unsolicited=3D1, wake=3D0
  IO[0]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
  IO[1]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
  IO[2]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
  IO[3]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
Node 0x10 [Audio Output] wcaps 0xc1d: Stereo Amp-Out R/L
  Control: name=3D"Headphone Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Control: name=3D"Headphone Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Device: name=3D"CX20588 Analog", type=3D"Audio", device=3D0
  Amp-Out caps: ofs=3D0x4a, nsteps=3D0x4a, stepsize=3D0x03, mute=3D1
  Amp-Out vals:  [0x4a 0x4a]
  Converter: stream=3D8, channel=3D0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 D3cold EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x11 [Audio Output] wcaps 0xc1d: Stereo Amp-Out R/L
  Control: name=3D"Speaker Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Control: name=3D"Speaker Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Amp-Out caps: ofs=3D0x4a, nsteps=3D0x4a, stepsize=3D0x03, mute=3D1
  Amp-Out vals:  [0x4a 0x4a]
  Converter: stream=3D8, channel=3D0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 D3cold EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x12 [Audio Output] wcaps 0x611: Stereo Digital
  Converter: stream=3D0, channel=3D0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Power states:  D0 D1 D2 D3 D3cold EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x13 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Control: name=3D"Beep Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D1, dir=3DOut, idx=3D0, ofs=3D0
  Control: name=3D"Beep Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D1, dir=3DOut, idx=3D0, ofs=3D0
  Amp-Out caps: ofs=3D0x07, nsteps=3D0x07, stepsize=3D0x0f, mute=3D0
  Amp-Out vals:  [0x06]
Node 0x14 [Audio Input] wcaps 0x100d1b: Stereo Amp-In R/L
  Control: name=3D"Capture Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
  Control: name=3D"Capture Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
  Device: name=3D"CX20588 Analog", type=3D"Audio", device=3D0
  Amp-In caps: ofs=3D0x4a, nsteps=3D0x50, stepsize=3D0x03, mute=3D1
  Amp-In vals:  [0x50 0x50] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Converter: stream=3D4, channel=3D0
  SDI-Select: 0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 D3cold EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 4
     0x17* 0x18 0x23 0x24
Node 0x15 [Audio Input] wcaps 0x100d1b: Stereo Amp-In R/L
  Control: name=3D"Capture Volume", index=3D1, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
  Control: name=3D"Capture Switch", index=3D1, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
  Device: name=3D"CX20588 Alt Analog", type=3D"Audio", device=3D2
  Amp-In caps: ofs=3D0x4a, nsteps=3D0x50, stepsize=3D0x03, mute=3D1
  Amp-In vals:  [0xc6 0xc6] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Converter: stream=3D0, channel=3D0
  SDI-Select: 0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 D3cold EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 4
     0x17* 0x18 0x23 0x24
Node 0x16 [Audio Input] wcaps 0x100d1b: Stereo Amp-In R/L
  Control: name=3D"Capture Volume", index=3D2, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
  Control: name=3D"Capture Switch", index=3D2, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
  Amp-In caps: ofs=3D0x4a, nsteps=3D0x50, stepsize=3D0x03, mute=3D1
  Amp-In vals:  [0xc7 0xc7] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Converter: stream=3D0, channel=3D0
  SDI-Select: 0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 D3cold EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 4
     0x17* 0x18 0x23 0x24
Node 0x17 [Audio Selector] wcaps 0x30050d: Stereo Amp-Out
  Control: name=3D"Mic Boost Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x04, stepsize=3D0x27, mute=3D0
  Amp-Out vals:  [0x04 0x04]
  Power states:  D0 D1 D2 D3 D3cold EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 4
     0x1a 0x1b 0x1d 0x1e*
Node 0x18 [Audio Selector] wcaps 0x30050d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x04, stepsize=3D0x27, mute=3D0
  Amp-Out vals:  [0x00 0x00]
  Power states:  D0 D1 D2 D3 D3cold EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 4
     0x1a* 0x1b 0x1d 0x1e
Node 0x19 [Pin Complex] wcaps 0x400581: Stereo
  Control: name=3D"Headphone Jack", index=3D0, device=3D0
  Pincap 0x0000001c: OUT HP Detect
  Pin Default 0x03211040: [Jack] HP Out at Ext Left
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0x4, Sequence =3D 0x0
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=3D01, enabled=3D1
  Power states:  D0 D1 D2 D3 D3cold EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 2
     0x10* 0x11
Node 0x1a [Pin Complex] wcaps 0x400481: Stereo
  Control: name=3D"Mic Jack", index=3D1, device=3D0
  Pincap 0x00001324: IN Detect
    Vref caps: HIZ 50 80
  Pin Default 0x03a1103e: [Jack] Mic at Ext Left
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0x3, Sequence =3D 0xe
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=3D04, enabled=3D1
  Power states:  D0 D1 D2 D3 D3cold EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x1b [Pin Complex] wcaps 0x400581: Stereo
  Control: name=3D"Mic Jack", index=3D0, device=3D0
  Pincap 0x00011334: IN OUT EAPD Detect
    Vref caps: HIZ 50 80
  EAPD 0x2: EAPD
  Pin Default 0x03a19030: [Jack] Mic at Ext Left
    Conn =3D 1/8, Color =3D Pink
    DefAssociation =3D 0x3, Sequence =3D 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=3D02, enabled=3D1
  Power states:  D0 D1 D2 D3 D3cold EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 2
     0x10* 0x11
Node 0x1c [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x00000014: OUT Detect
  Pin Default 0x400001f0: [N/A] Line Out at Ext N/A
    Conn =3D Unknown, Color =3D Unknown
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=3D00, enabled=3D0
  Power states:  D0 D1 D2 D3 D3cold EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 2
     0x10* 0x11
Node 0x1d [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x00010034: IN OUT EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x400001f0: [N/A] Line Out at Ext N/A
    Conn =3D Unknown, Color =3D Unknown
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=3D00, enabled=3D0
  Power states:  D0 D1 D2 D3 D3cold EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 2
     0x10* 0x11
Node 0x1e [Pin Complex] wcaps 0x400481: Stereo
  Control: name=3D"Internal Mic Phantom Jack", index=3D0, device=3D0
  Pincap 0x00000024: IN Detect
  Pin Default 0x95a70120: [Fixed] Mic at Int Top
    Conn =3D Analog, Color =3D Unknown
    DefAssociation =3D 0x2, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x20: IN
  Unsolicited: tag=3D00, enabled=3D0
  Power states:  D0 D1 D2 D3 D3cold EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x1f [Pin Complex] wcaps 0x400501: Stereo
  Control: name=3D"Speaker Phantom Jack", index=3D0, device=3D0
  Pincap 0x00000010: OUT
  Pin Default 0x92170110: [Fixed] Speaker at Int Front
    Conn =3D Analog, Color =3D Unknown
    DefAssociation =3D 0x1, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Power states:  D0 D1 D2 D3 D3cold EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 2
     0x10 0x11*
Node 0x20 [Pin Complex] wcaps 0x400781: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x400001f0: [N/A] Line Out at Ext N/A
    Conn =3D Unknown, Color =3D Unknown
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x00:
  Unsolicited: tag=3D00, enabled=3D0
  Power states:  D0 D1 D2 D3 D3cold EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 1
     0x12
Node 0x21 [Audio Output] wcaps 0x611: Stereo Digital
  Converter: stream=3D0, channel=3D0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Power states:  D0 D1 D2 D3 D3cold EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x22 [Pin Complex] wcaps 0x400781: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x400001f0: [N/A] Line Out at Ext N/A
    Conn =3D Unknown, Color =3D Unknown
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x00:
  Unsolicited: tag=3D00, enabled=3D0
  Power states:  D0 D1 D2 D3 D3cold EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 1
     0x21
Node 0x23 [Pin Complex] wcaps 0x40040b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x04, stepsize=3D0x2f, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000020: IN
  Pin Default 0x400001f0: [N/A] Line Out at Ext N/A
    Conn =3D Unknown, Color =3D Unknown
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x00:
  Power states:  D0 D1 D2 D3 D3cold EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x24 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
  Amp-In caps: ofs=3D0x4a, nsteps=3D0x4a, stepsize=3D0x03, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Power states:  D0 D1 D2 D3 D3cold EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 2
     0x10 0x11
Node 0x25 [Vendor Defined Widget] wcaps 0xf00000: Mono
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116,  4 Sep  6 17:23 /dev/snd/controlC0
crw-rw----+ 1 root audio 116,  9 Sep  6 17:23 /dev/snd/controlC1
crw-rw----+ 1 root audio 116,  3 Sep  6 17:23 /dev/snd/hwC0D0
crw-rw----+ 1 root audio 116,  8 Sep  6 17:23 /dev/snd/hwC1D0
crw-rw----+ 1 root audio 116,  2 Sep 11 16:16 /dev/snd/pcmC0D3p
crw-rw----+ 1 root audio 116,  7 Sep 11 16:16 /dev/snd/pcmC1D0c
crw-rw----+ 1 root audio 116,  6 Sep 11 16:16 /dev/snd/pcmC1D0p
crw-rw----+ 1 root audio 116,  5 Sep  6 17:23 /dev/snd/pcmC1D2c
crw-rw----+ 1 root audio 116,  1 Sep  6 17:23 /dev/snd/seq
crw-rw----+ 1 root audio 116, 33 Sep  6 17:23 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x. 2 root root  80 Sep  6 17:23 .
drwxr-xr-x. 3 root root 260 Sep  6 17:23 ..
lrwxrwxrwx. 1 root root  12 Sep  6 17:23 pci-0000:00:01.1 -> ../controlC0
lrwxrwxrwx. 1 root root  12 Sep  6 17:23 pci-0000:00:14.2 -> ../controlC1


!!ALSA configuration files
!!------------------------

!!System wide config file (/etc/asound.conf)

#
# Place your global alsa-lib configuration here...
#


!!Aplay/Arecord output
!!--------------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: Generic [HD-Audio Generic], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: SB [HDA ATI SB], device 0: CX20588 Analog [CX20588 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 1: SB [HDA ATI SB], device 0: CX20588 Analog [CX20588 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: SB [HDA ATI SB], device 2: CX20588 Alt Analog [CX20588 Alt Analog=
]
  Subdevices: 2/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [Generic]

Card hw:0 'Generic'/'HD-Audio Generic at 0x90444000 irq 41'
  Mixer name	: 'ATI R6xx HDMI'
  Components	: 'HDA:1002aa01,00aa0100,00100200'
  Controls      : 7
  Simple ctrls  : 1
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]

!!-------Mixer controls for card 1 [SB]

Card hw:1 'SB'/'HDA ATI SB at 0x90440000 irq 16'
  Mixer name	: 'Conexant CX20588'
  Components	: 'HDA:14f1506c,10250598,00100003'
  Controls      : 29
  Simple ctrls  : 13
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 74
  Mono: Playback 74 [100%] [0.00dB] [on]
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 74
  Mono:
  Front Left: Playback 74 [100%] [0.00dB] [on]
  Front Right: Playback 74 [100%] [0.00dB] [on]
Simple mixer control 'Speaker',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 74
  Mono:
  Front Left: Playback 74 [100%] [0.00dB] [on]
  Front Right: Playback 74 [100%] [0.00dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 255 [100%] [0.00dB]
  Front Right: Playback 255 [100%] [0.00dB]
Simple mixer control 'Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 4
  Front Left: 4 [100%] [40.00dB]
  Front Right: 4 [100%] [40.00dB]
Simple mixer control 'Beep',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 7
  Mono: Playback 6 [86%] [-4.00dB] [on]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 80
  Front Left: Capture 80 [100%] [6.00dB] [on]
  Front Right: Capture 80 [100%] [6.00dB] [on]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 80
  Front Left: Capture 70 [88%] [-4.00dB] [off]
  Front Right: Capture 70 [88%] [-4.00dB] [off]
Simple mixer control 'Capture',2
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 80
  Front Left: Capture 71 [89%] [-3.00dB] [off]
  Front Right: Capture 71 [89%] [-3.00dB] [off]
Simple mixer control 'Auto-Mute Mode',0
  Capabilities: enum
  Items: 'Disabled' 'Enabled'
  Item0: 'Disabled'
Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Mic' 'Internal Mic' 'Mic 1'
  Item0: 'Internal Mic'
Simple mixer control 'Input Source',1
  Capabilities: cenum
  Items: 'Mic' 'Internal Mic' 'Mic 1'
  Item0: 'Internal Mic'
Simple mixer control 'Input Source',2
  Capabilities: cenum
  Items: 'Mic' 'Internal Mic' 'Mic 1'
  Item0: 'Internal Mic'


!!Alsactl output
!!--------------

--startcollapse--
state.Generic {
	control.1 {
		iface CARD
		name 'HDMI/DP,pcm=3D3 Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.2 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.3 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.4 {
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.5 {
		iface MIXER
		name 'IEC958 Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.6 {
		iface PCM
		device 3
		name ELD
		value ''
		comment {
			access 'read volatile'
			type BYTES
			count 0
		}
	}
	control.7 {
		iface PCM
		device 3
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
}
state.SB {
	control.1 {
		iface MIXER
		name 'Headphone Playback Volume'
		value.0 74
		value.1 74
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 74'
			dbmin -7400
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.2 {
		iface MIXER
		name 'Headphone Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.3 {
		iface MIXER
		name 'Speaker Playback Volume'
		value.0 74
		value.1 74
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 74'
			dbmin -7400
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.4 {
		iface MIXER
		name 'Speaker Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.5 {
		iface MIXER
		name 'Auto-Mute Mode'
		value Disabled
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Disabled
			item.1 Enabled
		}
	}
	control.6 {
		iface MIXER
		name 'Input Source'
		value 'Internal Mic'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Mic
			item.1 'Internal Mic'
			item.2 'Mic 1'
		}
	}
	control.7 {
		iface MIXER
		name 'Input Source'
		index 1
		value 'Internal Mic'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Mic
			item.1 'Internal Mic'
			item.2 'Mic 1'
		}
	}
	control.8 {
		iface MIXER
		name 'Input Source'
		index 2
		value 'Internal Mic'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Mic
			item.1 'Internal Mic'
			item.2 'Mic 1'
		}
	}
	control.9 {
		iface MIXER
		name 'Capture Volume'
		value.0 80
		value.1 80
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 80'
			dbmin -7400
			dbmax 600
			dbvalue.0 600
			dbvalue.1 600
		}
	}
	control.10 {
		iface MIXER
		name 'Capture Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.11 {
		iface MIXER
		name 'Capture Volume'
		index 1
		value.0 70
		value.1 70
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 80'
			dbmin -7400
			dbmax 600
			dbvalue.0 -400
			dbvalue.1 -400
		}
	}
	control.12 {
		iface MIXER
		name 'Capture Switch'
		index 1
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.13 {
		iface MIXER
		name 'Capture Volume'
		index 2
		value.0 71
		value.1 71
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 80'
			dbmin -7400
			dbmax 600
			dbvalue.0 -300
			dbvalue.1 -300
		}
	}
	control.14 {
		iface MIXER
		name 'Capture Switch'
		index 2
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.15 {
		iface MIXER
		name 'Mic Boost Volume'
		value.0 4
		value.1 4
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 4'
			dbmin 0
			dbmax 4000
			dbvalue.0 4000
			dbvalue.1 4000
		}
	}
	control.16 {
		iface MIXER
		name 'Master Playback Volume'
		value 74
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 74'
			dbmin -7400
			dbmax 0
			dbvalue.0 0
		}
	}
	control.17 {
		iface MIXER
		name 'Master Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.18 {
		iface CARD
		name 'Mic Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.19 {
		iface CARD
		name 'Internal Mic Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.20 {
		iface CARD
		name 'Mic Jack'
		index 1
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.21 {
		iface CARD
		name 'Headphone Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.22 {
		iface CARD
		name 'Speaker Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.23 {
		iface MIXER
		name 'Beep Playback Volume'
		value 6
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 7'
			dbmin -2800
			dbmax 0
			dbvalue.0 -400
		}
	}
	control.24 {
		iface MIXER
		name 'Beep Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.25 {
		iface PCM
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
	control.26 {
		iface PCM
		name 'Capture Channel Map'
		value.0 0
		value.1 0
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
	control.27 {
		iface PCM
		device 2
		name 'Capture Channel Map'
		value.0 0
		value.1 0
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
	control.28 {
		iface PCM
		device 2
		name 'Capture Channel Map'
		index 1
		value.0 0
		value.1 0
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
	control.29 {
		iface MIXER
		name 'PCM Playback Volume'
		value.0 255
		value.1 255
		comment {
			access 'read write user'
			type INTEGER
			count 2
			range '0 - 255'
			tlv '0000000100000008ffffec1400000014'
			dbmin -5100
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
ums_realtek
usb_storage
fuse
ebtable_nat
nf_conntrack_netbios_ns
nf_conntrack_broadcast
ipt_MASQUERADE
bnep
bluetooth
ip6table_nat
nf_nat_ipv6
ip6table_mangle
ip6t_REJECT
nf_conntrack_ipv6
nf_defrag_ipv6
iptable_nat
nf_nat_ipv4
nf_nat
iptable_mangle
nf_conntrack_ipv4
nf_defrag_ipv4
xt_conntrack
nf_conntrack
ebtable_filter
ebtables
ip6table_filter
ip6_tables
acer_wmi
sparse_keymap
acpi_cpufreq
mperf
kvm_amd
arc4
kvm
ath9k
ath9k_common
ath9k_hw
snd_hda_codec_conexant
ath
snd_hda_codec_hdmi
mac80211
uvcvideo
videobuf2_vmalloc
videobuf2_memops
snd_hda_intel
videobuf2_core
videodev
media
snd_hda_codec
microcode
snd_hwdep
snd_seq
snd_seq_device
snd_pcm
cfg80211
k10temp
rfkill
atl1c
sp5100_tco
i2c_piix4
snd_page_alloc
snd_timer
snd
soundcore
uinput
dm_crypt
radeon
i2c_algo_bit
drm_kms_helper
ttm
drm
i2c_core
video
wmi


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x03 0x18560010

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:

/sys/class/sound/hwC0D0/hints:

/sys/class/sound/hwC1D0/init_pin_configs:
0x19 0x03211040
0x1a 0x03a1103e
0x1b 0x03a19030
0x1c 0x400001f0
0x1d 0x400001f0
0x1e 0x95a70120
0x1f 0x92170110
0x20 0x400001f0
0x22 0x400001f0
0x23 0x400001f0

/sys/class/sound/hwC1D0/driver_pin_configs:

/sys/class/sound/hwC1D0/user_pin_configs:

/sys/class/sound/hwC1D0/init_verbs:

/sys/class/sound/hwC1D0/hints:


!!ALSA/HDA dmesg
!!--------------

[    3.572674] [drm] Connector 1:
[    3.572678] [drm]   HDMI-A-1
[    3.572682] [drm]   HPD2
--
[   24.402852] Linux video capture interface: v2.00
[   24.431853] ALSA sound/pci/hda/hda_intel.c:3276 0000:00:01.1: Using LP=
IB position fix
[   24.431951] snd_hda_intel 0000:00:01.1: irq 41 for MSI/MSI-X
[   24.455441] ALSA sound/pci/hda/hda_intel.c:1763 0000:00:01.1: Enable s=
ync_write for stable communication
[   24.474915] uvcvideo: Found UVC 1.00 device WebCam (0402:7675)
--
[   24.488462] USB Video Class driver (1.1.1)
[   24.495250] input: HD-Audio Generic HDMI/DP,pcm=3D3 as /devices/pci000=
0:00/0000:00:01.1/sound/card0/input8
[   24.499313] ALSA sound/pci/hda/hda_intel.c:3276 0000:00:14.2: Using LP=
IB position fix
[   24.499797] snd_hda_intel 0000:00:14.2: setting latency timer to 64
[   24.509487] ALSA sound/pci/hda/hda_intel.c:1763 0000:00:14.2: Enable s=
ync_write for stable communication
[   24.548554] hda_codec: CX20588: BIOS auto-probing.
[   24.549081] ALSA sound/pci/hda/hda_auto_parser.c:393 autoconfig: line_=
outs=3D1 (0x1f/0x0/0x0/0x0/0x0) type:speaker
[   24.549095] ALSA sound/pci/hda/hda_auto_parser.c:397    speaker_outs=3D=
0 (0x0/0x0/0x0/0x0/0x0)
[   24.549103] ALSA sound/pci/hda/hda_auto_parser.c:401    hp_outs=3D1 (0=
x19/0x0/0x0/0x0/0x0)
[   24.549109] ALSA sound/pci/hda/hda_auto_parser.c:402    mono: mono_out=
=3D0x0
[   24.549114] ALSA sound/pci/hda/hda_auto_parser.c:406    inputs:
[   24.549122] ALSA sound/pci/hda/hda_auto_parser.c:410      Mic=3D0x1b
[   24.549128] ALSA sound/pci/hda/hda_auto_parser.c:410      Internal Mic=
=3D0x1e
[   24.549135] ALSA sound/pci/hda/hda_auto_parser.c:410      Mic=3D0x1a
[   24.584329] microcode: failed to load file amd-ucode/microcode_amd.bin
--
[   24.694482] ieee80211 phy0: Atheros AR9485 Rev:1 mem=3D0xf9580000, irq=
=3D19
[   24.696032] input: HDA ATI SB Headphone as /devices/pci0000:00/0000:00=
:14.2/sound/card1/input9
[   24.696344] input: HDA ATI SB Mic as /devices/pci0000:00/0000:00:14.2/=
sound/card1/input10
[   24.696613] input: HDA ATI SB Mic as /devices/pci0000:00/0000:00:14.2/=
sound/card1/input11
[   24.730978] acpi-cpufreq: overriding BIOS provided _PSD data
--
[  586.687907] PM: early resume of devices complete after 0.211 msecs
[  586.688763] snd_hda_intel 0000:00:01.1: irq 41 for MSI/MSI-X
[  586.690406] ath: phy0: ASPM enabled: 0x43




--------------010101080505010800050903
Content-Type: text/x-patch;
 name="mic-boost.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="mic-boost.patch"

--- analog-input-internal-mic.conf.org	2013-09-11 16:10:12.936214819 -0600
+++ analog-input-internal-mic.conf	2013-09-11 16:14:01.251544504 -0600
@@ -138,8 +138,17 @@
 volume = off
 
 [Element Mic Boost]
-switch = off
-volume = off
+required-any = any
+switch = select
+volume = merge
+override-map.1 = all
+override-map.2 = all-left,all-right
+
+[Option Mic Boost:on]
+name = input-boost-on
+
+[Option Mic Boost:off]
+name = input-boost-off
 
 [Element Dock Mic Boost]
 switch = off

--------------010101080505010800050903
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------010101080505010800050903--
