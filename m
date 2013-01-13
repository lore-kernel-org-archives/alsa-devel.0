From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 6/8] ASoC: Constify ops and compr_ops
 fields of snd_soc_dai_link
Date: Mon, 14 Jan 2013 07:55:28 +0900
Message-ID: <20130113225527.GG5041@opensource.wolfsonmicro.com>
References: <1357833977-3682-1-git-send-email-lars@metafoo.de>
 <1357833977-3682-6-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3821248733950852024=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ECD73265114
 for <alsa-devel@alsa-project.org>; Sun, 13 Jan 2013 23:55:33 +0100 (CET)
In-Reply-To: <1357833977-3682-6-git-send-email-lars@metafoo.de>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============3821248733950852024==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xs+9IvWevLaxKUtW"
Content-Disposition: inline


--xs+9IvWevLaxKUtW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 10, 2013 at 05:06:15PM +0100, Lars-Peter Clausen wrote:
> The core does not modify these fields, so they can be made const. This allows
> drivers to declare their op tables as const.

Applied, thanks.

--xs+9IvWevLaxKUtW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ8zkNAAoJELSic+t+oim9mbkP/2DmZ1E4QU/k9iPnag13o5yr
xjOpYmacBhYtFrzsviV7mTUswQNebsk21ltesFwRL1zbh0nuXYBgeTwzSfwJu+Dy
TqSrbodezq8zO4JzNvf7ikhxKJQB35K9F4fG5pAfz1wQ/ugWZoeqtEOz5SS+0hHR
va+n6aiINwwkgOI6yt6f8xDOkRnCg4xDkxKbMjT4diAZIOlOKgp5OPjqtonZruBm
2FJ0H+CcksZSQhB9jnQNvgD/mnE1E16Zqd4dC/fy9rH8uqGlXmy1SAIQCB8TNcsX
ngHVnvxuLmpnCoz48pwFLQDuMmzb8bFB1KRuQvJ8EAGXcOmBu6aYJAZWARZk7shN
QnjGdjatqhwmt+wLZ34AUNOsVCB6qK4zSxQy13m/BjO3NvtE7wacoBHM1ZAM2w/K
0jz2c1Vh4YnIiUgPKOrPZv3AKMzMXdF8PH+bmstidtQcb3+WwGxv0Z6+TtfQUXfg
r/5KnM+8rtiBzRU8tcnVRnKQLTSaTbcWYtQTbl0EN3kYuArWcriQxgNwZuWhC2sQ
I4ySfKL7neN7quu6oL5qV99EzyOfNoPlMFg/gw+bINmTGsXMEvh0bML3iPzu8wDP
FdKI5k0xGfg9VmcbywDARU2ZVC7Gaavaaml7kxTo+JLLTKM93OQjx9uKnu2TLzkI
qIQRagnvjIwVJWLU1pLE
=MDtV
-----END PGP SIGNATURE-----

--xs+9IvWevLaxKUtW--

--===============3821248733950852024==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3821248733950852024==--
