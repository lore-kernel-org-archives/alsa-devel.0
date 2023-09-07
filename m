Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F8AEC8734
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Sep 2023 14:36:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CF96DA4B;
	Thu,  7 Sep 2023 16:36:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CF96DA4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694097413;
	bh=GY6/oA7SpWwIF/ML9jHKi31Aw6dDj+gK/Pfk0CzMgqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=S+BoK8+ErqkwOKvsugsPSUxmy6vsPruY2i67+jGrHPkNw1vVDVLsnx5XdinxZyRKP
	 uRfYC2qScaZttHWSc545AxczevBuxqq442MaUkQtDwKk1r0Ow3WS85yM/Mr5r7v4Om
	 0AScnWIexWHZxKuQBf83AQ1ViUg7RFNqrqvJqtZo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D0D20F804F3; Thu,  7 Sep 2023 16:35:53 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4498BF80494;
	Thu,  7 Sep 2023 16:35:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 090EAF80494; Thu,  7 Sep 2023 16:35:50 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 13AEEF800F5
	for <alsa-devel@alsa-project.org>; Thu,  7 Sep 2023 16:35:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 13AEEF800F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=meYesdsY
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 642B6B81D4A;
	Thu,  7 Sep 2023 14:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23E2C32792;
	Thu,  7 Sep 2023 14:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694097344;
	bh=GY6/oA7SpWwIF/ML9jHKi31Aw6dDj+gK/Pfk0CzMgqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=meYesdsY2uNTDb5EWe4281EIPUqP+ejVqDZt9LCkSfXPg4Irrz3V+aN6tNCzOlgc2
	 ahh8dLGQQAnbuiFUv6CfwEQdgMoQh2Us23Bv55rnXFCgCOLrOmRgckQmB49BCwBfNT
	 F3vJeT816sWqUt+PmdBvRs2D4bFdqQfjc1DO7pMD099Ku5mwQT/QLbNiAWJ/KW2x1x
	 2ft6mNiLln57pjQduAluykFZGPrhx+sfNSVVZRVaXjbIdi+4wugfRr70TqxfCMPe1l
	 Gbt/aytSPZ6Z7sQtswCgUTVlJunB/G6M+lsApHXzAaRfDmEyiemOTyTCnbq+vrNOO9
	 r6MAC/pLNbtjg==
Date: Thu, 7 Sep 2023 15:35:38 +0100
From: Mark Brown <broonie@kernel.org>
To: Sameer Pujar <spujar@nvidia.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
	thierry.reding@gmail.com, jonathanh@nvidia.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: tegra: Fix redundant PLLA and PLLA_OUT0 updates
Message-ID: <262708f6-d25c-4734-834e-6a3959ad6c07@sirena.org.uk>
References: <1694069533-7832-1-git-send-email-spujar@nvidia.com>
 <1694069533-7832-3-git-send-email-spujar@nvidia.com>
 <2c3371b7-3dae-48d7-8cc8-1acfd5bd267c@sirena.org.uk>
 <61ca531e-6138-7abe-74d1-357369134748@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1d4+VEBxjo3mBMnm"
Content-Disposition: inline
In-Reply-To: <61ca531e-6138-7abe-74d1-357369134748@nvidia.com>
X-Cookie: In the next world, you're on your own.
Message-ID-Hash: 7FGIOL4K627K2H6GO4R7TQY6PNPTST3A
X-Message-ID-Hash: 7FGIOL4K627K2H6GO4R7TQY6PNPTST3A
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7FGIOL4K627K2H6GO4R7TQY6PNPTST3A/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--1d4+VEBxjo3mBMnm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 07, 2023 at 07:51:13PM +0530, Sameer Pujar wrote:
> On 07-09-2023 17:21, Mark Brown wrote:
> > On Thu, Sep 07, 2023 at 12:22:13PM +0530, Sameer Pujar wrote:

> > > Fixes: 202e2f774543 ("ASoC: tegra: Add audio graph based card driver")
> > > Cc: stable@vger.kernel.org

> > This is just a performance improvement rather than a correctness fix as
> > far as I can tell?

> This was supposed to be a performance improvement. However this is found to
> be resolving a DMIC clock discrepancy and suspect is it happens because of
> back to back quick PLLA updates. Thought it would be safer to have this fix
> in stable releases. May be I should mention these points to justify the
> 'Fixes' and 'stable' tag?

Yes, please - that does make sense as a fix.

--1d4+VEBxjo3mBMnm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT537kACgkQJNaLcl1U
h9Aybwf+PTHcefnbcaqpdAilafzxlBkq71oJqgpR14bRtbQXU4jEgToFVRwoEe2r
eh7710aUYzNQatW+EVTp6OlxujcL/CmTLyjzdmVZDRViDZvVTtq1BwnEMBPVoDnm
VQd2uTPqMq05uopzbCnq2s3Mv5gEcw1PPMnqAYvGBOJ+e1XvlBC4h7t3svkcHHku
Y8QCOwyGF+Akq3Dl7WFvenZ0rGJ7z2/NXP//rD2TXeKorRSID19tupKL+i4KJPFV
9RLhqpX/8CpXvo2EwlOSuWvtvN1Waqego6zmQ511uj90I1K24+dY9sgXk8JEE/6L
gsWaQE4XT7wbfut/xeALndmOVrDk0g==
=Ei6H
-----END PGP SIGNATURE-----

--1d4+VEBxjo3mBMnm--
