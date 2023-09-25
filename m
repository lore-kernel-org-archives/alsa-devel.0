Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12821CE7A94
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Sep 2023 12:17:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5819FDF5;
	Mon, 25 Sep 2023 14:16:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5819FDF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695644261;
	bh=Q8qQZ657UKl5aPTt0ZTac66Lc4DXtCCQzGVJeOrOcSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hfP+nApNxz25I/ZzdpLK0xng+iu/15FAbe5gyWWsmJNm8RyNSq3Vb2mDWNiEsnZBP
	 LgZHEuKp0+du822D9LKbG99+Wuc+fr92+3H2zwWZOhxRzkM09zElhP98kqxoSAMUHH
	 La0S4RR5QLPCcU4di8EUv74OSoiOAKqhXSpHPGLg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DA95BF8055A; Mon, 25 Sep 2023 14:16:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 12EFAF80552;
	Mon, 25 Sep 2023 14:16:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7063AF8016A; Mon, 25 Sep 2023 14:16:08 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EA87CF8001D
	for <alsa-devel@alsa-project.org>; Mon, 25 Sep 2023 14:16:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EA87CF8001D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=AvdmQMcw
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id B34DACE0FC0;
	Mon, 25 Sep 2023 12:15:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82347C433C8;
	Mon, 25 Sep 2023 12:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695644157;
	bh=Q8qQZ657UKl5aPTt0ZTac66Lc4DXtCCQzGVJeOrOcSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AvdmQMcwLIfhkoLRJ7Co/CBXCjnTybz8ZtDTsoxOoCs4Y/z90o8BAjgi69TRhMaOH
	 N24sqMvyRmdfRJfZctQhOGWBT29DSYWMhXpsGNZJvl6LJUm9jfGfXeAxZplbsS2VNu
	 iCZjq5QZNR043WxqyEIC8d338GCi0N/93VQN5uBPwjkHHAUCZCQG49ZUw+ufaS5YS3
	 zthYva4B9vs313AxN4VCMKkYAQZ2iwC1bCDB+DXgEMN+Mrd4ZxghWSzSWA4YN7xIeO
	 TSELB2WbJMaNNme2oasWhvhhO58Tc/6UGbqLth1mZNrLh2vrvLZEa+iPMFqgBe8Hqa
	 J3Q84wLGSDDgg==
Date: Mon, 25 Sep 2023 13:15:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Takashi Iwai <tiwai@suse.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH 40/54] ASoC: sof: convert not to use asoc_xxx()
Message-ID: <ZRF59s2NHInRz5yf@finisterre.sirena.org.uk>
References: <87h6o0s275.wl-kuninori.morimoto.gx@renesas.com>
 <87v8cgp8ux.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="69NJ6gnaE4P12vI9"
Content-Disposition: inline
In-Reply-To: <87v8cgp8ux.wl-kuninori.morimoto.gx@renesas.com>
X-Cookie: No motorized vehicles allowed.
Message-ID-Hash: Q7DX5BJIPVFYCWATH7LGY23EX3DCJ2MQ
X-Message-ID-Hash: Q7DX5BJIPVFYCWATH7LGY23EX3DCJ2MQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Q7DX5BJIPVFYCWATH7LGY23EX3DCJ2MQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--69NJ6gnaE4P12vI9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 11, 2023 at 11:51:02PM +0000, Kuninori Morimoto wrote:
> ASoC is now unified asoc_xxx() into snd_soc_xxx().
> This patch convert asoc_xxx() to snd_soc_xxx().

This doesn't apply against current code, please check and resend.

--69NJ6gnaE4P12vI9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmURefUACgkQJNaLcl1U
h9BFZwf/SEc1i2iAVVoNfjB1YZK3wNDg3QkZiH61UmRW8eONGyKHQSvFwKOytz0h
EGZL3spwsY+Jbc+nm1rQdqIUDUADY/r97xXivQ9VtRdpGX8JBIHogohsixyFpEDv
0c0wbFDKzh8X2Tke8bfYX/ytcRQSGM4PMdBTjPCsk6WBHKs7rES2HnL4dJtL2RRe
vWWZopZxHGYZPzwQqVytDaQYWr8mP8g1mhmWRchYcVyvvc6AvN3oCndOGFOa9X0Y
MV0BqWAOamS8/1rl6UDnF5zDtmB4v188au/nnzriVarRlEVrXphLg5m4PfC1Q1Xp
Bc/GBTKz4i87v+MAKxDVcCHQJnsFuA==
=f/C6
-----END PGP SIGNATURE-----

--69NJ6gnaE4P12vI9--
