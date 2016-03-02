From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFD] Add hw_params support for hostless stream BE
	DAIs
Date: Wed, 2 Mar 2016 11:02:15 +0900
Message-ID: <20160302020215.GN18327@sirena.org.uk>
References: <20160216161747.GA18103@jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4882645150522069394=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A5252614D6
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2016 03:02:31 +0100 (CET)
Received: from e0109-106-188-111-59.uqwimax.jp ([106.188.111.59]
 helo=finisterre)
 by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
 (Exim 4.80) (envelope-from <broonie@sirena.org.uk>)
 id 1aaw7R-00066R-0E
 for alsa-devel@alsa-project.org; Wed, 02 Mar 2016 02:02:29 +0000
In-Reply-To: <20160216161747.GA18103@jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: tiwai@suse.de, vinod.koul@intel.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============4882645150522069394==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+Ynv2hSkSgugk2Bq"
Content-Disposition: inline


--+Ynv2hSkSgugk2Bq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 16, 2016 at 09:47:47PM +0530, Jeeja KP wrote:
> We have no mechanism to configure hw_params for DAIs which are hostless.
> Like a loop or DAIs connected to internal sinks/sources.

Please propose patches, don't send enormous design documents.  They're
big, take a long time to read and don't really get us anywhere unless
they're extremely clear.

> Approach:
> 	1. Allow params to be defined for other BE dai link also. this
> 	currently applicable only for codec_codec link.

Like I keep saying if you're thinking about this in terms of DPCM you're
solving the wrong problem - we already support supplying parameters for
device<->device links, we already have systems that need to configure
things for device<->device links so we can already see that if we're
doing something that only works for things that are on SoC and can use
DPCM then we're not solving the problem.

DPCM works pretty well for small, simple DSPs that are mostly in line
in the middle of a standard DAI but it does have limitations which
you're now running into.  Your systems don't fit well with what DPCM
supports naturally.

> struct snd_soc_dai_link {
>         const struct snd_soc_pcm_stream *params;
>         unsigned int num_params;
>=20
> +       /* flag to create codec codec based on the flag*/
> +       unsigned int codec_link:1;
> +

This is clearly confused, if we can't figure out what the two devices we
are connecting are based on just looking at the devices then that's
really not a good sign that our interfaces are sensible and easy to work
with.

--+Ynv2hSkSgugk2Bq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW1kmmAAoJECTWi3JdVIfQQ84H/jry4ty72DK0KvI68o1RDRcm
K/KF6FqZlWYcYfX0BTpsWnhbgdjlBj1as6J7mEfX6L/fbCmqIIJS9ryU+0I/hSV4
SU+OG6I8sDXneIUTMSPY6/UVTrooBxXNz/AItHh+IkY+CTs9aP2QPtzg+Mqu8zJJ
ubj9q/3NeshmAboID5uZoIFSuDRd/j03Ieh3beeAKupKwKtJpCsoO3abHk4a10SG
QfzWegAxWKPRCB9Gu5lFGrU9Zl8zQfkiOrJA4/d2d+sAZ7FVbZ+EZC8nGLLYhJvq
aQ3Jomen40R7RgLU2Ms4JgwWpx0RrUSIT8wFothvqXscwtL4Jh0AkHOmPZaXOCU=
=CnTx
-----END PGP SIGNATURE-----

--+Ynv2hSkSgugk2Bq--

--===============4882645150522069394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4882645150522069394==--
