Return-Path: <SRS0=U/T/=46=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9BEC10DCE
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:32:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7743B2073E
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RdjqViV1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7743B2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ABE61166C;
	Fri, 13 Mar 2020 15:31:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ABE61166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584109967;
	bh=x8GGQ1ulMYXe3kWEbWWEenVnUQikdkrRgnbGKRGISR4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RdjqViV11BXcHpiaVb3GE2r+sY+deFyLHYRrpljRI7VgIlIcqA1jG8/CfqpN/kP8i
	 WKmWUbA0ENFbQyqx+bsIJ61789IYqBFCQKXm/fEZbn4VbYhaxJDyffd+pTRYi4z0QA
	 KdACjGEq60gY10zDQJbKXXn0enmiWfj4TNXNVrsY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 212EEF801A3;
	Fri, 13 Mar 2020 15:31:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B8674F80086; Fri, 13 Mar 2020 15:31:30 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id AD0D4F80086;
 Fri, 13 Mar 2020 15:31:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AD0D4F80086
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71D3230E;
 Fri, 13 Mar 2020 07:31:23 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC9693F67D;
 Fri, 13 Mar 2020 07:31:22 -0700 (PDT)
Date: Fri, 13 Mar 2020 14:31:21 +0000
From: Mark Brown <broonie@kernel.org>
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [PATCH 00/14] ASoC: SOF DSP virtualisation
Message-ID: <20200313143121.GI5528@sirena.org.uk>
References: <20200312144429.17959-1-guennadi.liakhovetski@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ev7mvGV+3JQuI2Eo"
Content-Disposition: inline
In-Reply-To: <20200312144429.17959-1-guennadi.liakhovetski@linux.intel.com>
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


--ev7mvGV+3JQuI2Eo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 12, 2020 at 03:44:15PM +0100, Guennadi Liakhovetski wrote:
> This patch series extends the SOF driver to add support for DSP
> virtualisation to ASoC. It is built on top of VirtIO, contains a
> guest driver and a vhost in-kernel guest driver. This version

Is there a spec for this?

--ev7mvGV+3JQuI2Eo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5rmTgACgkQJNaLcl1U
h9AFjQf9GAsVkvJADM4k1Rp2gmWANvzxSTw/QLf0L6rbACWr28/0B1WR8gT7OdLn
XBvwCIbMe+vcPNaon22cp/mSowr5P8jJw9wIGAtiQDGqbD6czpagzz30WFuNaTPz
vQsVuoPfB8lCRAkEpWyQZwh6VFB9FLDbjwVSdO3/yAU+Z0Mle5UdR/jP9isPUh+F
y39jelF0OsCrxEBbEt8VC92ZJJGgDiEeKCbLZrzLjYCxhWJsR0KLdmFGPiyW/+zv
CAe4MvvO6sGz0CuxlNnFeR+rti+yl4+F6AsKnnEofw+vDRN29lVZ6ZQR59rQHvG3
CizUHPlF+p3yggBuZEAWnFhPppIdPw==
=lJ/I
-----END PGP SIGNATURE-----

--ev7mvGV+3JQuI2Eo--
