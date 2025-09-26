Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFC2CAC5AE
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Sep 2025 12:41:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5286E601F5;
	Fri, 26 Sep 2025 14:41:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5286E601F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1758890480;
	bh=D8VNkutOFVbdB+WTbKEdA2yGUCDNpWcCrSFM27oUxD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=fDkbokvCHIhoQmwDdGjzk60mPTg/hf/BxU2DvTALKETZZ98QZU2C3NJC8XI5qbmDd
	 mwWgv5Djlz0LY0hZDELDQbrBebNLOOi0CHHfyol1vo0Y3LgFLwyQzzCPiy9cUYjqVI
	 qpHz6lV2HgODKL26eeedqL8Ck9SwtqvkOxOeoXm0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 09239F805C9; Fri, 26 Sep 2025 14:40:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A92D3F805CB;
	Fri, 26 Sep 2025 14:40:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 30DB3F804FC; Fri, 26 Sep 2025 14:40:33 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1C14CF8010B
	for <alsa-devel@alsa-project.org>; Fri, 26 Sep 2025 14:40:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C14CF8010B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ejIurmpp
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E4DE861D5D;
	Fri, 26 Sep 2025 12:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA810C4CEF4;
	Fri, 26 Sep 2025 12:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758890427;
	bh=D8VNkutOFVbdB+WTbKEdA2yGUCDNpWcCrSFM27oUxD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ejIurmpp0T7KnXvLld8UsNcXf3yqMnnkMF5JWl3wu18/Oyc1BNP/yxR3Jin2MbMmD
	 qfmwk+aVsQk6d6G1c5EuuYOa0q2mBvIYrOs++7a+htid9ap9q8ckFoWdUtU9P2XSf6
	 mIZBIKvlVgo2z8mrGc33u3AqMFMyKy2D0rzEc7zrR38ZwmMd5QSMygTiQEf58k5YkY
	 cjoioGzU8+FO4/sM4vbVGUzAczFqOdduLix/zTiukLCfxsUzFpJgi0vUIHRMG6T+Vn
	 flxER02GUY2gtp29pLcKugPo32xVtH/kOUzjSVlynFLLdfwKAzIcKWlkUvGG8Hxt2W
	 KAp3qOCxfplGA==
Date: Fri, 26 Sep 2025 13:40:18 +0100
From: Mark Brown <broonie@kernel.org>
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, andriy.shevchenko@linux.intel.com, 13916275206@139.com,
	alsa-devel@alsa-project.org, shenghao-ding@ti.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org, k-yi@ti.com,
	henry.lo@ti.com, robinchen@ti.com, jesse-ji@ti.com,
	will-wang@ti.com, jim.shil@goertek.com, toastcheng@google.com,
	chinkaiting@google.com
Subject: Re: [PATCH v2 1/2] ASoC: tas2781: Add tas5828 support
Message-ID: <31fc3ce7-59c6-401f-9681-fd75764e9124@sirena.org.uk>
References: <20250926043339.8419-1-baojun.xu@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EIWsqXtN7cfBcYJJ"
Content-Disposition: inline
In-Reply-To: <20250926043339.8419-1-baojun.xu@ti.com>
X-Cookie: Your canceled check is your receipt.
Message-ID-Hash: 5KSDMDTSKHG6QCWU5BXEOPY7GOYMSWPH
X-Message-ID-Hash: 5KSDMDTSKHG6QCWU5BXEOPY7GOYMSWPH
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5KSDMDTSKHG6QCWU5BXEOPY7GOYMSWPH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--EIWsqXtN7cfBcYJJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 26, 2025 at 12:33:38PM +0800, Baojun Xu wrote:
> TAS5828 have on-chip DSP without current/voltage feedback.

Reviewed-by: Mark Brown <broonie@kernel.org>

Takashi, this would need to go via your tree (though I guess at this
point it's likely to be after the merge window and I can pick it up).

--EIWsqXtN7cfBcYJJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjWibIACgkQJNaLcl1U
h9C6uAf/alhWSE8NQd8/eJDv+fU4N46SAore2/8P4xw9zzzJEch843K5n0unLXAS
3e6gEbfkGpz6g/Wdp+cQXZshbMf72I51Jci1W/cQcOkT/n/HOPJtahLpUONo0joH
WwpDJFW0AoT6kOLcB57t8EiIe8Ye/84qFGX241PPwgQzSBOaLzhJSFPJbslwDDmh
E6fpLB56cddQHKXyaK17QjU7dKTEzixP+lFqDuihF1zCFYVfG741Y8pbUPZseEAy
ut+wWKA27dtVpgqGRXFAG+JY2taXhP5FiBOBleYyqKa30C34fjitqWILao9n+KgO
sFiE1e92zUbjCRi+XLtJzNTCL8cmvA==
=3xMG
-----END PGP SIGNATURE-----

--EIWsqXtN7cfBcYJJ--
