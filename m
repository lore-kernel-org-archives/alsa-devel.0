Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FFCC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Apr 2022 17:28:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EE16F184D;
	Mon, 25 Apr 2022 19:27:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EE16F184D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650907699;
	bh=/eg1aAQGAhXyy+euVBTjuXj3vXPgIAwKG34G46xjphM=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zek9CrsF1Qk8ZOdDALWAYysZShOiByeb6BnCkzONCw0bZpbSp3RstGfMvxqedr0nk
	 szHKEF2SpJM2m+vMI9ChL1CdjOhRF8SwAhcd/QSkCMRs1uWr+d6uMPg7PQZNED/6Gh
	 oz37AQFb1e/GEDXATucOHx2Q0BAWqnHjcGxb5kEg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7B4D0F80548;
	Mon, 25 Apr 2022 19:24:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D94AAF8053D; Mon, 25 Apr 2022 19:24:39 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2BD29F8052E;
 Mon, 25 Apr 2022 19:24:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2BD29F8052E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jt7M9osM"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0E4FA61501;
 Mon, 25 Apr 2022 17:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B27C385A4;
 Mon, 25 Apr 2022 17:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650907474;
 bh=/eg1aAQGAhXyy+euVBTjuXj3vXPgIAwKG34G46xjphM=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=jt7M9osM6PGY8RKw21ZKDnjUT5uRB/zCjP8t4Akgeytohy+jyODJheE/nvOwDa1t8
 cfg2a75JtASaoc0k5JzcLAHQ7dnEHFnzSAZsk8fCbpCAtJla6HgGEbH4W7m+fDZaj4
 gtV4zjyAXIMBrqiRmejQ6/tqWJ16XFjdZWAvnTmSQNXsp7flV75570lHlPVEAGtqbT
 f70bpC2CuqDEYpe0OeF8MEtHuXKVj0DdLRSTsjuKc7ieqeDyvpUbGXBh7AgvT/Csqw
 YLr4R4O++XWkpftl9ivE0DbOXNPVji8jlZtaladHg+m0tPE/wTtRMJUz5YmHqSdAKI
 EUdUOUTPjPu+Q==
From: Mark Brown <broonie@kernel.org>
To: matthias.bgg@gmail.com, daniel.baluta@nxp.com, lgirdwood@gmail.com,
 geert@linux-m68k.org, perex@perex.cz, yc.hung@mediatek.com,
 pierre-louis.bossart@linux.intel.com, allen-kh.cheng@mediatek.com,
 tinghan.shen@mediatek.com, kai.vehmanen@linux.intel.com,
 ranjani.sridharan@linux.intel.com, peter.ujfalusi@linux.intel.com,
 tiwai@suse.com
In-Reply-To: <20220422055659.8738-1-tinghan.shen@mediatek.com>
References: <20220422055659.8738-1-tinghan.shen@mediatek.com>
Subject: Re: [PATCH v1 0/4] Add support of MediaTek mt8186 to SOF
Message-Id: <165090747057.583823.11213583506158187957.b4-ty@kernel.org>
Date: Mon, 25 Apr 2022 18:24:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 sound-open-firmware@alsa-project.org
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

On Fri, 22 Apr 2022 13:56:55 +0800, Tinghan Shen wrote:
> Add support of MediaTek mt8186 SoC DSP to SOF.
> This series is taken from thesofproject/linux/tree/topic/sof-dev-rebase.
> 
> Tinghan Shen (4):
>   ASoC: SOF: mediatek: Add mt8186 hardware support
>   ASoC: SOF: mediatek: Add mt8186 sof fw loader and dsp ops
>   ASoC: SOF: mediatek: Add mt8186 dsp clock support
>   ASoC: SOF: mediatek: Add DSP system PM callback for mt8186
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: SOF: mediatek: Add mt8186 hardware support
      commit: 1f0214a86de87011ecb96f22545dd6e5c7324cd7
[2/4] ASoC: SOF: mediatek: Add mt8186 sof fw loader and dsp ops
      commit: 570c14dc92d5dc6f732cb74fa691ef909d182710
[3/4] ASoC: SOF: mediatek: Add mt8186 dsp clock support
      commit: 210b3ab932f7a08d8b912c497ca0ca86f712814f
[4/4] ASoC: SOF: mediatek: Add DSP system PM callback for mt8186
      commit: 0e0b83cc7ec7fc5e6695aa6ebbb0961e26096105

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
