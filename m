From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2 v6] ASoC: mediatek: Add second I2S on
 mt8173-rt5650 machine driver
Date: Wed, 20 Apr 2016 09:29:17 +0100
Message-ID: <20160420082917.GH3217@sirena.org.uk>
References: <1461134447-42001-1-git-send-email-pc.liao@mediatek.com>
 <1461134447-42001-3-git-send-email-pc.liao@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1978703617254817036=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B445261B0A
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2016 10:29:43 +0200 (CEST)
In-Reply-To: <1461134447-42001-3-git-send-email-pc.liao@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: PC Liao <pc.liao@mediatek.com>
Cc: alsa-devel@alsa-project.org, srv_heupstream@mediatek.com, tiwai@suse.de, s.hauer@pengutronix.de, linux-kernel@vger.kernel.org, koro.chen@mediatek.com, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============1978703617254817036==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="caC6Ojpb5aKGbDVu"
Content-Disposition: inline


--caC6Ojpb5aKGbDVu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 20, 2016 at 02:40:47PM +0800, PC Liao wrote:

> +Optional properties:
> +- capture-dai: audio codec dai on capture path
> +  <&rt5650 0> : Default setting. Connect rt5650 I2S1 for capture. (dai_name = rt5645-aif1)
> +  <&rt5650 1> : Connect rt5650 I2S2 for capture. (dai_name = rt5645-aif2)

I sugggested changing this to use a subnode but you've ignored my
suggestion...

--caC6Ojpb5aKGbDVu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXFz3bAAoJECTWi3JdVIfQ1TAH/RTZ74H/1+D4Pg07yV1ONzqd
hDrnYVrZlSr1kyxqWyoynvfyXmNsK1on7EqajK1BGJlSe5Idp1vJ9ymRU8ZvbGhk
+NdexYG3maQREHx9BKOmaXCaHnAQHEYSwcAqm6G31LiqCcFTvihAaQbd4amjqdm2
4tYyCz+IkbdHAIg/mThp0sgkz20mUtSyffp7J+R1bDLqX4HeNYfNyax0QcTxjexC
Lnhuwboo/x4PPVJrilfRAvLaRMIefS6K7H/WgQgCZdXNv+so121J/FX1x2YlQ6A1
2zz+qCh2M2dEkw/fiG5YHZqNFjLrD+iogtyZHFxUM7fL+NUbUZYYtTwHRhWfieM=
=O//j
-----END PGP SIGNATURE-----

--caC6Ojpb5aKGbDVu--

--===============1978703617254817036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1978703617254817036==--
