From: William Pitcock <nenolod@sacredspiral.co.uk>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Thu, 09 Oct 2008 13:25:51 -0500
Message-ID: <1223576751.20200.2210.camel@petrie.sacredspiral.co.uk>
References: <s5hy70xsl46.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2395247994815542606=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from carpathia.dereferenced.org (unknown [67.202.90.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 03DD1245AA
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Oct 2008 20:26:12 +0200 (CEST)
In-Reply-To: <s5hy70xsl46.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2395247994815542606==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-090jsZVH425K6uX0NglZ"


--=-090jsZVH425K6uX0NglZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello Takashi,

I will have plenty of patches for this fairly soon. Stay tuned.

William

On Thu, 2008-10-09 at 20:02 +0200, Takashi Iwai wrote:
> Hi,
>=20
> $SUBJECT is now on my sound-unstable git tree:
>     git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-unstable-2.=
6.git
> together with other experimental patches.
>=20
> If you're using 2.6.27-rc* git tree, pull the master branch of the
> tree above into yours, and run make oldconfig.  That is,
>     % cd /your/git-tree
>     % git pull git://...../sound-unstable-2.6.git master
>=20
> If you are not using 2.6.27-rc*, or not familiar with git, you can try
> alsa-driver-unstable snapshot tarball available at
>     ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/
> Run configure, make and make install as usual ALSA-driver tarball.
>=20
> (I didn't check whether the tarball correctly includes the sbxfi
>  stuff.  It should have been generated automatically.  If not, wait
>  for a while.  If it still doesn't include sbxfi code, please report.
>  I'll fix it tomorrow morning.)
>=20
> The driver is built only for 2.6.26 or later.  If you have an older
> kernel, edit alsa-driver*/kconfig-vers and change the version of
> CONFIG_SND_SBXFI to 2.6.24 or whatever you want.  Then run
> ./gitcompile, instead of configure in this case to update the
> configure script.
>=20
> **NOTE**
> The driver is totally untested.  It's just compiled without errors,
> but not reviewed after a quick writing.  So, don't expect it ever runs
> at the first try.  A crash is highly possible.
>=20
> There are some build conditions found in sound/pci/sbxfi/sbxfi.c,
> starting with XXX_*.  You can change it if you want.  As default, it's
> for non-fullduplex but accept different rates.  Not sure whether this
> works at all.
>=20
> Any test- (and better debugging-) reports are appreciated.
>=20
>=20
> thanks,
>=20
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>=20

--=-090jsZVH425K6uX0NglZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBI7kyvoB+26npOQg4RAiTIAJ0UaXrj+I9SMP3h1yZM8DYp2gXSsQCdEA08
B/0dPtPa7uOHo9Kp0VK5SR8=
=QFf8
-----END PGP SIGNATURE-----

--=-090jsZVH425K6uX0NglZ--


--===============2395247994815542606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2395247994815542606==--
