From: "Stephen Warren" <SWarren@nvidia.com>
Subject: RE: New azx driver: Problems in snd_mixer_load
Date: Thu, 9 Dec 2004 13:29:43 -0800
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B0033AE13F@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> From: Takashi Iwai [mailto:tiwai@suse.de]=20
>=20
> Stephen Warren wrote:
> > On top of this, I added the latest CVS version of the azx=20
> > driver into the kernel.
> >=20
> > Now, when I run alsamixer, I get the following error=20
> > message right at startup:
> >=20
> > =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > root@localhost# alsamixer
> > ALSA lib simple.c:950:(simple_add1) helem (MIXER,'Capture=20
> Source',0,0,0)
> > appears twice or more
> > alsamixer: function snd_mixer_load failed: Invalid argument
> > =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>=20
> Could you show the content of /etc/asound.state after "alscatl store"?
> Also, try to build with --with-debug=3Ddetect
> (i.e. CONFIG_SND_DEBUG_DETECT=3Dy).  This will give some more=20
> verbose info.
>=20
> > In particular, I'm a little confused about the role the files in
> > /usr/share/alsa play in the whole ALSA system. Do I need to=20
> > import new version of these files along with the udpated device
> > driver?
>=20
> It'd be better if you update the driver.

OK. I've built alsa-driver from CVS. I get this in the kernel logs when
doing "modprobe snd-azx":

ACPI: PCI interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 16
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/azx.c:356:
codec_mask =3D 0x4
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:488:
AUD_IN =3D 8
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:201:
UNMUTE IN: NID=3D0xb IDX=3D0x0
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:201:
UNMUTE IN: NID=3D0xc IDX=3D0x0
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:201:
UNMUTE IN: NID=3D0xd IDX=3D0x0
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:201:
UNMUTE IN: NID=3D0xe IDX=3D0x0
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:201:
UNMUTE IN: NID=3D0xf IDX=3D0x0
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:201:
UNMUTE IN: NID=3D0x10 IDX=3D0x0
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:201:
UNMUTE IN: NID=3D0x11 IDX=3D0x0
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:201:
UNMUTE IN: NID=3D0x1f IDX=3D0x0
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:201:
UNMUTE IN: NID=3D0x20 IDX=3D0x0
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:518:
[Capture Source] NID=3D0x8, #SRC=3D9
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:520:
[Input 0] IDX=3D0x0
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:520:
[Line] IDX=3D0x1
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:520:
[Mic] IDX=3D0x2
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:520:
[Input 3] IDX=3D0x3
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:520:
[Input 4] IDX=3D0x4
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:520:
[Mic] IDX=3D0x5
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:520:
[CD] IDX=3D0x6
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:520:
[Input 7] IDX=3D0x7
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:520:
[Input 8] IDX=3D0x8
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:251:
AUD_OUT found 3
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:201:
UNMUTE IN: NID=3D0xb IDX=3D0x0
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:185:
UNMUTE OUT: NID=3D0xb
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:185:
UNMUTE OUT: NID=3D0xb
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:251:
AUD_OUT found 4
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:251:
AUD_OUT found 5
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:251:
AUD_OUT found 6
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:251:
AUD_OUT found 3
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:217:
CONNECT: NID=3D0xf IDX=3D0x0
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:201:
UNMUTE IN: NID=3D0xf IDX=3D0x0
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:185:
UNMUTE OUT: NID=3D0xf
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:185:
UNMUTE OUT: NID=3D0xf
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:251:
AUD_OUT found 3
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:217:
CONNECT: NID=3D0x10 IDX=3D0x0
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:201:
UNMUTE IN: NID=3D0x10 IDX=3D0x0
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:185:
UNMUTE OUT: NID=3D0x10
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:185:
UNMUTE OUT: NID=3D0x10
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:251:
AUD_OUT found 7
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:251:
AUD_OUT found 3
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:217:
CONNECT: NID=3D0x1f IDX=3D0x0
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:201:
UNMUTE IN: NID=3D0x1f IDX=3D0x0
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:185:
UNMUTE OUT: NID=3D0x1f
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:185:
UNMUTE OUT: NID=3D0x1f
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:251:
AUD_OUT found 3
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:217:
CONNECT: NID=3D0x20 IDX=3D0x0
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:201:
UNMUTE IN: NID=3D0x20 IDX=3D0x0
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:185:
UNMUTE OUT: NID=3D0x20
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:185:
UNMUTE OUT: NID=3D0x20
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:576:
[Capture Switch] NID=3D0x8, DIR=3DIN, IDX=3D0x0
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:598:
[Capture Volume] NID=3D0x8, DIR=3DIN, IDX=3D0x0
ALSA /home/swarren/src/alsa-cvs/alsa-driver/pci/azx/hda_generic.c:217:
CONNECT: NID=3D0x8 IDX=3D0x0

If I re-run "alsactl store", I get the same content in /etc/asound.state
as before.

I didn't update any of the user-space tools. I assume that's OK?

--=20
Stephen Warren, Software Engineer, NVIDIA, Fort Collins, CO
swarren@nvidia.com        http://www.nvidia.com/
swarren@wwwdotorg.org     http://www.wwwdotorg.org/pgp.html


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
