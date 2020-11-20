Return-Path: <SRS0=4V3b=E2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55703C2D0E4
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 21:36:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 719C622403
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 21:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Dziu8S2V";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="STsrivqA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 719C622403
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 57B00170B;
	Fri, 20 Nov 2020 22:35:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 57B00170B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605908198;
	bh=EFiexHFZKW7N+/KrKxGNqn62prfsHu7FTDQCJmxMJts=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dziu8S2VerM3H0UutoV4qTkoks7q2y1JscWhXaUh2/nCwzLTmXdUv9ice42RpqKH1
	 V3s1QbH1cfQfthw97E0CbpssAP3f91WeJzR+D4AfIZby01WeA1xldoiZ365GrFu3is
	 KNTx8KKyM6ZtChgjAE9CQz+ZLRWr3weMcqrYVRkY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B79FAF8016C;
	Fri, 20 Nov 2020 22:35:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 83207F8016C; Fri, 20 Nov 2020 22:35:45 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B9C43F80166
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2020 22:35:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B9C43F80166
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="STsrivqA"
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net
 [92.233.91.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 73AC12237B;
 Fri, 20 Nov 2020 21:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605908141;
 bh=EFiexHFZKW7N+/KrKxGNqn62prfsHu7FTDQCJmxMJts=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=STsrivqAhf90GKlMJGc4Ab5vZuotHcUl+J6aFoNmwlmhupWVdNrgTBwS9GuuPcSNJ
 WNejah8Hw1fnaL/6Jc+Cp1GqGBEw9AUacZZWUYFBS89eQiib9EQIxX6JPSL0QzenjK
 I4M6/forAw2zSQBvIRmre7dM/7zXseMQHnEGFJck=
Date: Fri, 20 Nov 2020 21:35:19 +0000
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, Jiaxin Yu <jiaxin.yu@mediatek.com>, matthias.bgg@gmail.com,
 tzungbi@google.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 robh+dt@kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <1605841573-1442-1-git-send-email-jiaxin.yu@mediatek.com>
References: <1605841573-1442-1-git-send-email-jiaxin.yu@mediatek.com>
Subject: Re: [PATCH 0/2] ASoC: mt6359: Fix regulator_dev_lookup() fails for id
 "LDO_VAUD18"
Message-Id: <160590773742.47461.980400438580357576.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: shane.chien@mediatek.com, Trevor.Wu@mediatek.com
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

On Fri, 20 Nov 2020 11:06:11 +0800, Jiaxin Yu wrote:
> This series fixed "LDO_VAUD18-supply" regulator register fail.
> We can see the error log "mt6359-sound supply LDO_VAUD18 not found, using
> dummy regulator" when register the DAPM widget "LDO_VAUD18"
> Otherwise, the power can not be turned on correctly when recording.
> 
> Jiaxin Yu (2):
>   ASoC: mediatek: mt6359: Fix regulator_dev_lookup() fails for id
>     "LDO_VAUD18"
>   dt-bindings: mediatek: mt6359: remove unused property for mt6359
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: mediatek: mt6359: Fix regulator_dev_lookup() fails for id "LDO_VAUD18"
      commit: 9546c76c73a1ee8b662b09f7308bcb63d2cd0d51
[2/2] ASoC: mt6359: remove unused property for mt6359
      commit: 6e85530496a496616ece6c444df23522afc81520

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
