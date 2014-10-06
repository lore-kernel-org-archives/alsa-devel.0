From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v7 5/7] ASoC: Intel: mrfld: add the DSP
	DAPM widgets
Date: Mon, 6 Oct 2014 08:14:35 +0530
Message-ID: <20141006024435.GR1638@intel.com>
References: <1411125368-5836-1-git-send-email-subhransu.s.prusty@intel.com>
 <1411125368-5836-6-git-send-email-subhransu.s.prusty@intel.com>
 <20141002181228.GA4273@sirena.org.uk>
 <20141006024010.GQ1638@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4257259366694321173=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 96CE62605A9
 for <alsa-devel@alsa-project.org>; Mon,  6 Oct 2014 05:16:55 +0200 (CEST)
In-Reply-To: <20141006024010.GQ1638@intel.com>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4257259366694321173==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aYDVKSzuImP48n7V"
Content-Disposition: inline


--aYDVKSzuImP48n7V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 06, 2014 at 08:10:10AM +0530, Vinod Koul wrote:
> On Thu, Oct 02, 2014 at 07:12:28PM +0100, Mark Brown wrote:
> > On Fri, Sep 19, 2014 at 04:46:06PM +0530, Subhransu S. Prusty wrote:
> >=20
> > > +#define SST_MMX_DECLARE_MIX_CONTROLS(kctl_name)			\
> > > +	static const struct snd_kcontrol_new kctl_name[] =3D {			\
> > > +		SOC_DAPM_SINGLE("media0_in", SND_SOC_NOPM, SST_IP_MEDIA0, 1, 0),	\
> > > +		SOC_DAPM_SINGLE("media1_in", SND_SOC_NOPM, SST_IP_MEDIA1, 1, 0),	\
> > > +		SOC_DAPM_SINGLE("media2_in", SND_SOC_NOPM, SST_IP_MEDIA2, 1, 0),	\
> > > +		SOC_DAPM_SINGLE("media3_in", SND_SOC_NOPM, SST_IP_MEDIA3, 1, 0),	\
> > > +	}
> >=20
> > These should be Switch controls?
> Yup I will fix this one.
>=20
> >=20
> > > +	snd_soc_dapm_new_controls(dapm, sst_dapm_widgets,
> > > +			ARRAY_SIZE(sst_dapm_widgets));
> > > +	snd_soc_dapm_add_routes(dapm, intercon,
> > > +			ARRAY_SIZE(intercon));
> > > +	snd_soc_dapm_new_widgets(dapm->card);
> >=20
> > We should be able to do this from the component but we can't yet...
> We can convert once ready :)
>=20
> I still have lots of stuff to do once this series is in. We also need to
> enable dynamic firmware here once liam upstreams basic support :)

Wanted to check if you have any comments on last two patches, before I
send updated series :)

--=20
~Vinod

--aYDVKSzuImP48n7V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJUMgITAAoJEHwUBw8lI4NHagcQAKwT0vOk6CyY8ozJIIaEwT7k
NdWUbNjLPOTcMy+QEx6DuId/g4wGukRz6T5fKyc7JLp6SNWvu6spPwfqSFvRQ+3A
qTPhLG09nTk59o8FCt6uFH1djjpbp1Az7nLf+cagGyZxxkyBfFl0LE7wZUdJVw4n
th49zHjAzLybh3EZ6UnCCCwWPt8WXeoZ8VezU+a3EJAG11Kup88pl4q5aXkxPXf5
X4egbUiZeP2ODaK0frqxqJW9OkD+NEHhbHFAuek6+iSHIgxGSXlcufHqy5j3wUwN
xJ5DLVPyw34OQeiFWZjxM5QuCRGayRt+GMaTEmKtRK4ZedtBxBSYvfBCuIFt0lii
IkcE4d1dmjlmMVQd3WSQF3unWvYZNK7LzVwiN2KCzUslLdPNPO/ie4T5jOCwhMwi
0RWrN5BKWlx0AEyHithlYpZGbKYQSI3Hx0ivlCXc+7IIPTuJTiiJdyUUB6NHJwjw
OQ1EH5IO0psV3ix2EXytylxJf38D7OIjiTo+rvzqSQzkX2E+9nHipmv2wvtt0rd4
Dcle030yoiLVW6MT6usA/3YN7DpW7UzVqYDnpcr+x7TSz0fKkwjH+xaDuKY0H4eJ
HW7Qu6Z3Blf+YWyVWznmLKHKN4JvsJi8HH/yxWKxVkR5v30z6F5FoulRuLuri6oV
l+sssQDdNefKybeodChZ
=BVas
-----END PGP SIGNATURE-----

--aYDVKSzuImP48n7V--

--===============4257259366694321173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4257259366694321173==--
