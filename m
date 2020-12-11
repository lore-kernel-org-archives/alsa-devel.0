Return-Path: <SRS0=kZkJ=FP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB18C433FE
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 17:53:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBBA723F29
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Dec 2020 17:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBBA723F29
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4EA431758;
	Fri, 11 Dec 2020 18:52:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4EA431758
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607709207;
	bh=4EOf8D7OQUUvtQ6rD3P+pGdYNfTp7JphaQcIkzav/Ic=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jBUOdSnhKBio+ISQpqAwUHRtrr2Y3L5HWIOq1wCnCtOQei8A5cmjj3vLUYOaD7xNr
	 a1AMq5eSJUe91mSzYiYeKRTN6ShWOBH5TQ1zcJF8haErI212lFjnxD872c0Rt2/GHJ
	 W6cTY5J8DL8egCmQSJvSVfwa5/rST1NAbnr/pvLo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9BF0FF804ED;
	Fri, 11 Dec 2020 18:50:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3C2B2F804ED; Fri, 11 Dec 2020 18:50:20 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EB572F804E2
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2020 18:50:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EB572F804E2
From: Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org;
 dkim=permerror (bad message/signature format)
To: Sameer Pujar <spujar@nvidia.com>, robh+dt@kernel.org,
 thierry.reding@gmail.com
In-Reply-To: <1607006202-4078-1-git-send-email-spujar@nvidia.com>
References: <1607006202-4078-1-git-send-email-spujar@nvidia.com>
Subject: Re: [RESEND PATCH 0/2] Convert Tegra HDA doc to json-schema
Message-Id: <160770898108.26354.183397284224263445.b4-ty@kernel.org>
Date: Fri, 11 Dec 2020 17:49:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, jonathanh@nvidia.com, sharadg@nvidia.com,
 linux-tegra@vger.kernel.org
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

On Thu, 3 Dec 2020 20:06:40 +0530, Sameer Pujar wrote:
> Convert Tegra HDA doc to YAML format. Ran binding validation checks to
> ensure there are no warnings/errors for HDA.
> 
> Patch "arm64: tegra: Fix Tegra194 HDA {clock,reset}-names ordering" is
> already merged and hence not included here.
> 
> Sameer Pujar (2):
>   dt-bindings: tegra: Convert HDA doc to json-schema
>   dt-bindings: tegra: Add missing HDA properties
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] dt-bindings: tegra: Convert HDA doc to json-schema
      commit: 2d8f8955fe02c1f5d41c283f48d8c6a2a02ae17f
[2/2] dt-bindings: tegra: Add missing HDA properties
      commit: 3759d5edc07598d55124d87bd292a95f79f47997

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
