Return-Path: <SRS0=eqSS=OD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5125C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 10:58:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3512F61004
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 10:58:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3512F61004
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B22041670;
	Mon, 13 Sep 2021 12:57:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B22041670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631530682;
	bh=oRmb9RFSDD9BpTeblLtC7yBA1uU7R97XAGDSNw6NsME=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vIooacigbt5AC2e3IFSzZlbjzVC7wbQyDlo5Sc224Z9EM+dIhhWjZ9B79eMQviHsb
	 Sw6rn2Ci2nyub0u+CaYR1D4MhjwXJePxbSZx5gOCFkHZWv5/wOxtwZIFG5URHHMfz5
	 5VSPhL0/Nmubf0c9zZFyp/3xd8jrzJ07x/ibJd7s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 42299F804FC;
	Mon, 13 Sep 2021 12:55:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 14F46F804FF; Mon, 13 Sep 2021 12:55:04 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C42B5F804FB
 for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2021 12:55:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C42B5F804FB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Fp4DepS+"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E35EF610A6;
 Mon, 13 Sep 2021 10:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631530499;
 bh=oRmb9RFSDD9BpTeblLtC7yBA1uU7R97XAGDSNw6NsME=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Fp4DepS+BORdOAJho0LvkruiFnEiCugLdI/LYht8Y+gr/8fyunbRswMMhfsuDTNul
 uXFi/uY4ue8nBKZUHpfPDpIQXBbj5e1FhdsZJYBa5ldTHPT5QIYAKbPcqAg1NVeGri
 rpWgm0SxiTGVNGwRpX7m2Gf7f7Lc1bP9g9nJ0+7KQYmwXw7Vk1Jqjo0840wLGK/slg
 2lLHxJDeqXQwcRFya7pUV7OZfEfk5eIuAePaiMUzwasYnfY9kw5p1v+mVd8ZS6wRuI
 knlfaYiZWNgT8vC17H/h+QDEFQ36zjOptAT9BLdDNDm32MKMO2ZYEas65ekyvMwPGV
 7Ih8Dq/BKII3Q==
From: Mark Brown <broonie@kernel.org>
To: perex@perex.cz, nicoleotsuka@gmail.com, festevam@gmail.com,
 alsa-devel@alsa-project.org, Xiubo.Lee@gmail.com,
 Shengjiu Wang <shengjiu.wang@nxp.com>, tiwai@suse.com, timur@kernel.org
Subject: Re: [PATCH v2] ASoC: fsl_rpmsg: add soc specific data structure
Date: Mon, 13 Sep 2021 11:53:22 +0100
Message-Id: <163152996584.45703.10310868616819481458.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1630044038-19036-1-git-send-email-shengjiu.wang@nxp.com>
References: <1630044038-19036-1-git-send-email-shengjiu.wang@nxp.com>
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

On Fri, 27 Aug 2021 14:00:38 +0800, Shengjiu Wang wrote:
> Each platform has different supported rates and
> formats, so add soc specific data for each platform.
> This soc specific data is attached with compatible string.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_rpmsg: add soc specific data structure
      commit: b7bbbf01362720a8066e3f6d880cae6d63fc92f6

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
