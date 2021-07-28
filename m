Return-Path: <SRS0=/xSo=MU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DDCC4320A
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Jul 2021 23:30:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C27C61039
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Jul 2021 23:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2C27C61039
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 288E41F4D;
	Thu, 29 Jul 2021 01:29:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 288E41F4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627515018;
	bh=O+//6IJ/VPQ62CUgWxVD82JUZheq3ea8zHr1YC2khU4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D2nUoXroZ30nQB8/kt5rNevMGM/hp33QP6tpleEPyAwBs3Y4SheLyV6LD3EXhlMVo
	 NtcozLj/tOf7GT15xcnTqWaecqcz80jW5pyj8O3nZOzsFr1Mx04OvUJDFOyQAwIBsP
	 P68ZpfRf1CR5r9lz+mkg5J8IRrhqGPfAbrHqjkVQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 351AAF8028B;
	Thu, 29 Jul 2021 01:28:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2CBCEF802A9; Thu, 29 Jul 2021 01:28:26 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A29D8F80127
 for <alsa-devel@alsa-project.org>; Thu, 29 Jul 2021 01:28:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A29D8F80127
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="JQRw58bj"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 040DF6101B;
 Wed, 28 Jul 2021 23:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627514898;
 bh=O+//6IJ/VPQ62CUgWxVD82JUZheq3ea8zHr1YC2khU4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JQRw58bjtYCNMizbYEe/o+pyprfdExpIxGQFN8yiWlY/viVeE9z5mPuo7P9AbOf12
 DmSP8aCGhgGnPH97bGg58DnLnLoTJbMRDyYomYKzdqbdHZp6d5jGwyLCILSYTPpJlu
 5haPpcGiN60gzdNNgqJmLvTpfkFiXVk0LZQxflLDdLhKbXKrck5aZTa+0nIeZfP91H
 Nkcdy9QrP/WQw+eYNC7rj5MOSrvUWKwegmGcywAf54m3brX0L8Ad08OPNU8p4mZhKj
 fMTJrID7/Lvu3Ki+RYc2ly7qnbfLdBliMEpe3fdMVEm97IVcp95vGjoXuW2XbAJxPv
 YgovX1W/vvg0A==
From: Mark Brown <broonie@kernel.org>
To: Jie Yang <yang.jie@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Colin King <colin.king@canonical.com>, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: Intel: Fix spelling contraction "cant" -> "can't"
Date: Thu, 29 Jul 2021 00:27:55 +0100
Message-Id: <162751391069.10122.6012833198246486438.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210728103602.171817-1-colin.king@canonical.com>
References: <20210728103602.171817-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org,
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

On Wed, 28 Jul 2021 11:36:02 +0100, Colin King wrote:
> There is a spelling mistake in a dev_err message. Fix it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: Fix spelling contraction "cant" -> "can't"
      commit: 0f6b04adb58d80e7fb5f8d9229ad22c9931c3bd1

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
