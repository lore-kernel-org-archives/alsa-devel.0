Return-Path: <SRS0=P7Dr=G7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0802EC433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Jan 2021 20:57:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6373964DE0
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Jan 2021 20:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6373964DE0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E066216C1;
	Thu, 28 Jan 2021 21:56:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E066216C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611867458;
	bh=zP7BtAjXd2GopoUBhr1TtCnvQWxy/cbtIbEULHWPGU8=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ata2DZQmE3Kyrx4vKtnlyCO5KwzEAw4mhaZw6et59SEBb/mjktFOqluLWLyhbvljk
	 F3DFVN8XQuwU6MtIZhvQAldCZSMGGe+lVX37hENNsLBoM1runOnK/gtyQjnbKTSzJ4
	 +cVySr6P00RH/8mPvNnNPUU8VfpXoEy1umwKu8u4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 72273F804E0;
	Thu, 28 Jan 2021 21:55:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 10092F804B4; Thu, 28 Jan 2021 21:55:36 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AF9F9F80217
 for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2021 21:55:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AF9F9F80217
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="CcoKBk30"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C98D64DE6;
 Thu, 28 Jan 2021 20:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611867332;
 bh=zP7BtAjXd2GopoUBhr1TtCnvQWxy/cbtIbEULHWPGU8=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=CcoKBk30BtTolpYoibxZu2RTtHOi7ctngbUu3tSuHn/K0LzF4wRdxEKEFsxA1n58u
 Og4EdVuyMtMZb1n1QFsKvvvLa4010Xcrx93bzOEjEJhcXxsKXx4uqzWsDGnaipmSHH
 CSh2H8zDeAkiOiJFrIeJvL0IequU/pfJL/CscPRhqGh8nUIzaAJjhhOvWCafEjXJyy
 grW9dT9dqQ6OKmXInV/FV4eAOk8aS3CL1diMh6IAcB0PWKaVHynxN3qUYhQRvBEtel
 +UmS8Bd1ALVXb9DP+WB7wM8be2eNnQLP0O/SRdyhFl+WMYXRhIiGYdpp1IzGHSjR2p
 Y1bVe/n30I8pg==
From: Mark Brown <broonie@kernel.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>, alsa-devel@alsa-project.org
In-Reply-To: <20210128092345.1033085-1-kai.vehmanen@linux.intel.com>
References: <20210128092345.1033085-1-kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: Intel: hda: cancel D0i3 work during runtime
 suspend
Message-Id: <161186727763.43763.7404676669230379320.b4-ty@kernel.org>
Date: Thu, 28 Jan 2021 20:54:37 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: pierre-louis.bossart@linux.intel.com, yung-chuan.liao@linux.intel.com,
 ranjani.sridharan@linux.intel.com, lgirdwood@gmail.com
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

On Thu, 28 Jan 2021 11:23:45 +0200, Kai Vehmanen wrote:
> Cancel the D0i3 work during runtime suspend as no streams are
> active at this point anyway.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Intel: hda: cancel D0i3 work during runtime suspend
      commit: 0084364d9678e9d722ee620ed916f2f9954abdbf

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
