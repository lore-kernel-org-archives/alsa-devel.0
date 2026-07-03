Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB981C43458
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:29:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 531E060175;
	Fri,  3 Jul 2026 18:29:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 531E060175
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783096151;
	bh=Wsa8e60w8+QOPPxrLWdRcVw01IrklMQWAMErh0FATrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=euBomnvxchYesvioV6xQ7dfAH8bQ9Il7dnihr/B9cMWW59YAWMyv1iRh6OqR6ffqD
	 wUH5tZv63qTz5sFo6kvgLN1ErBZeMZvl/J3GgiW75lm3lCQZ/E5K3PGxqCYCITm0hb
	 GdYuW5PETJW6azQ3w4fA6YVToyvQXmyt7dZLy8Bc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B9F1FF805F2; Fri,  3 Jul 2026 18:28:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 868F6F805EC;
	Fri,  3 Jul 2026 18:28:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F38FFF80579; Fri,  3 Jul 2026 18:28:28 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783096108;
	b=dc/BVJO7xzON/yy5DExqMYB/a/FdyIFA6LLy6w/cy/qbRYw4Md9SvT4UM95ZzfNn5fLe
	 Ip33ryJNpTJuRuRpqtuxDaB+RuiGEqA3pvb8hfxNzYE/vclM2lJUUb1+4IeXM2dp8ktSQ
	 0FYHSbf4dVoKeKB0zQHsenUzmFBrNMuW0Q8MiEicHp9sOu2xg584e4Gd7g518blYyq9PZ
	 cVgb7R3FWEoh2dz9DVIIVMnWowhsrNMB4qK5fCrhKTfXTVMZ9Z5la/iLtJQg+9lhKNnL/
	 4HD3qozCp21apEhutFbr/+SWfk3WTNal+eU6K07i6ZoPHk1M3ukg4HLNswf09QKEy+A==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783096108;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=Wsa8e60w8+QOPPxrLWdRcVw01IrklMQWAMErh0FATrY=;
	b=UvF27CqhP1Fll0gdSsA/P6GNKca9upS1COVuJ4so/V3Uvze2TD7eVoMH00AmDYCIfndJ
	 XBJWdLpoxQr1bfTCTLOn1fhLibsSav+mblO/t46GnuQIvLX2E9X9cF1TQpBOD2ZmVSbCE
	 Nv0L6KTvYJhoe2QiwwY7peNUfWmg7HQEbll3fq4TDOTVOjJxMNszUmgkrJFHM7QlVbNoU
	 Z6/tfrI8Br6ZzcjYXCWpjiVgLXaiPfJldH7V+GRBEGZGbAtIK9cCgxR6IhagTwg0i9KZ/
	 ja4VUEXvsbxAg9PNJq3jiPgvG+ivQryG76s/17Q+7X0bL4Ox1CyLWdeCJfdzjKohpYw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="mJlTK/ML";
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 242E7F8011B;
	Fri,  3 Jul 2026 18:28:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 242E7F8011B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=mJlTK/ML
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1699D438E1;
	Fri,  3 Jul 2026 16:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8A41F000E9;
	Fri,  3 Jul 2026 16:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783096103;
	bh=Wsa8e60w8+QOPPxrLWdRcVw01IrklMQWAMErh0FATrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mJlTK/MLMIQ+rd/1H1ee/scqYwaVUY/0YIXlR2xipz8OC9TCICYWdqLvAGbb7Kx9n
	 OREL+av26ebXWSRiqp/FAGDcVp45q5qSXlg5/0k1K+OuNM3b/q32h0Bh5ahCBWZiqq
	 u41c7JAhY7yLa/WXMKRet7P6GvI4i4zFyaxt5yH+4N4nljdAWJvNqrVxljJpskw+Ys
	 SDq99IrG/SbBkxpxLVBjgogTc38se4jnO7Tsk8QR0H/WK0IXV4CAYodKHhaXdD3Ql3
	 czrM2sF/2xtD3FUfVBJOePCAYxBvM7HhsMsfKJ+z3oa8uhxX3jA0oBYSHIbulJfce5
	 wfFa/7Agy67Sg==
Date: Fri, 3 Jul 2026 17:28:17 +0100
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
	yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
	perex@perex.cz, tiwai@suse.com, Basavaraj.Hiregoudar@amd.com,
	Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
	mario.limonciello@amd.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
Subject: Re: [PATCH 16/16] ASoC: SOF: amd: add system and runtime PM ops for
 ACP7x
Message-ID: <58e4579d-f87c-48db-9682-fec99c4706af@sirena.org.uk>
References: <20260701095759.1012929-1-Vijendar.Mukunda@amd.com>
 <20260701095759.1012929-17-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xi+K1Jmv9S1qyQZZ"
Content-Disposition: inline
In-Reply-To: <20260701095759.1012929-17-Vijendar.Mukunda@amd.com>
X-Cookie: Another megabytes the dust.
Message-ID-Hash: E4V2SBGDYDMSKTUCEF32ZKVD7V24VN2I
X-Message-ID-Hash: E4V2SBGDYDMSKTUCEF32ZKVD7V24VN2I
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/E4V2SBGDYDMSKTUCEF32ZKVD7V24VN2I/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--xi+K1Jmv9S1qyQZZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 01, 2026 at 03:25:17PM +0530, Vijendar Mukunda wrote:
> Add amd_sof_acp7x_suspend() and amd_sof_acp7x_resume() for ACP7.B/7.F
> platforms power management.

The interrupt is requested with IRQF_SHARED so probably worth double
checking if the interrupt handler is safe to run while the suspend and
resume callbacks are running, I see we reset the device during suspend
so there might be some risk of corrupted register reads?

--xi+K1Jmv9S1qyQZZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpH4yAACgkQJNaLcl1U
h9BTeAf/Xfs1KNhSBIwDYu9QP2zsOV1/3DUMCxLaFbq37lr72UfKrdXpClDydIEn
T09HIBD1H5s+Zrth7ZBVYRYjEtm2wzl9cuCQksc0YtQ3XqBbC/MzFWHdEVaI/BVd
3OFTXAdsuzrcGAiOv9i9NiSQNdju/stm0O4Ttxfuq2j3SkiPQ9yjAaaRpOdgQ6x/
fOFttkBKLg5zdQfeIapK91jDfYm171kaLwKEBZ0tkzf81kdLyucygP5p1IeXQEjP
JF+ImSdXb3RM4Ar3wv4a/B3o7TyGmwAPEVWhBpn06Gf48N+bN4WapRlfvA33y859
JjFvPy1LUZhXtHT14b83Aia6PiNS3w==
=3h86
-----END PGP SIGNATURE-----

--xi+K1Jmv9S1qyQZZ--
