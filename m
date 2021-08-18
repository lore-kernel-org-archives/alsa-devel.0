Return-Path: <SRS0=kMQ4=NJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34915C4320A
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 16:28:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 139E460EFE
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 16:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 139E460EFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A033C1694;
	Wed, 18 Aug 2021 18:27:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A033C1694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629304082;
	bh=6acFwTMZIC6gk0x6yoAGFSCVjV5LISXXZQTTQAHwKxQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MFvyEOG+msvzhSP0yQU3EWvshgZ+g8Ic31gvrOnH+CSWE/Kphcc2e/WJBudfS+Ybr
	 y+VBEa+lDiIduSewsG2HMu2OLE8HiVFsyH0rE+c4+a9G0a0H1DAzH6y20NdpdSFsUX
	 AHjKhVDraWgSfrAhJ6qYWW/ZOuS90mO52ERGbefU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 39C36F80246;
	Wed, 18 Aug 2021 18:27:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CA33BF80249; Wed, 18 Aug 2021 18:27:10 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5FE0CF80169
 for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2021 18:27:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5FE0CF80169
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Hj41TU7k"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4B6D610CB;
 Wed, 18 Aug 2021 16:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629304021;
 bh=6acFwTMZIC6gk0x6yoAGFSCVjV5LISXXZQTTQAHwKxQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Hj41TU7kRliPxrAO5KkTX+iNLT3ONSLN3tmUyUUwGkQzp/k5Z5RKGT5oJHHkJNvbQ
 DQVOua9uo/QANQZGqFMr5798Mm28kGLlDcOKM4QwwIi0vEjAhFCbuI3uu+U15MuzZa
 462pDek0YTmlB2lI+wWlU9r4y7qB6/8Gyy2GgQo2iU8PZhbvVdni5dBEUjSliipc0o
 RAsDzmwvQSWSV0VIiDpLVcAv5Xi/etOGCw/ow3tzWp65T+m5SjXz8vyEBq8cJsnDlR
 dAxomcM0jWyJCWdYzDaU+YZ+bAJ8nUCri1EMQwHGYp9aZoFAa82N1RzQUJOpKrlCOj
 P6NqyraEZbKCg==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
 nicoleotsuka@gmail.com, timur@kernel.org, alsa-devel@alsa-project.org,
 perex@perex.cz, Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_rpmsg: Check -EPROBE_DEFER for getting clocks
Date: Wed, 18 Aug 2021 17:26:32 +0100
Message-Id: <162930349966.11010.7849823203473029819.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1629266614-6942-1-git-send-email-shengjiu.wang@nxp.com>
References: <1629266614-6942-1-git-send-email-shengjiu.wang@nxp.com>
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

On Wed, 18 Aug 2021 14:03:34 +0800, Shengjiu Wang wrote:
> The devm_clk_get() may return -EPROBE_DEFER, then clocks
> will be assigned to NULL wrongly. As the clocks are
> optional so we can use devm_clk_get_optional() instead of
> devm_clk_get().
> 
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_rpmsg: Check -EPROBE_DEFER for getting clocks
      commit: 2fbbcffea5b6adbfe90ffc842a6b3eb2d7e381ed

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
