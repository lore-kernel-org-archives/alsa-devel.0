From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 3/7] ASoC: Intel: sst - add pcm ops
 handling
Date: Fri, 17 Oct 2014 17:05:23 +0530
Message-ID: <20141017113523.GR1638@intel.com>
References: <1413469819-18775-1-git-send-email-vinod.koul@intel.com>
 <1413469819-18775-4-git-send-email-vinod.koul@intel.com>
 <20141017120710.GG1820@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2584474261293590203=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id E31662606A3
 for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2014 14:11:26 +0200 (CEST)
In-Reply-To: <20141017120710.GG1820@sirena.org.uk>
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


--===============2584474261293590203==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LpcCHpaCAbC4X43d"
Content-Disposition: inline


--LpcCHpaCAbC4X43d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2014 at 02:07:10PM +0200, Mark Brown wrote:
> On Thu, Oct 16, 2014 at 08:00:15PM +0530, Vinod Koul wrote:
>=20
> > +int free_stream_context(struct intel_sst_drv *ctx, unsigned int str_id)
> > +{
> > +	struct stream_info *stream;
> > +	int ret =3D 0;
> > +
> > +	stream =3D get_stream_info(ctx, str_id);
> > +	if (stream) {
> > +		/* str_id is valid, so stream is alloacted */
> > +		ret =3D sst_free_stream(ctx, str_id);
> > +		if (ret)
> > +			sst_clean_stream(&ctx->streams[str_id]);
> > +		return ret;
> > +	}
> > +	return ret;
> > +}
>=20
> I keep on asking for this to print an error on double frees.
Okay looks like I missed this instance though I do rember fixed another one.
I will fix it up.

>=20
> > +/*
> > + * sst_get_sfreq - this function returns the frequency of the stream
> > + *
> > + * @str_param : stream params
> > + */
> > +int sst_get_num_channel(struct snd_sst_params *str_param)
>=20
> Cut'n'paste error in the kerneldoc.
Oops will fix

--=20
~Vinod


--LpcCHpaCAbC4X43d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJUQP77AAoJEHwUBw8lI4NHEHQP/1NoAE7LddcqVR48qOkSFF/S
vK4Ri6o/IVkgE35WZfckcQ3lYvvzycVJoKn19Rg/oWFSV5vOZdxx/MBlVI65egYb
ZWzttDjOs4n4xCeJOsiqJIKpxTHKl1PtCZwaDjq37N2aZWIwENem+w6M847+2A/E
OpDTpbiNhsoMzqJ6TKGjsy2z443sO0FuRNkj0T3bgXvvoI7M0nme6LIQHKWOkB8K
/uEKXOmXu8pjNUrC67i4tIj7m0fDV0kebOQCRkOEzRzRPGRtedaqiNTPgU4pKf8W
BTUw5FL/pPtyUk1qudYH03OP9lZtQrg1H8+CQLUAiylqaqyC3z6LpKv0dZOPrdKf
1Wv+JkPMU3lRE+8UGrqxjLplY9ls7yfM2tqWhmGVEjwB4hFiXpNme0AI0mXP2LBQ
vcUik/Pd3uSsJGBzOIhvWjvqFblhCMPxvz5W3hCBMv6fKq/j4q7VLKQ+L76L7NA4
aU0vVqhwRIkgn85FZCL35zGtwm/7nWsXnFbYxZdQ5SnFfataQTmGL8JY+F9OwepY
HE5K6q7Rpiy3wtnW7cKQ48nUT0+h+6exVScWghQ6ZDBZ+VlHiR25Y+wng9JWnISe
qKA6X49evb5XYTy53lh3yZmB9OHN4bRg1Jhc90LgiRWEk47KziFTmK5FQkSxHdFB
Stp4Bm24I2xlYVkg8jlv
=zJAV
-----END PGP SIGNATURE-----

--LpcCHpaCAbC4X43d--

--===============2584474261293590203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2584474261293590203==--
