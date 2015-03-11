From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] ASoC: rt5670: export jack
	suspend/resume APIs
Date: Wed, 11 Mar 2015 12:51:27 +0000
Message-ID: <20150311125127.GE28806@sirena.org.uk>
References: <1426045365-15975-1-git-send-email-bardliao@realtek.com>
 <1426045365-15975-2-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5527888740451664878=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F3AA52652CF
 for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2015 13:51:33 +0100 (CET)
In-Reply-To: <1426045365-15975-2-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, mengdong.lin@intel.com, lgirdwood@gmail.com, john.lin@realtek.com, Jin Yao <yao.jin@linux.intel.com>, yao.jin@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============5527888740451664878==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jmfxxgLgPT+fSo7V"
Content-Disposition: inline


--jmfxxgLgPT+fSo7V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 11, 2015 at 11:42:45AM +0800, Bard Liao wrote:
> We force enable "Mic Det Power" when a jack is inserted. Also, we
> set codec idle_bias_off = true. As a result, codec driver will not
> suspend as we expect.

Reverted since it doesn't build.

--jmfxxgLgPT+fSo7V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVADpOAAoJECTWi3JdVIfQRNUH/3MT29+aAdhcTx9RVNpw5gkY
m7098oPlynXEHfOEUY5pJGQUI/n/RjI7zqoAk5taIuTL8zwZTp+2TuSDfiUZTWor
3ELEHVJ1VFMygL+vWbr/r7PcCva+9KtGI889k/0ZhKSYlgbcp99cs8qDXcGMFEAz
8wDwiBTR6NVH79cC3C9rLl2mVhptJpeVnerej5V9FiBfO3sUql7yvYgE87HnGMzf
YuOtnedkJkfoWqzJU/1BaXfrAxfLgRV2gHZennUJkaslqbRuPElsVJL3B7Hd/GQU
8tXpJcCxhV/XShfm3c3v4ZjM0KwobHrLzSRAjFN8XsPNZUY5R0DpRgIz9JYgdXM=
=5hk8
-----END PGP SIGNATURE-----

--jmfxxgLgPT+fSo7V--

--===============5527888740451664878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5527888740451664878==--
