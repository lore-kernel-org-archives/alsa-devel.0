From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/17] Baytrail audio fixes
Date: Thu, 18 Aug 2016 17:35:33 +0100
Message-ID: <20160818163533.GR9347@sirena.org.uk>
References: <1471037280-17433-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <928a31f5-d032-c06c-f59d-04d0d7ef1220@linux.intel.com>
 <20160817105032.GJ9347@sirena.org.uk>
 <5a448c3a-3f72-f753-e92f-43442c48f3e7@linux.intel.com>
 <20160818092929.GM9347@sirena.org.uk>
 <5e408cf5-cb8c-0588-021a-8b8fa5aa6321@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5289186364017655611=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 87D63266011
 for <alsa-devel@alsa-project.org>; Thu, 18 Aug 2016 18:36:07 +0200 (CEST)
In-Reply-To: <5e408cf5-cb8c-0588-021a-8b8fa5aa6321@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, irina.tirdea@intel.com
List-Id: alsa-devel@alsa-project.org


--===============5289186364017655611==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5mu1Tvth33Vj8K2q"
Content-Disposition: inline


--5mu1Tvth33Vj8K2q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 18, 2016 at 11:22:38AM -0500, Pierre-Louis Bossart wrote:
> On 8/18/16 4:29 AM, Mark Brown wrote:

> > No, if there's any need to do a merge we'll do a merge.  Does this
> > actively break existing boards?

> No for all the Baytrail-CR boards who never worked before.

Ah, good - that's what I thought.  So long as it's just that the new
stuff doesn't work yet that's not such an issue.

> But I believe it does for the T100/DellVenue, but we could have a mechanism
> to fall back to BCLK when MCLK is not available. Let me look at it later
> today.

Hopefully we can get the clock side merged quickly, it looks fairly
straightforward.

--5mu1Tvth33Vj8K2q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEbBAEBCAAGBQJXtePUAAoJECTWi3JdVIfQxyAH+KCDjQ+y9Mgb71ugu10pfTnW
MoYulnp2jpW7vCvIMW02lISRTI3CJi3NQcxvTccXzDBkcWuBD+Qw+GRxDLZhdtMJ
dZzkzYYTyK7lveI1fqa0y16PMcYDn7MH1XU0nGw9/XG9+ahTYbVRwyCYwu5WqPOL
jJy8x7DIIO7ZpsPh+iHYTMAF4vg8fpRwBJcufIpNN+9eJbTzJI282FX8OzMbFfky
FV0t8LrY+vimc+Kb1kMTSQvvZaQpu9YHTs5tRETnXV5dc4LnDbNoVgdfkFZvOHpa
+kb8baHA/Im/dw2Oj3f6XZwDq2vlV3pz29cLsIaVu80Q4UC6GYN2sJ4ny5gklQ==
=YfXr
-----END PGP SIGNATURE-----

--5mu1Tvth33Vj8K2q--

--===============5289186364017655611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5289186364017655611==--
