Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB2AEB64D9
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Jul 2023 12:11:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 554EE7F4;
	Thu,  6 Jul 2023 14:10:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 554EE7F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688645473;
	bh=xNVGuKAKGspfO0U3AqsxNnqpZ8lzvY8FFZk/ZAZuwzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=rwjsnx/b0o8ZeXOI6i0Y/iDgx19nxp+HW+ONGk5lHm1xijXLAXLGx0kuZRNwRswaM
	 FDKSMbMNB8wxTLaKTcLJdowvAnEtt2RAVmYuzWZ0XAjxSoDWbJeCGFpjKmflJqQRGk
	 1gsDpa4HadyAMUcxPgGIjL6FMjWNgARdlwH1IB8w=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9161AF800E4; Thu,  6 Jul 2023 14:09:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 187F0F80125;
	Thu,  6 Jul 2023 14:09:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B2FFEF80125; Thu,  6 Jul 2023 14:09:46 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C913FF800E4
	for <alsa-devel@alsa-project.org>; Thu,  6 Jul 2023 14:09:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C913FF800E4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=G30kiem5
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9FF816191C;
	Thu,  6 Jul 2023 12:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C49C433C7;
	Thu,  6 Jul 2023 12:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688645381;
	bh=xNVGuKAKGspfO0U3AqsxNnqpZ8lzvY8FFZk/ZAZuwzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G30kiem5FA0LlI4gL/FBgc6dht72xhbSl6QyMqsYEAvPuERBPYOKDdVA4hgsnfbgW
	 lhFdORvVkPjlyew91k7g6kZqvXdWzfqoRFx7elOGwqGqVoGkzmZCH94NxMWrqERcw6
	 mLJzkpazq1OmPmpSLFR/FDT8NsRosy+Ur9+VBjVwsb0DCxedCBt8/wfkkx9BtbbstW
	 oT91uM7OE1WS72/+hqOk5t5YftJjo8/Yh1KEKxrvipVC0KZNhEtpU1e/FTyI8kJhYP
	 5lZV6tcSeiaEDK4zAmjSLDb+Kell4/7JatdMAMRlrHELYMBd7g2kBkxn7CllBlgAvK
	 F6XcK7QZwmOYg==
Date: Thu, 6 Jul 2023 13:09:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ASoC: codecs: SND_SOC_WCD934X should select
 REGMAP_IRQ
Message-ID: <bd265a83-ca5e-4196-936e-0f753ea47a25@sirena.org.uk>
References: <cover.1688643442.git.geert@linux-m68k.org>
 <cafd878747e7951914a7d9fea33788a4a230d1f0.1688643442.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Lzh0BKmrl/zHqQZM"
Content-Disposition: inline
In-Reply-To: 
 <cafd878747e7951914a7d9fea33788a4a230d1f0.1688643442.git.geert@linux-m68k.org>
X-Cookie: Being ugly isn't illegal.  Yet.
Message-ID-Hash: QEN3IJIUCVHY5W2NKDHPO3ZFDPMQCWC2
X-Message-ID-Hash: QEN3IJIUCVHY5W2NKDHPO3ZFDPMQCWC2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QEN3IJIUCVHY5W2NKDHPO3ZFDPMQCWC2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--Lzh0BKmrl/zHqQZM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 06, 2023 at 01:42:04PM +0200, Geert Uytterhoeven wrote:
> If CONFIG_SND_SOC_WCD934X=y, CONFIG_COMPILE_TEST=y,
> CONFIG_MFD_WCD934X=n, CONFIG_REGMAP_IRQ=n:

There appears to be at best a marginal relationship between this and the
rest of the series, please don't group things needlessly like this, it
just creates spurious dependencies which complicates getting things
merged.

--Lzh0BKmrl/zHqQZM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSmrv4ACgkQJNaLcl1U
h9Do3gf/RdOeKYR2p5jpUgp2fzowEi29dDeXA7QxNNDwLM3AndW4VvXWuL/yUnQN
ANNBVINGMcytkLwWVKQ+QRLgUeowpA2Psh2hMWCWL6dOKF3LJwqd8WwrKBsMEtql
CYXXiNr8MPstrJJlrLRCgt33gjuC5p9SVirtQvay4uKRIwCfr1HLs5SmNcYBKy6L
2FbbJyybWgPK0RcVIqJozCb95gIJokDUa00tA0kq4nZ6vYrgbyV9zbDtLYg7D8P6
JX53lCywA3/jkuaXZ8r2D3StOUxNKM01L0HXS0lw5g1KPTgCbWu3/z3/ojqYGN88
9M5/sT3be61ZdYNXKiBPs07yaaI72A==
=BVyP
-----END PGP SIGNATURE-----

--Lzh0BKmrl/zHqQZM--
