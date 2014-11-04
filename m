From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: Remove card field from
	snd_soc_dai struct
Date: Tue, 4 Nov 2014 11:54:10 +0000
Message-ID: <20141104115410.GP3815@sirena.org.uk>
References: <1415097059-14551-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5824526390159792528=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EDF9926060B
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 12:55:25 +0100 (CET)
In-Reply-To: <1415097059-14551-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5824526390159792528==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hI0HXimLkvfVxAyB"
Content-Disposition: inline


--hI0HXimLkvfVxAyB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 04, 2014 at 11:30:58AM +0100, Lars-Peter Clausen wrote:
> The card field of the snd_soc_dai field is very rarely used. We can use
> dai->component->card instead and remove the card field from the snd_soc_dai
> struct.

Applied, thanks.

--hI0HXimLkvfVxAyB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUWL5hAAoJECTWi3JdVIfQDl0H/j4eHSfZ4vZcHUwAfPwZkYtY
zLJZYdQExxyTz9Ngb2JREZm1xhq0qsba+hRBHO9CW1YJFUGgXpXVKQla9l+JntIG
GUwckaePrFYZJ3bagF49Srh1iQV9CfYQGgkRrWt+x/K2dZTX92gWocGSOedcs2mc
nrC6tLxUXpJZkwcB+XRCEbkGhMS1G6MViDZldIMRurGrfRANCRYZm01Nd3zUURJX
RsLpDVzui4aXeYXzGDEfoG9iMcRS0F/BwK/yQ/n19wlfhC1AK/xF/F+IraDvLoE6
SvuMkg4il0S03vz8G65X3TfgYQhnDzoPw5hNUnuMbidpw2hQJb5Bs5XIwiyQCYw=
=eOrc
-----END PGP SIGNATURE-----

--hI0HXimLkvfVxAyB--

--===============5824526390159792528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5824526390159792528==--
