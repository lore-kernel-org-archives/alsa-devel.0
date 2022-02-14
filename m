Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F73C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Feb 2022 09:28:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EFB9B1928;
	Wed, 16 Feb 2022 10:28:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EFB9B1928
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645003731;
	bh=IQKHs148sOwzSOJ9x7YM1yay1qSuKlbeZzKnX8pviEM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dmysygaP4bx4GFHHu0+xfMJQwr0MD88DbF/DCHwHT/EGk03VrhiBmrjmBpg6FoSvm
	 L3/eDmNYwYRiUsa8xiTIfd0CZEUWvy64Jgi/3BgOtfmJ66lv8L6uggVwsZ+uLKL0vJ
	 FtX7boNL+ABboE9vzewoNHbGggHCLOy3nd7Yze28=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B467CF80539;
	Wed, 16 Feb 2022 10:25:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AF7ADF80310; Mon, 14 Feb 2022 13:40:27 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 54FE4F800C0
 for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2022 13:40:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 54FE4F800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="rWhH+LSo"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id B5B0AB80E91;
 Mon, 14 Feb 2022 12:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4250FC340E9;
 Mon, 14 Feb 2022 12:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644842418;
 bh=IQKHs148sOwzSOJ9x7YM1yay1qSuKlbeZzKnX8pviEM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rWhH+LSokZ3Zs/QiXpu8o5Ki+KnAslQZ/LWSTzG9fMRcf+8pxIVHNAgtUU1oj6cvU
 ueXKCU7WZKJ/wRK68K+zEAjeJMdaM7s47AyvQ25N8LoFbUMh7pKIayN3VgCmqiQ99S
 EQR52sV8lX24QDh5Y6RmFhExf1wnMLker7AQ7F8D4NFlTeWtaasxrCVfhF99LVv4oK
 GCeaHeVIzO4MU8vxm/xgXbvG8u+tFoMpgRZSLd4+HwKHyKf5X75+YbpnFVMkkgUSk6
 fDvjyddaRrvSTNImWVKyRUoZuzRyOMhMV3cPUcakLZra9OnBOGXZW/szRhs+oQ3MYF
 1e2CJ3Ew+jpfQ==
Date: Mon, 14 Feb 2022 12:40:08 +0000
From: Mark Brown <broonie@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH 20/23] ASoC: codecs: wcd938x: Make use of the helper
 component_compare/release_of
Message-ID: <YgpNqLQzpx4J6d8K@sirena.org.uk>
References: <20220214060819.7334-1-yong.wu@mediatek.com>
 <20220214060819.7334-21-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kmbocLNYrfZ7Ic0Q"
Content-Disposition: inline
In-Reply-To: <20220214060819.7334-21-yong.wu@mediatek.com>
X-Cookie: Am I in GRADUATE SCHOOL yet?
X-Mailman-Approved-At: Wed, 16 Feb 2022 10:25:43 +0100
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 David Airlie <airlied@linux.ie>, Liviu Dudau <liviu.dudau@arm.com>,
 dri-devel@lists.freedesktop.org, Sebastian Reichel <sre@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Will Deacon <will@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Joerg Roedel <joro@8bytes.org>, Takashi Iwai <tiwai@suse.com>,
 Rob Clark <robdclark@gmail.com>, James Wang <james.qian.wang@arm.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 srv_heupstream@mediatek.com, Stephen Boyd <sboyd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Tomasz Figa <tfiga@chromium.org>, iommu@lists.linux-foundation.org,
 Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--kmbocLNYrfZ7Ic0Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 14, 2022 at 02:08:16PM +0800, Yong Wu wrote:
> Use the common compare/release helpers from component.

What's the story with dependencies here?  I've just got this one patch
with no cover letter...

--kmbocLNYrfZ7Ic0Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIKTagACgkQJNaLcl1U
h9ChNwf9H0Bf8Q4NJFX6MpkURJU1WTUkJZ8s9zjT9F5003kszR2qdhtG8TCUYisF
m+Ywr7okO1EGsbMSae1gxr0q5In/J/buVsEnIjl42Be7doIn1xXcDB+3tjDyi4aH
ZN/sHluDMyiwzeBgN2jiu99gsgHDVXThtPOdyMLab2QMCVo6PEox6vsKyIb6vO2F
Rl7BLwS916U45mWEFF/XAJLWV7QPG5f43JvKlSkjKLgJhFP8H/cxKzlNZclRAdEi
fSWK497fgwmyoHrXr2inZNyDmAh20f9np1WMgLBl2sJwN8LnmWSDpp76C/XfRV0T
Qp7CAMe19I/TqvJsaFw7oluNeBT7Yg==
=2URH
-----END PGP SIGNATURE-----

--kmbocLNYrfZ7Ic0Q--
