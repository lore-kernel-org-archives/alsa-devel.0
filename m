From: Paul Menzel <pm.debian@googlemail.com>
Subject: Re: Bug#613979: [regression] "BUG: Unable to handle kernel paging
 request at ffffc90013cd8000" and no sound card recognized
Date: Fri, 15 Jul 2011 00:12:11 +0200
Message-ID: <1310681531.20700.4.camel@mattotaupa>
References: <s5haage43qz.wl%tiwai@suse.de>
	 <1301396296.32453.1.camel@s1499.it.kth.se> <s5h7hbi41xs.wl%tiwai@suse.de>
	 <1301480744.21366.110.camel@hp.my.own.domain>
	 <s5hpqp827sv.wl%tiwai@suse.de> <1301486370.32453.9.camel@s1499.it.kth.se>
	 <4D932C71.10402@ladisch.de> <1301524966.21366.118.camel@hp.my.own.domain>
	 <1301906577.32453.92.camel@s1499.it.kth.se> <s5h8vvqv0r2.wl%tiwai@suse.de>
	 <20110714182702.GA14014@elie>  <1310679322.2740.5.camel@x60>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-i1r/+C+wuUKpaAaDnHcP"
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1310679322.2740.5.camel@x60>
Sender: linux-pci-owner@vger.kernel.org
To: srs@kth.se, 613979@bugs.debian.org
Cc: Jonathan Nieder <jrnieder@gmail.com>, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, 619034@bugs.debian.org, alsa-devel@alsa-project.org, linux-pci@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--=-i1r/+C+wuUKpaAaDnHcP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Donnerstag, den 14.07.2011, 23:35 +0200 schrieb Svante Signell:
> On Thu, 2011-07-14 at 13:27 -0500, Jonathan Nieder wrote:

> > Takashi Iwai wrote:
> > >>> On Wed, 2011-03-30 at 15:13 +0200, Clemens Ladisch wrote:
> > >>>>>>>>> Svante Signell wrote:
> >=20
> > >>>>>>>>>> During boot of kernel 2.6.38 (and 2.6.37) udev bugs out:
> > >>>>>>>>>> Waiting for /dev to be fully populated
> > >>>>>>>>>> BUG: Unable to handle kernel paging request at ffffc90013cd8=
000
> > >>>>>>>>>> axz_probe+ ... [snd_hda_intel]
> > >>>>>>>>>> ...lots of output lost...
> > >>>>>>>>>> udevadm timeout 180 sec ...
> > >>>>>>>>>> udevd[390]: worker [439] failed while handling
> > >>>>>>>>>> '/devices/pci0000:80/0000:80:01.0'
> > >>>>>>>>>>=20
> > >>>>>>>>>> After the timeout the boot continues! Have not yet tested if=
 sound is
> > >>>>>>>>>> functional.
> > [...]
> > >>>> This is the azx_readw(chip, GCAP) in azx_create(); chip->remap_add=
r is
> > >>>> 0xffffc90011c08000 which does look like a valid pointer, but isn't=
.
> > [...]
> > > The point where it Oops implies that the problem isn't in the sound
> > > driver but rather in a breakage in a deeper level, either PCI core,
> > > x86 mm or ACPI/BIOS.
> > >
> > > Any chance to bisect the kernel?
> >=20
> > Svante bisected it to v2.6.34-rc1~218^2~27 (x86/pci: Use
> > resource_size_t in update_res, 2010-02-10) --- thanks.  Which is
> > pretty weird, since I think phys_addr_t on an amd64 machine (and hence
> > resource_size_t) would be 64 bits, making that commit a no-op.

I just want to add that I experience this with an AMD 64-bit processor
but 32-bit userspace and linux-image-=E2=80=A6-amd64 and -686-pae.

> > Svante, more questions (sorry):
> >=20
> >  - could you try booting b74fd238a9cf and b74fd238a9cf^ again
> >    (to make sure we haven't hit a heisenbug) and send the
> >    corresponding full dmesg and .config files?
>=20
> I am very sorry but I don't have physical access to that box for a month
> from now.

Having the same I could do also some tests over the weekend. I only need
some instructions how to do that. Svante, could you please paste your
commands for generating your Linux kernel package.

[=E2=80=A6]


Thanks,

Paul

--=-i1r/+C+wuUKpaAaDnHcP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk4fabUACgkQPX1aK2wOHVgiOQCeJRHOl0+9g/igFax6eVH1i7iz
iK4AnAm/+Nm8k61BCz5cg7d34ooXNOJo
=IGVJ
-----END PGP SIGNATURE-----

--=-i1r/+C+wuUKpaAaDnHcP--
