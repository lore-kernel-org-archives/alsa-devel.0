From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rt5670: Revert Keep sysclk on
	patch
Date: Mon, 9 Mar 2015 18:13:02 +0000
Message-ID: <20150309181302.GO28806@sirena.org.uk>
References: <1425891323-21445-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2259117698649604591=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 94C712607E9
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2015 19:13:07 +0100 (CET)
In-Reply-To: <1425891323-21445-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, mengdong.lin@intel.com, lgirdwood@gmail.com, john.lin@realtek.com, yao.jin@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============2259117698649604591==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y8OL7jWO5wDKNv+B"
Content-Disposition: inline


--y8OL7jWO5wDKNv+B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 09, 2015 at 04:55:22PM +0800, Bard Liao wrote:
> The "Keep sysclk on if JD func is used" patch force enable/disable
> pin in rt5670_set_dai_sysclk. But some machine driver call it in
> dapm widget event. It will cause kernel crash.

Applied both, thanks.

--y8OL7jWO5wDKNv+B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/eKtAAoJECTWi3JdVIfQyegH/AzDW3u47wOImAAPyHsYQ+Al
3M56jfpuIfKY33Fp6kvYM3PAXNa+qwnNjldpSAg5RYDslxUkVGDfYVT2u84ON0QL
rkGjGcG3wZ72uSQ/JygQeUd96Z/2nndU+1JFkvXUCaByB7jpeKxuHNTboxKABJnA
BKJffWh+N3adPwvdWpyG1Y6SUxRW55uMXe3g8DpP3dAzCy4oxwtGqyR0SARfaXYK
YcXivW/7YkZHjMrmjNleXPeaXXoCcQTVyMwKJt6it+bmoO35ozezEUyOI2dI5pW/
ne7rxnEEsQAtYoIOtPLyxhu2p4tcjuE3Cf+6OldQ24H9UdrOnd4yF1JjX5ECdts=
=UX+2
-----END PGP SIGNATURE-----

--y8OL7jWO5wDKNv+B--

--===============2259117698649604591==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2259117698649604591==--
