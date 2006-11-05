From: =?ISO-8859-1?Q?St=E9phane_Graber?= <stgraber@sgserv.net>
Subject: Toshiba A100-193 (hda)
Date: Sun, 05 Nov 2006 10:59:37 +0100
Message-ID: <454DB609.8030107@sgserv.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030301050909010302000800"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030301050909010302000800
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,
That's some weeks I try to make my microphone input to work correctly
with this laptop, I tried nearly all the model available in the 1.0.13
version and all the tips I found on the internet (pci=3Drouteirq,
acpi=3Doff), and I still have my problem.

When I use my microphone, I can use it with the programs using ALSA
during maximum 15minutes (my personal record), after it start in
something like a sound loop (repeating the last second of sound) and I
just have to kill my X server, unload the snd-hda-intel and reload it.

When I use it with an OSS program (like TeamSpeak), it works during the
same time but I also have a really annoying background noise (like a fan
noise).

Now, what I get from my syslog :
hda_codec: Unknown model for ALC861, trying auto-probe from BIOS...
hda-intel: Invalid position buffer, using LPIB read method instead.

The first one came when loading the driver and doesn't disappear with
any of the model I tried, the second one came after some minutes and
disappear if I put a position_fix=3D1

The model I tried that works during the longer amount of time is :
model=3Dlaptop-eapd position_fix=3D1
I was able to use skype when listening to an mp3 during 15minutes.

I also have some ACPI error message, but I tried without ACPI and that
doesn't work better.
ACPI Error (evevent-0314): No installed handler for fixed event
[00000000] [20060707]
ACPI Error (evxfevnt-0386): Could not disable RealTimeClock events
[20060707]
ACPI Error (evevent-0314): No installed handler for fixed event
[00000000] [20060707]


My soundcard :
00:14.2 Audio device: ATI Technologies Inc Unknown device 437b (rev 01)
00:14.2 0403: 1002:437b (rev 01)

I attached the codec#0 and #3 files.

Tell me if you need any other information.

Thank you for your great job

St=E9phane Graber




--------------030301050909010302000800
Content-Type: text/plain;
 name="codec0"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="codec0"

Codec: Generic 11c1 Si3054
Address: 0
Vendor Id: 0x11c13026
Subsystem Id: 0x11790001
Revision Id: 0x100700




--------------030301050909010302000800
Content-Type: text/plain;
 name="codec3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="codec3"

Codec: Realtek ALC861
Address: 3
Vendor Id: 0x10ec0861
Subsystem Id: 0x1179ff10
Revision Id: 0x100300
Default PCM: rates 0x140, bits 0x0e, types 0x1
Default Amp-In caps: N/A
Default Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Node 0x03 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x00 0x00]
  Power: 0x0
Node 0x04 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x80 0x80]
  Power: 0x0
Node 0x05 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x80 0x80]
  Power: 0x0
Node 0x06 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x80 0x80]
  Power: 0x0
Node 0x07 [Audio Output] wcaps 0x605: Stereo Digital Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x00 0x00]
  Power: 0x0
Node 0x08 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=0x02, nsteps=0x0d, stepsize=0x0b, mute=1
  Amp-In vals:  [0x0d 0x0d] [0x0d 0x0d] [0x0d 0x0d] [0x0d 0x0d] [0x0d 0x0d] [0x0d 0x0d]
  PCM: rates 0x140, bits 0x02, types 0x1
  Power: 0x0
  Connection: 6
     0x0d* 0x0c 0x0f 0x10 0x11 0x15
Node 0x09 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0a [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0b [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x081f: OUT HP Detect
  Pin Default 0x01014110: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Green
  Pin-ctls: 0x40: OUT
  Power: 0x0
  Connection: 1
     0x16
Node 0x0c [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x0837: IN OUT Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x20: IN
  Power: 0x0
  Connection: 1
     0x19
Node 0x0d [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x08337: IN OUT Detect
  Pin Default 0x01a19921: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x24: IN
  Power: 0x0
  Connection: 1
     0x18
Node 0x0e [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x0817: OUT Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x40: OUT
  Power: 0x0
  Connection: 1
     0x19
Node 0x0f [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x0833f: IN OUT HP Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x40: OUT
  Power: 0x0
  Connection: 1
     0x1a
Node 0x10 [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x0833f: IN OUT HP Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x20: IN
  Power: 0x0
  Connection: 1
     0x1b
Node 0x11 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0863: IN
  Pin Default 0xb7331120: [Fixed] CD at Oth Mobile-In
    Conn = ATAPI, Color = Black
  Pin-ctls: 0x00:
Node 0x12 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x07
Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x14 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Connection: 2
     0x0d 0x10
Node 0x15 [Audio Mixer] wcaps 0x20050f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x0c, nsteps=0x17, stepsize=0x0b, mute=1
  Amp-In vals:  [0x17 0x17] [0x80 0x80] [0x00 0x00]
  Amp-Out caps: ofs=0x0c, nsteps=0x0c, stepsize=0x0b, mute=1
  Amp-Out vals:  [0x0c 0x0c]
  Power: 0x0
  Connection: 3
     0x11 0x14 0x1c
Node 0x16 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Connection: 2
     0x03 0x15
Node 0x17 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Connection: 2
     0x04 0x15
Node 0x18 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Connection: 2
     0x05 0x15
Node 0x19 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Connection: 2
     0x06 0x15
Node 0x1a [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x00 0x00] [0x00 0x00]
  Connection: 4
     0x04 0x06 0x15 0x03
Node 0x1b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x00 0x00] [0x00 0x00]
  Connection: 4
     0x04 0x06 0x15 0x03
Node 0x1c [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Connection: 2
     0x0c 0x0f
Node 0x1d [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1e [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1f [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x0817: OUT Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x40: OUT
  Power: 0x0
  Connection: 1
     0x18
Node 0x20 [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x0817: OUT Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x40: OUT
  Power: 0x0
  Connection: 1
     0x17
Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x22 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x23 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x0f, nsteps=0x0f, stepsize=0x0b, mute=1
  Amp-Out vals:  [0x8f]




--------------030301050909010302000800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------030301050909010302000800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------030301050909010302000800--
