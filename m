From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] regmap: cache: Fall back to register
 by register read for cache defaults
Date: Mon, 1 Feb 2016 22:13:46 +0000
Message-ID: <20160201221346.GJ4455@sirena.org.uk>
References: <1454362695-10682-1-git-send-email-broonie@kernel.org>
 <1454362695-10682-2-git-send-email-broonie@kernel.org>
 <20160201214139.GI4455@sirena.org.uk>
 <CAOMZO5BSbFo7xMEHY9s5YNitKFq8gJ83W6oDnS8PYBBDu2+ykQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5948238927311074176=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 06AB32605D7
 for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2016 23:13:56 +0100 (CET)
In-Reply-To: <CAOMZO5BSbFo7xMEHY9s5YNitKFq8gJ83W6oDnS8PYBBDu2+ykQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--===============5948238927311074176==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2xeD/fx0+7k8I/QN"
Content-Disposition: inline


--2xeD/fx0+7k8I/QN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 01, 2016 at 07:58:54PM -0200, Fabio Estevam wrote:
> On Mon, Feb 1, 2016 at 7:41 PM, Mark Brown <broonie@kernel.org> wrote:
> > On Mon, Feb 01, 2016 at 09:38:15PM +0000, Mark Brown wrote:
> >> If we are unable to read the cache defaults for a regmap then fall back
> >> on attempting to read them word by word. This is going to be painfully
> >> slow for large regmaps but might be adequate for smaller ones.

> > Competely untested, hopefully it helps fix the issues with the SSI.

> After applying this series I get:

Please try to fix it yourself, probably needs setting cache_bypass
around the manual fill.

--2xeD/fx0+7k8I/QN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWr9iZAAoJECTWi3JdVIfQTAoH/1eOmlpcARl5fBZnko80VGSc
GCTG+nyzqMStSZVd3CUfgRdfBD0JXFZHZp/JM8kpGqmWJ2XDBoRfBsm4dD421J9S
2aar7K1zBFzqp7R718WFlVZqgnL66MdNQNzvFEgfS6l3whiSWHzyGpYAJc8P5EKl
+Hkolnno2iDxsoxm362Wkb4vw6t2kOxr842zv+8crPSjSt/7yc3XZZqfaU2kP+d2
bIAEmwt6G8omA0MZdufC3+xjMAsW2nN1hEkE3MxenJg6FD2c8GeMMKkXhe18anAs
60XoVNkJvF3DSkLLzy/LUmtZnMlUtuoMDZgVyVKS1ivnKNQeJD6qXYJjVJz49wQ=
=5SeL
-----END PGP SIGNATURE-----

--2xeD/fx0+7k8I/QN--

--===============5948238927311074176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5948238927311074176==--
