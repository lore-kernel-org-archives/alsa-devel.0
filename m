Return-Path: <SRS0=Cjbi=KG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F89CC433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 18:24:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A296B61207
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 18:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A296B61207
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 640C418C0;
	Tue, 11 May 2021 20:23:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 640C418C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620757460;
	bh=tzQI48qc4TkUQ9zo4+5oAMZas2lYgB+Myx5nBcxQpTs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YFCUZ1Kwq3ih3CihbCVhm1V5uzejikcmQGOWFkUGQEiygxvrmsA4xInNozJkCQQmP
	 9u7C4mOpVvvjI9GDUn7AnNVGJTTwS7I9tJm456ev8cYj5TwMnGvYU8JBIiUr7YxAYc
	 Ote026A+MGuy43HPphnfxK0zWu6XtWS/R2YXXqdM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C251F80279;
	Tue, 11 May 2021 20:22:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 97E2CF8028D; Tue, 11 May 2021 20:22:39 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 39FF8F80129
 for <alsa-devel@alsa-project.org>; Tue, 11 May 2021 20:22:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 39FF8F80129
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="httCx7EG"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D6E76186A;
 Tue, 11 May 2021 18:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620757350;
 bh=tzQI48qc4TkUQ9zo4+5oAMZas2lYgB+Myx5nBcxQpTs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=httCx7EG90o9MOPSzN/WR939X0OGMA8jnVChiuZ9cPRtXtAsRDtbhQu42Cv7icpz3
 IQgLaigUM87hzAXUVHsXY98IWez+N47v+KAFFMbJjWiFZp79yx61+WvPbV0hJziWtG
 ouRFyLItoAgvRzDc5ncY5BRSQlhIST4zgcnzd2BTmNpLwWkLLMDLi4PbDH8CFSKekf
 LgLukSN+bb4R7XEoiCEJEp91DagsGI1cD7ddV5op4IwJByDqVRvCAAyFR+W6K1YGGd
 9+rEORLV0xiy+JGbXGKvqI5vhJzpdBl+cOFLZp6vV3X28gRjd/nqTP3TLop9UDGTB/
 /RIqA+AXpYJIQ==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l42: Regmap must use_single_read/write
Date: Tue, 11 May 2021 19:21:29 +0100
Message-Id: <162075713910.17925.13540340521558879999.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210511132855.27159-1-rf@opensource.cirrus.com>
References: <20210511132855.27159-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
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

On Tue, 11 May 2021 14:28:55 +0100, Richard Fitzgerald wrote:
> cs42l42 does not support standard burst transfers so the use_single_read
> and use_single_write flags must be set in the regmap config.
> 
> Because of this bug, the patch:
> 
> commit 0a0eb567e1d4 ("ASoC: cs42l42: Minor error paths fixups")
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l42: Regmap must use_single_read/write
      commit: 0fad605fb0bdc00d8ad78696300ff2fbdee6e048

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
