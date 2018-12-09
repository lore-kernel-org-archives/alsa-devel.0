From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH v8 1/4] media: Media Device Allocator
	API
Date: Sun, 9 Dec 2018 12:37:14 +0100
Message-ID: <20181209113714.GA21784@amd>
References: <cover.1541109584.git.shuah@kernel.org>
 <e474dd16f1d6443c12b1361376193c9d0efcced6.1541109584.git.shuah@kernel.org>
 <20181119085931.GA28607@amd>
 <73c22137-9c7a-75c8-8cd1-3736c63c2d40@kernel.org>
 <20181209080944.GA7561@amd> <20181209092715.50a7e4e4@coco.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6645910780067889961=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
 [195.113.26.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E0B502677E4
 for <alsa-devel@alsa-project.org>; Sun,  9 Dec 2018 12:37:15 +0100 (CET)
In-Reply-To: <20181209092715.50a7e4e4@coco.lan>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, shuah <shuah@kernel.org>, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============6645910780067889961==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > On Thu 2018-12-06 08:33:14, shuah wrote:
> > > On 11/19/18 1:59 AM, Pavel Machek wrote: =20
> > > >On Thu 2018-11-01 18:31:30, shuah@kernel.org wrote: =20
> > > >>From: Shuah Khan <shuah@kernel.org>
> > > >>
> > > >>Media Device Allocator API to allows multiple drivers share a media=
 device.
> > > >>Using this API, drivers can allocate a media device with the shared=
 struct
> > > >>device as the key. Once the media device is allocated by a driver, =
other
> > > >>drivers can get a reference to it. The media device is released whe=
n all
> > > >>the references are released. =20
> > > >
> > > >Sounds like a ... bad idea?
> > > >
> > > >That's what new "media control" framework is for, no?
> > > >
> > > >Why do you need this? =20
> > >=20
> > > Media control framework doesn't address this problem of ownership of =
the
> > > media device when non-media drivers have to own the pipeline. In this=
 case,
> > > snd-usb owns the audio pipeline when an audio application is using the
> > > device. Without this work, media drivers won't be able to tell if snd=
-usb is
> > > using the tuner and owns the media pipeline.
> > >=20
> > > I am going to clarify this in the commit log. =20
> >=20
> > I guess I'll need the explanation, yes.
> >=20
> > How can usb soundcard use the tuner? I thought we'd always have
> > userspace component active and moving data between tuner and usb sound
> > card?
>=20
> It sounds that the description of the patch is not 100%, as it seems
> that you're not seeing the hole picture.
>=20
> This is designed to solve a very common usecase for media devices
> where one physical device (an USB stick) provides both audio
> and video.

Aha, ok, it makes sense now. Thanks!
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwM/moACgkQMOfwapXb+vKOCACcCSevIvvLj57RR7yYVXHr54DH
emcAoK0Pb/5LFFQjUm/27hJjWMsRwkXQ
=XydS
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--

--===============6645910780067889961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6645910780067889961==--
