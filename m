Return-Path: <SRS0=vsGj=3L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5937DC32771
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jan 2020 21:33:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8EA724673
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jan 2020 21:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GjsxyWxH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8EA724673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AD10C167F;
	Wed, 22 Jan 2020 22:32:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AD10C167F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579728792;
	bh=c70oJi8e/8aDlOyuICf6LOlBt78z6Q1rrKWDZ/Ws5PE=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GjsxyWxHBU9yvb9Po2P1ItymKYNFZrO3+yq7xcjzYRkdD2tHPZhHOODzaQ2sd0Jxu
	 zMRHrbpra1SxkmNJCstK2igR/UunxmClb1UjhRxYWqsk3vobv+opfe3b765HMvVEfP
	 IJHBZXZXyqT18G2JfVJxU77rO3viorN9q88r4fzc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2C6B1F8020C;
	Wed, 22 Jan 2020 22:32:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B862AF8020C; Wed, 22 Jan 2020 22:32:20 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 4BFA9F800BA
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2020 22:32:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4BFA9F800BA
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E49D5FEC;
 Wed, 22 Jan 2020 13:32:15 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6023D3F52E;
 Wed, 22 Jan 2020 13:32:15 -0800 (PST)
Date: Wed, 22 Jan 2020 21:32:13 +0000
From: Mark Brown <broonie@kernel.org>
To: "Sridharan, Ranjani" <ranjani.sridharan@intel.com>
Message-ID: <20200122213213.GH3833@sirena.org.uk>
References: <20200122181254.22801-1-cezary.rojewski@intel.com>
 <0c4a19c3-f1e3-7b76-be42-e4902645955b@linux.intel.com>
 <CAFQqKeVi8OBNc0ON+ogFBv07fYV25G3oK9Hsnydfg-sTwYZx5A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFQqKeVi8OBNc0ON+ogFBv07fYV25G3oK9Hsnydfg-sTwYZx5A@mail.gmail.com>
X-Cookie: Sorry.  Nice try.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.com,
 Liam Girdwood <lgirdwood@gmail.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Linux-ALSA <alsa-devel@alsa-project.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: skl_hda_dsp_common: Fix
 global-out-of-bounds bug
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0582101494945569503=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============0582101494945569503==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gTtJ75FAzB1T2CN6"
Content-Disposition: inline


--gTtJ75FAzB1T2CN6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 22, 2020 at 01:30:04PM -0800, Sridharan, Ranjani wrote:

> SOF does have the same problem too but I thought we're allowed to have dai
> links without platform component? An alternative to adding the platform
> component would be to do something like below.

CODEC to CODEC links are supported.

--gTtJ75FAzB1T2CN6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4ov1wACgkQJNaLcl1U
h9C/vQf/YdPAMWZlKWXmWV/iPsWXSEkgA/ZlYBRDBnDX6yweQ19SgoGmpkxMCphi
PY9196wVw1Xb2Eho/ssYHIrTlXXc9ttCc8fp/79NnY6RAws08anwtuWW1Pi4j83C
j8oTwvtl5KH8wRMTRnTUHdXQsb+2WuUdaWcEne2rrda3L3CnMBAmO2a9pIaOIcyc
0NTME/n8gqEefhTA6dlvEG2QVjF4Lh1lvW7DTx6SbrMJSUyhn+OVK/8gcw0L+qjK
9De5n4jHFKe16kI1tNxSd1cCDv1KbcAuDvW9qQvQLmiMIhVlEXxfBvdtCbt2Pjhs
1LcA0bc4jdX/7J+VXI4/R0D6/ZrvUA==
=pxI+
-----END PGP SIGNATURE-----

--gTtJ75FAzB1T2CN6--

--===============0582101494945569503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0582101494945569503==--
