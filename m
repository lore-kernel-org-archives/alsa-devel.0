Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25651C433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  4 May 2022 20:38:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 21DF51785;
	Wed,  4 May 2022 22:38:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 21DF51785
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651696733;
	bh=MhaXkcCYVV4yXHPmCqSqrqc+KqDCZa4fRVvXSNkprdQ=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cwc2eWPr4oL8l1/fNlE/+HB+E49yDukohyMR9hpC1SLuwribUiKi0f2fWCNXJOpuf
	 LFgaDLYVSZa34GUfDiiO+5iyV2QvN+W9a5nGY7H8avTVu3/vznUYk6w3RCOOXeqiK4
	 Hn7flsGE8T8naFbbmefUDscaUTKi6dQm5S7aPRTU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1F7D0F80506;
	Wed,  4 May 2022 22:37:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 685B4F8049E; Wed,  4 May 2022 22:37:13 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B4AF1F80141
 for <alsa-devel@alsa-project.org>; Wed,  4 May 2022 22:37:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B4AF1F80141
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="gt0aywyq"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A72A06178F;
 Wed,  4 May 2022 20:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAF9C385AE;
 Wed,  4 May 2022 20:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651696623;
 bh=MhaXkcCYVV4yXHPmCqSqrqc+KqDCZa4fRVvXSNkprdQ=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=gt0aywyq4GFWecTCEeVm65qTaUaPrEQpKz39dH1/ojlUu8I5SqlQ4wMJ+X8eGpITe
 FrIjU3XZ8uY2VVBhMwBlNFWVjRMBU6x4N3+rZPfIFbYqaJu6ec8HFNPJSlW6NBot0j
 7VVo8yQ+91rt2fOVmqIDqkOHc3livI9UZFcnz8W9uqxMnAiZdkPv2kFliPp0dGovdT
 tq1f8nVkCPtcCamU19YmxLhfACXCWblLOTsk6bFlEXL0CD2eLMyfkzhL5lSx/JIyCY
 Z2+M7DkpI/GcjRlv9sroGVCfAHGv1noVyxxYGvpk3+gqS8IoKVXFIfN91b/tppA9pn
 pslGtKTnpid0A==
From: Mark Brown <broonie@kernel.org>
To: pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
 peter.ujfalusi@linux.intel.com
In-Reply-To: <20220504102831.10071-1-peter.ujfalusi@linux.intel.com>
References: <20220504102831.10071-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: ipc3: Remove the ipc3-ops.h header file
Message-Id: <165169662122.1744642.16025534398868254252.b4-ty@kernel.org>
Date: Wed, 04 May 2022 21:37:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: daniel.baluta@nxp.com, alsa-devel@alsa-project.org,
 yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
 kai.vehmanen@linux.intel.com
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

On Wed, 4 May 2022 13:28:31 +0300, Peter Ujfalusi wrote:
> Only the main IPC ops struct should be visible outside of IPC3 code to make
> sure that the code is correctly abstracted.
> 
> Instead of keeping the ipc3-ops.h with only the high level ops struct
> declaration, put the ipc3_ops to sof-priv.h and move all other ops struct
> declaration into ipc3-priv.h
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: ipc3: Remove the ipc3-ops.h header file
      commit: f80beaf6f2b1eb55fb1b2128a43e0a0c9c4d19de

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
