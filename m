From: "Stephen Warren" <SWarren@nvidia.com>
Subject: New azx driver: Problems in snd_mixer_load
Date: Thu, 9 Dec 2004 10:20:04 -0800
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B0033AE0D7@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from hqemgate00.nvidia.com (hqemgate00.nvidia.com [216.228.112.144])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1CA9230E
	for <alsa-devel@alsa-project.org>; Thu,  9 Dec 2004 19:20:28 +0100 (MET)
Content-class: urn:content-classes:message
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi.

Background: We have a custom 2.6.9 kernel, to which we've back-ported
the ALSA 1.0.7 drivers, and they're all compiled in as non-modules right
now. I've installed this kernel on a machine running FC2, plus installed
the 1.0.7 version of libasound and associated config files.

On top of this, I added the latest CVS version of the azx driver into
the kernel.

Now, when I run alsamixer, I get the following error message right at
startup:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
root@localhost# alsamixer
ALSA lib simple.c:950:(simple_add1) helem (MIXER,'Capture Source',0,0,0)
appears twice or more
alsamixer: function snd_mixer_load failed: Invalid argument
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

Does anyone have any ideas about this?

In particular, I'm a little confused about the role the files in
/usr/share/alsa play in the whole ALSA system. Do I need to import new
version of these files along with the udpated device driver?

Here's some system information:

Portions of lspci, and lspci -nv:

00:1b.0 Class 0403: Intel Corp. I/O Controller Hub Audio (rev 03)

00:1b.0 Class 0403: 8086:2668 (rev 03)
	Subsystem: 8086:2668
	Flags: bus master, fast devsel, latency 0, IRQ 16
	Memory at feb3c000 (64-bit, non-prefetchable)
	Capabilities: [50] Power Management version 2
	Capabilities: [60] Message Signalled Interrupts: 64bit+
Queue=3D0/0 Enable-
	Capabilities: [70] #10 [0091]

root@localhost# cd /proc/asound

root@localhost# cat cards
0 [HDA            ]: Azalia - ICH6 HDA
                     ICH6 HDA at 0xfeb3c000 irq 16

root@localhost# cd card0

root@localhost# cat codec#2
Codec: Generic 434d ID 4980
Address: 2
Vendor Id: 0x434d4980
Subsystem Id: 0x0
Revision Id: 0x90002
Default PCM: rates 0x540, bits 0x0e, types 0x1
Default Amp-In caps: N/A
Default Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, =
mute=3D1
Node 0x03 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals: 0x80 0x80
Node 0x04 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals: 0x80 0x80
Node 0x05 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals: 0x80 0x80
Node 0x06 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals: 0x80 0x80
Node 0x07 [Audio Output] wcaps 0x615: Stereo Digital Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals: 0x80 0x80
  PCM: rates 0x000, bits 0x00, types 0x5
Node 0x08 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x1e, stepsize=3D0x05, mute=3D1
  Amp-In vals: 0x80 0x80
  PCM: rates 0x160, bits 0x02, types 0x0
  Connection: 9
     0x0b 0x0c 0x0d 0x0e 0x0f 0x10 0x11 0x1f 0x20
Node 0x09 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x1e, stepsize=3D0x05, mute=3D1
  Amp-In vals: 0x80 0x80
  PCM: rates 0x160, bits 0x02, types 0x0
  Connection: 9
     0x0b 0x0c 0x0d 0x0e 0x0f 0x10 0x11 0x1f 0x20
Node 0x0a [Audio Input] wcaps 0x100791: Stereo Digital
  PCM: rates 0x160, bits 0x0e, types 0x0
  Connection: 1
     0x13
Node 0x0b [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x0833f:  IN
  OUT
  Pin Default 0x01014020: Line Out at Ext Rear
    Conn =3D 1/8, Color =3D Green
  Pin-ctls: 0xc0
  Connection: 1
     0x03
Node 0x0c [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x0833f:  IN
  OUT
  Pin Default 0x01813030: Line In at Ext Rear
    Conn =3D 1/8, Color =3D Blue
  Pin-ctls: 0x20
  Connection: 1
     0x04
Node 0x0d [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x0833f:  IN
  OUT
  Pin Default 0x01a19040: Mic at Ext Rear
    Conn =3D 1/8, Color =3D Pink
  Pin-ctls: 0x20
  Connection: 1
     0x05
Node 0x0e [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x081033f:  IN
  OUT
  Pin Default 0x01014021: Line Out at Ext Rear
    Conn =3D 1/8, Color =3D Green
  Pin-ctls: 0x20
  Connection: 1
     0x06
Node 0x0f [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x0833f:  IN
  OUT
  Pin Default 0x42214050: HP Out at Ext Front
    Conn =3D 1/8, Color =3D Green
  Pin-ctls: 0xc0
  Connection: 4
     0x03 0x04 0x05 0x06
Node 0x10 [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x0833f:  IN
  OUT
  Pin Default 0x42a19060: Mic at Ext Front
    Conn =3D 1/8, Color =3D Pink
  Pin-ctls: 0xc0
  Connection: 4
     0x03 0x04 0x05 0x06
Node 0x11 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0863:  IN
  Pin Default 0x9933f170: CD at Int ATAPI
    Conn =3D ATAPI, Color =3D Other
  Pin-ctls: 0x00
Node 0x12 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810:  OUT
  Pin Default 0x01450000: SPDIF Out at Ext Rear
    Conn =3D Optical, Color =3D Unknown
  Pin-ctls: 0x40
  Connection: 1
     0x07
Node 0x13 [Pin Complex] wcaps 0x400281: Stereo Digital
  Pincap 0x0830:  IN
  OUT
  Pin Default 0x01c50000: SPDIF In at Ext Rear
    Conn =3D Optical, Color =3D Unknown
  Pin-ctls: 0x00
Node 0x14 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x15 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x16 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x17 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x18 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x19 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1a [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1b [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1c [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1d [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1e [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1f [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0833f:  IN
  OUT
  Pin Default 0x01019022: Line Out at Ext Rear
    Conn =3D 1/8, Color =3D Pink
  Pin-ctls: 0xc0
  Connection: 4
     0x03 0x04 0x05 0x06
Node 0x20 [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0833f:  IN
  OUT
  Pin Default 0x01013023: Line Out at Ext Rear
    Conn =3D 1/8, Color =3D Blue
  Pin-ctls: 0xc0
  Connection: 4
     0x03 0x04 0x05 0x06
Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x22 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x23 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=3D0x0f, nsteps=3D0x0f, stepsize=3D0x0b, mute=3D1
  Amp-Out vals: 0x0f

--=20
Stephen Warren, Software Engineer, NVIDIA, Fort Collins, CO
swarren@nvidia.com        http://www.nvidia.com/
swarren@wwwdotorg.org     http://www.wwwdotorg.org/pgp.html


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
