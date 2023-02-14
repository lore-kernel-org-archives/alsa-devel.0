Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A3EC05027
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Feb 2023 13:08:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 21A5082C;
	Tue, 14 Feb 2023 14:07:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 21A5082C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1676380128;
	bh=ZEPZLL2ZKUy55Unu8q0cOVpaiMguKqJHtB7H8o/4DV4=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=UdzvjKIwcH/MtPCujUSGfZugkUkoyNtocNeG4ZqyeDtWpJqvzBttShHwDhopc4K1J
	 MA+9kvl+TdRTef7U6AKlVYAf/ynipJWebc1gWrEKmfC9tmW8Yt2O6FxwRVdDM6c81f
	 8TLTggVl9oKnHUcv+gciD+TgY/DmNCkN2kA12i8k=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6ECF4F801C0;
	Tue, 14 Feb 2023 14:07:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5B03DF801C0; Tue, 14 Feb 2023 14:07:29 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5215EF800B6
	for <alsa-devel@alsa-project.org>; Tue, 14 Feb 2023 14:07:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5215EF800B6
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=dgyBKVPa
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 55ED3B81B7C;
	Tue, 14 Feb 2023 13:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98993C433D2;
	Tue, 14 Feb 2023 13:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676380044;
	bh=ZEPZLL2ZKUy55Unu8q0cOVpaiMguKqJHtB7H8o/4DV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dgyBKVPaBr2HQXN43pZOzCb4H4tA2rtGobKxsA6L14FuS6dFETH9ZgzoQ6FmrI0Ez
	 2TAL5S+VRc6+IpOCfgOmojZXMJx7+HPRuIS+ht+Oeku1CkNbgNOOMufT7bkYVBI0mU
	 xrPn5SUwvNy4v5HmGPZoG+nkJRP+vviOhiEpWKyw+eb9OgnfYrtUYIYAUCGtY2mJIS
	 YWt4IgzSqKs1L4hPKeSd4XQfdR6mMfFC6Fra4zFbPJfMEzUd+xq/T/POZoysW2fkgS
	 ++HWk+aLYZy8agWztMf7gFcEcthd/nmGMijy4vGYSH9AWAfe0KxK6d+hJR4b2g7ZLK
	 nRNT78SXT/rJw==
Date: Tue, 14 Feb 2023 13:07:21 +0000
From: Mark Brown <broonie@kernel.org>
To: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] SoC: rt5682s: Disable jack detection interrupt during
 suspend
Message-ID: <Y+uHiZ1D5rmFc2L3@sirena.org.uk>
References: 
 <20230209012002.1.Ib4d6481f1d38a6e7b8c9e04913c02ca88c216cf6@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ETlhmiRcEav6CrZn"
Content-Disposition: inline
In-Reply-To: 
 <20230209012002.1.Ib4d6481f1d38a6e7b8c9e04913c02ca88c216cf6@changeid>
X-Cookie: Serving suggestion.
Message-ID-Hash: 6RWR5QBK454QE5DCTHHSSV4EKT5GKGLE
X-Message-ID-Hash: 6RWR5QBK454QE5DCTHHSSV4EKT5GKGLE
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 Douglas Anderson <dianders@chromium.org>,
 Judy Hsiao <judyhsiao@chromium.org>, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6RWR5QBK454QE5DCTHHSSV4EKT5GKGLE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--ETlhmiRcEav6CrZn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 09, 2023 at 01:20:23AM +0000, Matthias Kaehlcke wrote:
> The rt5682s driver switches its regmap to cache-only when the
> device suspends and back to regular mode on resume. When the
> jack detect interrupt fires rt5682s_irq() schedules the jack
> detect work. This can result in invalid reads from the regmap
> in cache-only mode if the work runs before the device has
> resumed:

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--ETlhmiRcEav6CrZn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPrh4gACgkQJNaLcl1U
h9CtFwf/cETeyaTBqREWV1P0f3zFV9nLL3Hh1QF3i6dqz7TwD0wWHQHOOqUWZRWN
B2Tv1YwBEi9pfwbO5tv38mtzz3W1P2xphzbiJF/mP3kk0/bzLeoYCwhDtFsMBmFj
agRsU3GBFhkAuy3/iYuhDh8PSytgoAqTinNxVQU1CiWtk77JEmomm2Q+clxJpQrv
jcIkoKxq6BJNq8zP+TCMTi99h3BzywNhpL3reO31HVulZGxvfArQafPv03O1O3i8
ErpWtrNLq7sr6OhGApZjvCKEinQ4f22VGXbLEMj7fjpYgWM2UXRZeIyCC6/8jzxl
l5G6DJTuk3RflJq/nUqZj5NPL33ZPg==
=5BVe
-----END PGP SIGNATURE-----

--ETlhmiRcEav6CrZn--
