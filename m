From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5670: patch reg-0x8a
Date: Fri, 17 Jun 2016 12:10:22 +0100
Message-ID: <20160617111022.GD26099@sirena.org.uk>
References: <1466136482-21944-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2491409382252002422=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 60886265826
 for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2016 13:10:30 +0200 (CEST)
In-Reply-To: <1466136482-21944-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============2491409382252002422==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tNQTSEo8WG/FKZ8E"
Content-Disposition: inline


--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 17, 2016 at 12:08:02PM +0800, Bard Liao wrote:

> reg-8a assign the tracking source for each ASRC tracker. The default
> value is 0x0000 which means all ASRC trackers will track LRCK1. But
> in most case, we wish each ASRC tracker track the corresponding LRCK.
> i.e. ASRC1 tracks LRCK1, ASRC2 tracks LRCK2 and so on. So, we rewrite
> reg-8a as 0x0123.

Shouldn't this be configurable?

--tNQTSEo8WG/FKZ8E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXY9qdAAoJECTWi3JdVIfQhi8H/2wepdqW17DY6LN702jKyfBb
1DZr9v3Vr/k0Y2PYSz4F/v6kCplW6TOTl75H8x5lrpdPTL6dd6KkjICsDmbdmmfw
Xm1PITCP7+SJ/zTBVPl4eUsSF3RMGc+woKL8ycaT8OX3uUKq2PgEAaCnREXk8Q+5
2mBSWnK8zc7lSceoStBM1KOjfdvd4+IHqBRlMHksz19a77Ypm7Wu83xZW0fATZ92
Fn6kVnFb29h87cL7yMlKkrDFtsN2U/ogdqGhyIg5lC0wsUxWuEtrtgT6Fm+2W1hx
fkXTmz36CFIC+aQ0CYFKm3RK0hpvnQbtwJ5H48Dyqc79lID9H//2Wzl6MB4gvIQ=
=Zc8E
-----END PGP SIGNATURE-----

--tNQTSEo8WG/FKZ8E--

--===============2491409382252002422==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2491409382252002422==--
