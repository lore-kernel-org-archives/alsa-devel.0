From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: Implement DAI links in a list &
 define API to add/remove a link
Date: Tue, 8 Dec 2015 18:03:53 +0000
Message-ID: <20151208180352.GW5727@sirena.org.uk>
References: <cover.1449036307.git.mengdong.lin@linux.intel.com>
 <55f372688ae3e96e0403147f53f7891483318aa4.1449036307.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8862611881285797998=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8048726043C
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 19:03:59 +0100 (CET)
In-Reply-To: <55f372688ae3e96e0403147f53f7891483318aa4.1449036307.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@linux.intel.com
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org


--===============8862611881285797998==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="36+Jv5wzUORg1Ut4"
Content-Disposition: inline


--36+Jv5wzUORg1Ut4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 02, 2015 at 02:11:22PM +0800, mengdong.lin@linux.intel.com wrote:

> +	struct list_head dai_link_list; /* all links */
> +	int num_dai_links;

Why do we have num_dai_links?  I can't see any users.

--36+Jv5wzUORg1Ut4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWZxuIAAoJECTWi3JdVIfQq40H/0Fd7jdjDUxnqytoVxD82lEA
oNLPpgYAJONdULlX20ijBKUDNJ67TIrnXw7Q45opTyT/uglr/Qn0wsHfKm101jLa
OYqHTxnGoY5WZyUfsC5dr4EBf4WDu1fjh32/W0rJvXbjLi06ZyHpmYLvI8vMqhFg
OswUKTB280WCkRIXaZKw8HU96ivRDTVsW0D95fXr4UkiVWcEm21ohUYy/bGVsWEf
gN5/mFBYrL+GMOlIbnmbDrcuTTLIz2TGGKaJv2PXqtC85vFmEOans9ieQVYvpI8H
dD2i+RgbRoON+YC7a9Zr9WLMOUXPavrqwz+mcjnU5tqkOwIJKa4sY5+/bOHUiWg=
=APqo
-----END PGP SIGNATURE-----

--36+Jv5wzUORg1Ut4--

--===============8862611881285797998==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8862611881285797998==--
