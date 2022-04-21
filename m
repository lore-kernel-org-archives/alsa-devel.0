Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E56C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Apr 2022 18:23:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5CDA31E9;
	Thu, 21 Apr 2022 20:22:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5CDA31E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650565395;
	bh=CnVCETWql77rAIPIdKNVoa4jG6xKyEeOOE6FeK3tbaE=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u2ftLQLwvh47g+B1cToBfcq4kJvJtd8xMpeTVbNBojVLN1OMLkZPsI50sVsch+Emk
	 dmXpVLcP4AD/hx9NF/WRbaG3HRg9LWZ/zNSyactgEfv0W56l5B8p7HdHjL0988zix3
	 V4L6GY94HwO0Kd8zchvLu2CV1eGZxMXG8ecuJ9Qw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D1101F80279;
	Thu, 21 Apr 2022 20:22:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 47AA1F8032D; Thu, 21 Apr 2022 20:22:23 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AF456F800C1
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2022 20:22:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AF456F800C1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="hHg2pZB2"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 16D7260C86;
 Thu, 21 Apr 2022 18:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D49C385A5;
 Thu, 21 Apr 2022 18:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650565335;
 bh=CnVCETWql77rAIPIdKNVoa4jG6xKyEeOOE6FeK3tbaE=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=hHg2pZB23gyUHtoTUB+lfN9R5Kyd1XBcAso4mD0ylSRqmeubWHuGkCur/wsJBjFme
 TCvQMmBQYVEWMnwhr//Cq0KDT40HaX6FYfVnN0v9pHnvJtcf0MMY8H1Ouw7UchcTNQ
 0jECtxRfnaDP2yxkA0dMhq9fQ5YDz+aZCmFBBLMMVYheY7An6Nrv1xlRs9u8tMHB62
 Ua9fA+qkcoRYLrdyIOvPbZvTeq7alSnakKujmkU9n9h8E7PCJ8ExZ2N/7NMu9CU56T
 uBIv/PVq1tLJC5RVsFMclCJM0NclFWNlafMJ5bOyXX3qJ+0Sg9EIb7Kr5MIk9A2bgk
 G1yxt0ktk4s5A==
From: Mark Brown <broonie@kernel.org>
To: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org
In-Reply-To: <20220421163645.319686-1-pierre-louis.bossart@linux.intel.com>
References: <20220421163645.319686-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: sof_ssp_amp: remove 'set-but-not-used'
 warning
Message-Id: <165056533401.395574.657377415855346599.b4-ty@kernel.org>
Date: Thu, 21 Apr 2022 19:22:14 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, peter.ujfalusi@linux.intel.com,
 ranjani.sridharan@linux.intel.com, lkp@intel.com
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

On Thu, 21 Apr 2022 11:36:45 -0500, Pierre-Louis Bossart wrote:
> Clang warning:
> >> sound/soc/intel/boards/sof_ssp_amp.c:97:6: warning: variable 'i'
>    set but not used [-Wunused-but-set-variable]
>            int i = 0;
>                ^
> 
> The device counter is not used when the quirk is not set, which static
> analysis cannot know. Move its initialization before the loop to
> remove this warning.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: sof_ssp_amp: remove 'set-but-not-used' warning
      commit: aa4c06e02b4139c378ba8d20d767d6d1cf6a2ad8

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
