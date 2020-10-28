Return-Path: <SRS0=HcWj=ED=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBA7C4363A
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Oct 2020 21:32:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D09324841
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Oct 2020 21:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Zxfnhqup";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+A7w0xI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D09324841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B02C5828;
	Wed, 28 Oct 2020 22:31:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B02C5828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603920760;
	bh=LB7IIgnXLRPsvFSUKfcokjOHLKCLUEJ1lH4XLR7MgK0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZxfnhqupYnaX+XSXP20mxuvhuMHEeBY4Dh9UuCa3ngCAx8O6h4HV9l6V+cy2EaH5W
	 A1eAd8YiTktV4eQDYsbySq125QooA2Ua6/fIJZ/2E7I/SWtK9PcmuJ3BPRJS1Jsuvw
	 znwn7T3laeH60RlL7eSClEF1QVq06b3miF7Q98nE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2E6FFF801D5;
	Wed, 28 Oct 2020 22:31:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 44818F80212; Wed, 28 Oct 2020 22:31:48 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 03AF9F800FF
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2020 22:31:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 03AF9F800FF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="k+A7w0xI"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 34CE2247C7;
 Wed, 28 Oct 2020 21:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603920698;
 bh=LB7IIgnXLRPsvFSUKfcokjOHLKCLUEJ1lH4XLR7MgK0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=k+A7w0xItkNypDfSE7bzwrJqNiCTMGib6IX7NpCgnWnSUwFpafXnO36QAYiJdnpnf
 EOvurTDYgXlZqJIYCL1avYRyhlWXUbxuL74ZdIigPGd9Xcx4lyLEQ17m6Jmf3f4zF8
 PQ1E4zSN9hqRZ3SMZF3Mf+sqJgazYPWF4Pvzo0OA=
Date: Wed, 28 Oct 2020 21:31:32 +0000
From: Mark Brown <broonie@kernel.org>
To: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Subject: Re: [PATCH v2] Asoc: qcom: lpass-sc7180: Fix MI2S bitwidth field bit
 positions
Message-ID: <20201028213132.GC6302@sirena.org.uk>
References: <1603798474-4897-1-git-send-email-srivasam@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Content-Disposition: inline
In-Reply-To: <1603798474-4897-1-git-send-email-srivasam@codeaurora.org>
X-Cookie: Allow 6 to 8 weeks for delivery.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, V Sujith Kumar Reddy <vsujithk@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com,
 lgirdwood@gmail.com, robh+dt@kernel.org, bjorn.andersson@linaro.org,
 agross@kernel.org, srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
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


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 27, 2020 at 05:04:34PM +0530, Srinivasa Rao Mandadapu wrote:

> Fixes: cba62c8b49be ("ASoC: qcom: Add support for SC7180 lpass variant")

This commit is actually

    Merge series "ASoC: qcom: Add support for SC7180 lpass variant" from Rohit kumar <rohitkr@codeaurora.org>:

which is not the commit that should be pointed at here.

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+Z4zMACgkQJNaLcl1U
h9BhgAf/REPtAdUvxZvoB6gjMUFKH76y/rzERDgx0/fE+V/YDYb4P7Y45oXgGgwX
qHVXKLHq5BO4CsRGk1pozAgu4JsLRmTe/nmOkhSKl03VOUxAOrdJ5aYbQJotmEJD
oJEo4v4slQWlq1e4zfR7KF6f/eX/kF1r7GSErZBZ+RjGJETpfqsIbfL7wOZs4u9q
xsA7JJzVfzObYngoBJTZ7gHvuGYrbNXowOWkGrR/CiYFlDLMtPgWkZgtWSIjpbzc
mQCm+OOXp8ImuP3fc8Y02yzDlnus5yiPwareUbYjLPRKwOZQW88FfbfzyAA5AJDK
Uzo/iywf8dc8Nr9VGZGyXr1Zrj5k1w==
=ANOe
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--
