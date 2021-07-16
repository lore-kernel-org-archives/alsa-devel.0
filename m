Return-Path: <SRS0=MRBS=MI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03A5C12002
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Jul 2021 15:08:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E1F5613CF
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Jul 2021 15:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E1F5613CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 867461685;
	Fri, 16 Jul 2021 17:07:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 867461685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626448083;
	bh=7dYyGuli35UbeRxxsgE3uQcgqLGiJZcOAGfUQou/NtQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z7RxVjlpo1ap3nTTBd0Fxog4xapfCGouKUE8U+HpjDk0UhVg+9PsjPezBW9e/ue1H
	 4V1LnOCD9Ftl4WJtBgzgi9v/q54wl802DC55K88rmXkpu9jLYogB/c18aBGojHlwra
	 HsQ7nLHt8IH+sHyzyBm1+p+sEAHzJZ1gfsttYFEc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B934F80269;
	Fri, 16 Jul 2021 17:06:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AB42FF800FB; Fri, 16 Jul 2021 17:06:20 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 33AB1F800FB
 for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2021 17:06:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 33AB1F800FB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="O+RbaJLe"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B750613BB;
 Fri, 16 Jul 2021 15:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626447975;
 bh=7dYyGuli35UbeRxxsgE3uQcgqLGiJZcOAGfUQou/NtQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=O+RbaJLeaaO/sOV1cbthRVQUaqaxoH7UVHSKxKjQayS593nFfwMulKKBDTmybruq3
 OCydrewJWnPxv/76pGz/GRIJx3j9V3Qxvk43akUgLCOwuLOtGpKD9YpWPRPAmwK6aN
 Y0c0OCP3Q/3156adG+sB79OSibjRQG1fxIogiXpM/9Q0b8EVCRoyFLIZ02svfIU5qL
 x+xTQ3YfQmIN5pYrnOyhtk12ErLDEzudDUuqOtSTWjjPnjKFrccqbN3bh9YKLjyw1G
 NtBpwTVVIqZd/GIsRJwFM6bCiXOd9+lkSXx5yXQY5a6ypleXmeCKiNQV41xcdoXSBi
 0MD56wt3SGLxg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com,
	Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [PATCH] ASoC: rt5682: Fix the issue of garbled recording after
 powerd_dbus_suspend
Date: Fri, 16 Jul 2021 16:05:30 +0100
Message-Id: <162644746763.25983.4580401183042752351.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210716085853.20170-1-oder_chiou@realtek.com>
References: <20210716085853.20170-1-oder_chiou@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, judyhsiao@google.com,
 albertchen@realtek.com, Mark Brown <broonie@kernel.org>,
 derek.fang@realtek.com, shumingf@realtek.com, flove@realtek.com
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

On Fri, 16 Jul 2021 16:58:53 +0800, Oder Chiou wrote:
> While using the DMIC recording, the garbled data will be captured by the
> DMIC. It is caused by the critical power of PLL closed in the jack detect
> function.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5682: Fix the issue of garbled recording after powerd_dbus_suspend
      commit: 6a503e1c455316fd0bfd8188c0a62cce7c5525ca

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
