From: Prakash Punnoor <prakash@punnoor.de>
Subject: Re: [RFC: 2.6.19 patch] snd-hda-intel: default MSI to
	off
Date: Tue, 31 Oct 2006 09:37:38 +0100
Message-ID: <200610310937.42576.prakash@punnoor.de>
References: <200610050938.10997.prakash@punnoor.de>
	<s5hhcxv1bc3.wl%tiwai@suse.de>
	<5aa69f860610302256u61e30b2aj2501e5c1f5b7335@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0942242893=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7B09322A
	for <alsa-devel@alsa-project.org>; Tue, 31 Oct 2006 09:37:10 +0100 (MET)
In-Reply-To: <5aa69f860610302256u61e30b2aj2501e5c1f5b7335@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: fatih.asici@gmail.com
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, mingo@redhat.com, hnguyen@de.ibm.com, Stephen Hemminger <shemminger@osdl.org>, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

--===============0942242893==
Content-Type: multipart/signed; boundary="nextPart3068189.yOAyV9dVk0";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3068189.yOAyV9dVk0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Dienstag 31 Oktober 2006 07:56 schrieb Fatih Asici:
> On 10/23/06, Takashi Iwai <tiwai@suse.de> wrote:
> > At Sun, 22 Oct 2006 22:29:13 +0200,
> >
> > Prakash Punnoor wrote:
> > > Am Mittwoch 18 Oktober 2006 19:21 schrieb Takashi Iwai:
> > > > > Yes, it would be better to check the value and reset chip->msi if
> > > > > not successful.  But it's not a fatal error, so the current code
> > > > > should work.
> > > >
> > > > The below is the revised patch.
> > >
> > > I tried it and it works fine for me now (with the driver not using msi
> > > automatically now).
> >
> > Thanks for checking.  I applied the patch to ALSA tree for the next
> > push round.
>
> It does not solve my problem. I still need to boot with pci=3Dnomsi optio=
n.
>
> Prakash: did you use Takashi's patch or Andrian's patch?

I used Takashi's revised patch, but rc3 works w/o patching:

dvanced Linux Sound Architecture Driver Version 1.0.13 (Sun Oct 22 08:56:16=
=20
2006 UTC).
ACPI: PCI Interrupt Link [AAZA] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [AAZA] -> GSI 23 (level, low) -=
>=20
IRQ 23
PCI: Setting latency timer of device 0000:00:10.1 to 64
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
hda_intel: No response from codec, disabling MSI...
ALSA device list:
  #0: HDA NVidia at 0xfe028000 irq 316

And it disables MSI automatically.
=2D-=20
(=C2=B0=3D                 =3D=C2=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart3068189.yOAyV9dVk0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFRwtWxU2n/+9+t5gRAvG4AKDLJUK+KHGL708uwjMgWrXY3IN+vQCgxKVg
8Kh/XWS5wdiJWkt+JXbX0m0=
=onh0
-----END PGP SIGNATURE-----

--nextPart3068189.yOAyV9dVk0--


--===============0942242893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0942242893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0942242893==--
