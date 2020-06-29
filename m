Return-Path: <SRS0=wrte=AK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AE4C433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2020 18:17:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84BC5255CF
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2020 18:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ScZGDYyi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqTxBMQQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84BC5255CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 13E761676;
	Mon, 29 Jun 2020 20:17:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 13E761676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593454676;
	bh=HME3jm5v+kI3YX0e1z9z2PFpSji4Pm/di2GGIvU+mpM=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ScZGDYyixJdVlU5EQqulUPAvBAelpYT1tNhCep/SHtpsPVloIHrcDmRD8iMzwkrSu
	 69ImmybnGEpQS7Lt6/4/sgu4KeDo48pbXqmu5ALykPRaN79msf7h8JIBcgVRq/QlAw
	 PNk3QvwYB150gtvLYlAkjg6IW0mfAgawEJzv/oLs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2A6F5F80268;
	Mon, 29 Jun 2020 20:15:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 32D5AF8022B; Mon, 29 Jun 2020 20:15:28 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DF083F8020C
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2020 20:15:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DF083F8020C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="pqTxBMQQ"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C94A025599;
 Mon, 29 Jun 2020 18:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593454519;
 bh=HME3jm5v+kI3YX0e1z9z2PFpSji4Pm/di2GGIvU+mpM=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=pqTxBMQQ7VvDugyQK5aqKCae+tDtwremB2oe11I/J6sXrgwhq/Q0XqQLNhuX2KBdW
 RJm+2Bg0tIzcZeRo+V6/Bxo56MsCI22ceSzjrC4OXFpxcA/oPBE79FSBezP5486YaP
 5ZduXoLhipDZghr8b07IILTLCqqlCy55LSMj29SQ=
Date: Mon, 29 Jun 2020 19:15:17 +0100
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, plai@codeaurora.org,
 alsa-devel@alsa-project.org, tiwai@suse.com, linux-kernel@vger.kernel.org,
 Rohit kumar <rohitkr@codeaurora.org>
In-Reply-To: <1593265030-1451-1-git-send-email-rohitkr@codeaurora.org>
References: <1593265030-1451-1-git-send-email-rohitkr@codeaurora.org>
Subject: Re: [PATCH] asoc: Update supported rate and format for dummy dai
Message-Id: <159345450675.54191.18376967903850938054.b4-ty@kernel.org>
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

On Sat, 27 Jun 2020 19:07:10 +0530, Rohit kumar wrote:
> Add support for 384KHz sample rate and S24_3LE
> bitwidth for dummy dai.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] asoc: Update supported rate and format for dummy dai
      commit: abc17b2974d634c17d25be7f4472890c8533a005

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
