From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: ALC892 optical SPDIF not working
Date: Sat, 31 Jul 2010 19:22:52 +0200
Message-ID: <1280596972.4074.1.camel@mattotaupa>
References: <AANLkTimvFz0wW02WGzTx1iei_jOoaXgO=iGopE_n2-+C@mail.gmail.com>
	<s5hmxt9qqlv.wl%tiwai@suse.de>
	<AANLkTi=QxpJSyXgNH+WeUQdTo0kVNuPN73F-iXW5meAa@mail.gmail.com>
	<AANLkTim=_kdSJJ1NSW2D5X7GVWp=8ffwKqSbdQ9MqjMb@mail.gmail.com>
	<s5hvd7xp4dh.wl%tiwai@suse.de>
	<AANLkTin+BUQr0iVq3MT+O-dA6PYyZZF_QVcEdoM-xK9p@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8512372170021289813=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 23F3324422
	for <alsa-devel@alsa-project.org>;
	Sat, 31 Jul 2010 19:22:58 +0200 (CEST)
Received: from f053040133.adsl.alicedsl.de ([78.53.40.133]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1OfFlw-0000ku-DU
	for alsa-devel@alsa-project.org; Sat, 31 Jul 2010 17:22:56 +0000
In-Reply-To: <AANLkTin+BUQr0iVq3MT+O-dA6PYyZZF_QVcEdoM-xK9p@mail.gmail.com>
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
List-Id: alsa-devel@alsa-project.org


--===============8512372170021289813==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-SHfMRKyCofMVPecBxbXt"


--=-SHfMRKyCofMVPecBxbXt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Freitag, den 30.07.2010, 14:03 +0200 schrieb Manuel Lauss:
> On Fri, Jul 30, 2010 at 1:59 PM, Takashi Iwai <tiwai@suse.de> wrote:
> > At Fri, 30 Jul 2010 13:32:40 +0200,
> > Manuel Lauss wrote:

> >> On Fri, Jul 30, 2010 at 12:24 PM, Manuel Lauss
> >> <manuel.lauss@googlemail.com> wrote:
> >> > On Fri, Jul 30, 2010 at 11:13 AM, Takashi Iwai <tiwai@suse.de> wrote=
:
> >> >> At Fri, 30 Jul 2010 10:00:13 +0200,
> >> >> Manuel Lauss wrote:
> >> >>>
> >> >>> Hello,
> >> >>>
> >> >>> I have a Gigabyte 890GX-based board with an ALC892 codec.
> >> >>> The optical SPDIF output does not work at all (i.e. no red light o=
n
> >> >>> the cable), and the kernel prints
> >> >>> "ALSA hda_codec.c:407: Too many connections"
> >> >>> messages whenever sound is played (analog works, but I need
> >> >>> digital).
> >> >>
> >> >> Could you try the latest alsa-driver-snapshot?
> >> >>    ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa=
-driver-snapshot.tar.gz
> >> >>
> >> >> I fixed a few things regarding digital I/O handling of Realtek code=
cs
> >> >> now, and fixed the too-many-connections bug there, too.
> >> >
> >> > I pulled from your tree: AC3/DTS passthrough works now, however "nor=
mal" audio
> >> > only works with 48kHz rate.
> >>
> >> Is there a way to insert an initial playback delay?  Under linux, the
> >> first 2-2.5 seconds
> >> of anything played are just silence; on windows audible playback
> >> starts immediately.
> >
> > It's the time for synchronization your digital receiver takes, I guess.
> > Maybe changing SPDIF status makes it resync, which happens at each
> > opening / closing the stream.
>=20
> Yes, seems so. I've found a workaround in meantime.

Could you elaborate on the workaround please, so others having this
issue know it.


Thanks,

Paul

--=-SHfMRKyCofMVPecBxbXt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkxUW+YACgkQPX1aK2wOHVjC9QCfdDhf0iFM7TCOgkC/d77i3nqH
JAEAn0zSvPvSwYgn4YDDsm6Fa53iUTcE
=74IU
-----END PGP SIGNATURE-----

--=-SHfMRKyCofMVPecBxbXt--


--===============8512372170021289813==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8512372170021289813==--
