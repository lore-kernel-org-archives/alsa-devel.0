From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: soc-compress: add a config item
 for soc-compress
Date: Fri, 12 Jun 2015 14:00:02 +0100
Message-ID: <20150612130002.GX1921@sirena.org.uk>
References: <1434110356-23516-1-git-send-email-yang.jie@intel.com>
 <20150612121449.GS1921@sirena.org.uk>
 <E7B1D079BA13FB44A978CC8F69C7D6A90554A1FB@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3524168578813539926=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 16B68266928
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 15:00:15 +0200 (CEST)
In-Reply-To: <E7B1D079BA13FB44A978CC8F69C7D6A90554A1FB@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Jie, Yang" <yang.jie@intel.com>
Cc: "ramesh.babu@linux.intel.com" <ramesh.babu@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "Zhang, Vivian" <vivian.zhang@intel.com>, "vinod.koul@linux.intel.com" <vinod.koul@linux.intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3524168578813539926==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zuE2pCA56U4I9Fhk"
Content-Disposition: inline


--zuE2pCA56U4I9Fhk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2015 at 12:31:25PM +0000, Jie, Yang wrote:

> > here to make the drivers that do use compressed support select this sym=
bol

> As mentioned in commit message, we need add 'select SND_SOC_COMPRESS'
> to driver  Kconfig(e.g. sound/soc/intel/Kconfig) when it is needed.
>=20
> > and since there's no config text there's no way for users to enable thi=
s on a
> > per system basis so this breaks all existing compressed audio support.
> =20
> Do you mean I should add this message to 'Help' for this config item?
> Per my understanding, no existing driver really uses this compressed audio
> support currently, is that true?

Some of the existing Intel machine drivers have references to compressed
audio, it certainly looks like they're trying to use it.  Are you saying
that this is not actually the case?

--zuE2pCA56U4I9Fhk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVetfRAAoJECTWi3JdVIfQCdoH/R1G3scJu0gkj3CfyAFHmD9a
/DDSNgjuK7cT3XmTaI4Gs82EXwNQLaMNaguAQVB2N14tbH3mf+5Fun30k7SXzaBf
Bo6wKCU4JY5XjY5VMx9F5FKjCRCPY3pyNULYmnw18wUziaHfFOkQ4vqXvAS0beRT
GhPXv0Ub0rDrxPevM03egjl8K6T830mMN8KTLhIPd3rhJkawiILbDJQyRqS6Y+zd
7ayPTgHVOzZjBLzbgzNLBkOGcPw1SjkfZSBeieGYMRzx0I6OGDs1+Wd/id1zUQ/f
7bYBYYxDV/3Yb4xYbKdwcxcHV3LrRFMq9RtbxKZjKdmnT/p3Rm7KRsTgAi/nxlc=
=/yC2
-----END PGP SIGNATURE-----

--zuE2pCA56U4I9Fhk--

--===============3524168578813539926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3524168578813539926==--
