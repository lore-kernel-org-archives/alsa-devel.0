From: Sebastian Henschel <sebastian@mali.geekcorps.org>
Subject: Re: Re: [Alsa-user] snd-via82xx on EPIA-M - 0 analog subsections not ready
Date: Mon, 27 Jun 2005 10:39:36 +0000
Message-ID: <20050627103936.GA5627@fingerbrecher>
References: <20050623184321.GA7728@fingerbrecher> <1119555870.13259.26.camel@mindpipe> <20050624105942.GA10544@fingerbrecher> <s5hoe9veqna.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hoe9veqna.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hello....

* Takashi Iwai <tiwai@suse.de> [2005-06-24 22:18 +0000]:
> At Fri, 24 Jun 2005 10:59:42 +0000,
> Sebastian Henschel wrote:
> >=20
> > * Lee Revell <rlrevell@joe-job.com> [2005-06-24 08:51 +0000]:
> > > On Thu, 2005-06-23 at 18:43 +0000, Sebastian Henschel wrote:
> > > >=20
> > > > i am working on a machine with an EPIA-M mainboard and the ICEensem=
ble
> > > > VT1616i sound chip (see attached lspci -v).
> > >=20
> > > Thanks, this is an excellent bug report.  It sounds like a not quite
> > > fully supported device.
> >=20
> > so should i open a bug report on that?
>=20
> Yes, please.

ok, done: https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D1213
the contents of /proc/asound/card0/codec97#0/ will follow when i have
access to the machine again.


> > > On a related topic, it seems like a lot of users waste hours and hours
> > > changing settings before they even consider that they might have a
> > > hardware variation we have not seen before.
> >=20
> > given that the BIOS is dated from somewhere from 2004 and that the
> > EPIA-M is not unpopular, i would have thought it is well-known. but
> > perhaps this is just another hardware revision (rev 50 in this case)
> > which might do something slightly different than the revisions before.
>=20
> Also, this kind of bug depends pretty upon the BIOS.

will try to upgrade the BIOS.

> Try acpi=3Doff boot option once.

this used to be the default behaviour, there is no difference between on
and off.

thanks,
 Sebastian
--=20
Oo.....................
 wer ein ganzer mensch ist, braucht keine autoritaet zu sein.
 OpenPGP key ID: 0x4A1F5E81  Geekcode: GCSd-s:a-C++ULB+++W++M+PS+++
                                                ..................oO

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCv9doqe04hEofXoERAn52AJ9cBQaK08Rr2RPFkTb+TOmg0sAB+QCdESl2
3oMXHo9HmaeQwXS6987Lui8=
=Plm3
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
