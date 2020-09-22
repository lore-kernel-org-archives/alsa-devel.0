Return-Path: <SRS0=PysP=C7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD98C2D0E2
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:45:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1551D2388B
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MlXCa7z5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6seZPA/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1551D2388B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0400616FD;
	Tue, 22 Sep 2020 13:44:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0400616FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600775119;
	bh=3OhywcltP9VHm6MmXFAi4kj4+8+FaFh5Jl0cjhgWevI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MlXCa7z5isPw0hVQUS9BXnfbqTXjV565z4ja9e3u6JGiO6dU2MWVltHiF4k+8D919
	 lvwlyssndQj+8JOC8lHCJBUG1+8S/Ne++jRrS37dcZAvsv1EKc2hf5twYtWIrZWuca
	 p/2STr8CAJKMs3Mc0dEa6z+CMgkUaTEZUX7qqCNQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7D18EF8015F;
	Tue, 22 Sep 2020 13:44:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EE824F80229; Tue, 22 Sep 2020 13:44:26 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 49B1BF800ED
 for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2020 13:44:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 49B1BF800ED
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="R6seZPA/"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 22C62214F1;
 Tue, 22 Sep 2020 11:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600775052;
 bh=3OhywcltP9VHm6MmXFAi4kj4+8+FaFh5Jl0cjhgWevI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=R6seZPA/KYfch3970nAndvescUMM14RveYUo8rkB69y4KfOAWHalRvlDVbbLGz0xD
 xHFTtQR7oplTb/Vvc2IisPURG10cscMznhU8yXAZ0N/mf+kVyArQ5LTW/Ii7maQv72
 JABAfDNdUV2pBtjZaHU/tWkZ9jouuf240imOrPZo=
Date: Tue, 22 Sep 2020 12:43:19 +0100
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v6 3/5] Asoc:qcom:lpass-cpu:Update dts property read API
Message-ID: <20200922114319.GR4792@sirena.org.uk>
References: <1600409084-29093-1-git-send-email-srivasam@codeaurora.org>
 <1600409084-29093-4-git-send-email-srivasam@codeaurora.org>
 <040290a8-26a3-ab9c-04dc-beb23ee827e8@linaro.org>
 <20200922110825.GN4792@sirena.org.uk>
 <3866ce69-b7d0-5eb5-e0aa-874d150cd47a@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TMgB3/Ch1aWgZB1L"
Content-Disposition: inline
In-Reply-To: <3866ce69-b7d0-5eb5-e0aa-874d150cd47a@linaro.org>
X-Cookie: Love thy neighbor, tune thy piano.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
 V Sujith Kumar Reddy <vsujithk@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org,
 bjorn.andersson@linaro.org, agross@kernel.org, rohitkr@codeaurora.org,
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


--TMgB3/Ch1aWgZB1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 22, 2020 at 12:22:38PM +0100, Srinivas Kandagatla wrote:
> On 22/09/2020 12:08, Mark Brown wrote:

> I agree with you on this and I see the point, but Rob had a very different
> opinion about the reg-names bindings to start with.

> This topic been discussed in the past with Rob in many instances ex: https://lore.kernel.org/linux-devicetree/CAL_Jsq+MMunmVWqeW9v2RyzsMKP+=kMzeTHNMG4JDHM7Fy0HBg@mail.gmail.com/

> According to him, reg-names seems to be highly discouraged as it came along
> for the OMAP folks and was related to the hwmods stuff.

That's very much specific to reg, it's not true of the use of names in
general - Rob mentions cases like interrupts for example.

--TMgB3/Ch1aWgZB1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9p41YACgkQJNaLcl1U
h9AuWQf/ca9nQ2PmzHcNzlz7TsFIO+ht142QjTqAQlUdhHDiYcPpG9jqzYi81epi
FLGHcE+NK0CCvc7fgnWsPv776/Fbj2+19GtH1bbQxARF2Oc9fkBvzP7x9lV92iUh
KZ7aX5RAgvA+87nDF2jmOgfcJbeTnMw3ToKLbvlEqS4k+zsXhSWFuGbgCogexiSg
TGI8So/Mp296hyFsgLFYIyF4pc2FPP9gulIwzyk+tPanIXZIXMgrWJvGVvq/BXp+
32W1NMxm0HX5mY4vdAqPid7EiP+7wZCp/YtxmoOiY9XhqK38c5YZnqQV8rv+azpO
ffsGe76ABBy85FJ4OdxsXt+7iw3cZg==
=oQkO
-----END PGP SIGNATURE-----

--TMgB3/Ch1aWgZB1L--
