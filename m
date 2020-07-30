Return-Path: <SRS0=sGsA=BJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F8BC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2020 22:34:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3052420829
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2020 22:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HofjG4vR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uweg23Oa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3052420829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3AD4A1676;
	Fri, 31 Jul 2020 00:33:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3AD4A1676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596148472;
	bh=mm8J/i6ZSAlgRjsL3uPXnNjYT5qwNb3j2lHa5rHt1qw=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HofjG4vRNe+npZnScAZPYSnIniAXDWZyYm1md2beYy5IGFKHdNaUY8txQPI7r2W6u
	 MtrHGVBCa50uSGxFJaUpvwRJ1Dasz0fDhwJniMfdp/kXqQQ62Pi3jHTjPyCRbGAn4G
	 d+CJWfcMemIOfMI/HlifG8+Jwr5ecLEBjcX9UX+8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 86C59F8021E;
	Fri, 31 Jul 2020 00:29:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AADA8F80308; Fri, 31 Jul 2020 00:28:50 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 65424F80306
 for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2020 00:28:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 65424F80306
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Uweg23Oa"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 037F320829;
 Thu, 30 Jul 2020 22:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596148122;
 bh=mm8J/i6ZSAlgRjsL3uPXnNjYT5qwNb3j2lHa5rHt1qw=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=Uweg23OatF1tL9LWUhp6srSCrbhLnO5s3KtqUHVPPR4yX39LrtXPmeC5wemWS/eKP
 HFGASlrbrs3jgFcIbcHDxmagFih0ANByQ5bbE8QjZhIDC8APJiV0h8ZWaMpKKC6CSa
 VlKeBzw9u94Yoc1b4eq59TimGrUP9JOumINjoa9E=
Date: Thu, 30 Jul 2020 23:28:22 +0100
From: Mark Brown <broonie@kernel.org>
To: krzk@kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>
In-Reply-To: <20200728131111.14334-1-s.nawrocki@samsung.com>
References: <CGME20200728131126eucas1p16365622c52f91104373a2cd3e0ebb619@eucas1p1.samsung.com>
 <20200728131111.14334-1-s.nawrocki@samsung.com>
Subject: Re: [PATCH v3 1/3] ASoC: samsung: Document DT bindings for Midas
 sound subsystem
Message-Id: <159614804534.1473.10836514117836508755.b4-ty@kernel.org>
Cc: simon@lineageos.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
 b.zolnierkie@samsung.com, robh+dt@kernel.org, m.szyprowski@samsung.com
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

On Tue, 28 Jul 2020 15:11:09 +0200, Sylwester Nawrocki wrote:
> This patch adds documentation of DT biding for the Midas sound complex.
> Partially based on the *txt version by Simon Shields <simon@lineageos.org>.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: samsung: Document DT bindings for Midas sound subsystem
      commit: f61d06ae99468e3f02b8af4b464945290c0cf2cc
[2/2] ASoC: samsung: Add sound support for Midas boards
      commit: fd0ea9cd9698edd8e9dab7dfe86163d00897b000

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
