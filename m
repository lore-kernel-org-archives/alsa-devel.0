Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE919C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Feb 2022 18:33:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4CCF71897;
	Thu, 17 Feb 2022 19:32:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4CCF71897
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645122806;
	bh=xwSCKgJCSi//NdMMY/uqE9yzCLpiaQujmlrCLYqJ29M=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iCSWug5TeNxS3P4Y1OnXBN9mRPMGz6kewdMdEydnYyP7FhL4akTPPoiDRlYEqs7IC
	 oN+pWGrTRcHQHhbRzdd6WYkW/gCpXYhHXI6N1iRDd5czymQDIrJbAQ0L5HMhlWD7qf
	 LGH6jFnUxqTICAgAOgnAfDtdt89x7cp1oBGPshq8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D5161F80118;
	Thu, 17 Feb 2022 19:32:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2ED8CF80240; Thu, 17 Feb 2022 19:32:34 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 62A6AF80118;
 Thu, 17 Feb 2022 19:32:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 62A6AF80118
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Ew0EMEJt"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id E6571B823D1;
 Thu, 17 Feb 2022 18:32:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5447CC340E8;
 Thu, 17 Feb 2022 18:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645122741;
 bh=xwSCKgJCSi//NdMMY/uqE9yzCLpiaQujmlrCLYqJ29M=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=Ew0EMEJtVqPTC1tjTEMpaKO7aSCibLsRxhlFO4GWnj6NtQBwSyUj/cqtZ7o/9wami
 IJ4oJrpgwwKsN9cBs5irSLjVFEhgaoQKhaBCrbp+mAR+g8Ti67368C2hMG/+nkI2c1
 HKwOdcZ2qdisPdToFP/OTLujo6tHv6Ac3B2K7V3G5sgWBtzPxhvdYevoGRmCyu6gTi
 /Xtnt87CydStz6RXQSCnyfZobLbG1cy8Nla+fEsjq65M4v+Mk9GZhbT8NA+5/xjTKU
 LggzxN5JGHvD7nxgiNzuC/mMRjCfari4eOKmhlqL2U1FMeGyqJBX+FFf/ai0kJPwTT
 5kuCS929r4dwQ==
From: Mark Brown <broonie@kernel.org>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Stephen Kitt <steve@sk2.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Daniel Baluta <daniel.baluta@nxp.com>
In-Reply-To: <20220217132755.1786130-1-steve@sk2.org>
References: <20220217132755.1786130-1-steve@sk2.org>
Subject: Re: [PATCH] ASoC: SOF: Replace zero-length array with flexible-array
 member
Message-Id: <164512273904.3993052.15786188783009967860.b4-ty@kernel.org>
Date: Thu, 17 Feb 2022 18:32:19 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org,
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

On Thu, 17 Feb 2022 14:27:55 +0100, Stephen Kitt wrote:
> There is a regular need in the kernel to provide a way to declare having
> a dynamically sized set of trailing elements in a structure. Kernel code
> should always use "flexible array members"[1] for these cases. The older
> style of one-element or zero-length arrays should no longer be used[2].
> 
> This helps with the ongoing efforts to globally enable -Warray-bounds
> and get us closer to being able to tighten the FORTIFY_SOURCE routines
> on memcpy().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Replace zero-length array with flexible-array member
      commit: 4fe6a63077a6d3c143d68f6b96e4051f1d0740ac

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
