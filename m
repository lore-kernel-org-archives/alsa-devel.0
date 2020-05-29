Return-Path: <SRS0=qQ1O=7L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1B5C433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 29 May 2020 10:52:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE783207D4
	for <alsa-devel@archiver.kernel.org>; Fri, 29 May 2020 10:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PiihZRoI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFWxS1zt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE783207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 223551780;
	Fri, 29 May 2020 12:51:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 223551780
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590749541;
	bh=8U5a1MO/z+2ZYlwKk6XRLF8rVuKQjTLWUExCB3LYACU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PiihZRoI+Vze/2nnIN3VSFDL9imYEkH9Pg3xW+OoeIX2/tQbwa0ij6MyERf8AkL+t
	 cxH4lar0WQ1cOn3wnp0ELLk3wdFHBXPYw3MJyiffM9VnRhMAcxlJqZS/NjLtvKgWuh
	 FPDhdXs2aPknaz0FY0dDI/4gIjPY/r9vF2oHDfoY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E90FF80149;
	Fri, 29 May 2020 12:51:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 57D40F8014E; Fri, 29 May 2020 12:51:29 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D815FF80107
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2020 12:51:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D815FF80107
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="sFWxS1zt"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 32FF12075A;
 Fri, 29 May 2020 10:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590749483;
 bh=8U5a1MO/z+2ZYlwKk6XRLF8rVuKQjTLWUExCB3LYACU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sFWxS1ztgF79SyVpUQemcY9sOvMWx3w6HJQdHEx1bdpMD5OZsd5mn7/PwlwJnJEDG
 frMwXDfE3HEbu80flevuCV7MI9KwVQPmilVIuKv14juyus32XuYXir8hUr2/1Zdmvd
 Ll9nzqBDCb03dLnFfDLWmTcRuBxC0LnfdZ4RcA8I=
Date: Fri, 29 May 2020 11:51:20 +0100
From: Mark Brown <broonie@kernel.org>
To: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH] dt-bindings: sound: tlv320adcx140: Fix dt-binding-check
 issue
Message-ID: <20200529105120.GE4610@sirena.org.uk>
References: <20200528144711.18065-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qFgkTsE6LiHkLPZw"
Content-Disposition: inline
In-Reply-To: <20200528144711.18065-1-dmurphy@ti.com>
X-Cookie: The Killer Ducks are coming!!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: robh@kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com
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


--qFgkTsE6LiHkLPZw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 28, 2020 at 09:47:11AM -0500, Dan Murphy wrote:

> Fix dt-binding-check issue

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--qFgkTsE6LiHkLPZw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7Q6ScACgkQJNaLcl1U
h9Al+Qf/QviqRDpXTXjaVEBeM9WTzOiVI+TAiCq5U+WkWU9w/gz3bgkFgNvZzs8R
dK+hJsKzDojpzy/B7rewKyte5BjkUuoOBM+LNCkWn+Qiz9qEJ+XuL1Z+CA5gjUGa
dMtWxHnfgLJb14xcPJLH0BFkRu4aSqvOc7m8v6efre4tXJt7TAV5MaPG0nRHoMM/
9ASsWT2VUmMRpSzeCFGq+azL8NoZJLJpCtmGNSbsrAF5s98TAPibUpVbmvmchDW+
ZubEbXbfnhspEIbzRk/iFvC8SremBRme9Dsga7r3i7VcRRp/HVeU0RGnE/RUPSB+
P88zBO0iQmEjlYXnUZdtBSOdfc2b7w==
=STRG
-----END PGP SIGNATURE-----

--qFgkTsE6LiHkLPZw--
