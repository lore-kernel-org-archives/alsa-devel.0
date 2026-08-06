Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EADEC55ABF
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2026 11:42:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C39D460239;
	Thu,  6 Aug 2026 13:42:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C39D460239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786016531;
	bh=Flo/uHX4QUjlM708gbPqM09Zj+zFE5pjBISZkGdM9xE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=GObpMmRlisiNd4fleyEdbQmii2Xgd0efhVw6hLd/8wdo4YmY243gsXrPl0xeaVzHR
	 zuUepO/f+3OoYulEL12nKWV429HK21FYS1UUlTXgUJvAqtSkQb3uk1pJYhK+NUFkBO
	 lRO/0eWpR5TgypplUpSCh91Zr29ZV1qBLTyVrHYo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 83CDBF805F7; Thu,  6 Aug 2026 13:41:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2AC5FF805EE;
	Thu,  6 Aug 2026 13:41:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 38359F8055A; Thu,  6 Aug 2026 13:41:30 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786016489;
	b=nKQWJvk/5Dd7arqMHAx2eSrtjDxrygqD/Aq1sdwTIt85pMV0wlqHKnyMKLV/9ahun01b
	 uEi1AISx3jY4rSihDWT8zdUzg2GSNfB4Ub/IAszGT4lz4A6NRN76ZB5WEE1uliJB4xQOh
	 VkTa8zYJcScRJMtJEnRNk6enBF0/KYLZSRhuIjwzOJ7trh8OzkvkoklVcSWgllLjwx7P/
	 mAn6fGhtr9xmpBzJnfwijlGjcDfEnpV6hI8MYQc5zCY6/0APnZl9xju1bScgxtDSiuqDc
	 TKoV+1AFwmG0PKzQJXrUj5BgCPHJJ6hPBjAk+fri7+xJtVgPjegsaBWHAGuWBNnNL9A==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786016489;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=Flo/uHX4QUjlM708gbPqM09Zj+zFE5pjBISZkGdM9xE=;
	b=pm452I5dN0L1Yl4vo/cPeArUco6dJfdo5tqLVQdXaBhPNsKMrMsZDd3mb9EquP5V91M4
	 ecV1Df0bwueIX1a6nUkCoK4Ef/fofSx4Sl8+Pb3Sx/AKvUcPEStqpzEp732yzHaMRoVop
	 vy4id2XItq58+NqMdAvmDlAH7R68+UnlkpRIKBaqPJVFlqzD1WHMzIn4xH/ldbb+1RMsM
	 BcQRRjuf3E7NL23z+yIh6RTZOdynlcFFFr1j0uG2aP2TtKHwK9IBwnNEfEngjbEzegkjp
	 Z6KFFsZ8gNjJCzqswfyqBnY4Yuo8YA7xkultRLbPL7azfGpG0QISXlFDRI8JYLnAacg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=nglPgRSq;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9D2E6F800B5
	for <alsa-devel@alsa-project.org>; Thu,  6 Aug 2026 13:41:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9D2E6F800B5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=nglPgRSq
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 70C554323A;
	Thu,  6 Aug 2026 11:41:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225CE1F000E9;
	Thu,  6 Aug 2026 11:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786016485;
	bh=Flo/uHX4QUjlM708gbPqM09Zj+zFE5pjBISZkGdM9xE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nglPgRSqENZvFj3z1QCGSioSvVIpiqrBxeCoFlH74qebIBnM2r5cOPUWa798zYaOg
	 XyBXSPqc7wXWsnIGh465ZHQgspNEfzWCGZfEmafsIV17/lF1l0jhMf2fV8MQA/Pr2o
	 sTj2rcjtuTuSaWrMCTr9Wqo6bRfXZmXE3+gt03fNhlC7YhWrBmTuYyh+8f4N1y/Raq
	 t9O1GyWAFhf5ElUpPiqFOyGZ5AMjbnuTtOhpK32hfuDt0v4i0vgc4YrgITYVssw7Sb
	 Ec4W51QPG90CMdybu/q76CXNNrwwxwixc8g6tOciyBVWgdxm31lCBKP8tI3u6ztI8Y
	 7jTdw9AOlXlCA==
Date: Thu, 6 Aug 2026 12:41:20 +0100
From: Mark Brown <broonie@kernel.org>
To: YLCHANG2 <neo.chang70@gmail.com>
Cc: Neo Chang <YLCHANG2@nuvoton.com>, lgirdwood@gmail.com, perex@perex.cz,
	robh@kernel.org, krzk+dt@kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
	kchsu0@nuvoton.com, sjlin0@nuvoton.com
Subject: Re: [PATCH v7 2/2] ASoC: codecs: nau8360: Add support for NAU83G60
 amplifier
Message-ID: <24312caa-d38f-48ae-a137-63eac9f7d58b@sirena.org.uk>
References: <20260804032951.1069901-1-YLCHANG2@nuvoton.com>
 <20260804032951.1069901-3-YLCHANG2@nuvoton.com>
 <479efa04-2c02-4b5d-8fdd-e3d4c6e49c4f@sirena.org.uk>
 <7691eac8-5798-c1b5-5ffd-19c780b69a3f@gmail.com>
 <fe60dbe2-0626-4d52-8be3-62445a35ddaf@sirena.org.uk>
 <4bde20c7-2496-8122-7e0c-4fd986a59232@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6m+pV/bZ58Xr9IBk"
Content-Disposition: inline
In-Reply-To: <4bde20c7-2496-8122-7e0c-4fd986a59232@gmail.com>
X-Cookie: Brain fried -- Core dumped
Message-ID-Hash: HTQIZOBJLVBFZYSTUAS6UEXL5E6NXEJJ
X-Message-ID-Hash: HTQIZOBJLVBFZYSTUAS6UEXL5E6NXEJJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HTQIZOBJLVBFZYSTUAS6UEXL5E6NXEJJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--6m+pV/bZ58Xr9IBk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 06, 2026 at 11:27:43AM +0800, YLCHANG2 wrote:
> On 8/5/26 18:30, Mark Brown wrote:

> In the v8 patch, I will remove all fine-grained clock divider configurations
> from nau8360_dsp_hw_clk and nau8360_dig_sys_clk,
> leaving them to only handle source switching.
> Is this approach acceptable?

Yes, the concern was the fine grained dividers.

--6m+pV/bZ58Xr9IBk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp0ct8ACgkQJNaLcl1U
h9D7dAf/fNB/oCN7chAia30DfMPgccSts/Pd2aNA+/KjjZK+mpYPJNNEx3k9VLXt
C5C9RDUgVsA6PVwnMHSTjgCur77ADP5IZ9gs2zMmoV1iF+WynxQUQXgNNjXwJdGc
CK7LAJli4PxJCf83uKcciqTQOWKYANRQfn04yMKthQ6RrP6W/SpM4Yrzfzz88igH
PV/5+Ymzijn9sASLn3Ik4y9ufaT01Pt4mAlAGBTwxsVlMT+5QdNhEqR6H5VTW+NT
ZGXs/q3klie3jYnlfKE4EnpuoiF/r28LEalr8whWwfEDsyKv0jcIiG6sqJD5S2qu
W07nHoDhYWEMzRji88RpJqCOxVgDHw==
=drsC
-----END PGP SIGNATURE-----

--6m+pV/bZ58Xr9IBk--
