Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071D1D3941D
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Apr 2026 12:08:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D739660201;
	Thu,  2 Apr 2026 14:08:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D739660201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775131706;
	bh=5FF/JMbLOH2zr7Wm2D0Aegyt31e2Z29daRvG17HQsA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hsCtQYQrdLQwaYwNUaUAtZ8BYIaIhWEJZF+RKM8bMrAiM1YJyXcxsD+E0uNujniB7
	 VSVqC4JCigUqRO6Zlky08pIg8amFGyhfIHNf0r7wbuJG3gAuCZcZ2yHdUxCeAjnuvU
	 2o7RwxqMaa0h85pDX2bSOp2PjW9fBwE5kBjnISkE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E7547F805EE; Thu,  2 Apr 2026 14:07:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 51B0CF805F3;
	Thu,  2 Apr 2026 14:07:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 845C8F804B4; Thu,  2 Apr 2026 14:07:42 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3E25CF8047D
	for <alsa-devel@alsa-project.org>; Thu,  2 Apr 2026 14:07:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3E25CF8047D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=qq1PhU/8
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 175DA61879;
	Thu,  2 Apr 2026 12:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29911C116C6;
	Thu,  2 Apr 2026 12:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775131656;
	bh=5FF/JMbLOH2zr7Wm2D0Aegyt31e2Z29daRvG17HQsA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qq1PhU/8CmAb7xahhYlZuaD3lhuf/2DcOG6L4ClK0LaRTiShC21Ix1bSkN7E4i8UI
	 y+T9ZqW4y3y9XIMMWdadvyowkHz+kpi1WdesM4ySaCz7TZMyH1FWJfg+EELpXwcsxX
	 qLSOv+FQMgy2Xn8PHBT2rkbqTQNR4om4/RPTPUwFPphy95I2o+nSmQ2NnaZwB1XFBo
	 gFdnL1qP+co0vUQPKcNnFrdszJ6pdRi4n4sZtJno5+PV3bT12BPMqav6pgx4++mQ6w
	 cjvvnaJxteQNI8HdBw7q7oTpPTA8plNFML7Eptyzb+lQm6+1+ZwwD5Hi2N+z7rl2wA
	 Vd2knXFM2IRYw==
Date: Thu, 2 Apr 2026 13:07:32 +0100
From: Mark Brown <broonie@kernel.org>
To: jack.yu@realtek.com
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, lars@metafoo.de,
	flove@realtek.com, oder_chiou@realtek.com, shumingf@realtek.com,
	derek.fang@realtek.com
Subject: Re: [PATCH v2 1/2] ASoC: rt1320-sdw: kcontrol for brown-out feature
 update
Message-ID: <f0dceb6b-6f93-402c-9e96-713f9e8fbd8a@sirena.org.uk>
References: <20260402064601.1799013-1-jack.yu@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zIyvDqDTccgwoFQE"
Content-Disposition: inline
In-Reply-To: <20260402064601.1799013-1-jack.yu@realtek.com>
X-Cookie: <doogie> dpkg has bugs?  no way!
Message-ID-Hash: HJSY7IHNX4THYQ64BL3XI5JPEORTLZXR
X-Message-ID-Hash: HJSY7IHNX4THYQ64BL3XI5JPEORTLZXR
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HJSY7IHNX4THYQ64BL3XI5JPEORTLZXR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--zIyvDqDTccgwoFQE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 02, 2026 at 02:46:00PM +0800, jack.yu@realtek.com wrote:

> +	rt1320->brown_out = ucontrol->value.integer.value[0];
> +	regcache_cache_bypass(rt1320->regmap, true);
> +
> +	if (rt1320->brown_out == 0)
> +		regmap_write(rt1320->regmap, 0xdb03, 0x00);
> +	else
> +		regmap_write(rt1320->regmap, 0xdb03, 0xf0);

What happens after a suspend/resume?  I don't see anything except get()
that reads the value here.

--zIyvDqDTccgwoFQE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnOXAMACgkQJNaLcl1U
h9DcrQf/e9iShQt/MMeP5kDOWIXMKyPlAO+lyx+qp3MaQI+PJWNr/euCjHTluZbi
G6FxnIa7iER7mcl3NMzpPP2ZoOUzR7ZKtN7RlHHRs/tJgGkZY3RJpvrT0NHo1ALd
pxLetmuPAhwlMuS6C7nENZm5SC1cS/gJuobsP9F6P5bl7+9K6fw3ykBzda0ywE7/
a0ZNZGs4o3QWpo688injxi1Ct7CHA3S/+B4ETkwP7SuWMHT0wDJErp0SG8A00c5M
21qcDFBwlXzsAcOQUcLSp1+XR/OmhsN02E1qFyYEyQJkYhgxPSu/RWDnLWGMvLgx
CE+nBlhCWnvfM+3r4QILprIE+tb1rw==
=Q4i+
-----END PGP SIGNATURE-----

--zIyvDqDTccgwoFQE--
