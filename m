From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] soc-core: Fix volsw_range funcs so
 SOC_DOUBLE_R_RANGE_TLV works.
Date: Wed, 24 Sep 2014 09:36:26 +0100
Message-ID: <20140924083626.GC4015@sirena.org.uk>
References: <1411127431-31144-1-git-send-email-hm@hmbedded.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4851461436144143568=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C2302608C9
 for <alsa-devel@alsa-project.org>; Wed, 24 Sep 2014 10:36:52 +0200 (CEST)
In-Reply-To: <1411127431-31144-1-git-send-email-hm@hmbedded.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Howard Mitchell <hm@hmbedded.co.uk>
Cc: tiwai@suse.de, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4851461436144143568==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVmWh8UkjoBIyGkN"
Content-Disposition: inline


--EVmWh8UkjoBIyGkN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 19, 2014 at 12:50:31PM +0100, Howard Mitchell wrote:
> This fixes a bug when using the SOC_DOUBLE_R_RANGE_TLV macro in
> the invert mode. In the non-invert case, e.g.

Applied, thanks.

--EVmWh8UkjoBIyGkN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEbBAEBAgAGBQJUIoKKAAoJECTWi3JdVIfQT6kH+KAqrRLkHxTSyXNuls2Ke58v
TnN3PL7ENEWJRKi3wZKyEEBeFrP1ORttxoj4VdVd2zdkbU4DoQztvoKlHx0nHd7Z
Ye5TM4gqGHTeVW3BecU/q8ixNI267bCsScRzW2LS7jZojdubzoEEHRQjD6GCWrWU
KzXP6xmbN90C3G/rHbTEhD0cfnr9NVJKUWg4ZbAAItSbrM+rR4bOmXG8m5eTCqjk
H76sAzsB4pKODefXVQUtYOmDZ0st2l+egacU5oNi64BnCAHGdHqoQy3avJJBOhPM
bYaDE9aWxt+KsiYRV1sUvOzZ8OadlLZB8QsTufu8QOLZeh6j5PWGRCIGWWhhRg==
=V3jp
-----END PGP SIGNATURE-----

--EVmWh8UkjoBIyGkN--

--===============4851461436144143568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4851461436144143568==--
