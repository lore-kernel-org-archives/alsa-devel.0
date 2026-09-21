Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F81C982DE
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2026 09:11:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 28C5A60201;
	Mon, 21 Sep 2026 11:11:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 28C5A60201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789981915;
	bh=+VcB+ttMt1E9WO6tUcLJBeyW9ptO/U+QQgi2fbcNjGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=M/4750IgGmitjcwykLK+yk5a5be4PgwmvsKeDPmGtx7Vnfml+TYGboUAxa96stcf+
	 E9FDZBBomU2FSBPpNS69BBrYYrkwryKchUyhJY6y0ptBxcR2Anpdx2DB+763Nm3y/N
	 vwS0wT6xv6LbxeaU4DEWGX5uAoeARSY6jpbDrxtE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 84466F805FF; Mon, 21 Sep 2026 11:11:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D6435F80600;
	Mon, 21 Sep 2026 11:11:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E6C72F804F3; Mon, 21 Sep 2026 11:11:08 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789981868;
	b=WvR+l5HQZ4NiS5ZzPWDWhhmaYGPnp+lzfIlusiiXOe/qBzG1TRwaFdqJzJoMibWHHhQN
	 7TTlAx1aYODIBIhoSMtC/ie/6E1mZci4yBtKo4NUOS5oJ9OjJ6etOBH5Ab9P6YZTWjUNo
	 e0SGNrdrb41f6zfRy8agkB0Ydf9eOwvo3ywpms/BuAaVFdbCl8HfeYD7F/6OMaNVTcoCA
	 mh5UuVvXbWIfI1t64gh0Rh6C9qUrKn00ostYRMmWQHt4wPuXJotZILVu7yiKTTK1joLEO
	 VF80EYCh+5ZpvPp/Cs1+Ed4zxDHXI5wwfSewNtz+Zd3x05v4VJvixVDYoE1AAI27c9w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789981868;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=+VcB+ttMt1E9WO6tUcLJBeyW9ptO/U+QQgi2fbcNjGw=;
	b=VbwBIRJpVq+065eCD0avlVPcynYOX8dyjV14/bsXYtpMCqFW1wx+YVA0MugwDOVAcBxK
	 nmskzLeI7cpyepl6sWOP2OJKvpldINDacxPWQMXl0m1BP1gg394cQQ89nxar5+BOhkyOe
	 81ydnwB2BxQqX4Wn0D1UR7Jv+xdoUf0dWKh+q2CA/xxxBt7nmbl2VFkI+yvXeLbly0zFz
	 Uhz5QDlk+azSe7j9lHnutMlNAPBxKbbWWidRrkO3CMx74pAQ1p7Ee2B/sJkIG6znY82Iy
	 sLvLHZid3s2T2oeB0+w9rCeytdPDdAYMA9oMXEWxpfYOF+eAUr3NhLkTvuk6ToG6UfA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=PYlEgP8q;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E3F61F800FA
	for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2026 11:11:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E3F61F800FA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=PYlEgP8q
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4F345600C8;
	Mon, 21 Sep 2026 09:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD0D1F000FF;
	Mon, 21 Sep 2026 09:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789981864;
	bh=4r6J+O27bPN/mF+lHzy1akfGvLRv+kcqQTrsw7MnBbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PYlEgP8qdGaPzQWNM0QBtfYnPomuw7eJiIHcH3f8PvIoFnHmRoVuTH/OvRGeMYBsX
	 pr+6uknZJa/ndpWPwDrCL3gWqJzTyw23/9kU8fzxzdVe9EPndXt+ZeqdkJF2SzO70j
	 dS5rTlUlo/ODQJ0RsZ3VhWR+EK+ww/NW4SbJup3khTThfaYIg80qsnXSgvqEzZ+mHy
	 Ye+HFiZHpCnPvJ4JVzEvUV3uxu3ZVQSVvdaICSIw014M5t68O/Uesau2NHaDeXVykf
	 6MxbMhvuIMgeY8rSHjJva5W63QqOcQVkW916zAI5WHmcmuQMOo/pDP8ybtRYGq2YDg
	 mPzuRtJOfyi2g==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id A11611AC52F3; Mon, 21 Sep 2026 10:10:53 +0100 (BST)
Date: Mon, 21 Sep 2026 11:10:53 +0200
From: Mark Brown <broonie@kernel.org>
To: jack.yu@realtek.com
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, lars@metafoo.de,
	flove@realtek.com, oder_chiou@realtek.com, shumingf@realtek.com,
	derek.fang@realtek.com
Subject: Re: [PATCH] ASoC: rt1320: make SRAM registers readable to stop being
 cached
Message-ID: <arD0nQ4nTCuI2w0f@sirena.co.uk>
References: <20260921072847.2929865-1-jack.yu@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y1q6Ifudjp8kQ4ur"
Content-Disposition: inline
In-Reply-To: <20260921072847.2929865-1-jack.yu@realtek.com>
X-Cookie: Too clever is dumb.
Message-ID-Hash: B7TKFZOBQXQBLQKCEEY7TFD35WOKSYZW
X-Message-ID-Hash: B7TKFZOBQXQBLQKCEEY7TFD35WOKSYZW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/B7TKFZOBQXQBLQKCEEY7TFD35WOKSYZW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--Y1q6Ifudjp8kQ4ur
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 03:28:47PM +0800, jack.yu@realtek.com wrote:
> From: Jack Yu <jack.yu@realtek.com>
>=20
> rt1320_volatile_register() lists the SRAM ranges 0x10000000-0x10008fff
> and 0x1000c000-0x1000dfff as volatile, so they should never be cached.
> But regmap only honors the volatile flag for a readable register, and
> these ranges were missing from rt1320_readable_register().
> They were therefore cached at probe and
> replayed over SoundWire on every runtime resume, delaying the first
> PCM open after autosuspend by about a second.
>=20
> Add the two ranges to rt1320_readable_register() so the volatile flag
> takes effect and the SRAM is no longer cached or replayed.
> The removed lines are already covered by the
>  new 0x1000c000-0x1000dfff range, so no register loses readability.

The RAE loader seems to expect that 0x1000d000-0x1000d7ff is cached, or
at least it's fiddling with the cache bypass for that range.

--Y1q6Ifudjp8kQ4ur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqw9JwACgkQJNaLcl1U
h9BiVQf/eWnNK4MoVU9KyCwyapVjM9noqQMhiXbi/JXdPAURZtVYPaI8UH+p7Mj9
g/vWBNqG0QRVwBdL2HWhgTOpvtg4cBgQ5FLmtsirnONyt6BlYh1Mp++zt0smaG/R
wh53jiXfy7NSUPIa3Yr6Z6IXG/DTQbXVJojEhEgTNAe5YngfH5My6UdA0B/uYcAO
QRSx1LtTryCM/tXkdF17nysyjEqb82wglrssip4uxeYA8m2ACYpU2tvZdHFYuSJJ
L18QyKeM9kjyNtBackZSWQQa/O89QdU+/26kRaJApFL+k0mlIe2ZaRN60B1jf2XR
6/1IUFyzLabBKXBozn3KdHO3kck88w==
=DWOh
-----END PGP SIGNATURE-----

--Y1q6Ifudjp8kQ4ur--
