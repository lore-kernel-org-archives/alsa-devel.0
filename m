Return-Path: <SRS0=f4/q=ES=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0168FC2D0A3
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2020 15:14:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50983216C4
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2020 15:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YXkvlLXa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="my33epab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50983216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5CDC317E6;
	Thu, 12 Nov 2020 16:13:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5CDC317E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605194038;
	bh=BG7Spw3Anoatk3We67LFQ/D+hctkXaKroUMjUFvwMGg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YXkvlLXa3yhxVEWz//awsZlhSmsQE/3HpfCm+Q49AZYoHORNhcN6Tx3/wejJRT01E
	 mVlC/iTxngxMdXd46j/VeTImywra3VyTwlswOs+mHBmWmrrPOua75kT5/zO7Sx8DTi
	 MMhfuYW+0DheGD7rkmHxhMsvts6sjFipODIk9tOE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E4CC8F80161;
	Thu, 12 Nov 2020 16:13:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DBFF3F801D5; Thu, 12 Nov 2020 16:13:05 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 38DF3F800D1
 for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2020 16:13:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 38DF3F800D1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="my33epab"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1082D216C4;
 Thu, 12 Nov 2020 15:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605193980;
 bh=BG7Spw3Anoatk3We67LFQ/D+hctkXaKroUMjUFvwMGg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=my33epabW+NxU+lV68HAmmsepaL2Ws8WJgr+8ZUyq6KdIa3UtSD/ulLNVkTc9D/mH
 jSVI5cLGXaDwPtfSEP2/mMv5gR/vLbI2o0IF0xPhk0NH+6V7pFEWFt7U5L2DA903SW
 3MJkCsADUVcnPRB9rlxL9jfFosoLt0IEENQBOo2E=
Date: Thu, 12 Nov 2020 15:12:44 +0000
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 4/4] ASoC: SOF: Intel: fix Kconfig dependency for
 SND_INTEL_DSP_CONFIG
Message-ID: <20201112151244.GA15925@sirena.org.uk>
References: <20201111213533.149963-1-pierre-louis.bossart@linux.intel.com>
 <20201111213533.149963-5-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <20201111213533.149963-5-pierre-louis.bossart@linux.intel.com>
X-Cookie: fortune: No such file or directory
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: tiwai@suse.de, alsa-devel@alsa-project.org,
 Randy Dunlap <rdunlap@infradead.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 11, 2020 at 03:35:33PM -0600, Pierre-Louis Bossart wrote:

> SND_INTEL_DSP_CONFIG is selected by the HDaudio, Skylake and SOF
> drivers. When the HDaudio link is not selected as a option, this
> Kconfig option is not touched and will default to whatever other
> drivers selected. In the case e.g. where HDaudio is compiled as
> built-in, the linker will complain:

This doesn't apply against current code, please check and resend.

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+tUOwACgkQJNaLcl1U
h9CXxAf9GqzuXFDkSXuVNRRqeM5l8X0b3PgaLbryuTzQKHrAf9G3m10V3fMLqE6m
MzQfDLLkqYHhUXEJ/wOrLQR6HN5eZ7syoZSV/l2f8W+jhdfGmpkotWQGp1guq+on
YVHDW6RbvUrHR7ZTbx6pxuKVjHP4kVrpNOHsbHjH78xPd/gOuAlhBOsBEKfoETgG
zm/P3bJ9nnfSiLyHZ8mz1NUkzho5VuJMVfesAfd6oN2mABDVkx4l8bjZMBKnGpam
TUkNuqmIeKZkBFytbqZ/n4kM/PrXfVEl2z/7mCz0RhFhtMe/Ynl8FRf9+KDInOv3
YUJe8JemqQCcQU/89PHUHIp4ULEyAg==
=SAbP
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
