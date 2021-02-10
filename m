Return-Path: <SRS0=/2j+=HM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FB8C433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Feb 2021 20:16:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D38364EDC
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Feb 2021 20:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D38364EDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 216C216F3;
	Wed, 10 Feb 2021 21:15:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 216C216F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612988172;
	bh=/XJ14EvYFvze96WUDGqDMMRLgcue6gHSY9hj6HJUWE4=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KjLP4PFJBlq5tCS8IrumrvD3YrNlhVLozfAu1lQMvGbDvCQlpdItOLnzWIJsBr8xp
	 l/I2wjsqYMCevRwcYaFaicXK2QH0eUiIEgMTusAJYmN/ls2IEvj6gSFDa7USZ8MhJK
	 8JEr6AtqIaiyV2Wtega+gvYuElKLi7tbqWfNL+8w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 35E3FF8042F;
	Wed, 10 Feb 2021 21:13:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1B30FF8032D; Wed, 10 Feb 2021 21:13:01 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6056EF8032B
 for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2021 21:12:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6056EF8032B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="mJl5Nuhk"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02BCC64EDC;
 Wed, 10 Feb 2021 20:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612987976;
 bh=/XJ14EvYFvze96WUDGqDMMRLgcue6gHSY9hj6HJUWE4=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=mJl5NuhkwTJ82MwVgVgAVPJddW5+XDODUieeJTvSFgGmkCkAVRjPjpEBdj/aKs1yq
 Ud6R1JjDTZPK3d6edok2D/apkH6PifVeWUtLokkq6EZkPALjUPFbpHqStYiGL0D3GA
 /t9rl+Yjnd982U1jbcw6B+5yAZ/Qy0Cw65lLXCMqi0K0hJrPlDugrLb7v0SedoyH/e
 EJPAo6ft9mmuSTv9iu6ZVkx05RmzTt8sY953OFVk2RVmPb4K3nmYYxI5fc/zEe5pO7
 GgQwVlDo5uiWXYLXAH8YDbFF69cNdAu/haACXoyLRzEEkhWd+WKioBwjD6LhojIlr5
 LrvESy8uxpmLQ==
From: Mark Brown <broonie@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>
In-Reply-To: <20210125062003.1221810-1-tzungbi@google.com>
References: <20210125062003.1221810-1-tzungbi@google.com>
Subject: Re: [PATCH v2 0/3] ASoC: mediatek: mt8192: apply some cleanup
Message-Id: <161298789619.5497.4062987580680565020.b4-ty@kernel.org>
Date: Wed, 10 Feb 2021 20:11:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org
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

On Mon, 25 Jan 2021 14:20:00 +0800, Tzung-Bi Shih wrote:
> The series applies after [1].
> 
> The 1st and 2nd patch refactor to use asoc_substream_to_rtd().  Just
> realized there is such a helper for the purpose.
> 
> The 3rd patch simplies ops of Capture1 DAI link.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: mediatek: mt8192-mt6359: use asoc_substream_to_rtd()
      commit: 8e59cf943fa7402f008de4b444beb0c5280317bc
[2/3] ASoC: mediatek: mt8192: use asoc_substream_to_rtd()
      commit: 0840706d6c61658e51f42762c5b4f211b7596535
[3/3] ASoC: mediatek: mt8192-mt6359: simply ops for Capture1 DAI link
      (no commit info)

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
