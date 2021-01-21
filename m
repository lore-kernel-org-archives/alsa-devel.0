Return-Path: <SRS0=oBR+=GY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D6AC433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Jan 2021 19:41:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FEA023A57
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Jan 2021 19:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FEA023A57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CF81316B4;
	Thu, 21 Jan 2021 20:40:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CF81316B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611258058;
	bh=vQNTs0h+6FxGYAZiKCnKfmlanAmoHs/5OzhtkdW24QI=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MPKCajPvcBDgnVyCq169E5uMx6SbylCO9y5XE+zM0kNMvYef5nWxkSbIwtH9eCrK9
	 HvWmEZ1TN5+kSQBr8P+4Mv1rYeW7jpTjcPMKxCuU02GtrhtNt6ZTOaSEsmjEbjycEQ
	 S35myXMPgKkbNxMqA25gq5TMhEDmiS7eKq0ABajk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 23F37F80255;
	Thu, 21 Jan 2021 20:40:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D286CF80164; Thu, 21 Jan 2021 20:40:05 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CC6C2F80164
 for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2021 20:39:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CC6C2F80164
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jpCgxF+B"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 876A623A40;
 Thu, 21 Jan 2021 19:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611257993;
 bh=vQNTs0h+6FxGYAZiKCnKfmlanAmoHs/5OzhtkdW24QI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=jpCgxF+BAEuUUE5EOTrq+spkszfuqtEzLQ5ugUO71qJHu4S+pgjitb3OJlymOY2cc
 AVHbFAd4/wNa+VBkhc5UBIzSY34BDFr2zx/0GUQBfP5/Ieb42u9m9+eS20/PBjIpC1
 M2MVGYU7QOiEWLEJxcsxJ7/vjTY6FfYvSHRmzltWmwOg2h0dt7fkyWNplAFCYBIi0M
 Wb9ClZO7H7E4M5yq/M8DGpM+R0ymKRQOYobN3k4vA8+cZD338kLTeejzbln9uxI1hz
 Ez/T4vKN4F1TGn18jQSJkAdeJvm+0Md6mWKyABD9tthxyRcjuZI/hREoxVzqUT4FlW
 dlo7CzsXsgkcw==
From: Mark Brown <broonie@kernel.org>
To: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20210120152846.1703655-1-amadeuszx.slawinski@linux.intel.com>
References: <20210120152846.1703655-1-amadeuszx.slawinski@linux.intel.com>
Subject: Re: (subset) [PATCH 0/5] Add KUNIT tests for ASoC topology
Message-Id: <161125795422.35635.8958502643983739917.b4-ty@kernel.org>
Date: Thu, 21 Jan 2021 19:39:14 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

On Wed, 20 Jan 2021 16:28:41 +0100, Amadeusz Sławiński wrote:
> This series adds unit tests for ASoC topology.
> 
> First fix problems found when developing and running test cases and
> then add tests implementation.
> 
> Tests themselves are quite simple and just call
> snd_soc_tplg_component_load() with various parameters and check the
> result. Tests themselves are described in more detail in commits
> adding them.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[3/5] ASoC: topology: KUnit: Add KUnit tests passing various arguments to snd_soc_tplg_component_load
      commit: d52bbf747cfa8a2988289009241214a84982cc7d
[4/5] ASoC: topology: KUnit: Add KUnit tests passing empty topology with variants to snd_soc_tplg_component_load
      commit: cec9128dfcf9101f903470e43d46278e5b07ef24
[5/5] ASoC: topology: KUnit: Add KUnit tests passing topology with PCM to snd_soc_tplg_component_load
      commit: 3ad8c8e9efc53d14d928b84aabe1a27dd5d3171b

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
