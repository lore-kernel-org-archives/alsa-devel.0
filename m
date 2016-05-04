From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 1/7] ASoC: mediatek: Refine mt8173 driver
 and change config option
Date: Wed, 4 May 2016 17:43:06 +0100
Message-ID: <20160504164306.GA6292@sirena.org.uk>
References: <1461934848-60011-1-git-send-email-garlic.tseng@mediatek.com>
 <1461934848-60011-2-git-send-email-garlic.tseng@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="utUizcr4eQAkV3Ky"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461934848-60011-2-git-send-email-garlic.tseng@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Garlic Tseng <garlic.tseng@mediatek.com>
Cc: tiwai@suse.de, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, koro.chen@mediatek.com, PC.Liao@mediatek.com, ir.lian@mediatek.com
List-Id: alsa-devel@alsa-project.org


--utUizcr4eQAkV3Ky
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 29, 2016 at 09:00:42PM +0800, Garlic Tseng wrote:

>  .../{mtk-afe-pcm.c => mt8173/mt8173-afe-pcm.c}     | 488 ++++++++++-----------

So there's going to be no code sharing at all between this and any other
Mediatek chips?  That seems very surprising, it'd suggest that the
hardware designers were creating a new design completely from scratch
each time which doesn't seem all that likely.  This is an unusual way of
organizing things and we need a much clearer explanation of what's going
on here.

--utUizcr4eQAkV3Ky
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXKiaaAAoJECTWi3JdVIfQlmsIAIBywmMZ2EhbIi3Rgo+HaHOJ
IZRiAOvXMTafJdw7ToZu0qzGL+yq+ofNqEB1bommSYCYe0sIzm8WMPI8grkz+r3X
77E4ylGx3ikCY9wMSFK+xLZjLq5qT8rcL1KRzm1QCvcWx1mp/9k1qCHI8MMrc/sf
IDRZMrdH5pYrThAkQcBJ7ALerL4tIy53QaL5KMa4v2jyfjdqWXhIOuSRl4sYRMUi
dqiJ5F6adYmu5gs+vv2o1VLgIxRFfLPorMOOz03puMmpXyY0CrSr7TbL4HsqEv4A
9zJRpnGGLXaSJIQcBuX0i5M/H+qX3AT1F2eGeaJEfAqOlXy/rprp/IlTcgKWIq4=
=7N8B
-----END PGP SIGNATURE-----

--utUizcr4eQAkV3Ky--
