Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDCFCC6B38
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Oct 2026 22:14:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 110EC601F1;
	Fri, 16 Oct 2026 00:14:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 110EC601F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792102468;
	bh=y+VasQ4aL7Focz6vi0d5xxW7JpBpA1cs6a5hhY6eYl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=buUwchILdQbC01VKjhAir9g4a9sAmDtGyj3iEpvSy8lRMCcVlEo1l4oxsEa/DKW7M
	 87GHpwI8zxSjDCdK6/eXL+Rb7if7qoTAwE+YLlFaj0kwNt1YrdO7i+BG43e6eoWTWg
	 qX2FY4E5mfkbUbR9rzOduMDs7cTzZx686s+OzrDk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3D9C3F805F4; Fri, 16 Oct 2026 00:13:57 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E933CF805FD;
	Fri, 16 Oct 2026 00:13:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CA3B5F80423; Fri, 16 Oct 2026 00:13:49 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1792102429;
	b=ZVOuxZXg3Iz0EqxRDau5jyutHky4SrJHCFKu6QbsPJ8/zPQQ7sN7GhMEmC8ZiDOugYWu
	 UuYJwRclpBgsv/dPMU3d1MFDE4c68aSCwhm7DivEN9E7eJSmGXQWynhVKsCi6ZBa0UssV
	 Oy+kYDaGx1shl8DoAVaw1whzVdHZoIqwOUXXHTHKecHj0BzASARErodMQ6IY1b4S7i3oI
	 f2ycyBgHtwWHhA+WFUeolkX0vUbv5E6eFWZ+wX5cCVsmACpXpr4aVmXepFzEHqxk6/HzX
	 48EhRPHuPpNJTMMGIgFweOEg+fsQndjjf6zx5V30FxI0K/cU4aBCE/+wWkxUMEtHLCw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1792102429;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=y+VasQ4aL7Focz6vi0d5xxW7JpBpA1cs6a5hhY6eYl4=;
	b=iPA2n6ke0QUQHtOSVzV6gHHkFjxBipiBc0Q7YAZB81pSSPr2ahCmhEEyrWHkgGVmS6zI
	 WMbDTl/FEQDHLCoo8h+Zeit71eSPFoZy314WToVTfpaFE/ZhG0TZqGK34qFfmb9S+7RNa
	 bj0gvMEYSlAbTaDlA7kBqGZwVrxvcPzICI+pH8KS4Pk+h57k0SoCflIoHdQL3KDBtz0oq
	 fcD4+hDQrzk1JSqXPKud0hE5JSfX5F01Ldw8kjlv5I6HQ/tHKvFFTzBE4j3mcLKHSXqz5
	 CXdcs02Kde5gD9b0ogeoibBiTVi5RHUuikA+RMvQ+X+cQyAN2JWWhuJFL65GhUU6hlg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=TXCHMCyN;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E347EF800BD;
	Fri, 16 Oct 2026 00:13:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E347EF800BD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=TXCHMCyN
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3C2A560A7F;
	Thu, 15 Oct 2026 22:13:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D293C1F000C4;
	Thu, 15 Oct 2026 22:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792102423;
	bh=ZXpkbDlDApBPK2KQbFof91uesi3/H9UAD12pf5U8tvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TXCHMCyNp2JOwUejlUfnkxZWaLeT4HaVMFnZqFsrKaM/J9Px3R5A/U7j+XSunbaxH
	 9g6TO1gL/135Hl2NX+CaWIMiThGZsb/uLMlectAmqPLla97zZ1XUjRaydVxLeLZ4I9
	 06jhT6MiqqHlnsr2TUMfgvXTT9I+DBtlobnGNhFT1d7Gie14XKYKZWXpzjPy9eCPZZ
	 iK+P7DTPCRyX3U/b5XG4K8z6k59jzB6YcxQuxlWYiUwi78VRFtapi8KTbWdsAi0vIO
	 v/0Vz15L52x55UoQmOpbvC5/xHDtbLNoMJIVsYg8djeQQ7NUTJm+wmhMIlb3ShZRcJ
	 9tOMUj59lSKSQ==
Date: Thu, 15 Oct 2026 23:13:38 +0100
From: Mark Brown <broonie@kernel.org>
To: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
	tiwai@suse.com, yung-chuan.liao@linux.intel.com,
	Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
	venkataprasad.potturu@amd.com, Syed.SabaKareem@amd.com,
	Mario.Limonciello@amd.com, Richard.Gong@amd.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	sound-open-firmware@alsa-project.org
Subject: Re: [PATCH 0/9] ASoC: SOF/amd: ACP7.B support and ASP carveout
 firmware loading
Message-ID: <894dae20-5574-4b88-99f2-55df1861e3a2@sirena.org.uk>
References: <20261013154644.3788064-1-Vijendar.Mukunda@amd.com>
 <179191856632.42298.5680316320552393906.b4-ty@b4>
 <247100a4-3dec-4257-abaa-2b311deb842b@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RSd1CeaTP7vu4YSv"
Content-Disposition: inline
In-Reply-To: <247100a4-3dec-4257-abaa-2b311deb842b@amd.com>
X-Cookie: <<<<< EVACUATION ROUTE <<<<<
Message-ID-Hash: T6IGQQ7YE4HN633SEVT6F3VQ7DLT5U6E
X-Message-ID-Hash: T6IGQQ7YE4HN633SEVT6F3VQ7DLT5U6E
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/T6IGQQ7YE4HN633SEVT6F3VQ7DLT5U6E/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--RSd1CeaTP7vu4YSv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 15, 2026 at 05:30:01PM +0530, Mukunda,Vijendar wrote:

> I noticed that the incremental patches sent as replies to the v1 series were
> not included in the applied changes.
> https://lore.kernel.org/alsa-devel/20261014114446.1476489-1-Vijendar.Mukunda@amd.com/T/#u

> Please let me know if you would prefer the incremental patches to be resent?

Those should have gone in separately on top of these, that was the whole
point of them being incremental.  Due to the confusion with lack of a
cover letter they used some slightly different tooling, pulling your
patch out of one series without a cover letter really caused problems.

--RSd1CeaTP7vu4YSv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrRUBEACgkQJNaLcl1U
h9A/TAf/egWlpMYt+GYuZvSVWwehLO4+S8F9z4nYIIc4K+mxgrc4XCtXVZr89bD5
YQFXej6tWdftFrsCyjLTEl/p51oVBJIkvvjtYpCuK/vImp6nwaVfhyd5xEw+thI0
Ki1cbQ7Sh261plY+dkEteUqEd2lP7+j+49iUG++F1PD0/YVfZKDfF/vCbZ0QXJq6
FaLdyk80ShECn6MTgh1yVJNyXX6Ma4sFVKqGULXeew+TyHXtM4kNsUfawgC0M2vQ
hZNdVQDcYnySCD82nN9gMULllLHslgbVp5q+7HD+euYS0bpURpSXdfBuqz/+eTxf
O8jAWoNqMpcljEVN30Gtz8ye43pD9w==
=ZsMW
-----END PGP SIGNATURE-----

--RSd1CeaTP7vu4YSv--
