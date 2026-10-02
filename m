Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3F1CA5FE3
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Oct 2026 12:36:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AAB346027F;
	Fri,  2 Oct 2026 14:36:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AAB346027F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790944573;
	bh=eOogGp3OqzGyGsPyK4VzxRn/p3N4zRGZpeC+y3xZ1yE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Y7wuGx7r5KdfZoFRCQI4vyCfT/OkUIiUcXqe2nzIdDKgLcVh8HAiUz4nEqhAU4gQW
	 aAj4gRFvA1vIfLwtpW47PsFB1tee6N3R61G7P1zs4GsJpyij5Ph4rE2LRJw34QqDBC
	 RDA0KpXHu183fwRDGR+Lj8JU99aCoOeB/eg4H6rc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6C09CF805FC; Fri,  2 Oct 2026 14:35:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 10213F805F9;
	Fri,  2 Oct 2026 14:35:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D911DF805BA; Fri,  2 Oct 2026 14:35:35 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790944534;
	b=i3P50jdWP8dFlBdax7OgszSfzH24ewVw3BHZfYrjI7KHz947iRiWrGIxF7pk1xVut4+q
	 OmBg9hCJHKWq83HzRZbDe1BxKlZJVjF5Noo0yZrkfySn6wCrkME2xLywFQ2a4ZfmfLeJc
	 xXzx0SWuzXbZs4h0nm8sc2qQyx19NmoI4mAyJPi8C7tec0ukTiPlMqgxFivdcMLDLb97C
	 DwDHJ85WabseLj0InQWjDIkUoNIIVEJic3CnF+DsBHjDUlPAiU/+D88WEVRFiJuwiZ9fv
	 wZwvLxixOzKGyOdwqX8Nr7O5Om09txDRy9J4JYnTfZFSVOsKSHR0FnFwb4QQpGcAvww==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790944534;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=eOogGp3OqzGyGsPyK4VzxRn/p3N4zRGZpeC+y3xZ1yE=;
	b=KjgocMAydBvgde2mTIAkpPHfherJBB2sXuSRhmjAyNt0i2g9MOL00lJl3w1PiXxnBKcJ
	 /extq2OjIY9j5c3C0gg/OQ36w7wmePbQZ6kELP3yzbW208PUOMG3F0zS/OAQwFXuj7gKX
	 5BTMFGO8NVx1wMElvMIDed+3yEdeetTW6n3ms/74sBQo0DB5V/z4h80+nc9xvEJ8r9g0D
	 l1de9pOs0494fP3sev/PhpJWU+s0o7xtFDjwyOCjElYOYUnITKS4znlWrYoCZ6dirAZCB
	 RAQz+jWBgUXCYHp5L/G1K8e2P77vvnJk458Xt0QGJpxVA67VmgjmbsS7V1W7EcTkydw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=m9uZK4nO;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6E822F800B0
	for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2026 14:35:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E822F800B0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=m9uZK4nO
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 190AF60A8C;
	Fri,  2 Oct 2026 12:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83801F00893;
	Fri,  2 Oct 2026 12:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790944529;
	bh=r9riRWp2jVzTJJm6AucA/1g5MVf4YA77Zu+vPY+Ol6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m9uZK4nOdBG1/vobUCCDTtgrEZO6ABSW0TonOaLZlCh2whSClGodW1t+/+kClLr0X
	 k4KiU9uw0CwhM2ajhOCAF50HkSsOfmCiR+6ivcKourIM7lsn4NaMHWq4/Q8dCbwLC/
	 kGpnr736+NQWFkwtVeE8PVMMGH7aQUlrNSWsed+bVbEBATkXRUbw2zLpfJlN2nGe+u
	 8Gw7PFnBnMVAqG1uyG1kialz6ijS/PXALUWzzF67n+bBBzhAkKDyt33H0Mn5YGTst+
	 rNmh4e4CKfnyw9MGqAza5pBDIQftV1fr3skHVjOMWVuhfcsmYr59KZ6NkVfyrTolIq
	 ac3IbRSU0PCsQ==
Date: Fri, 2 Oct 2026 13:35:26 +0100
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.3-rc5
Message-ID: <9f499530-3b86-4c14-8245-d27507213234@sirena.org.uk>
References: <20261002115438.DD6341AC57CB@finisterre.sirena.org.uk>
 <877bk01fii.wl-tiwai@suse.de>
 <68deab21-b10e-47d5-b0f3-f533c995a87e@sirena.org.uk>
 <874if41eee.wl-tiwai@suse.de>
 <871pa81e9f.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oMsUp/GSpAoVqPRg"
Content-Disposition: inline
In-Reply-To: <871pa81e9f.wl-tiwai@suse.de>
X-Cookie: Expedience is the best teacher.
Message-ID-Hash: C4CDTDXNNHSOJLYPHLSXB7SCUW4HI5M7
X-Message-ID-Hash: C4CDTDXNNHSOJLYPHLSXB7SCUW4HI5M7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/C4CDTDXNNHSOJLYPHLSXB7SCUW4HI5M7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--oMsUp/GSpAoVqPRg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 02, 2026 at 02:24:44PM +0200, Takashi Iwai wrote:

> It contains lots of Morimoto-san's refactoring changes, for example.
> So they look really rather for 7.4.

Huh, something changed branches on me - that explains where the version
number update came from I think.  Resending with the correct thing
tagged.

--oMsUp/GSpAoVqPRg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq/pQ0ACgkQJNaLcl1U
h9BD4Qf/Sg2qr0BsnF2aGXrdRINtdPIxEXoBJ0lRRm5tUfEOvdpcxYgdF8Yhne43
g7vzQgPXSdV90MnFFsLT9zrNAQFI5gOqtf5ptsi2Ivijehqk5+hM3JD1ogfK7glk
6kpth46KWQ0CNVP8Dwpnel2WLny9B7yXK+vVNZyjE/r2bGglO27xFZi41A4MFEYv
zQKaSBTA8JAv5UOQEnxRVPm6WTiFm8K/bHdmg4V7mnZuO5GGaatzAPdccNg2Kwmd
LLno1VReFh+YCS4KgmleWTppM2cyQoUv9Xvn2cxPXUrl/SwY+uZirRD+XaTCmpP4
+PC8B/UCzrSYAofqyIbG6GzMvMWR2A==
=GD2/
-----END PGP SIGNATURE-----

--oMsUp/GSpAoVqPRg--
