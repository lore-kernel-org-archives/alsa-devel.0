Return-Path: <SRS0=72a4=G6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60230C433E6
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Jan 2021 17:36:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 804F864DA5
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Jan 2021 17:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 804F864DA5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (unknown [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BEACE178D;
	Wed, 27 Jan 2021 18:17:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BEACE178D
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D6F3EF804E6;
	Wed, 27 Jan 2021 18:15:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 92971F804EB; Wed, 27 Jan 2021 18:15:03 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BBB3EF804E6
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2021 18:14:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BBB3EF804E6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="beHFpdI3"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5164A64DAA;
 Wed, 27 Jan 2021 17:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611767697;
 bh=O287Nnrz1Nzcsa3kBINOq8DwoZ8K1tvphv8Ae2qknAQ=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=beHFpdI3MbW3UXSYZ0JwS3lLAZCRgR/IICUZFYxABWYrXYMiLry7H8NUiSfN1Usgx
 PsvRfi5iCMQ2liEw2oWJk6Th5SDxEBu+aHk18hFJy7/jjLLDQiJ8ubiMB/HYEK8CNb
 gvmsfdeIe25FKlww4BAkYdwALITWP4Wmqd3RduZCAUCr/qL0M4VgALaNSht5t0/NQe
 GGez0rx01wQ1RDy3aEgcTsbXwV1nTXD+qgbd+WBYCRwW1in7DTUmFc7Jm2g/1IOI6R
 /4nlx/4ogKRTt3ej8QqhLEy0ET/sNQZ6c1iAfKGrRxB3TecD3AvPTZpnNq+MxEdNWV
 m9M7bNH5+LA9w==
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <20210126154702.3974-1-tiwai@suse.de>
References: <20210126154702.3974-1-tiwai@suse.de>
Subject: Re: [PATCH] ASoC: siu: Fix build error by a wrong const prefix
Message-Id: <161176762853.34530.4154305891257852492.b4-ty@kernel.org>
Date: Wed, 27 Jan 2021 17:13:48 +0000
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

On Tue, 26 Jan 2021 16:47:02 +0100, Takashi Iwai wrote:
> A const prefix was put wrongly in the middle at the code refactoring
> commit 932eaf7c7904 ("ASoC: sh: siu_pcm: remove snd_pcm_ops"), which
> leads to a build error as:
>   sound/soc/sh/siu_pcm.c:546:8: error: expected '{' before 'const'
> 
> Also, another inconsistency is that the declaration of siu_component
> misses the const prefix.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: siu: Fix build error by a wrong const prefix
      commit: ae07f5c7c5e9ebca5b9d6471bb4b99a9da5c6d88

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
