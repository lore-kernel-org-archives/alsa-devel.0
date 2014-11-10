From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: tlv320aic3x: Add output driver
 pop reduction controls
Date: Mon, 10 Nov 2014 13:27:25 +0000
Message-ID: <20141110132725.GP3815@sirena.org.uk>
References: <1415615253-28919-1-git-send-email-peter.ujfalusi@ti.com>
 <20141110105155.GL3815@sirena.org.uk> <5460BC38.9010707@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7965095627379498221=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 32B5D2610A7
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 14:28:47 +0100 (CET)
In-Reply-To: <5460BC38.9010707@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7965095627379498221==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cFzf7FtGyCxP0iFx"
Content-Disposition: inline


--cFzf7FtGyCxP0iFx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 10, 2014 at 03:23:04PM +0200, Peter Ujfalusi wrote:
> On 11/10/2014 12:51 PM, Mark Brown wrote:

> >> +	/* Pop reduction */
> >> +	SOC_ENUM("Output Driver Power-On time", aic3x_pop_reduction_enum[0]),
> >> +	SOC_ENUM("Output Driver Ramp-up step", aic3x_pop_reduction_enum[1]),

> > Don't add arrays of enums with magic number indexes like this, it's hard
> > to read and hence error prone.

> I agree on this. I have not changed this since this driver is using enums like
> this and I thought it is better to follow the style.

> But if I add these to the aic3x_enum[] array with a define for the ID I think
> it is going to be a bit better?

A bit, though I think I'd still prefer to use individual variables, it's
less to fix when someone does get round to fixing the driver.

--cFzf7FtGyCxP0iFx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUYL08AAoJECTWi3JdVIfQ48wIAIAJSkPR1HCvsNYnotYxNsNt
jgM6xeNLptVGecXmX2c2Y2ofOM9hK8L0RwVdlAyJDYVQbvhnrgXtI2NeMC9lNieu
2NI0PBcFjz/qxG3ZQ8YCkylG3iqZJGmff8Sj5phnyfP5ZjtcKcmva54C3HGfnbNg
IqSW9JL4b1B9z4ilmxS65OTzE0dpHDeHASoVheAYhzSmo7NdE2XWHyAjytwO4NYa
w06TKwLmiyf0EN93YC+t1aRpZh3FjdP0Foq5a6R6KoS3zvG+tj+aXZKPCzNIrpbY
oJWfO9E+poFI8uj7sE4eeGZ2vC/gMs7mr+D1ufXnWEuBzNxtsYC9Yox/SouVMRQ=
=uyCu
-----END PGP SIGNATURE-----

--cFzf7FtGyCxP0iFx--

--===============7965095627379498221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7965095627379498221==--
