From: cklein@mpi-sb.mpg.de
Subject: Re: Cannot change volume on Plantronics Audio 910 USB
	Headset
Date: Sat, 29 Mar 2008 01:42:21 +0100
Message-ID: <20080329004220.GB21910@mpi-inf.mpg.de>
References: <20080318151117.GA11027@mpi-inf.mpg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5663543873051414939=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from francois.mpi-sb.mpg.de (mx2.mpi-sb.mpg.de [139.19.1.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 5AE6C2479A
	for <alsa-devel@alsa-project.org>; Sat, 29 Mar 2008 01:42:25 +0100 (CET)
In-Reply-To: <20080318151117.GA11027@mpi-inf.mpg.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============5663543873051414939==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Content-Disposition: inline


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2008 at 04:11:17PM +0100, cklein@mpi-sb.mpg.de wrote:
> Hi,
>=20
> I recently got a Plantronics .audio 910 USB headset.
> It is correctly detected by snd-usb-audio and works, but I cannot change =
the
> volume of the PCM output or the MIC input. When executing alsamixer -c 1,
> the volumes seem to be locked and cannot be changed as usual. Unfortunate=
ly
> the microphone volume is at 0, leading to very poor quality of the record=
ed
> voice (especially in Skype, which seems to try to compensate the low volu=
me
> and fails miserably).
> Does anyone know how to fix this?
> I found similar reports on the internet for various usb headsets, but no
> real fix for the situation.
> I already asked on alsa-users some weeks ago, but did not get any respons=
e.
>=20
> I tried the headset on three different PCs, all with the same result.
> A desktop at work running Fedora 7, a Thinkpad R50p running debian/testing
> and the 2.6.22 kernel provided in debian/testing. The third one is a Dell
> precision M65 with debian/unstable.
> There, I used a vanilla 2.6.24.2 kernel and latest alsa drivers from the
> mercurial repository when I asked on alsa-users, but in the meantime I
> upgraded to 2.6.24.3 and hg snapshots from 2008-03-13 06:41
> (alsa-driver) and 2008:03:17 05:23 (alsa-kernel), but still got the same
> behaviour.
> On all I get some message about "no or invalid class specific endpoint
> descriptor" in the kernel log (see below).
> When loading the snd-usb-audio module, dmesg shows the following kernel
> output (on the M65):
>=20
> usb 2-2: new full speed USB device using uhci_hcd and address 5
> usb 2-2: configuration #1 chosen from 1 choice
> input: Plantronics Plantronics BT Adapter as /devices/pci0000:00/0000:00:=
1d.1/usb2/2-2/2-2:1.3/input/input10
> input: USB HID v1.11 Device [Plantronics Plantronics BT Adapter] on usb-0=
000:00:1d.1-2
> usbcore: registered new interface driver usbhid
> drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
> ALSA /usr/src/kernel-modules/alsa-driver-d20080313_0641-k20080317_0523/us=
b/usbaudio.c:2787: 5:1:1 : no or invalid class specific endpoint descriptor
> ALSA /usr/src/kernel-modules/alsa-driver-d20080313_0641-k20080317_0523/us=
b/usbaudio.c:2787: 5:2:1 : no or invalid class specific endpoint descriptor
> usbcore: registered new interface driver snd-usb-audio
>=20
> I posted the output of alsa-info.sh and lsusb -v on pastebin (both taken =
on
> the M65).
>=20
> alsa-info.sh:
> http://pastebin.ca/915715
> lsusb -v:
> http://pastebin.ca/915723

Does no one have a clue what could be the cause for this behaviour?
If I boot windows, the headset works flawlessly.
Unfortunately I have no clue what could be wrong or where else to find
information about this problem.

--=20
CU, Christian Klein

http://www.garfield.com/comics/comics_archives_strip.html?2003-ga031023

Homepage:       http://www.mpi-sb.mpg.de/~cklein

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFH7ZBssuy/KwFz75MRAqunAKCZV+ddPaellRcGDe5AmJHXcDcW6QCgyQut
vJdgCRGw+O69v5DZDtcyDrE=
=zdXP
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--

--===============5663543873051414939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5663543873051414939==--
