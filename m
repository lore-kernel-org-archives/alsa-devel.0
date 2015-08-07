From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: extend seq_notifier callback
	interface
Date: Fri, 7 Aug 2015 11:44:19 +0100
Message-ID: <20150807104419.GN20873@sirena.org.uk>
References: <1438902946-49633-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4906011831810019705=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A57D26044D
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 12:44:25 +0200 (CEST)
In-Reply-To: <1438902946-49633-1-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: yang.a.fang@intel.com
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, Anish.Kumar@maximintegrated.com, praveen.k.jain@intel.com, lgirdwood@gmail.com, denny.iriawan@intel.com, sathyanarayana.nujella@intel.com, ullysses.a.eoff@intel.com, kevin.strasser@linux.intel.com, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org


--===============4906011831810019705==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pzbJLE37+dCGloGb"
Content-Disposition: inline


--pzbJLE37+dCGloGb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2015 at 04:15:44PM -0700, yang.a.fang@intel.com wrote:
> From: "Fang, Yang A" <yang.a.fang@intel.com>
>=20
> This is needed for some codec driver to know whether
>=20
> it is power up/down sequence call from dapm

This isn't a good changelog - it's not enough to say what the change is,
you should (especially for a core change like this) be explaining why
the change is needed.  For example in this case why do CODEC drivers
need this information?

You've also got a random blank line in there.

--pzbJLE37+dCGloGb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVxIwDAAoJECTWi3JdVIfQHWMH/jSiM1Y2jK2yrK7HBXs+jwsS
S2H0CrHhSMK76yje6VNTNUx11XToGxMIwv4EnbmDoZcc9ixnxoS+THX9ljFYEDtu
UjftL5DVv+GUQjjg0TcfFHcGuWjjch14bDaUiYawmYVEKY0HHy5NYSJF6TtWVO0S
rXc3cgiPrmUZsoWDOzkck14WC0DNmEU3UcPgMnEYTAO3mjZWy34pUn8lrPWha6hJ
YsTF6pj6/z1kvfRfAFuQ/X827v248Nljj5dDaTFOWWL3IiMHudtoXu/cVC//bS0V
/xN1wnGn6f0hzlGC0/R9qErD7IHjcCNNHqwFz5agxmdb5CifNxSAKHSeTuw3srI=
=HtwM
-----END PGP SIGNATURE-----

--pzbJLE37+dCGloGb--

--===============4906011831810019705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4906011831810019705==--
