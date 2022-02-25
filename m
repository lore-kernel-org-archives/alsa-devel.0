Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694A3C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Feb 2022 17:38:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9318D1EF2;
	Fri, 25 Feb 2022 18:37:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9318D1EF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645810688;
	bh=60Aj97bhCy6GhcHiP/GEc6hAyHSIKtkMbp6raHwJd4A=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k7Ex6znq6L07JE0GS/J9ntr41+lm8iv8Kk89BE70f1xUKt9URjDK5dypeUc2hBnAK
	 lw7uSfWK1SDtLh+6HNGQtnYZal1xzv74vVRTumb/a9J81V/V1LPzEZBI/4HNbCBc25
	 gwA7b/3umPdQ/s7aXSeDaTDLhYr5C3H9ZejqiHVI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 091B3F8051F;
	Fri, 25 Feb 2022 18:36:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BA010F8051F; Fri, 25 Feb 2022 18:35:59 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5C0E0F80515
 for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2022 18:35:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5C0E0F80515
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="F16A1nFN"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 51E6DB832D7;
 Fri, 25 Feb 2022 17:35:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B854C340F0;
 Fri, 25 Feb 2022 17:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645810555;
 bh=60Aj97bhCy6GhcHiP/GEc6hAyHSIKtkMbp6raHwJd4A=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=F16A1nFNWxF85bJAu6f10xr4xjBGEIUr2LqmsDSNLo7x8My+7YawxNYJoUVrD09ae
 s3tx5oHe5/yedR5uxCzfu8PZmXo/Nf3nQ4zGk9Qopbd5qoJRQAbuXgyPpImFSESquO
 +AJYdWXF2s63xgGSZhkG5AMQEsGHPdKcAU1cD7Ldnmy6ujONILs1eAFRRRAYzcqW4z
 YrSmivQcSadKn8WCgtldTsAwCdBMp3h344N/kfzOE+rrA+3aBdP0baGS8aWpycBfxv
 cOCrpFXC+2kKdVYPeoFcxaH4RcxnGnsduna3Sf1GAFglRVR3gN2zcdC46WmJNLItYW
 PUGdckQP2MKIQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
 AjitKumar.Pandey@amd.com, vsujithkumar.reddy@amd.com,
 Jia-Ju Bai <baijiaju1990@gmail.com>
In-Reply-To: <20220225131645.27556-1-baijiaju1990@gmail.com>
References: <20220225131645.27556-1-baijiaju1990@gmail.com>
Subject: Re: [PATCH] ALSA: acp: check the return value of devm_kzalloc() in
 acp_legacy_dai_links_create()
Message-Id: <164581055316.2548431.3373385373741114980.b4-ty@kernel.org>
Date: Fri, 25 Feb 2022 17:35:53 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

On Fri, 25 Feb 2022 05:16:45 -0800, Jia-Ju Bai wrote:
> The function devm_kzalloc() in acp_legacy_dai_links_create() can fail,
> so its return value should be checked.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ALSA: acp: check the return value of devm_kzalloc() in acp_legacy_dai_links_create()
      commit: 431f9a77a4a62694ce90742d1f4c5abe1b8b6612

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
