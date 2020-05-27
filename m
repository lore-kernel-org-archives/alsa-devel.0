Return-Path: <SRS0=+ZhY=7J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F25CC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2020 13:50:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0002C20787
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2020 13:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OQkBJCbA";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJNvaSMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0002C20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 65A1217B3;
	Wed, 27 May 2020 15:49:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 65A1217B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590587429;
	bh=uMgur9fSeLKrBpTOlJ0CmQ/inX4ifFut+KsI9NagPpg=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OQkBJCbAJti1U2nsXK2a6xtG2RFGuIBextPn83MrIzkwNeqWXjWgA+eMw1I3qYKyC
	 F/7sjNVo3VDKBMoiZshSHasPOlOVoOkT3BRwrMGIE/2dcG9zvdskGw0rJEhSUshFAL
	 Z9q8t8FSdkEzhYhsHrm71NzEKye3gF1Aha0CgGyk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 92DB2F80149;
	Wed, 27 May 2020 15:49:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 23D92F8014E; Wed, 27 May 2020 15:49:37 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 390ABF800FF
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2020 15:49:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 390ABF800FF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="RJNvaSMU"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 357992078C;
 Wed, 27 May 2020 13:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590587372;
 bh=uMgur9fSeLKrBpTOlJ0CmQ/inX4ifFut+KsI9NagPpg=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=RJNvaSMUIm4T+Jz47+hN6nC7Q+GHUWKVgxrLD9cI6LlEhZfa8ttldvEno1K5q5C2m
 UhJXBPu5W0z904x/N/aCi06PRs3C7H7nw0ScmAQcGLqBr5cfow/+b8UA+yO6AaAANz
 2twQYRj0dRT7nf0K/b5RaSaFoh4cALHL9rqOzr8M=
Date: Wed, 27 May 2020 14:49:30 +0100
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
In-Reply-To: <20200526161930.30759-1-ckeepax@opensource.cirrus.com>
References: <20200526161930.30759-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: dapm: Move dai_link widgets to runtime to fix use
 after free
Message-Id: <159058737039.56986.1556152236392295649.b4-ty@kernel.org>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com
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

On Tue, 26 May 2020 17:19:30 +0100, Charles Keepax wrote:
> The newly added CODEC to CODEC DAI link widget pointers in
> snd_soc_dai_link are better placed in snd_soc_pcm_runtime.
> snd_soc_dai_link is really intended for static configuration of
> the DAI, and the runtime for dynamic data.  The snd_soc_dai_link
> structures are not destroyed if the card is unbound. The widgets
> are cleared up on unbind, however if the card is rebound as the
> snd_soc_dai_link structures are reused these pointers will be left at
> their old values, causing access to freed memory.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dapm: Move dai_link widgets to runtime to fix use after free
      commit: f4aa5e214eeaf7f1c7f157526a5aa29784cb6a1f

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
