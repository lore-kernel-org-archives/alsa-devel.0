From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/5] ASoC: mt6797: add structure define
 and clock control function for 6797
Date: Wed, 25 Apr 2018 18:52:41 +0100
Message-ID: <20180425175241.GJ24769@sirena.org.uk>
References: <20180425072522.14167-1-kaichieh.chuang@mediatek.com>
 <20180425072522.14167-3-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4827768900183323979=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9665D267035
 for <alsa-devel@alsa-project.org>; Wed, 25 Apr 2018 19:52:47 +0200 (CEST)
In-Reply-To: <20180425072522.14167-3-kaichieh.chuang@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Cc: alsa-devel@alsa-project.org, garlic.tseng@mediatek.com, linux-mediatek@lists.infradead.org, chipeng.chang@mediatek.com, wsd_upstream@mediatek.com
List-Id: alsa-devel@alsa-project.org


--===============4827768900183323979==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LQAwcd5tHl0Qlnzi"
Content-Disposition: inline


--LQAwcd5tHl0Qlnzi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 25, 2018 at 03:25:19PM +0800, KaiChieh Chuang wrote:
> Signed-off-by: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
> ---
>  sound/soc/mediatek/mt6797/mt6797-afe-clk.c         | 132 ++++
>  sound/soc/mediatek/mt6797/mt6797-afe-clk.h         |  25 +
>  sound/soc/mediatek/mt6797/mt6797-afe-common.h      |  57 ++
>  sound/soc/mediatek/mt6797/mt6797-interconnection.h |  41 +
>  sound/soc/mediatek/mt6797/mt6797-reg.h             | 846 +++++++++++++++++++++

I've applied this and the following patch but they do need updates for
SPDX - please submit followup patches doing that.

--LQAwcd5tHl0Qlnzi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrgwGkACgkQJNaLcl1U
h9AfIwf+K+qMOgUJWH/xj2XXYaRyn+Lqn/CxLQDOK79VBcy/2kMyOf45YWsKRcUc
EpVDISIpn6PVlxbn1Gwl1n2aE5ST0X/O6TuTwkKOFpXDmV+3rDi2EgRQr7Lw1D+k
VhDruQSOR8w6XuFINSH5sQVa28E/M9/iftvB/lNbnfLByXhehZ9RKSF8u9JVgF/Q
M1sGSfs5DZert3niW2YAxHaRhoDWaB1RQavjtY8mgKIf4162OWkYgL5TIxXgqCvB
9oEibdC19gFLnHWDMwWOKCFvTFfhqbSe5N45RuG1uoSxV2N61sqCHsOdUaxxpY6s
EmzG9XnfqMe80jN8NxeBp8Iv5R0dlw==
=xQTL
-----END PGP SIGNATURE-----

--LQAwcd5tHl0Qlnzi--

--===============4827768900183323979==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4827768900183323979==--
