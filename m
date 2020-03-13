Return-Path: <SRS0=U/T/=46=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB236C10DCE
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:40:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16383206CD
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ha9RGNhL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16383206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6A6F6184F;
	Fri, 13 Mar 2020 19:39:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6A6F6184F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584124817;
	bh=MUIqtlM88VBe5x2tzHrPx5WWByO10VfT47z1v80+PD0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ha9RGNhLXxPtZ9hRjzoaKwK2h5UT1mXqSd0AVcgmaNwAuNpH/q4wPoJV/KegnqS0l
	 QY3vq1WAfhN4tFEU8Tx9grdNutxGJ/EfbYSdoPbz6YEXJnQ2DPQmiPCqS0J6TaOTfi
	 N6GY5COWfK0yKxkn5htbIHbYhSbUTmiKtTJxKcx4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0030DF80086;
	Fri, 13 Mar 2020 19:39:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A65CDF8013E; Fri, 13 Mar 2020 19:39:24 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id CED77F80090;
 Fri, 13 Mar 2020 19:39:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CED77F80090
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FED131B;
 Fri, 13 Mar 2020 11:39:12 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FBB03F534;
 Fri, 13 Mar 2020 11:39:11 -0700 (PDT)
Date: Fri, 13 Mar 2020 18:39:10 +0000
From: Mark Brown <broonie@kernel.org>
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [PATCH 12/14] ASoC: SOF: VirtIO: check guest component IDs
Message-ID: <20200313183910.GL5528@sirena.org.uk>
References: <20200312144429.17959-1-guennadi.liakhovetski@linux.intel.com>
 <20200312144429.17959-13-guennadi.liakhovetski@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VBq/nvTu32OVLBUP"
Content-Disposition: inline
In-Reply-To: <20200312144429.17959-13-guennadi.liakhovetski@linux.intel.com>
X-Cookie: This page intentionally left blank.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 sound-open-firmware@alsa-project.org
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


--VBq/nvTu32OVLBUP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 12, 2020 at 03:44:27PM +0100, Guennadi Liakhovetski wrote:
> Each VirtIO SOF guest has a component ID range, assigned to it. Add a
> check to make sure, that guests stay within their ranges.

Just squash this into the change introducing the code being fixed.

--VBq/nvTu32OVLBUP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5r000ACgkQJNaLcl1U
h9DMCgf+IsIc7L/AQ6l0Ywx9ZyTkDKg3BxDEVNsahpHbqcVKu/iVyjrHZ6NpH67b
TEMDy2nwKCLTzHbNmIOWDTqaLfnEaPJk+DN6sXBjANfrKF7M2xt24V7IQf0mCjPZ
yhKq2Qe/uyg/c8GSoCtWLzlePw4Mt6T/5USc9shB58/ZzQCnGlKB2ECTdyLxc4UB
vPwxYPyGoXXeCFWVmkoUSCc1aoLGrX7o7C306KMNkZ7vOarBiOehc1RpGgZclbUZ
jrWlvLhwZu7q8W5eBeF/d8fdZfQT2wNSxjF+qxLb6t+EwQLAV/U6K5OGeoWTnSxp
MGWsq1qTYim92DdvLkwsfy/Q3HRbaQ==
=EfI9
-----END PGP SIGNATURE-----

--VBq/nvTu32OVLBUP--
