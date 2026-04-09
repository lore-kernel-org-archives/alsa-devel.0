Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7918F364B5
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2026 19:42:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5D38760200;
	Thu,  9 Apr 2026 21:42:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5D38760200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775763738;
	bh=gtKnKJScYYsWeqoov2i2/s6wmYCGAzfJzZ3lS2oSw1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=HexT6AMNT6eXnxYj2ZhOWZIALzPGrajnnpN30hQ03CLUOTdal+Z4kfLgh+/zyO3yS
	 dhuFzYCPtuoSruFOFvycCoy8W9SFTFo2IShNzVm96t7+akF2i472ikzF8nH660bydk
	 JBQMJ3TqGK6gebvZJLdUSXQPZDKUeSzd5km8OSnw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E0955F805ED; Thu,  9 Apr 2026 21:41:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A6A48F805E5;
	Thu,  9 Apr 2026 21:41:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A1015F8052D; Thu,  9 Apr 2026 21:41:32 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9E60CF8027B
	for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2026 21:41:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9E60CF8027B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=q6b5gcYZ
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0E944600CB;
	Thu,  9 Apr 2026 19:41:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898FFC4CEF7;
	Thu,  9 Apr 2026 19:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775763687;
	bh=gtKnKJScYYsWeqoov2i2/s6wmYCGAzfJzZ3lS2oSw1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q6b5gcYZzuI2xMCw9mnywZNOGr8EuVPp094gFakHopduNoQgKPqMo9jeaFbrnkNWv
	 7BJclP7BZD1abGYRnSJwSjjH/PIVLi/+vqM59hFsBRxuM9unaJAUESGg3OvsHNqX1N
	 pDIMRqi4zdjSTN6QPeMjtxwWqRgsoIexshLwf8gOO/hbv150hR18eMjeOtNxppI8Uu
	 fgRps1QyNedwEtCe+13UowzSqJGS+StcTv4uavwii5ZRyEGKGvGHLjAO8NHKg0351m
	 +fe/BdNPsOmIURDwkCpgTQhWQ89Gl5Iaj7pGPkuaDQflyrF8fyGsNhewuAjpyYsR4p
	 HD7MtKuftVECQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 827D71AC58A7; Thu, 09 Apr 2026 20:41:23 +0100 (BST)
Date: Thu, 9 Apr 2026 20:41:23 +0100
From: Mark Brown <broonie@kernel.org>
To: jack.yu@realtek.com
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, lars@metafoo.de,
	flove@realtek.com, oder_chiou@realtek.com, shumingf@realtek.com,
	derek.fang@realtek.com
Subject: Re: [PATCH v4 2/2] ASoC: rt1320-sdw: Add an approach to get new
 hardware advance gain
Message-ID: <adgA4xUYsu6xj1au@sirena.co.uk>
References: <20260409060102.4177554-1-jack.yu@realtek.com>
 <20260409060102.4177554-2-jack.yu@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tfP9Ceg32SJvueAi"
Content-Disposition: inline
In-Reply-To: <20260409060102.4177554-2-jack.yu@realtek.com>
X-Cookie: Are we not men?
Message-ID-Hash: TCZ7ESDW2S2ZROGZERVN5UQT33YQGREC
X-Message-ID-Hash: TCZ7ESDW2S2ZROGZERVN5UQT33YQGREC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TCZ7ESDW2S2ZROGZERVN5UQT33YQGREC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--tfP9Ceg32SJvueAi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 09, 2026 at 02:01:02PM +0800, jack.yu@realtek.com wrote:
> From: Jack Yu <jack.yu@realtek.com>
>=20
> Add an approach to get new hardware advance gain,
> and if there is no advance gain with this approach,
> we can still get advance gain with original method.

> +	 /* Get new hardware advance gain by ID 1300 */
> +	rt1320_fw_param_protocol(rt1320, RT1320_GET_PARAM, 1300,
> +		&audDriverDataHwSwGain, sizeof(audDriverDataHwSwGain));
> +	HwAdvGain =3D audDriverDataHwSwGain.HwAdvGain;

If this is intended to support a fallback in case param 1300 isn't
supported shouldn't we have an error check here in case the call to the
firmware fails?  The parameters are just read onto a stack variable so
we're not relying on them being left at 0 on error...

--tfP9Ceg32SJvueAi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnYAOIACgkQJNaLcl1U
h9DCGwf+INuhlRDH5tfaQqsjzKJRlVStAxoA1w8okxEDirOiX0SR4u0dY1MjT5Wg
HTMhvtT37SJQD3L+rDdt59VicjYgPjAWgQefiJv5QwAwOhdjVKg+26tRy88xg4LJ
aannW1O1PYzGsQ1VItOxEgg0Lj8PU5m2LAaQTFsED16uwFN5UrusMnWeFWbBl2WJ
Psv/YM6kO/+uUS6Yk7NxqPXnR60ZcLh2A+q+nyAkTGayTQ4gPjc6XtCRFcvSKVZx
Zj/Gq35T8JGPR6ZuBRwZRmN275VE+eu2L/rOXOURQ2kwPo5SnXOz7nYz3bKtvk0S
+OrHvmuZay9xL0bVIW26z8S4DPsNEQ==
=ClKQ
-----END PGP SIGNATURE-----

--tfP9Ceg32SJvueAi--
