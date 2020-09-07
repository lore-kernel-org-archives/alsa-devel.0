Return-Path: <SRS0=BS+q=CQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875BBC43461
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:08:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCB562078E
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VKMnZkX8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xpdqjh2D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB562078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EE1A417CF;
	Mon,  7 Sep 2020 20:07:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EE1A417CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599502078;
	bh=lUhwtVMbUkBTjCP5fxV8Zm3w9gOVGN/Ajj5PzG3OuGw=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VKMnZkX8R+aDu2vJYzSggono/K5geN70PSrjMtWqxfRiTwQlv8VNPYqaH6kcwAYay
	 q3h7JLQGS6igKm9qJpFY+vYFb3C5MWXSZJhcaZPPg0Qy4GOqxQAuW3WYZNp+Gx7IUA
	 q2jaO/njUF+VP8oNtbm87qX3wqzlKnXCcbkO6YZg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 06E5FF80256;
	Mon,  7 Sep 2020 20:06:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2E2AEF8028D; Mon,  7 Sep 2020 20:06:16 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D76B5F80256
 for <alsa-devel@alsa-project.org>; Mon,  7 Sep 2020 20:06:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D76B5F80256
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Xpdqjh2D"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9687020738;
 Mon,  7 Sep 2020 18:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599501972;
 bh=lUhwtVMbUkBTjCP5fxV8Zm3w9gOVGN/Ajj5PzG3OuGw=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=Xpdqjh2D3BzGgPoXBxGDIvpDTgGGqUWfHn8UqzHXqUIU7Ie1UIKShSMiQo9n+3Lwu
 0OZVxDaeScVgABmF3SWE47TPRBWmSK6MdTc2hjnzniO3nWs0yBlAdKV6GekKI6hmbP
 gseuZ+OPEnBaQxRMkNQLwUhOKJj//aPvStMig+7g=
Date: Mon, 07 Sep 2020 19:05:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
 alsa-devel@alsa-project.org
In-Reply-To: <20200904020904.19577-1-michael.wei.hong.sit@intel.com>
References: <20200904020904.19577-1-michael.wei.hong.sit@intel.com>
Subject: Re: [PATCH] ASoC: Intel: KeemBay: Fix warning potential ! vs ~ typo
Message-Id: <159950192275.52707.17628974013033365928.b4-ty@kernel.org>
Cc: cezary.rojewski@intel.com, andriy.shevchenko@intel.com,
 pierre-louis.bossart@linux.intel.com, jee.heng.sia@intel.com, tiwai@suse.com,
 liam.r.girdwood@linux.intel.com
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

On Fri, 4 Sep 2020 10:09:04 +0800, Michael Sit Wei Hong wrote:
> To set platform in slave mode setting the MASTER_MODE bit is not needed.
> Removing !MASTER_MODE conditional to avoid potential errors and warning.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: KeemBay: Fix warning potential ! vs ~ typo
      commit: b40f708deb951c3d46857fe5aed9cea1a506585b

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
