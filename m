From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: Problems with snd_hda_intel in Linux kernel 2.6.38
Date: Tue, 24 May 2011 12:23:31 +0200
Message-ID: <1306232611.4255.1.camel@mattotaupa>
References: <1301394280.3906.29.camel@s1499.it.kth.se>
	<s5haage43qz.wl%tiwai@suse.de>
	<1301396296.32453.1.camel@s1499.it.kth.se>
	<s5h7hbi41xs.wl%tiwai@suse.de>
	<1301480744.21366.110.camel@hp.my.own.domain>
	<s5hpqp827sv.wl%tiwai@suse.de>
	<1301486370.32453.9.camel@s1499.it.kth.se>
	<4D932C71.10402@ladisch.de>
	<1301524966.21366.118.camel@hp.my.own.domain>
	<1301906577.32453.92.camel@s1499.it.kth.se>
	<s5h8vvqv0r2.wl%tiwai@suse.de>
	<1301908906.32453.94.camel@s1499.it.kth.se>
	<1306087019.5994.20.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3738572501775707619=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id CCD59103850
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 12:23:34 +0200 (CEST)
In-Reply-To: <1306087019.5994.20.camel@mattotaupa>
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
Cc: 619034@bugs.debian.org, 613979@bugs.debian.org, srs@kth.se
List-Id: alsa-devel@alsa-project.org


--===============3738572501775707619==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-1P6RrI32YdqV5LjTQA61"


--=-1P6RrI32YdqV5LjTQA61
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Sonntag, den 22.05.2011, 19:56 +0200 schrieb Paul Menzel:
> Am Montag, den 04.04.2011, 11:21 +0200 schrieb Svante Signell:
> > On Mon, 2011-04-04 at 11:12 +0200, Takashi Iwai wrote:
> > > At Mon, 04 Apr 2011 10:42:57 +0200,
> > > Svante Signell wrote:
> > > >=20
> > > > On Thu, 2011-03-31 at 00:42 +0200, Svante Signell wrote:
> > > > > On Wed, 2011-03-30 at 15:13 +0200, Clemens Ladisch wrote:
> > ...
> > > > Anything happening here with respect to this bug? How can I help
> > > > further? Booting with 2.6.32 all the time does not feel like a good
> > > > solution in long term.
> > >=20
> > > The point where it Oops implies that the problem isn't in the sound
> > > driver but rather in a breakage in a deeper level, either PCI core,
> > > x86 mm or ACPI/BIOS.
>=20
> The problem is still present with 2.6.39.
>=20
> > > Any chance to bisect the kernel?
> >=20
> > Never done that before. Is there a bisect HOWTO somewhere?
>=20
> Ben, I am sorry to bother you directly, but there are so many howtos on
> the Web, it would be great if you could point us to an =E2=80=9Cofficial=
=E2=80=9D one,
> which has proofed itself. Or maybe you could write up a blog post. ;-)
>=20
> Anyway I did not find any information here.
>=20
>         $ ls /usr/share/doc/linux-image-2.6.39-1-amd64/
>         changelog.Debian.gz  copyright

Svante, if you have some time, could you please try to follow the Wiki
page DebianKernel/GitBisect [1] in the Debian Wiki. Unfortunately I will
not have time until the beginning of July.


Thanks,

Paul


[1] http://wiki.debian.org/DebianKernel/GitBisect

--=-1P6RrI32YdqV5LjTQA61
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk3bhxwACgkQPX1aK2wOHVjl4QCfVtybeirIfQb1sf/P2AJ27yrj
5/AAn0OSZ+8OUAyCMgxMKvfnOTDZ5kSY
=teX6
-----END PGP SIGNATURE-----

--=-1P6RrI32YdqV5LjTQA61--


--===============3738572501775707619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3738572501775707619==--
