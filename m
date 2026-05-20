Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC2BCD5BCF
	for <alsa-devel@archiver.kernel.org>; Mon, 25 May 2026 08:23:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3B98C60228;
	Mon, 25 May 2026 10:23:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3B98C60228
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779697427;
	bh=0DUsU/YkT/6p7ixjcRhDi0Xoebn0Ckyg6HAwTiAqg6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qaOcbjoIh/KKNvpUmskhdLJrbS6vIHvPXbBORailgRkkc9crfopdLAbWNVn6jlpKn
	 WJDM4ukFiL2jfzrNo/omMdR0D/UOIk7eVELgeMA5612yFfPatUVIL3fy8PT4NzVluH
	 3W28qWgGzNLDIzrYx/gNRF+i/KLggdctW7Eu2EyQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E954CF805F8; Mon, 25 May 2026 10:23:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A7865F805E2;
	Mon, 25 May 2026 10:23:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C36EEF80557; Mon, 25 May 2026 10:23:07 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4873DF8047D
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2026 10:23:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4873DF8047D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=S/DrYgVN
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6B37E443F9;
	Wed, 20 May 2026 11:33:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F8A1F000E9;
	Wed, 20 May 2026 11:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779276812;
	bh=Y2HnzgfNxgDnJw595gPPk2OLeG8jwrkxR7AEQAb9CD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S/DrYgVNJ7/fcp5hURWOoqeJ96Sfi1bY+TaU2nDWWB8X/jSufqAUIdSsdsQ5xazJ+
	 7BDq39a6gBWYiiau0adUWf1J1MZ1agWndOr6ce9Ki6SjxwQEx6hmQBWCY/vipzHxJW
	 7HvpQ60vQh1xBQbAgNfiET/Db5+1uauzsX02i40MNcsBS6gPrUzXD/ty6mFZsegIdG
	 JAuDp0tN5FUUEyta1andhivNdjyaT0ix/GxqgwV9BM5nU3mj5zG0S+Nv8W87XWpBjq
	 xjPFIbS90BSVs7MFHtA5dY4JU0XvenPXYT84MTmWyP9fOv8+vK/P6DpPSxN/1TUK0V
	 UhoXYCpze8Y+g==
Date: Wed, 20 May 2026 12:33:27 +0100
From: Mark Brown <broonie@kernel.org>
To: jack.yu@realtek.com
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, lars@metafoo.de,
	flove@realtek.com, oder_chiou@realtek.com, shumingf@realtek.com,
	derek.fang@realtek.com
Subject: Re: [PATCH v4] ASoC: rt722-sdca: Add a control to support CAE
 firmware update
Message-ID: <7f0c280d-7a42-4933-a1b6-c627314c9b75@sirena.org.uk>
References: <20260520053243.3645180-1-jack.yu@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XFaHUiZ1QpPFXarv"
Content-Disposition: inline
In-Reply-To: <20260520053243.3645180-1-jack.yu@realtek.com>
X-Cookie: Natural laws have no pity.
Message-ID-Hash: BJAPWIK4AQ6MQRDG7ZELQG235MOQ34IV
X-Message-ID-Hash: BJAPWIK4AQ6MQRDG7ZELQG235MOQ34IV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BJAPWIK4AQ6MQRDG7ZELQG235MOQ34IV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--XFaHUiZ1QpPFXarv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 20, 2026 at 01:32:43PM +0800, jack.yu@realtek.com wrote:

> Realtek CAE requires specific tuning parameters based on
> the system vendor and SKU.
> This patch adds a kcontrol to trigger the firmware loading process.

> +		if (strcmp(tag, xu_tag) == 0) {
> +			dev_dbg(dev, "%s: This is a XU tag", __func__);
> +			memcpy(&addr, (fw_data + 4), 4);
> +			memcpy(&size, (fw_data + 8), 4);

Sorry, should've thought of this before but the memcpy() will have
endianness issues - these should get washed through appropriate
conversion functions so the driver will work on non-x86 systems.  I'll
apply the patch since everything else looks good, but you might want to
follow up fixing the endianness.

--XFaHUiZ1QpPFXarv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoNnAcACgkQJNaLcl1U
h9DA+Af/ZQtQ3U7PYDFcn54Wdzj/zLBdghP1mCkbZpHCrXp3Ud29fBdgVZPeGz2O
wmXGKrkwKu/eow90etDdShqJ8xzsAtqx81lMp+2n/ELUHO6h4Rv4wQYxOuF6VKQ6
0U6+30Y6QbGg5R+4vHcgPcOEXBYmhIkcio4uztlHVDdjfaeXqPC3wVX8iR57PIrS
aEg4zzolrcz5M+xP+JgPpweCcs8Lf89ELEE1+AAtJ4DJy/yKsS+m/NztvBO8fY0N
Tq1Gr4Q8FmfOUuxO4o0KyAvYPL/KWPfBQ1OwKNdltlPX/q/A/hkS3PNKYzUC0Rh2
Zka28Jc/k9Na8i8argjLAqXcFaM49A==
=qHwu
-----END PGP SIGNATURE-----

--XFaHUiZ1QpPFXarv--
