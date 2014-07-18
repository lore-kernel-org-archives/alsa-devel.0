From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 7/7] ASoC: Intel: sst - add compressed ops
	handling
Date: Fri, 18 Jul 2014 19:53:39 +0530
Message-ID: <20140718142339.GG1985@intel.com>
References: <1404898076-1882-1-git-send-email-vinod.koul@intel.com>
 <1404898076-1882-8-git-send-email-vinod.koul@intel.com>
 <20140718114823.GN17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7167989612396460803=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D9561265649
 for <alsa-devel@alsa-project.org>; Fri, 18 Jul 2014 16:28:05 +0200 (CEST)
In-Reply-To: <20140718114823.GN17528@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7167989612396460803==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Content-Disposition: inline


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2014 at 12:48:23PM +0100, Mark Brown wrote:
> On Wed, Jul 09, 2014 at 02:57:55PM +0530, Vinod Koul wrote:
>=20
> > +	if (codec->codec =3D=3D SND_AUDIOCODEC_MP3) {
> > +		codec->num_descriptors =3D 2;
> > +		codec->descriptor[0].max_ch =3D 2;
> > +		codec->descriptor[0].sample_rates[0] =3D 48000;
> > +		codec->descriptor[0].sample_rates[1] =3D 44100;
> > +		codec->descriptor[0].sample_rates[2] =3D 32000;
> > +		codec->descriptor[0].sample_rates[3] =3D 16000;
> > +		codec->descriptor[0].sample_rates[4] =3D 8000;
> > +		codec->descriptor[0].num_sample_rates =3D 5;
> > +		codec->descriptor[0].bit_rate[0] =3D 320; /* 320kbps */
> > +		codec->descriptor[0].bit_rate[1] =3D 192;
> > +		codec->descriptor[0].num_bitrates =3D 2;
> > +		codec->descriptor[0].profiles =3D 0;
> > +		codec->descriptor[0].modes =3D SND_AUDIOCHANMODE_MP3_STEREO;
> > +		codec->descriptor[0].formats =3D 0;
>=20
> It'd be more idiomatic to copy a static variable.
will update...

--=20
~Vinod

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJTyS3rAAoJEHwUBw8lI4NHCNMQAM21yNnwzj4nsBy1QjT3SeaH
kxk653kDjexfaCKsW3B7UBPBpSOMQz7t+zApda3i1IpXOVvqfA8lM/M8Hw+gzcVn
1CGoNgVoCtCtPyKRJrVXP+twSN5bPpk/ZS9DPZTJ9PmcIZJyPCC7EIxLGfY1DE/t
DtZfvOBdrq5FgTIxHENCgm6peiWvS2FirRxPbh6F72u29kICopfjqDkBLGXkLs0c
W+fU/4UAaxwPg6dByyRaAUveRKVaxJMwdU92NNPFNJlbFe1FiPmxU2r5X0QnJBk9
j/fb8Q7eROC+gYvlyBxns24+CbduRy+1PafkSVBef5nTFHl5P1viY2Dnfnhd/V6K
6w8kv5TjBkFmR+sX90lIds0kdMXIe9004KFD34zFOhzUWyQ78m4+zEdG4Nh5eVG8
p6pQuId1xMrZp7DQ96LFU+AwFzZwu3zdHDTdCrZph8WZHYgwph5YWJ1cDIb+LhUV
SVJLTEseYW/tyx6Kev6E3Fz3u3w6V7gR43YDyAjtLCMZ+/ryudqJztOdD1cdYf5w
gvmceQk92uBO/GsINyA5n44CWLiUlGDMhplb//dEtRVyCVGA3muMpUH3/NU0eYQI
M+nn76exOlvP78He7QeJT0KXRLCSMeuXu69c+abHgI4bx/1yDm6GTnwzcqq9JDRE
JeOmKLAoxEEafOdEweJt
=O4fk
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--

--===============7167989612396460803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7167989612396460803==--
