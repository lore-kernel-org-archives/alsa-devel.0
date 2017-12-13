From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/10] ASoC: tlv320aic32x4: Remove filename
 from header and switch to SPDX
Date: Wed, 13 Dec 2017 17:00:45 +0000
Message-ID: <20171213170045.GQ6416@sirena.org.uk>
References: <20171212224311.24045-1-afd@ti.com>
 <20171213122824.GI6416@sirena.org.uk>
 <1ec05e88-b605-7ab4-ee5d-b3b73c562a0c@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2097549283232358550=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C033126792A
 for <alsa-devel@alsa-project.org>; Wed, 13 Dec 2017 18:00:47 +0100 (CET)
In-Reply-To: <1ec05e88-b605-7ab4-ee5d-b3b73c562a0c@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============2097549283232358550==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V2tfspbppmK1TQo2"
Content-Disposition: inline


--V2tfspbppmK1TQo2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 13, 2017 at 10:13:21AM -0600, Andrew F. Davis wrote:

> My regex is a bit too rusty right now to handle searching for multi-line
> examples, do you know of anyone else converting the whole block to C++
> style?

> Things will look a lot uglier if we do this inconsistently, if it is now
> the law of the land we do this for the first line, then we should have
> it be the only exception. Everywhere else remaining old style comments,
> IMHO.

I think that's just the limited tooling people are using right now,
we'll need to clean up the automatically generated output.  Unless
people provide tools to enforce styles we're going to end up with
divergence anyway as people start adding new files, they ought to be
going in with SPDX headers.

--V2tfspbppmK1TQo2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloxXLwACgkQJNaLcl1U
h9CT/gf/SNJYZjs4U8PKduE/1GU8YaDYDPj/ioL9aMt7/sy5xKsZl7hMPUZnjGDr
w66tld+P2z4G+lk+ZuOVec/i/hXvaxtdxk3jp9SV+BqUqS741ARTx9qr4Mv0GWsr
VPZ5nUkufTABHrUWNU5FBUPmh1Uy9KVuKH42DuXwadMEVLWZxhR1ypnDIMvK7s3B
f0dwujyDD2kNUYE5+CUNeQSXuWMKUuB6uxcTWBRz2edF7ARokhJ+Ho9OFG+7ymIv
4v9C/7g7Euz+wI+EZMzVKc9fLIjchixTQVzINofe8IN77+YqEf4LhMdEFz/5bcFk
1eoEOjjot/2PIF5o6Yud1ZT4NR5JWQ==
=cisq
-----END PGP SIGNATURE-----

--V2tfspbppmK1TQo2--

--===============2097549283232358550==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2097549283232358550==--
