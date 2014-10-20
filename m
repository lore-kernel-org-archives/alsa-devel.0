From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: add build dependency to spi
Date: Mon, 20 Oct 2014 11:03:33 +0100
Message-ID: <20141020100333.GN18557@sirena.org.uk>
References: <1413572202-18646-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3365758716969291503=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5795D260589
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 12:04:04 +0200 (CEST)
In-Reply-To: <1413572202-18646-1-git-send-email-anatol.pomozov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3365758716969291503==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KDy5+/kaQUC2a3Gw"
Content-Disposition: inline


--KDy5+/kaQUC2a3Gw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 17, 2014 at 11:56:42AM -0700, Anatol Pomozov wrote:
> Since 9cb715a9d4c the codec has a hardcoded dependency to spi.
> Add this dependency to Kconfig. It fixes buildbot compilation failure:

Applied, thanks.

--KDy5+/kaQUC2a3Gw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJURN30AAoJECTWi3JdVIfQMBgH/inLR0ht2PwSxKmTTH+MIvHc
5aF/AqqGnQgkid0aoXuGDcdRJG9AoW7rCwvfiImrYjc3xmVUxOigW5WnQFhQSAec
3ORHZcH70SbM8SiPMdFa3IVDB3ecyJZ7yMsGBiOiZino5scH+rffGbYB7uk3HBsT
K/NW7aIQBBJkKmczrp0PmxetQiEuXe9L69uTBHPz0RUVeSU0glPZ4IPWpRZ8kuzl
Vya3NMqMUI5OBfRE2cYL1WwYAEnBAacIXYQ4/vkFim6o5quk/BLshPPAqeY9BUc4
3uhtiMGXBAhraaM1A3FbllvdQaRE4sww0v8ZlU//uRHeR7Xuo0axpA7c7gcYJOA=
=vn5e
-----END PGP SIGNATURE-----

--KDy5+/kaQUC2a3Gw--

--===============3365758716969291503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3365758716969291503==--
