From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v9 1/6] ASoC: Intel: mrfld: add the gain
	controls
Date: Wed, 15 Oct 2014 15:53:03 +0530
Message-ID: <20141015102303.GM1638@intel.com>
References: <1413356701-8535-1-git-send-email-vinod.koul@intel.com>
 <1413356701-8535-2-git-send-email-vinod.koul@intel.com>
 <20141015104947.GC27755@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5064498459552175219=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 480E126041B
 for <alsa-devel@alsa-project.org>; Wed, 15 Oct 2014 12:58:34 +0200 (CEST)
In-Reply-To: <20141015104947.GC27755@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5064498459552175219==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HuXIgs6JvY9hJs5C"
Content-Disposition: inline


--HuXIgs6JvY9hJs5C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2014 at 12:49:47PM +0200, Mark Brown wrote:
> On Wed, Oct 15, 2014 at 12:34:56PM +0530, Vinod Koul wrote:
>=20
> > +static const struct snd_kcontrol_new sst_gain_controls[] =3D {
> > +	SST_GAIN("media0_in", SST_PATH_INDEX_MEDIA0_IN, SST_TASK_MMX, 0, &sst=
_gains[0]),
> > +	SST_GAIN("media1_in", SST_PATH_INDEX_MEDIA1_IN, SST_TASK_MMX, 0, &sst=
_gains[1]),
>=20
> > +
> > +/* the SST_GAIN macro above will create three alsa controls for each
> > + * instance invoked, gain, mute and ramp duration, which use the same =
gain
> > + * cell sst_gain to keep track of data
> > + *
> > + * To calculate number of gain cell instances we need to device by 3 in
> > + * below caulcation for gain cell memory.
> > + * This gets rid of static number and issues while adding new controls
> > + */
> > +static struct sst_gain_value sst_gains[ARRAY_SIZE(sst_gain_controls)/3=
];
>=20
> The use of ARRAY_SIZE() is nice here but I'm a bit confused about the
> divide by 3 - there's an entry in sst_gains referenced for each element
> in sst_gain_controls.
Thats is the reason added the comment above.

gain cells are used to represent the three ALSA controls. So SST_GAIN macro
expands expands to three kcontrols. If we have 5 names in array, then
ARRAY_SIZE once expanded will tell me 15.

But for gain cell allocation, we use single gain cell in firmware to
represent all three controls, so that is why we divide here by three when
allocation the gain cells. Here in example we need only 5 cells. So SST_GAIN
macro has to be compensated for by dividing by 3 :)

Thanks

--=20
~Vinod

--HuXIgs6JvY9hJs5C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJUPksHAAoJEHwUBw8lI4NHwlcP/RIKj+wO6K0dGTilJ1fiFuyL
KSvrL8yS+tvK8ktP9W8xxeXpGfuK+gZxQLmnjfTbWaDpskripXeUtzlvmtdrfLM5
ugYQss32JcQVQeEBiRkYREIiT8psQat9NtchHs3SpebIrB9S3ZRQqWqAI98AQlWu
3gWdAd4aLD1xZgD6W5P7Uvdfb+Xy4F2gs8sF6s8Ea5KRPW40YUNorNcAyDbJ1zLr
KXUoLYatEztabjI+iuGbgqKzK1u69SiIRaelANU1stjbz9F19jIs9yrShXK9gnJV
U5T0rbqmsG1lWEnJIiU31ETmEOHnLhsMRbVx972ctIhVVIoTTD7DYEl+0KmcdDtO
BE0TXvSBR6xLSwCDHabwLxR1FWz7YPLVpBctysA7OS29UJL+9ZAwgcBpP0HwYi+n
9XF9QlmFkQCQTBBAXqpz8fKRnqta6yJ/59LBDi9LwE6nDkLD/5W8LJ+pNoBEoCRk
ZIcH/HUAKHjrcmg3+xM47OANqj31FSWtoGunHmU0jXdY7tO9N6dGxb+YX6tX+D54
T1YBivKWGDP/TgKZy92a8BD14MYn+ydCCzO6ytoClFZ9z3FJ7KQ9tkVq3o51XNNX
3jxBkCcP5U0UZSYhJex7bWGJfydwNCG4HOsh3rhEK1tWN+1fZwjnGnnEd2FBJxeX
qpYv4s/9dC4oWTfXFIvy
=30Qv
-----END PGP SIGNATURE-----

--HuXIgs6JvY9hJs5C--

--===============5064498459552175219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5064498459552175219==--
