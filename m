Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDEFC77B75
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Apr 2023 11:55:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 96FB8E76;
	Tue, 18 Apr 2023 13:54:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 96FB8E76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1681818949;
	bh=rYnQQ/FWza9WvVDMOxLnZknjJ7AOUa7tySmBrTXYTbk=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=FJk30PnlLJXs10bJpBbjvETK7o9WItKDOPVD7lM/0yUsjLiGK0VvaapLYOIL/7xGE
	 mTxEOaiUS/AAf8iuzrumbtWqb25ktsnMQY+M3KWoP2vRqYVMIR9j6zEPQjqhMTyWRq
	 wD+7/6KpJ/rHQhpuPhFOnKhDNqIwZJsiFuuPyO5Q=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D95DF80155;
	Tue, 18 Apr 2023 13:54:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 55489F800F8; Tue, 18 Apr 2023 13:54:30 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C5972F80149
	for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2023 13:54:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C5972F80149
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=fsmsDuY7
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B25BA60C34;
	Tue, 18 Apr 2023 11:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA33C433AA;
	Tue, 18 Apr 2023 11:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681818863;
	bh=rYnQQ/FWza9WvVDMOxLnZknjJ7AOUa7tySmBrTXYTbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fsmsDuY7akrtTqsERoOHNe9rGEyuNP3u787qmHAPhbw8bxq0/cb4mk90m96amxtXH
	 ftrMK3A3Kz67LbnW/gIXvu3PYRzTkK55GxSsIjrdws2f8HWRd127IZEwEyyyrqL9d6
	 0Qmw2yanD8hiIDh9f1aUTENmcowKlBJLtsTJdQAhccFc+BjRKNksCGCaWqPbMpfQMp
	 ZnoVvkk3C+GwPP53X5Dd1O535x/YAn9PIWW3bRY7zcTMf0PmDWYUhzI2Zv8GdTuSaO
	 pM80NsoINfZbkRzHrfZnC62LAE4YvGJQWjE+KGAPiX4gmaf+qJ+42LTLDB3iw26Ixb
	 ojuWNstKiFoGg==
Date: Tue, 18 Apr 2023 12:54:18 +0100
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: What is difference between snd_soc_xxx() vs asoc_xxx() ?
Message-ID: <542fab62-8434-4dca-9d23-04e4e7c9bf50@sirena.org.uk>
References: <87h6td3hus.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jkevzcVeKhUdQL4+"
Content-Disposition: inline
In-Reply-To: <87h6td3hus.wl-kuninori.morimoto.gx@renesas.com>
X-Cookie: Just to have it is enough.
Message-ID-Hash: NWTB645GNN5TUV5IZT5CS5YDGBHIROXO
X-Message-ID-Hash: NWTB645GNN5TUV5IZT5CS5YDGBHIROXO
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Linux-ALSA <alsa-devel@alsa-project.org>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NWTB645GNN5TUV5IZT5CS5YDGBHIROXO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--jkevzcVeKhUdQL4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 18, 2023 at 05:00:11AM +0000, Kuninori Morimoto wrote:

> I think ALSA SoC is using 2 type of prefix.

> 	snd_soc_xxx()
> 	asoc_xxx()

> But, what is difference these two ?

> If there was no big clear reasons, I think it is good idea
> to unify them, because it is confusable.
> But what do you think ?

No particular reason, standarding on snd_soc_ seems sensible.

--jkevzcVeKhUdQL4+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ+hOoACgkQJNaLcl1U
h9CwXAf/epEk438trl0rXh6A+RYW+KIpdL1w5mjP+dla69iKFqxpvzGV6E4oZ3bH
h1XnTbJdKFYxX/kIKdbu06NBg1JftMnMByn1ktgi000uqsiHY7uoEWhTnQ21Kx96
dlmaPsDnGOi9xrKfkPN26ECn5FQ+vDep4Xl24KjDBLRg63BH3fNoA12CM1gxZAjQ
Ac/a6XXYvLlfYhDMo28klwM+l6R8kvttf5wMy1fISw2PjpCC1o1XMjArnRKIZybK
O7xC4+74t+z/TAA53QH+gfk4ebINqHT1lTC28EEXlsdi3kVFdOefLea+sS+B9PIb
3KSuTfXFL5i6MnTbp99Gqy/y3HJhhA==
=7QeA
-----END PGP SIGNATURE-----

--jkevzcVeKhUdQL4+--
