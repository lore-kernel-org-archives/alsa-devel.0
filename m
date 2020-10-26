Return-Path: <SRS0=iTaG=EB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D53BC4363A
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:12:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB8A12070E
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="put0qCDv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iroCn2XG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB8A12070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 03DB916B6;
	Tue, 27 Oct 2020 00:11:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 03DB916B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603753965;
	bh=MRx2pBBqNPPfjwNb906kXs5hP1/uC56QOW9EGdn3PIs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=put0qCDvUfT6UB3/sdVVNZyZ47Ft2aN+ErzRIkVyy2Aubp1gDUOxHfsdAZEv5LHKG
	 +HkPYFQnINyQFXMyaf6KwSTg/I5UlgnvA+jQFLi4AVCwmIT6PJ1PRRlerqktmnkxCN
	 RbVnHwocNzkS2y/p1xD59+3Q9BUtJ8xyi1096EWA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9E84BF8025E;
	Tue, 27 Oct 2020 00:11:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 11AD2F8026D; Tue, 27 Oct 2020 00:11:49 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DCA0BF80212
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2020 00:11:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DCA0BF80212
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="iroCn2XG"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2E66D20759;
 Mon, 26 Oct 2020 23:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603753902;
 bh=MRx2pBBqNPPfjwNb906kXs5hP1/uC56QOW9EGdn3PIs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iroCn2XGPTOZbcWO9zqylWO0Z5a2xG0/amHaI4/LeFmHV1wvJYcgwUpKlAmF88xsn
 uPVdqzdJJVfpoGLv0tdgb3JLXiXXyNdjRugo+NTkZrAbNCVcVsLnxJ7BWASsKq9Ebs
 1/G5GkX3PEgA9dqVRFN3YbalBIVxfvYic0fb2hdk=
Date: Mon, 26 Oct 2020 23:11:37 +0000
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qcom: qdsp6: make use of devm_of_platform_populate
Message-ID: <20201026231137.GA46087@sirena.org.uk>
References: <20201022130254.29937-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <20201022130254.29937-1-srinivas.kandagatla@linaro.org>
X-Cookie: Positively no smoking.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org
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


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 22, 2020 at 02:02:54PM +0100, Srinivas Kandagatla wrote:
> make use of devm_of_platform_populate to remove some redundant code!

This doesn't apply against current code, please check and resend.

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+XV6kACgkQJNaLcl1U
h9BzLgf8DAWyEk1h1XRBvNnSUDsTNffEVpxFffPmHUbEWIBd4zOJR6lkPSqj7/Ka
+Wag2B3/tHXZmo3VqXJhHILqeOusboC2/6AFNDWEgRMzqPEkCi7k8vEPY0jHx8uq
uSn1gzWFceGhroynl7cklAlrfDQGF64K3tif4u4RVmXt9mO+ZldU3RTDai05u4gq
2sgLj9K3lvkABbDOsNMhS9TZNM8pExLCJKmLOPVDagaa3KSJx/ew5fJ6GREVWehr
7xPu2yPLzNNDfmsQw2ciCqBmEdftXGCL42wys92UuBqBgnImGLF+tfe4u6baj/0x
It14csewGM7Ts8x2euOs6EjiR11RxA==
=GnyX
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
