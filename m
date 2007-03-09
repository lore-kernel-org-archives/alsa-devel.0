From: Andrea Gozzi <andrea.gozzi@linuxrevolution.eu>
Subject: Re: Sound on Packard Bell V7900 (ALC260):
	where	from	here?
Date: Fri, 09 Mar 2007 09:57:59 +0100
Message-ID: <1173430679.25793.8.camel@osmosis>
References: <1165746566.14195.31.camel@osmosis>
	<loom.20070308T165018-246@post.gmane.org>
	<1173370695.4531.73.camel@razman.gruemaster.com>
Reply-To: andrea.gozzi@linuxrevolution.eu
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0413937225=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1173370695.4531.73.camel@razman.gruemaster.com>
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
Cc: Pongi <pongi@pongi.it>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============0413937225==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-5FCdusA+et8Z+erJXV/k"


--=-5FCdusA+et8Z+erJXV/k
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I will join in since I'm having the same troubles as David and Pongi.

I compiled latest alsa 14rc3 but nothing changed; I also tried evey
model for ALC260 configuration but still no sound.
In case you need it, my gtalk contact is "asgozzi".

Andrea


*alsa-info.sh output:


ALSA Version
------------

Advanced Linux Sound Architecture Driver Version 1.0.14rc3.
Compiled on Mar  9 2007 for kernel 2.6.19.2-gnet_laptop (SMP).


Loaded ALSA modules
-------------------

snd_hda_intel


Soundcards recognised by ALSA
-----------------------------

 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0x5c300000 irq 21


PCI Soundcards installed in the system
--------------------------------------

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High
Definition Audio Controller (rev 02)
00:1b.0 0403: 8086:27d8 (rev 02)
        Subsystem: 1631:c017


HDA-Intel Codec information
---------------------------

Codec: Realtek ALC260
Address: 0
Vendor Id: 0x10ec0260
Subsystem Id: 0x16311635
Revision Id: 0x100400
Default PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
Node 0x02 [Audio Output] wcaps 0x11: Stereo
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x03 [Audio Output] wcaps 0x211: Stereo Digital
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0x1e]: 16 20 24 32
    formats [0x1]: PCM
Node 0x04 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x23, stepsize=3D0x03, mute=3D1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80
0x80] [0x80 0x80] [0x80 0x80]
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Connection: 7
     0x12* 0x13 0x14 0x15 0x16 0x0f 0x10
Node 0x05 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x23, stepsize=3D0x03, mute=3D1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80
0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Connection: 8
     0x12* 0x13 0x14 0x15 0x16 0x07 0x0f 0x10
Node 0x06 [Audio Input] wcaps 0x100391: Stereo Digital
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x1e]: 16 20 24 32
    formats [0x1]: PCM
  Connection: 1
     0x19
Node 0x07 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=3D0x23, nsteps=3D0x41, stepsize=3D0x03, mute=3D1
  Amp-In vals:  [0x41 0x41] [0x41 0x41] [0x41 0x41] [0x41 0x41] [0x41
0x41] [0x41 0x41] [0x41 0x41] [0x41 0x41]
  Connection: 8
     0x12 0x13 0x14 0x15 0x16 0x17 0x0f 0x10
Node 0x08 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=3D0x40, nsteps=3D0x40, stepsize=3D0x03, mute=3D0
  Amp-Out vals:  [0x40 0x40]
  Connection: 2
     0x02 0x07
Node 0x09 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=3D0x40, nsteps=3D0x40, stepsize=3D0x03, mute=3D0
  Amp-Out vals:  [0x40 0x40]
  Connection: 2
     0x02 0x07
Node 0x0a [Audio Mixer] wcaps 0x20010e: Mono Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x80] [0x80]
  Amp-Out caps: ofs=3D0x23, nsteps=3D0x41, stepsize=3D0x03, mute=3D0
  Amp-Out vals:  [0x41]
  Connection: 2
     0x02 0x07
Node 0x0b [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x08* 0x09
Node 0x0c [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x08* 0x09
Node 0x0d [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x08* 0x09
Node 0x0e [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x08* 0x09
Node 0x0f [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x081003f: IN OUT HP EAPD Detect
  Pin Default 0x01014110: [Jack] Line Out at Ext Rear
    Conn =3D 1/8, Color =3D Green
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x08
Node 0x10 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x081003f: IN OUT HP EAPD Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x09
Node 0x11 [Pin Complex] wcaps 0x40010c: Mono Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00]
  Pincap 0x0810: OUT
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0a
Node 0x12 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x08133f: IN OUT HP Detect
  Pin Default 0x01a19930: [Jack] Mic at Ext Rear
    Conn =3D 1/8, Color =3D Pink
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0b
Node 0x13 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x08133f: IN OUT HP Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0c
Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x08133f: IN OUT HP Detect
  Pin Default 0x01813131: [Jack] Line In at Ext Rear
    Conn =3D 1/8, Color =3D Blue
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0d
Node 0x15 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x08133f: IN OUT HP Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0e
Node 0x16 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x99330132: [Fixed] CD at Int ATAPI
    Conn =3D ATAPI, Color =3D Unknown
  Pin-ctls: 0x00:
Node 0x17 [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x0820: IN
  Pin Default 0x9983013e: [Fixed] Line In at Int ATAPI
    Conn =3D ATAPI, Color =3D Unknown
  Pin-ctls: 0x00:
Node 0x18 [Pin Complex] wcaps 0x400380: Mono Digital
  Pincap 0x0814: OUT Detect
  Pin Default 0x01454120: [Jack] SPDIF Out at Ext Rear
    Conn =3D Optical, Color =3D Green
  Pin-ctls: 0x00:
  Connection: 1
     0x03
Node 0x19 [Pin Complex] wcaps 0x400280: Mono Digital
  Pincap 0x0824: IN Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
  Pin-ctls: 0x00:
Node 0x1a [Vendor Defined Widget] wcaps 0xf00040: Mono
Node 0x1b [Volume Knob Widget] wcaps 0x600080: Mono
Codec: Conexant ID 2bfa
Address: 1
Vendor Id: 0x14f12bfa
Subsystem Id: 0x14f10001
Revision Id: 0x90000


--=-5FCdusA+et8Z+erJXV/k
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBF8SGXj5TKYSZYpiQRAvjMAKC4YvXE4nZtxfKshV+xo0HtTQ4NJQCg9wtS
YyuE7GWxR8+IXc8P/k6l+xQ=
=lIqg
-----END PGP SIGNATURE-----

--=-5FCdusA+et8Z+erJXV/k--



--===============0413937225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0413937225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0413937225==--
