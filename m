From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH v8 1/4] media: Media Device Allocator
	API
Date: Sun, 9 Dec 2018 09:09:44 +0100
Message-ID: <20181209080944.GA7561@amd>
References: <cover.1541109584.git.shuah@kernel.org>
 <e474dd16f1d6443c12b1361376193c9d0efcced6.1541109584.git.shuah@kernel.org>
 <20181119085931.GA28607@amd>
 <73c22137-9c7a-75c8-8cd1-3736c63c2d40@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9160131784896991348=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
 [195.113.26.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3588126796C
 for <alsa-devel@alsa-project.org>; Sun,  9 Dec 2018 09:09:45 +0100 (CET)
In-Reply-To: <73c22137-9c7a-75c8-8cd1-3736c63c2d40@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: shuah <shuah@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, mchehab@kernel.org, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============9160131784896991348==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-12-06 08:33:14, shuah wrote:
> On 11/19/18 1:59 AM, Pavel Machek wrote:
> >On Thu 2018-11-01 18:31:30, shuah@kernel.org wrote:
> >>From: Shuah Khan <shuah@kernel.org>
> >>
> >>Media Device Allocator API to allows multiple drivers share a media dev=
ice.
> >>Using this API, drivers can allocate a media device with the shared str=
uct
> >>device as the key. Once the media device is allocated by a driver, other
> >>drivers can get a reference to it. The media device is released when all
> >>the references are released.
> >
> >Sounds like a ... bad idea?
> >
> >That's what new "media control" framework is for, no?
> >
> >Why do you need this?
>=20
> Media control framework doesn't address this problem of ownership of the
> media device when non-media drivers have to own the pipeline. In this cas=
e,
> snd-usb owns the audio pipeline when an audio application is using the
> device. Without this work, media drivers won't be able to tell if snd-usb=
 is
> using the tuner and owns the media pipeline.
>=20
> I am going to clarify this in the commit log.

I guess I'll need the explanation, yes.

How can usb soundcard use the tuner? I thought we'd always have
userspace component active and moving data between tuner and usb sound
card?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwMzcgACgkQMOfwapXb+vIQkwCfboSZoTYly+FjJatgpBdS3bHX
VlQAn2u6XZ6zbrSsLhKe0NfdcDjS6o4Q
=rWVL
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--

--===============9160131784896991348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9160131784896991348==--
