Return-Path: <SRS0=ZYEx=2B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07F0C43603
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Dec 2019 16:36:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A794206A5
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Dec 2019 16:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XLh+st/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A794206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F1891668;
	Wed, 11 Dec 2019 17:35:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F1891668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576082172;
	bh=5v06Pk8tOLJJjDVkttJzEOJl4R0J1D9HPSSWY1NFsdQ=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XLh+st/Zbv1cPIk6Y9cnBwdmVHSPpl5kukvmcRDGAtRleUWRk9qVFsDijrFbhU6sN
	 HhwbEyDUYVLHgE34My+fSMNwsZRNPY94dI1yeq0kwgqSEm47ND+5fZahVQLwmffo+z
	 K8kWWRtz1IaZmY7jDadnUynD8dmK3FPMcOM+FAHQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3EC87F8023E;
	Wed, 11 Dec 2019 17:34:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A7C33F8023F; Wed, 11 Dec 2019 17:34:40 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 13C7CF800F3
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2019 17:34:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 13C7CF800F3
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9ED1530E;
 Wed, 11 Dec 2019 08:34:36 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F7C83F52E;
 Wed, 11 Dec 2019 08:34:35 -0800 (PST)
Date: Wed, 11 Dec 2019 16:34:34 +0000
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Message-ID: <20191211163434.GF3870@sirena.org.uk>
References: <20191210145406.21419-1-tiwai@suse.de>
 <20191210145406.21419-20-tiwai@suse.de>
MIME-Version: 1.0
In-Reply-To: <20191210145406.21419-20-tiwai@suse.de>
X-Cookie: NOBODY EXPECTS THE SPANISH INQUISITION!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
 alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] [PATCH for-5.6 19/23] ASoC: uniphier: Drop
 superfluous ioctl PCM ops
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
Content-Type: multipart/mixed; boundary="===============7781430004873557240=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============7781430004873557240==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qp4W5+cUSnZs0RIF"
Content-Disposition: inline


--qp4W5+cUSnZs0RIF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 10, 2019 at 03:54:02PM +0100, Takashi Iwai wrote:
> ASoC PCM core deals the empty ioctl field now as default.
> Let's kill the redundant lines.

This also doesn't apply.

--qp4W5+cUSnZs0RIF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3xGpkACgkQJNaLcl1U
h9A9AwgAgTBy1CSxV1qlzevVtlxeSnYPKMwBcNNP+8VN4imSeTF8MqzvIMkxflAS
LiTW2Mx7qvvZ/h1nOx9G/YOzDJqZxZZ150CkQCcB+X4oz5Xq1qVTYgOTIrYVuzbs
jUIDFeJqGuJTmgm6Zeu5LWWh0CzBke5+XvH8b1PjKomCTbhFK3kI61biT2ISHG8u
kzC9H8PXYvH0zTcgEJOzHU89lkBr+lXl3kx/X03jXXXkuPeJ5zwfQnBiE/knGGl/
scyhtfbkP4Wyi+SPyWLT6FEbpBY6Twf3Ttvmt9ScNd4FqUjGslUlWqXJNNG+ixmV
xN6xfg1x7oXG8RowSKKf4lcPJIOiew==
=BLJk
-----END PGP SIGNATURE-----

--qp4W5+cUSnZs0RIF--

--===============7781430004873557240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7781430004873557240==--
