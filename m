From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 4/8] ASoC: topology: ABI - Add name
 element to snd_soc_tplg_stream
Date: Wed, 7 Oct 2015 11:08:34 +0100
Message-ID: <20151007100834.GD12635@sirena.org.uk>
References: <08b095d38f59c43690daaa45e1d201f367812228.1443605139.git.mengdong.lin@intel.com>
 <20151002165907.GU12635@sirena.org.uk>
 <1443809055.10986.10.camel@loki>
 <F46914AEC2663F4A9BB62374E5EEF8F84B84FF3F@shsmsx102.ccr.corp.intel.com>
 <20151006103403.GH12635@sirena.org.uk>
 <1444144590.25504.27.camel@intel.com>
 <20151006162520.GB30592@sirena.org.uk>
 <5613F850.1040605@metafoo.de>
 <20151006173654.GY12635@sirena.org.uk>
 <F46914AEC2663F4A9BB62374E5EEF8F84B85136A@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6842971618141807718=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BC842265AE8
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 12:09:24 +0200 (CEST)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F84B85136A@shsmsx102.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, "Koul, Vinod" <vinod.koul@intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "tiwai@suse.de" <tiwai@suse.de>, "Kp, Jeeja" <jeeja.kp@intel.com>, "Prusty,
 Subhransu S" <subhransu.s.prusty@intel.com>, "Patel,
 Vedang" <vedang.patel@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6842971618141807718==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NIVOymhGwNk6AW2u"
Content-Disposition: inline


--NIVOymhGwNk6AW2u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 07, 2015 at 09:48:37AM +0000, Lin, Mengdong wrote:

Please fix your mailer to word wrap somewhere a bit nearer to 80
columns.

> > Yeah, I think we're kind of stuck with some degree of fairly tight coup=
ling at
> > some point though - at some point we're going to need to work out which
> > link in the driver corresponds to which link in the firmware file.

> There is a 'version' field in struct snd_soc_tplg_hdr, which is a vendor-=
specific version number.
> The driver can check this field of a firmware topology and decide whether=
 to support this firmware or not.

> Is this okay?

Well, they probably could check that but it's not really the point - we
don't want to break things at all here, we should try to avoid forcing
users to upgrade their userspace with their kernel since that makes life
harder for everyone. =20

--NIVOymhGwNk6AW2u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWFO8cAAoJECTWi3JdVIfQ6oMH/jEzjUtzJj+jQlLSrc5X9OCt
rtUPEr5S0aSY20hPuZX1TRL9qAH24GH4C/Tu4YjHO7k3xYaHQBSnj5D5H7qinHMd
SNwt4hAX3/JGxeNW0yuSJKmAC7qmZ4w7BH+befF1rz45nwTCr+pi6uZMi8f0Z3/9
OzY6CJo/NcAtF2nS3qR+AKWarZqqQFF0/toeCbR/bZAot5nrPPXHDplp8LP/0Mok
uayNo50CGuKmbDpiaGy90uUuZT4bMj8lAKcXSF5OErJuTvNmP5+u5UNeEtqcW65N
hk3ikT+FjE93HNuwJmymFmprr/mXtW354Klm6kVQgGI4l/ZdpEb1MilYfPl5C8w=
=NG7K
-----END PGP SIGNATURE-----

--NIVOymhGwNk6AW2u--

--===============6842971618141807718==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6842971618141807718==--
