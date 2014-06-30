From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sgtl5000: fix devres handling
Date: Mon, 30 Jun 2014 15:44:17 +0100
Message-ID: <20140630144417.GY23300@sirena.org.uk>
References: <E1X1YLq-0004E1-MT@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4538021929745214954=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ABDEF261A1A
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 16:44:45 +0200 (CEST)
In-Reply-To: <E1X1YLq-0004E1-MT@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4538021929745214954==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iK1l7ZgcrJDTNPEn"
Content-Disposition: inline


--iK1l7ZgcrJDTNPEn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 30, 2014 at 10:58:18AM +0100, Russell King wrote:

> You may wish to give some consideration to whether ASoC core code should
> be doing this instead, this is probably a very common source of brokenness
> where two-stage driver initialisation exists.  These kinds of issues are
> why I consider (as a general rule) that two-stage driver initialisation
> is really bad.

What we've been doing here is getting everyone to move their resource
allocation to the device level probe where it should be, leaving only
things that genuinely need the card to be there (mainly controls and so
on) in the ASoC level probe.  Is that possible for this device - now
that it's been converted to regmap I'd expect so?

--iK1l7ZgcrJDTNPEn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTsXe9AAoJELSic+t+oim99fsP/juHp3My9bDZ7u8PWkfKVxaM
lurwJJfY01x79JC9amOjyp4y/XXuuyhb1Nr5gPQy2KInvhQ4Qetvqvh2J0bRviZO
6B1wK+sbNI3ylyvMB2k3o5GUHerA1p4zgrinTej0EGMyyBJEkHPZxEHkq7mDlAW0
yno3yvp5rK1SAWXj/6qMn2j0xYc9l/LeSTXkOAiqOJaZoPqJval0DwpsGTrA/+ZF
E1MQQyLuwvNEX7ab5SvwjpjhckeJX4ztLcJzGZQ5WCHcjBBGtYrCP/sTJcL5VVOM
8UfaVzeHHtr5HLlYGoBEKmXh/91O9S1sT+nYliJce92gFIve4fY24ot6d6D/aSES
mRlxlelUuAVljBhlkr240cueij/N2iYiglw+NTNqGJLjnwjFDX7iS/qy4CkqWPBj
hUS10WEdFLRTu2wsu4ze7perrvQsZlzJDZp584L0jO42YB0E/7JN1O0331DsTa1B
4sMTUyT9rrIXynUgRLLBV3WluvPwPk1omJ/IfDs77Nm0LAmkXe9keIGojmJ+B4/+
P+8Eii9VF1XCSEm9YQhQ7pNvr5m6+2EsrviQDpIHyyys1cpRKvYhmJApsptUWbSr
UGsQuUVkAgY2bJTjFieae0bPnMVrqDTloq10EJc/X/7DB8R+pqnNj+LHDpHSGyza
aitXJWV3z9mcm7tPAOQe
=g6oc
-----END PGP SIGNATURE-----

--iK1l7ZgcrJDTNPEn--

--===============4538021929745214954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4538021929745214954==--
