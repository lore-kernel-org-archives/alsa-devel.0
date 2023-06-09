Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3778C7EE2E
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Jun 2023 09:40:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 21FE03E8;
	Fri,  9 Jun 2023 11:39:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 21FE03E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686303644;
	bh=hTpVqffufJ2N9o+Xz7ZN9/2MFzyD4BhvJJarsHNu0uM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=HnCMloomsY3AYU3HqFg6Cq32KD3vuLeqHS6IvE+VB0oSMq1HAtdcKrLijkVgsXTVM
	 3/McHm0lPBlFp7ajrMTGVEfv0s6asCRIVE/e9ktJL06ct6CSbQMd/6SSCsKFTxnjKx
	 CyZgK6JE36fwb0+WKkUL6O7Vp/QNrcad5GdlSkN4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B6940F80494; Fri,  9 Jun 2023 11:39:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4D263F80199;
	Fri,  9 Jun 2023 11:39:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6C03EF80199; Fri,  9 Jun 2023 11:39:22 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DAC0CF80130
	for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2023 11:39:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DAC0CF80130
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=iLjOAh08
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 48296615A1;
	Fri,  9 Jun 2023 09:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE65C433D2;
	Fri,  9 Jun 2023 09:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686303552;
	bh=hTpVqffufJ2N9o+Xz7ZN9/2MFzyD4BhvJJarsHNu0uM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iLjOAh08xhYEYFZiJ9MbOZr/TxhFmbxiNjjAW3BehX6L9WfJr1G03oOZmwk4HFnkF
	 gk3ARNCfg28FGUCMG3n8OdfLJ4mHvE39aMVa/0u9jsDnTFXmyzVCR0+T54Vuypye61
	 3kfiDToJvVoPwW57mwZ4s4CvYLZa0IdUC1Or+OLp34Fmh2JA9+0JeUiNvU7q4JF8NG
	 wWXdkTk112vTlfrqvCo05QW8zI6DyIQx9JCrzVht6LgjpQBHYh4zcMxKsPMdDeNLQe
	 YjxgbJZZKd26ciO3jr2zHZNdR6r8PTYaDHJMrpU65Na42scniQEED35IL/DkT7PXl5
	 of9pBjlFBmJRg==
Date: Fri, 9 Jun 2023 10:39:05 +0100
From: Mark Brown <broonie@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	kernel@collabora.com, Chen-Yu Tsai <wenst@chromium.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] Revert "ASoC: mediatek: mt8192-mt6359: Remove " Jack"
 from Headphone pin name"
Message-ID: <b463d2b1-6822-4c37-82dd-d92c196bda64@sirena.org.uk>
References: <20230608221050.217968-1-nfraprado@collabora.com>
 <1bb65d99-d1dc-7a73-12c0-e7f4cba3525a@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pFXW2BxSqw1fbALo"
Content-Disposition: inline
In-Reply-To: <1bb65d99-d1dc-7a73-12c0-e7f4cba3525a@collabora.com>
X-Cookie: Tom's hungry, time to eat lunch.
Message-ID-Hash: 4HZKG5VNA5DRIJAITKUQEABNQETEP443
X-Message-ID-Hash: 4HZKG5VNA5DRIJAITKUQEABNQETEP443
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4HZKG5VNA5DRIJAITKUQEABNQETEP443/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--pFXW2BxSqw1fbALo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 09, 2023 at 09:37:33AM +0200, AngeloGioacchino Del Regno wrote:

> That commit is made to bring consistency in naming across MediaTek (with
> other) sound card drivers.. I'm not sure whether the right solution would
> be to revert this one, or to make a small change in the UCM, counting that
> we'd be able to add more shared names around, finally reducing the config
> length by sharing actual configurations across various SoCs.

> Any opinion?

It's ABI so if people are noticing it the old behaviour needs to stay.

--pFXW2BxSqw1fbALo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSC8zkACgkQJNaLcl1U
h9BBjAf/Xltwx3g3VOYglckofoEdSEFXheLQnLngKL2QRHoUV6sNUNWRicnS8zc6
v6bLadZRd52Ia/2A2nLZ9GbPAdsCXVsm0YDK3bUZofcy6bdCH3C/TfeuWnWz7Lvd
PnKcfjhycCrYTN6F6JD1RxicvGb3yrIaskdMnTSHHf0tQ9vUhrCXkeiDPv0OD4TC
IYewZzQHPYa5IEOrnqDZA2nCxtr6v/1aaru9WanYB2bREybfScV5WDcezCA1oAp0
UaCziy+G8wqmeowzfVP9FVTdFiAojOB3C8AljbB4yB0mEiaQ5vtB85ynoS9T4UZo
kB1xatM8U/AVx1LtXp9dW3eaTotTzw==
=bEmH
-----END PGP SIGNATURE-----

--pFXW2BxSqw1fbALo--
