Return-Path: <SRS0=e91y=7R=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A31C433DF
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Jun 2020 14:07:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A320207D8
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Jun 2020 14:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eWXT85ff";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjV8DTBY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A320207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BEEDF1671;
	Thu,  4 Jun 2020 16:06:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BEEDF1671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591279629;
	bh=rE8aAOiPtU8yD/qqa4h0pT5TUBIYMvSrikKyYxDXOx4=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eWXT85ffiPTgUWTFZX3GOvzYOpr/dhjVA24reR6Bi6xFDN26AdB732E2G0tglchV9
	 yidtCRqyh7w+6vpGfKKE+ntBJ5YW6C5DHA/Eudt7aBa3mW8VU9hSbQwp0Y0Ifs75dQ
	 ev37Sc0shH1Lxi8kQ67bKe1B0WW4r8fkQGyy0jNk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 46565F80260;
	Thu,  4 Jun 2020 16:05:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CD82CF8013C; Thu,  4 Jun 2020 16:05:25 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 01CC8F8013C
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2020 16:05:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01CC8F8013C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="fjV8DTBY"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 30604207D8;
 Thu,  4 Jun 2020 14:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591279521;
 bh=rE8aAOiPtU8yD/qqa4h0pT5TUBIYMvSrikKyYxDXOx4=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=fjV8DTBYXuw8JkuCq50bbkuPqgA3hAMXcJbp05ldtOMKAOZvHQsEE+C0KtMIuB/PB
 7yPo3iQBQ4Kt6ObTzaBm/LC4myiQdWe1+qt8xxuE75MLekTlvQyZZ+Ed4tvQtF6dGN
 Pg7BeAij4fgCe7Prl3ZZyBP0K7dLkrUpuoqJFKOI=
Date: Thu, 04 Jun 2020 15:05:19 +0100
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <20200602164453.29925-1-tiwai@suse.de>
References: <20200602164453.29925-1-tiwai@suse.de>
Subject: Re: [PATCH] ASoC: max98390: Fix incorrect printf qualifier
Message-Id: <159127951452.54171.3413134466723891598.b4-ty@kernel.org>
Cc: alsa-devel@alsa-project.org, Steve Lee <steves.lee@maximintegrated.com>
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

On Tue, 2 Jun 2020 18:44:53 +0200, Takashi Iwai wrote:
> This patch addresses a compile warning:
>   sound/soc/codecs/max98390.c:781:3: warning: format ‘%ld’ expects argument of type ‘long int’, but argument 4 has type ‘size_t {aka const unsigned int}’ [-Wformat=]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: max98390: Fix incorrect printf qualifier
      commit: 678916ec54f38406032462dc466fd36cdfea4e3c

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
