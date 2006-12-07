From: "Allyn, Mark A" <mark.a.allyn@intel.com>
Subject: Re: Samsung Audio Problem (update)
Date: Thu, 7 Dec 2006 15:52:51 -0800
Message-ID: <5FD5754DDBA0B1499B5A0B4BB54194852FFED5@fmsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C71A5A.CEEE9383"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 076F4192
	for <alsa-devel@alsa-project.org>; Fri,  8 Dec 2006 00:52:55 +0100 (MET)
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Tobin Davis <tdavis@dsl-only.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C71A5A.CEEE9383
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Tobin:
=20
Here are the dmesg outputs and codec outputs as well.
=20
I did notice a slide for 'internal', but I could not activate the
capture for that slider.
=20
Mark

________________________________

From: Tobin Davis [mailto:tdavis@dsl-only.net]=20
Sent: Thursday, December 07, 2006 3:24 PM
To: Allyn, Mark A
Cc: alsa-devel@alsa-project.org
Subject: RE: [Alsa-devel] Samsung Audio Problem (update)


Could you send the new dmesg output as well as the output from cat
/proc/asound/card0/codec#0?  I'm assuming you compiled the driver with
"--with-debug=3Ddetect"?  I need to see what the driver reports after
loading.

Thanks,

Tobin

On Thu, 2006-12-07 at 14:03 -0800, Allyn, Mark A wrote:=20

	Tobin:
	=20
	I did apply the patch as you suggest. The dmesg from the
modprobe of the
	snd-hda-intel does show=20
	the ultra (Samsung) loading. However, there is still no
recording. I set
	all of the sliders on=20
	100 percent and I made sure that the capture is on both mike and
	capture. Audio playback of=20
	existing audio files is okay.
	=20
	Mark
=09
	________________________________
=09
	From: Tobin Davis [mailto:tdavis@dsl-only.net]=20
	Sent: Wednesday, December 06, 2006 3:31 PM
	To: Allyn, Mark A
	Cc: alsa-devel@lists.sourceforge.net
	Subject: RE: [Alsa-devel] Samsung Audio Problem (update)
=09
=09
	Mark,
	After looking through the documentation and the Windows regestry
	settings for that system's driver, I found some interesting
differences
	to the microphone selector.
=09
	Try this patch against the alsa-driver-hg20061130 snapshot
=09
(ftp://ftp.suse.com/pub/projects/alsa/snapshot/driver/alsa-driver-hg2006
	1129.tar.bz2).
=09
	To apply:
	tar -jxvf alsa-driver-hg20061130.tar.bz2
	cd alsa-driver-hg20061130/alsa-kernel
	patch -p1 <SamsungQ1.patch
	cd ..
	./configure --with-cards=3Dhda-intel --with-debug=3Ddetect ; make ;
make
	install
=09
	Let me know if this fixes your microphone.  I also added the
subdevice
	id so you shouldn't need to add any model parameters.
=09
	Tobin
=09
	On Tue, 2006-12-05 at 10:46 -0800, Allyn, Mark A wrote:=20
=09
		Tobin:
	=09
		Here is the result of the debug=3Ddetect & codec#0:
	=09
		=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
	=09
		[17179640.512000] PCI: Setting latency timer of device
	0000:00:1b.0 to
		64
		[17179640.544000] ALSA
=09
/mnt1/src/asianux/BUILD/alsa-driver-hg20061130/pci/hda/../..
=09
/alsa-kernel/pci/hda/hda_intel.c:696:
	codec_mask
		=3D 0x1
		[17179640.740000] ALSA
	=09
=09
/mnt1/src/asianux/BUILD/alsa-driver-hg20061130/pci/hda/hda_codec.c:1743:
	=09
		                       hda_codec: model 'laptop-eapd' is
	selected
	=09
	=09
=09
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
		output of codec#0
		Codec: Analog Devices AD1986A
		Address: 0
		Vendor Id: 0x11d41986
		Subsystem Id: 0x144dc027
		Revision Id: 0x100500
		Default PCM:
		    rates [0x7f]: 8000 11025 16000 22050 32000 44100
48000
		    bits [0xe]: 16 20 24
		    formats [0x1]: PCM
		Default Amp-In caps: ofs=3D0x00, nsteps=3D0x00,
stepsize=3D0x00,
	mute=3D1
		Default Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f,
stepsize=3D0x05,
	mute=3D1
		Node 0x02 [Audio Output] wcaps 0x30311: Stereo Digital
		  PCM:
		    rates [0x60]: 44100 48000
		    bits [0x2]: 16
		    formats [0x5]: PCM AC3
		  Connection: 2
		     0x01* 0x06
		Node 0x03 [Audio Output] wcaps 0x44d: Stereo Amp-Out
		  Amp-Out caps: ofs=3D0x17, nsteps=3D0x1f, stepsize=3D0x05,
mute=3D1
		  Amp-Out vals:  [0x80 0x80]
		  Power: 0x0
		Node 0x04 [Audio Output] wcaps 0x40d: Stereo Amp-Out
		  Amp-Out caps: ofs=3D0x17, nsteps=3D0x1f, stepsize=3D0x05,
mute=3D1
		  Amp-Out vals:  [0x80 0x80]
		  Power: 0x0
		Node 0x05 [Audio Output] wcaps 0x40d: Stereo Amp-Out
		  Amp-Out caps: ofs=3D0x17, nsteps=3D0x1f, stepsize=3D0x05,
mute=3D1
		  Amp-Out vals:  [0x80 0x80]
		  Power: 0x0
		Node 0x06 [Audio Input] wcaps 0x100511: Stereo
		  PCM:
		    rates [0x7f]: 8000 11025 16000 22050 32000 44100
48000
		    bits [0x6]: 16 20
		    formats [0x1]: PCM
		  Power: 0x0
		  Connection: 1
		     0x12
		Node 0x07 [Audio Mixer] wcaps 0x200101: Stereo
		  Connection: 8
		     0x03 0x09 0x13 0x14 0x15 0x16 0x17 0x18
		Node 0x08 [Audio Mixer] wcaps 0x200100: Mono
		  Connection: 1
		     0x07
		Node 0x09 [Audio Mixer] wcaps 0x20010e: Mono Amp-In
Amp-Out
		  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00,
mute=3D1
		  Amp-In vals:  [0x80] [0x80]
		  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00,
mute=3D1
		  Amp-Out vals:  [0x80]
		  Connection: 2
		     0x04 0x05
		Node 0x0a [Audio Selector] wcaps 0x300101: Stereo
		  Connection: 3
		     0x07* 0x04 0x05
		Node 0x0b [Audio Selector] wcaps 0x300101: Stereo
		  Connection: 2
		     0x07* 0x04
		Node 0x0c [Audio Selector] wcaps 0x300101: Stereo
		  Connection: 2
		     0x04* 0x07
		Node 0x0d [Audio Selector] wcaps 0x300101: Stereo
		  Connection: 2
		     0x05* 0x08
		Node 0x0e [Audio Selector] wcaps 0x300100: Mono
		  Connection: 2
		     0x08* 0x11
		Node 0x0f [Audio Selector] wcaps 0x30010d: Stereo
Amp-Out
		  Amp-Out caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27,
mute=3D0
		  Amp-Out vals:  [0x00 0x00]
		  Connection: 8
		     0x1f* 0x20 0x1d 0x1d 0x27 0x28 0x29 0x2a
		Node 0x10 [Audio Selector] wcaps 0x300101: Stereo
		  Connection: 3
		     0x20* 0x1c 0x1f
		Node 0x11 [Audio Selector] wcaps 0x300941: Stereo
		  Connection: 2
		     0x0f* 0x2b
		Node 0x12 [Audio Selector] wcaps 0x30010d: Stereo
Amp-Out
		  Amp-Out caps: ofs=3D0x00, nsteps=3D0x0f, stepsize=3D0x05,
mute=3D1
		  Amp-Out vals:  [0x80 0x80]
		  Connection: 8
		     0x11* 0x22 0x00 0x21 0x10 0x07 0x08 0x23
		Node 0x13 [Audio Selector] wcaps 0x30010d: Stereo
Amp-Out
		  Amp-Out caps: ofs=3D0x17, nsteps=3D0x1f, stepsize=3D0x05,
mute=3D1
		  Amp-Out vals:  [0x80 0x80]
		  Connection: 1
		     0x11
		Node 0x14 [Audio Selector] wcaps 0x30010c: Mono Amp-Out
		  Amp-Out caps: ofs=3D0x17, nsteps=3D0x1f, stepsize=3D0x05,
mute=3D1
		  Amp-Out vals:  [0x80]
		  Connection: 1
		     0x23
		Node 0x15 [Audio Selector] wcaps 0x30010d: Stereo
Amp-Out
		  Amp-Out caps: ofs=3D0x17, nsteps=3D0x1f, stepsize=3D0x05,
mute=3D1
		  Amp-Out vals:  [0x80 0x80]
		  Connection: 1
		     0x22
		Node 0x16 [Audio Selector] wcaps 0x30010d: Stereo
Amp-Out
		  Amp-Out caps: ofs=3D0x17, nsteps=3D0x1f, stepsize=3D0x05,
mute=3D1
		  Amp-Out vals:  [0x80 0x80]
		  Connection: 1
		     0x21
		Node 0x17 [Audio Selector] wcaps 0x30010d: Stereo
Amp-Out
		  Amp-Out caps: ofs=3D0x17, nsteps=3D0x1f, stepsize=3D0x05,
mute=3D1
		  Amp-Out vals:  [0x80 0x80]
		  Connection: 1
		     0x10
		Node 0x18 [Audio Selector] wcaps 0x30010c: Mono Amp-Out
		  Amp-Out caps: ofs=3D0x0f, nsteps=3D0x0f, stepsize=3D0x0b,
mute=3D1
		  Amp-Out vals:  [0x8f]
		  Connection: 2
		     0x19* 0x24
		Node 0x19 [Beep Generator Widget] wcaps 0x700000: Mono
		Node 0x1a [Pin Complex] wcaps 0x400185: Stereo Amp-Out
		  Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05,
mute=3D1
		  Amp-Out vals:  [0x80 0x80]
		  Pincap 0x081f: OUT HP Detect
		  Pin Default 0x02214021: [Jack] HP Out at Ext Front
		    Conn =3D 1/8, Color =3D Green
		  Pin-ctls: 0xc0: OUT HP
		  Connection: 1
		     0x0a
		Node 0x1b [Pin Complex] wcaps 0x400185: Stereo Amp-Out
		  Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05,
mute=3D1
		  Amp-Out vals:  [0x80 0x80]
		  Pincap 0x081001f: OUT HP EAPD Detect
		  Pin Default 0x01014011: [Jack] Line Out at Ext Rear
		    Conn =3D 1/8, Color =3D Green
		  Pin-ctls: 0x40: OUT
		  Connection: 1
		     0x0b
		Node 0x1c [Pin Complex] wcaps 0x400185: Stereo Amp-Out
		  Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05,
mute=3D1
		  Amp-Out vals:  [0x80 0x80]
		  Pincap 0x0837: IN OUT Detect
		  Pin Default 0x41013012: [N/A] Line Out at Ext Rear
		    Conn =3D 1/8, Color =3D Blue
		  Pin-ctls: 0x40: OUT
		  Connection: 1
		     0x0c
		Node 0x1d [Pin Complex] wcaps 0x400985: Stereo Amp-Out
		  Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05,
mute=3D1
		  Amp-Out vals:  [0x80 0x80]
		  Pincap 0x081737: IN OUT Detect
		  Pin Default 0x01019015: [Jack] Line Out at Ext Rear
		    Conn =3D 1/8, Color =3D Pink
		  Pin-ctls: 0x40: OUT
		  Connection: 1
		     0x0d
		Node 0x1e [Pin Complex] wcaps 0x400104: Mono Amp-Out
		  Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05,
mute=3D1
		  Amp-Out vals:  [0x80]
		  Pincap 0x0810: OUT
		  Pin Default 0x511710f0: [N/A] Speaker at Int Rear
		    Conn =3D Analog, Color =3D Black
		  Pin-ctls: 0x40: OUT
		  Connection: 1
		     0x0e
		Node 0x1f [Pin Complex] wcaps 0x400081: Stereo
		  Pincap 0x081727: IN Detect
		  Pin Default 0x02a190f0: [Jack] Mic at Ext Front
		    Conn =3D 1/8, Color =3D Pink
		  Pin-ctls: 0x24: IN
		Node 0x20 [Pin Complex] wcaps 0x400081: Stereo
		  Pincap 0x081727: IN Detect
		  Pin Default 0x418130f0: [N/A] Line In at Ext Rear
		    Conn =3D 1/8, Color =3D Blue
		  Pin-ctls: 0x20: IN
		Node 0x21 [Pin Complex] wcaps 0x400081: Stereo
		  Pincap 0x0827: IN Detect
		  Pin Default 0x5997e0f0: [N/A] Aux at Int ATAPI
		    Conn =3D Analog, Color =3D White
		  Pin-ctls: 0x20: IN
		Node 0x22 [Pin Complex] wcaps 0x400001: Stereo
		  Pincap 0x0820: IN
		  Pin Default 0x593310f0: [N/A] CD at Int ATAPI
		    Conn =3D ATAPI, Color =3D Black
		  Pin-ctls: 0x20: IN
		Node 0x23 [Pin Complex] wcaps 0x400000: Mono
		  Pincap 0x0820: IN
		  Pin Default 0x59b770f0: [N/A] Telephony at Int ATAPI
		    Conn =3D Analog, Color =3D Yellow
		  Pin-ctls: 0x20: IN
		Node 0x24 [Pin Complex] wcaps 0x400000: Mono
		  Pincap 0x0820: IN
		  Pin Default 0x51f710f0: [N/A] Other at Int Rear
		    Conn =3D Analog, Color =3D Black
		  Pin-ctls: 0x20: IN
		Node 0x25 [Pin Complex] wcaps 0x400301: Stereo Digital
		  Pincap 0x0810: OUT
		  Pin Default 0x4145f0f0: [N/A] SPDIF Out at Ext Rear
		    Conn =3D Optical, Color =3D Other
		  Pin-ctls: 0x40: OUT
		  Connection: 1
		     0x02
		Node 0x26 [Power Widget] wcaps 0x500500: Mono
		  Power: 0x0
		  Connection: 8
		     0x07* 0x08 0x13 0x14 0x15 0x16 0x17 0x18
		Node 0x27 [Audio Mixer] wcaps 0x200101: Stereo
		  Connection: 2
		     0x1f 0x1d
		Node 0x28 [Audio Mixer] wcaps 0x200101: Stereo
		  Connection: 2
		     0x1f 0x20
		Node 0x29 [Audio Mixer] wcaps 0x200101: Stereo
		  Connection: 2
		     0x1d 0x20
		Node 0x2a [Audio Mixer] wcaps 0x200101: Stereo
		  Connection: 3
		     0x1f 0x1d 0x20
		Node 0x2b [Audio Mixer] wcaps 0x200100: Mono
		  Connection: 1
		     0x0f
	=09
		=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=20
	=09
		________________________________
	=09
		From: Tobin Davis [mailto:tdavis@dsl-only.net]=20
		Sent: Tuesday, December 05, 2006 7:26 AM
		To: Allyn, Mark A
		Cc: alsa-devel@lists.sourceforge.net
		Subject: Re: [Alsa-devel] Samsung Audio Problem (update)
	=09
	=09
		Could you send a couple of things to the mailing list?
	Specifically,
		recompile the driver with "--with-debug=3Ddetect",
reinstall it,
	and send
		the output from dmesg after installing the driver.
Also, send
	the
		output from 'cat /proc/asound/card0/codec*'.
	=09
		I have a laptop (Asus Z62F) with the exact same codec,
and I
	had to do
		some fiddling with the alsamixer controls before I could
use
	either the
		internal mic or the external mic.  You might also check
that.
	The mic
		gain is listed as an output for some reason (it's been
marked as
	"fixme"
		in the code for quite some time).
	=09
		Tobin
	=09
		On Mon, 2006-12-04 at 13:43 -0800, Allyn, Mark A wrote:=20
	=09
			Hello:
			=20
			With thanks to Tobin Davis, I was able to
resolve part
	of my
		problem.
		=09
			With using the latest snapshot of the alsa
driver as
	well as
		adding
		=09
			options snd-hda-intel model=3Dlaptop-eapd
		=09
			to the /etc/modprobe.conf file, I was able to
get rid of
	the
		high
			pitched
			squeal and have proper audio playback on the
internal
	speakers.
		=09
			I am still unable to record. For your benefit, I
do have
	some
		more
			Information on the audio device. From the lspci
-qn, I
	got:
		=09
			Class: 0403
			8086:2668	rev03
			Subsystem: 144D:C027
		=09
			Has anyone got audio recording working on this
codec and
		subsystem?
		=09
			Thank you
		=09
			Mark Allyn
		=09
		=09
	=09
=09
------------------------------------------------------------------------
		-
			Take Surveys. Earn Cash. Influence the Future of
IT
			Join SourceForge.net's Techsay panel and you'll
get the
	chance
		to share your
			opinions on IT & business topics through brief
surveys -
	and
		earn cash
		=09
	=09
=09
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDE
		V
			_______________________________________________
			Alsa-devel mailing list
			Alsa-devel@lists.sourceforge.net
=09
https://lists.sourceforge.net/lists/listinfo/alsa-devel
		=09
	=09
	=09
=09
=09

--=20
Tobin Davis <tdavis@dsl-only.net> =09

------_=_NextPart_001_01C71A5A.CEEE9383
Content-Type: application/octet-stream;
	name="codec"
Content-Transfer-Encoding: base64
Content-Description: codec
Content-Disposition: attachment;
	filename="codec"

Q29kZWM6IEFuYWxvZyBEZXZpY2VzIEFEMTk4NkEKQWRkcmVzczogMApWZW5kb3IgSWQ6IDB4MTFk
NDE5ODYKU3Vic3lzdGVtIElkOiAweDE0NGRjMDI3ClJldmlzaW9uIElkOiAweDEwMDUwMApEZWZh
dWx0IFBDTToKICAgIHJhdGVzIFsweDdmXTogODAwMCAxMTAyNSAxNjAwMCAyMjA1MCAzMjAwMCA0
NDEwMCA0ODAwMAogICAgYml0cyBbMHhlXTogMTYgMjAgMjQKICAgIGZvcm1hdHMgWzB4MV06IFBD
TQpEZWZhdWx0IEFtcC1JbiBjYXBzOiBvZnM9MHgwMCwgbnN0ZXBzPTB4MDAsIHN0ZXBzaXplPTB4
MDAsIG11dGU9MQpEZWZhdWx0IEFtcC1PdXQgY2Fwczogb2ZzPTB4MWYsIG5zdGVwcz0weDFmLCBz
dGVwc2l6ZT0weDA1LCBtdXRlPTEKTm9kZSAweDAyIFtBdWRpbyBPdXRwdXRdIHdjYXBzIDB4MzAz
MTE6IFN0ZXJlbyBEaWdpdGFsCiAgUENNOgogICAgcmF0ZXMgWzB4NjBdOiA0NDEwMCA0ODAwMAog
ICAgYml0cyBbMHgyXTogMTYKICAgIGZvcm1hdHMgWzB4NV06IFBDTSBBQzMKICBDb25uZWN0aW9u
OiAyCiAgICAgMHgwMSogMHgwNgpOb2RlIDB4MDMgW0F1ZGlvIE91dHB1dF0gd2NhcHMgMHg0NGQ6
IFN0ZXJlbyBBbXAtT3V0CiAgQW1wLU91dCBjYXBzOiBvZnM9MHgxNywgbnN0ZXBzPTB4MWYsIHN0
ZXBzaXplPTB4MDUsIG11dGU9MQogIEFtcC1PdXQgdmFsczogIFsweDE4IDB4MThdCiAgUG93ZXI6
IDB4MApOb2RlIDB4MDQgW0F1ZGlvIE91dHB1dF0gd2NhcHMgMHg0MGQ6IFN0ZXJlbyBBbXAtT3V0
CiAgQW1wLU91dCBjYXBzOiBvZnM9MHgxNywgbnN0ZXBzPTB4MWYsIHN0ZXBzaXplPTB4MDUsIG11
dGU9MQogIEFtcC1PdXQgdmFsczogIFsweDgwIDB4ODBdCiAgUG93ZXI6IDB4MApOb2RlIDB4MDUg
W0F1ZGlvIE91dHB1dF0gd2NhcHMgMHg0MGQ6IFN0ZXJlbyBBbXAtT3V0CiAgQW1wLU91dCBjYXBz
OiBvZnM9MHgxNywgbnN0ZXBzPTB4MWYsIHN0ZXBzaXplPTB4MDUsIG11dGU9MQogIEFtcC1PdXQg
dmFsczogIFsweDgwIDB4ODBdCiAgUG93ZXI6IDB4MApOb2RlIDB4MDYgW0F1ZGlvIElucHV0XSB3
Y2FwcyAweDEwMDUxMTogU3RlcmVvCiAgUENNOgogICAgcmF0ZXMgWzB4N2ZdOiA4MDAwIDExMDI1
IDE2MDAwIDIyMDUwIDMyMDAwIDQ0MTAwIDQ4MDAwCiAgICBiaXRzIFsweDZdOiAxNiAyMAogICAg
Zm9ybWF0cyBbMHgxXTogUENNCiAgUG93ZXI6IDB4MAogIENvbm5lY3Rpb246IDEKICAgICAweDEy
Ck5vZGUgMHgwNyBbQXVkaW8gTWl4ZXJdIHdjYXBzIDB4MjAwMTAxOiBTdGVyZW8KICBDb25uZWN0
aW9uOiA4CiAgICAgMHgwMyAweDA5IDB4MTMgMHgxNCAweDE1IDB4MTYgMHgxNyAweDE4Ck5vZGUg
MHgwOCBbQXVkaW8gTWl4ZXJdIHdjYXBzIDB4MjAwMTAwOiBNb25vCiAgQ29ubmVjdGlvbjogMQog
ICAgIDB4MDcKTm9kZSAweDA5IFtBdWRpbyBNaXhlcl0gd2NhcHMgMHgyMDAxMGU6IE1vbm8gQW1w
LUluIEFtcC1PdXQKICBBbXAtSW4gY2Fwczogb2ZzPTB4MDAsIG5zdGVwcz0weDAwLCBzdGVwc2l6
ZT0weDAwLCBtdXRlPTEKICBBbXAtSW4gdmFsczogIFsweDgwXSBbMHg4MF0KICBBbXAtT3V0IGNh
cHM6IG9mcz0weDAwLCBuc3RlcHM9MHgwMCwgc3RlcHNpemU9MHgwMCwgbXV0ZT0xCiAgQW1wLU91
dCB2YWxzOiAgWzB4ODBdCiAgQ29ubmVjdGlvbjogMgogICAgIDB4MDQgMHgwNQpOb2RlIDB4MGEg
W0F1ZGlvIFNlbGVjdG9yXSB3Y2FwcyAweDMwMDEwMTogU3RlcmVvCiAgQ29ubmVjdGlvbjogMwog
ICAgIDB4MDcqIDB4MDQgMHgwNQpOb2RlIDB4MGIgW0F1ZGlvIFNlbGVjdG9yXSB3Y2FwcyAweDMw
MDEwMTogU3RlcmVvCiAgQ29ubmVjdGlvbjogMgogICAgIDB4MDcqIDB4MDQKTm9kZSAweDBjIFtB
dWRpbyBTZWxlY3Rvcl0gd2NhcHMgMHgzMDAxMDE6IFN0ZXJlbwogIENvbm5lY3Rpb246IDIKICAg
ICAweDA0KiAweDA3Ck5vZGUgMHgwZCBbQXVkaW8gU2VsZWN0b3JdIHdjYXBzIDB4MzAwMTAxOiBT
dGVyZW8KICBDb25uZWN0aW9uOiAyCiAgICAgMHgwNSogMHgwOApOb2RlIDB4MGUgW0F1ZGlvIFNl
bGVjdG9yXSB3Y2FwcyAweDMwMDEwMDogTW9ubwogIENvbm5lY3Rpb246IDIKICAgICAweDA4KiAw
eDExCk5vZGUgMHgwZiBbQXVkaW8gU2VsZWN0b3JdIHdjYXBzIDB4MzAwMTBkOiBTdGVyZW8gQW1w
LU91dAogIEFtcC1PdXQgY2Fwczogb2ZzPTB4MDAsIG5zdGVwcz0weDAzLCBzdGVwc2l6ZT0weDI3
LCBtdXRlPTAKICBBbXAtT3V0IHZhbHM6ICBbMHgwMCAweDAwXQogIENvbm5lY3Rpb246IDgKICAg
ICAweDFmKiAweDIwIDB4MWQgMHgxZCAweDI3IDB4MjggMHgyOSAweDJhCk5vZGUgMHgxMCBbQXVk
aW8gU2VsZWN0b3JdIHdjYXBzIDB4MzAwMTAxOiBTdGVyZW8KICBDb25uZWN0aW9uOiAzCiAgICAg
MHgyMCogMHgxYyAweDFmCk5vZGUgMHgxMSBbQXVkaW8gU2VsZWN0b3JdIHdjYXBzIDB4MzAwOTQx
OiBTdGVyZW8KICBDb25uZWN0aW9uOiAyCiAgICAgMHgwZiogMHgyYgpOb2RlIDB4MTIgW0F1ZGlv
IFNlbGVjdG9yXSB3Y2FwcyAweDMwMDEwZDogU3RlcmVvIEFtcC1PdXQKICBBbXAtT3V0IGNhcHM6
IG9mcz0weDAwLCBuc3RlcHM9MHgwZiwgc3RlcHNpemU9MHgwNSwgbXV0ZT0xCiAgQW1wLU91dCB2
YWxzOiAgWzB4MGYgMHgwZl0KICBDb25uZWN0aW9uOiA4CiAgICAgMHgxMSogMHgyMiAweDAwIDB4
MjEgMHgxMCAweDA3IDB4MDggMHgyMwpOb2RlIDB4MTMgW0F1ZGlvIFNlbGVjdG9yXSB3Y2FwcyAw
eDMwMDEwZDogU3RlcmVvIEFtcC1PdXQKICBBbXAtT3V0IGNhcHM6IG9mcz0weDE3LCBuc3RlcHM9
MHgxZiwgc3RlcHNpemU9MHgwNSwgbXV0ZT0xCiAgQW1wLU91dCB2YWxzOiAgWzB4MWYgMHgxZl0K
ICBDb25uZWN0aW9uOiAxCiAgICAgMHgxMQpOb2RlIDB4MTQgW0F1ZGlvIFNlbGVjdG9yXSB3Y2Fw
cyAweDMwMDEwYzogTW9ubyBBbXAtT3V0CiAgQW1wLU91dCBjYXBzOiBvZnM9MHgxNywgbnN0ZXBz
PTB4MWYsIHN0ZXBzaXplPTB4MDUsIG11dGU9MQogIEFtcC1PdXQgdmFsczogIFsweDgwXQogIENv
bm5lY3Rpb246IDEKICAgICAweDIzCk5vZGUgMHgxNSBbQXVkaW8gU2VsZWN0b3JdIHdjYXBzIDB4
MzAwMTBkOiBTdGVyZW8gQW1wLU91dAogIEFtcC1PdXQgY2Fwczogb2ZzPTB4MTcsIG5zdGVwcz0w
eDFmLCBzdGVwc2l6ZT0weDA1LCBtdXRlPTEKICBBbXAtT3V0IHZhbHM6ICBbMHg4MCAweDgwXQog
IENvbm5lY3Rpb246IDEKICAgICAweDIyCk5vZGUgMHgxNiBbQXVkaW8gU2VsZWN0b3JdIHdjYXBz
IDB4MzAwMTBkOiBTdGVyZW8gQW1wLU91dAogIEFtcC1PdXQgY2Fwczogb2ZzPTB4MTcsIG5zdGVw
cz0weDFmLCBzdGVwc2l6ZT0weDA1LCBtdXRlPTEKICBBbXAtT3V0IHZhbHM6ICBbMHg4MCAweDgw
XQogIENvbm5lY3Rpb246IDEKICAgICAweDIxCk5vZGUgMHgxNyBbQXVkaW8gU2VsZWN0b3JdIHdj
YXBzIDB4MzAwMTBkOiBTdGVyZW8gQW1wLU91dAogIEFtcC1PdXQgY2Fwczogb2ZzPTB4MTcsIG5z
dGVwcz0weDFmLCBzdGVwc2l6ZT0weDA1LCBtdXRlPTEKICBBbXAtT3V0IHZhbHM6ICBbMHgxZCAw
eDFkXQogIENvbm5lY3Rpb246IDEKICAgICAweDEwCk5vZGUgMHgxOCBbQXVkaW8gU2VsZWN0b3Jd
IHdjYXBzIDB4MzAwMTBjOiBNb25vIEFtcC1PdXQKICBBbXAtT3V0IGNhcHM6IG9mcz0weDBmLCBu
c3RlcHM9MHgwZiwgc3RlcHNpemU9MHgwYiwgbXV0ZT0xCiAgQW1wLU91dCB2YWxzOiAgWzB4OGZd
CiAgQ29ubmVjdGlvbjogMgogICAgIDB4MTkqIDB4MjQKTm9kZSAweDE5IFtCZWVwIEdlbmVyYXRv
ciBXaWRnZXRdIHdjYXBzIDB4NzAwMDAwOiBNb25vCk5vZGUgMHgxYSBbUGluIENvbXBsZXhdIHdj
YXBzIDB4NDAwMTg1OiBTdGVyZW8gQW1wLU91dAogIEFtcC1PdXQgY2Fwczogb2ZzPTB4MWYsIG5z
dGVwcz0weDFmLCBzdGVwc2l6ZT0weDA1LCBtdXRlPTEKICBBbXAtT3V0IHZhbHM6ICBbMHgxNyAw
eDE3XQogIFBpbmNhcCAweDA4MWY6IE9VVCBIUCBEZXRlY3QKICBQaW4gRGVmYXVsdCAweDAyMjE0
MDIxOiBbSmFja10gSFAgT3V0IGF0IEV4dCBGcm9udAogICAgQ29ubiA9IDEvOCwgQ29sb3IgPSBH
cmVlbgogIFBpbi1jdGxzOiAweGMwOiBPVVQgSFAKICBDb25uZWN0aW9uOiAxCiAgICAgMHgwYQpO
b2RlIDB4MWIgW1BpbiBDb21wbGV4XSB3Y2FwcyAweDQwMDE4NTogU3RlcmVvIEFtcC1PdXQKICBB
bXAtT3V0IGNhcHM6IG9mcz0weDFmLCBuc3RlcHM9MHgxZiwgc3RlcHNpemU9MHgwNSwgbXV0ZT0x
CiAgQW1wLU91dCB2YWxzOiAgWzB4MTcgMHgxN10KICBQaW5jYXAgMHgwODEwMDFmOiBPVVQgSFAg
RUFQRCBEZXRlY3QKICBQaW4gRGVmYXVsdCAweDAxMDE0MDExOiBbSmFja10gTGluZSBPdXQgYXQg
RXh0IFJlYXIKICAgIENvbm4gPSAxLzgsIENvbG9yID0gR3JlZW4KICBQaW4tY3RsczogMHg0MDog
T1VUCiAgQ29ubmVjdGlvbjogMQogICAgIDB4MGIKTm9kZSAweDFjIFtQaW4gQ29tcGxleF0gd2Nh
cHMgMHg0MDAxODU6IFN0ZXJlbyBBbXAtT3V0CiAgQW1wLU91dCBjYXBzOiBvZnM9MHgxZiwgbnN0
ZXBzPTB4MWYsIHN0ZXBzaXplPTB4MDUsIG11dGU9MQogIEFtcC1PdXQgdmFsczogIFsweDgwIDB4
ODBdCiAgUGluY2FwIDB4MDgzNzogSU4gT1VUIERldGVjdAogIFBpbiBEZWZhdWx0IDB4NDEwMTMw
MTI6IFtOL0FdIExpbmUgT3V0IGF0IEV4dCBSZWFyCiAgICBDb25uID0gMS84LCBDb2xvciA9IEJs
dWUKICBQaW4tY3RsczogMHg0MDogT1VUCiAgQ29ubmVjdGlvbjogMQogICAgIDB4MGMKTm9kZSAw
eDFkIFtQaW4gQ29tcGxleF0gd2NhcHMgMHg0MDA5ODU6IFN0ZXJlbyBBbXAtT3V0CiAgQW1wLU91
dCBjYXBzOiBvZnM9MHgxZiwgbnN0ZXBzPTB4MWYsIHN0ZXBzaXplPTB4MDUsIG11dGU9MQogIEFt
cC1PdXQgdmFsczogIFsweDgwIDB4ODBdCiAgUGluY2FwIDB4MDgxNzM3OiBJTiBPVVQgRGV0ZWN0
CiAgUGluIERlZmF1bHQgMHgwMTAxOTAxNTogW0phY2tdIExpbmUgT3V0IGF0IEV4dCBSZWFyCiAg
ICBDb25uID0gMS84LCBDb2xvciA9IFBpbmsKICBQaW4tY3RsczogMHgyNDogSU4KICBDb25uZWN0
aW9uOiAxCiAgICAgMHgwZApOb2RlIDB4MWUgW1BpbiBDb21wbGV4XSB3Y2FwcyAweDQwMDEwNDog
TW9ubyBBbXAtT3V0CiAgQW1wLU91dCBjYXBzOiBvZnM9MHgxZiwgbnN0ZXBzPTB4MWYsIHN0ZXBz
aXplPTB4MDUsIG11dGU9MQogIEFtcC1PdXQgdmFsczogIFsweDgwXQogIFBpbmNhcCAweDA4MTA6
IE9VVAogIFBpbiBEZWZhdWx0IDB4NTExNzEwZjA6IFtOL0FdIFNwZWFrZXIgYXQgSW50IFJlYXIK
ICAgIENvbm4gPSBBbmFsb2csIENvbG9yID0gQmxhY2sKICBQaW4tY3RsczogMHg0MDogT1VUCiAg
Q29ubmVjdGlvbjogMQogICAgIDB4MGUKTm9kZSAweDFmIFtQaW4gQ29tcGxleF0gd2NhcHMgMHg0
MDAwODE6IFN0ZXJlbwogIFBpbmNhcCAweDA4MTcyNzogSU4gRGV0ZWN0CiAgUGluIERlZmF1bHQg
MHgwMmExOTBmMDogW0phY2tdIE1pYyBhdCBFeHQgRnJvbnQKICAgIENvbm4gPSAxLzgsIENvbG9y
ID0gUGluawogIFBpbi1jdGxzOiAweDI0OiBJTgpOb2RlIDB4MjAgW1BpbiBDb21wbGV4XSB3Y2Fw
cyAweDQwMDA4MTogU3RlcmVvCiAgUGluY2FwIDB4MDgxNzI3OiBJTiBEZXRlY3QKICBQaW4gRGVm
YXVsdCAweDQxODEzMGYwOiBbTi9BXSBMaW5lIEluIGF0IEV4dCBSZWFyCiAgICBDb25uID0gMS84
LCBDb2xvciA9IEJsdWUKICBQaW4tY3RsczogMHgyMDogSU4KTm9kZSAweDIxIFtQaW4gQ29tcGxl
eF0gd2NhcHMgMHg0MDAwODE6IFN0ZXJlbwogIFBpbmNhcCAweDA4Mjc6IElOIERldGVjdAogIFBp
biBEZWZhdWx0IDB4NTk5N2UwZjA6IFtOL0FdIEF1eCBhdCBJbnQgQVRBUEkKICAgIENvbm4gPSBB
bmFsb2csIENvbG9yID0gV2hpdGUKICBQaW4tY3RsczogMHgyMDogSU4KTm9kZSAweDIyIFtQaW4g
Q29tcGxleF0gd2NhcHMgMHg0MDAwMDE6IFN0ZXJlbwogIFBpbmNhcCAweDA4MjA6IElOCiAgUGlu
IERlZmF1bHQgMHg1OTMzMTBmMDogW04vQV0gQ0QgYXQgSW50IEFUQVBJCiAgICBDb25uID0gQVRB
UEksIENvbG9yID0gQmxhY2sKICBQaW4tY3RsczogMHgyMDogSU4KTm9kZSAweDIzIFtQaW4gQ29t
cGxleF0gd2NhcHMgMHg0MDAwMDA6IE1vbm8KICBQaW5jYXAgMHgwODIwOiBJTgogIFBpbiBEZWZh
dWx0IDB4NTliNzcwZjA6IFtOL0FdIFRlbGVwaG9ueSBhdCBJbnQgQVRBUEkKICAgIENvbm4gPSBB
bmFsb2csIENvbG9yID0gWWVsbG93CiAgUGluLWN0bHM6IDB4MjA6IElOCk5vZGUgMHgyNCBbUGlu
IENvbXBsZXhdIHdjYXBzIDB4NDAwMDAwOiBNb25vCiAgUGluY2FwIDB4MDgyMDogSU4KICBQaW4g
RGVmYXVsdCAweDUxZjcxMGYwOiBbTi9BXSBPdGhlciBhdCBJbnQgUmVhcgogICAgQ29ubiA9IEFu
YWxvZywgQ29sb3IgPSBCbGFjawogIFBpbi1jdGxzOiAweDIwOiBJTgpOb2RlIDB4MjUgW1BpbiBD
b21wbGV4XSB3Y2FwcyAweDQwMDMwMTogU3RlcmVvIERpZ2l0YWwKICBQaW5jYXAgMHgwODEwOiBP
VVQKICBQaW4gRGVmYXVsdCAweDQxNDVmMGYwOiBbTi9BXSBTUERJRiBPdXQgYXQgRXh0IFJlYXIK
ICAgIENvbm4gPSBPcHRpY2FsLCBDb2xvciA9IE90aGVyCiAgUGluLWN0bHM6IDB4NDA6IE9VVAog
IENvbm5lY3Rpb246IDEKICAgICAweDAyCk5vZGUgMHgyNiBbUG93ZXIgV2lkZ2V0XSB3Y2FwcyAw
eDUwMDUwMDogTW9ubwogIFBvd2VyOiAweDAKICBDb25uZWN0aW9uOiA4CiAgICAgMHgwNyogMHgw
OCAweDEzIDB4MTQgMHgxNSAweDE2IDB4MTcgMHgxOApOb2RlIDB4MjcgW0F1ZGlvIE1peGVyXSB3
Y2FwcyAweDIwMDEwMTogU3RlcmVvCiAgQ29ubmVjdGlvbjogMgogICAgIDB4MWYgMHgxZApOb2Rl
IDB4MjggW0F1ZGlvIE1peGVyXSB3Y2FwcyAweDIwMDEwMTogU3RlcmVvCiAgQ29ubmVjdGlvbjog
MgogICAgIDB4MWYgMHgyMApOb2RlIDB4MjkgW0F1ZGlvIE1peGVyXSB3Y2FwcyAweDIwMDEwMTog
U3RlcmVvCiAgQ29ubmVjdGlvbjogMgogICAgIDB4MWQgMHgyMApOb2RlIDB4MmEgW0F1ZGlvIE1p
eGVyXSB3Y2FwcyAweDIwMDEwMTogU3RlcmVvCiAgQ29ubmVjdGlvbjogMwogICAgIDB4MWYgMHgx
ZCAweDIwCk5vZGUgMHgyYiBbQXVkaW8gTWl4ZXJdIHdjYXBzIDB4MjAwMTAwOiBNb25vCiAgQ29u
bmVjdGlvbjogMQogICAgIDB4MGYK

------_=_NextPart_001_01C71A5A.CEEE9383
Content-Type: application/octet-stream;
	name="dmesg"
Content-Transfer-Encoding: base64
Content-Description: dmesg
Content-Disposition: attachment;
	filename="dmesg"

WzE3MTg2NDM4LjIwODAwMF0gUENJOiBTZXR0aW5nIGxhdGVuY3kgdGltZXIgb2YgZGV2aWNlIDAw
MDA6MDA6MWIuMCB0byA2NApbMTcxODY0MzguMjQwMDAwXSBBTFNBIC9tbnQxL3NyYy9hc2lhbnV4
L0JVSUxEL2Fsc2EtZHJpdmVyLWhnMjAwNjExMzAvcGNpL2hkYS8uLi8uLi9hbHNhLWtlcm5lbC9w
Y2kvaGRhL2hkYV9pbnRlbC5jOjY5NjogY29kZWNfbWFzayA9IDB4MQpbMTcxODY0MzguNDM2MDAw
XSBBTFNBIC9tbnQxL3NyYy9hc2lhbnV4L0JVSUxEL2Fsc2EtZHJpdmVyLWhnMjAwNjExMzAvcGNp
L2hkYS9oZGFfY29kZWMuYzoxNzY4OiBoZGFfY29kZWM6IG1vZGVsICd1bHRyYScgaXMgc2VsZWN0
ZWQgZm9yIGNvbmZpZyAxNDRkOmMwMjcgKFNhbXN1bmcgUTEpCg==

------_=_NextPart_001_01C71A5A.CEEE9383
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
------_=_NextPart_001_01C71A5A.CEEE9383
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

------_=_NextPart_001_01C71A5A.CEEE9383--
