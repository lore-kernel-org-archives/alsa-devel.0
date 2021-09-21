Return-Path: <SRS0=+sGq=OL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4D7C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 15:28:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BB4D61178
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 15:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7BB4D61178
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EA6FA1662;
	Tue, 21 Sep 2021 17:27:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EA6FA1662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632238094;
	bh=vhLzjTgLnOT8QnJf7y/WSgDwF6yaNzF8AzzcaXhlpgM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Bg29DYuMKBM7gr2ztgrn9p8FYAmBDJA2M3kg1j7JJU3x6Ew8dGwMwzxs+quHFyEJr
	 CUlrfOU/xRDMhB7yMmQtBEq9uqu8qLY8qnzwIoXSB5H3zUXq9N2UAYSMlhuLljJupK
	 sxMC7h39fDOczp/cx2AbxBEbSZ8vXjs0hUlRn+jo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1AEE1F804E5;
	Tue, 21 Sep 2021 17:26:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 59EAEF804E2; Tue, 21 Sep 2021 17:26:14 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 85DF4F80124
 for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2021 17:26:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 85DF4F80124
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="MohmUdb3"
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6D1961215;
 Tue, 21 Sep 2021 15:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632237969;
 bh=vhLzjTgLnOT8QnJf7y/WSgDwF6yaNzF8AzzcaXhlpgM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MohmUdb3bmGffzzxtnXNhA6agKbH70gjj8JdakpsgSojS9mXK6M55oQLxrvxK/6AK
 oZvoD54oC8f6oMZN/yA19bqE65wOeCobAYp6MLU1BSH2QSenSpFThMI0co3hza5S8K
 /qQnn3yt7CWD5D7Hwfr3FcJN7iUfpd6v29REudwxaZOdkOB9hxgBuztUm8Pa8qrXYS
 XvuNU/NtivjHppwO6nV9FB23KXQUCdZ1nyVZxfEUsYWUBPuUFQT7oPy+oCW90EvdqG
 4ld1bbfG76aZm4u5FdXXTAC8WMz3KXsMSl3yHh6puxgJr3OHQeMC+VCy3mK7VsKbKb
 j2cQ8whYH6Ynw==
From: Mark Brown <broonie@kernel.org>
To: festevam@gmail.com, Xiubo.Lee@gmail.com, tiwai@suse.com, perex@perex.cz,
 alsa-devel@alsa-project.org, timur@kernel.org, nicoleotsuka@gmail.com,
 Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: Add support for i.MX8ULP
Date: Tue, 21 Sep 2021 16:25:12 +0100
Message-Id: <163223651318.32236.12273348857072894060.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1631238562-27081-1-git-send-email-shengjiu.wang@nxp.com>
References: <1631238562-27081-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org,
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

On Fri, 10 Sep 2021 09:49:22 +0800, Shengjiu Wang wrote:
> On i.MX8ULP the spdif works with EDMA, so add compatible
> string and soc specific data for i.MX8ULP.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_spdif: Add support for i.MX8ULP
      commit: a635d66be1642e59af17383a27b2c61409121241

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
