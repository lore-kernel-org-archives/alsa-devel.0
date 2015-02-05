From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rt286: Fix potencial crash in jd
	function
Date: Thu, 5 Feb 2015 18:17:21 +0000
Message-ID: <20150205181721.GI21293@sirena.org.uk>
References: <1423125634-8367-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5890388808697264337=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C643426509D
 for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2015 19:17:27 +0100 (CET)
In-Reply-To: <1423125634-8367-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============5890388808697264337==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6EVlxZEFeUQbArez"
Content-Disposition: inline


--6EVlxZEFeUQbArez
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 05, 2015 at 04:40:33PM +0800, Bard Liao wrote:
> We assign rt286->codec in rt286_probe. If rt286_jack_detect is
> invoked before rt286_probe, rt286->codec will be NULL and cause
> a kernel panic.

Applied, thanks.

--6EVlxZEFeUQbArez
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU07OxAAoJECTWi3JdVIfQErIH/A9O21vrrQ0m48/PQ1NjzxyN
FLOC8RyE8WWACp1KnYfg/xNlRK7JjXqqsf5M62lFNIDGs3yEddrIwP+fV8G88gME
sXgym0HRmI1ALOofjqpbVdORZXfA1QAe/CXcHA9jv4mFQGSpvktxrnkNDj0TIhki
vf+ajG7Yp+2q3F7WpgYFAjRe2Vnxe/QShiEcTOGsq8hjyubk5B2WwXllemdAk9uS
iIfYlrnQ+syZp9FLZnA95rvX0Zrl4Stc9iOmVFqHg9q0jWRxuPJAIHlmd8GNKViR
2iW06c6EiLpk8703voMWtzTUeH95SMKPL+82hhq0LncnBNsganVGgHSahb8g3/o=
=tgX3
-----END PGP SIGNATURE-----

--6EVlxZEFeUQbArez--

--===============5890388808697264337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5890388808697264337==--
