From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cs42l52: Fixes for Beep Volume
	kcontrol (fwd)
Date: Mon, 5 Aug 2013 19:42:33 +0100
Message-ID: <20130805184233.GB9858@sirena.org.uk>
References: <alpine.DEB.2.10.1308051050270.5288@heelrod.ad.cirrus.com>
 <20130805162016.GR9858@sirena.org.uk>
 <alpine.DEB.2.10.1308051318580.5288@heelrod.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7591570744063064534=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 154A226519B
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 20:42:36 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.10.1308051318580.5288@heelrod.ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7591570744063064534==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iGGQaRHzQ9dxg51H"
Content-Disposition: inline


--iGGQaRHzQ9dxg51H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 05, 2013 at 01:21:05PM -0500, Brian Austin wrote:

> In trying to split up this patch wouldn't the TLV also be a bugfix?
> Currently it is using a scale that is not correct for this control.
> So really it seems this is 2 bug fixes in 1 patch. Correct?
> Shouldn't they both go to stable?

Ah, the changelog said "add" not "replace existing incorrect" - yes they
can both go to stable.

--iGGQaRHzQ9dxg51H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR//IWAAoJELSic+t+oim9eREP+wRjWUtc22AiXZaTpEVRO8UO
9+HIqKmRECXULUMLvS0ARx5IU7dyXAgvx2h19ziNUXeCMBnWixM+sCYAB5aarVJs
T8XiSyKAUzfvUgY0GqqmdtUa0ysTAxFs1Da9lgoResWhNmtq1iD5LpMf9cRNMO+N
9UGFFKHwpU2gQE/pxPk+xeH9hfw/7PwhLgJ+YjNg3cYLlYzelM5QZK8wJyfdqx3z
DEY/PslJchRkIc8ey2cY8OjauVu4QWN2oZJmtc/xsva0FWwOTDpVN7MK4+3v+cLd
cGVwM6orAsfzj5d030gkg9THm33Z4u/zcss/xWh4hjHLv7iN5Ze1fvC2g8wryUqJ
R7IflRvNCjxGPILXOED2xn57I+DYlk+E4satlEfkx13FdGy3HDlXEq6NBOt2W2lv
fPU4jMtfbHhsaOCbnBRLPxpifG7+2yHXlOcmd7J89YYiusDdH7hpAOmXFYDq/Ssg
inW+Cz0XaW1LqVU+sMO6thZSR5m6zufuWDXu5PElRX5yPzRk/+b18N2guDpoPSk5
CCDgmrUVLf/Ai8EPl/0srboaUV1q9h/ALph9whbbP+ToLmVxACBetjqGkpB6Grel
4NaLda3+1f+e7hPjxpoukkdSCOdx54HpvSWrtjveeZEUtcEbI1PXexnqLTZnKN+0
hA+imxlK7CFGkEtvl9Au
=4hNb
-----END PGP SIGNATURE-----

--iGGQaRHzQ9dxg51H--

--===============7591570744063064534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7591570744063064534==--
