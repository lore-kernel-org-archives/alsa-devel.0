Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A387C7EE29
	for <alsa-devel@archiver.kernel.org>; Thu, 25 May 2023 14:58:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AAFB41E7;
	Thu, 25 May 2023 16:57:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AAFB41E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685026718;
	bh=xSCR3xzh1AVE6419MbW9C5LH8QmAA5EiVTzhTG7OXUg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=S8vxUuptgvP/Twn7uNoE+t0aVkak/grRBD1n4SlnxfTMbjBAw4jaS6XR+p1KPVxEV
	 ihfnemells1fEO7CuBHtBSiuceQLGcAZoUgVcMOOeHE8pcLhiVgwxSZNajxPU9W03G
	 z9pxNBrRDLunZyBOtUEF9wxMCKNqes/SS3sQlaaE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 506BBF8024E; Thu, 25 May 2023 16:57:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DE6DFF80249;
	Thu, 25 May 2023 16:57:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EADE5F80249; Thu, 25 May 2023 16:57:13 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 13DC3F800DF
	for <alsa-devel@alsa-project.org>; Thu, 25 May 2023 16:57:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 13DC3F800DF
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=o1Hpkiv1
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 607CA64676;
	Thu, 25 May 2023 14:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D6EC433D2;
	Thu, 25 May 2023 14:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685026623;
	bh=xSCR3xzh1AVE6419MbW9C5LH8QmAA5EiVTzhTG7OXUg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=o1Hpkiv1XgsqH1ntBabvWS4gqCEzcsBotNfdcck+phxnX1s3a4Q3EUCsPp5nMvVWt
	 +20FWqCBmQvUDynu3kwHha3Wtl8BdccF14FO4ORS0/zkoKgFanTz6au/Zq9ffcK87h
	 v/njmB2I/Jyd2ePikTjNNMRtFBYm/BOz0iOsLZIwBGAwIUd4m9yfIHLdkBPlX1P38u
	 gX9lrh3rmV8urSExmr2m8BPsoOZItKPND0Eh9FS9K8nik9/G8TD4mLdJuZ98WHmjO4
	 VvkYwxolzFkPEdPiwig6/okhohVzB39nfz8GO1W0+DCp4XDgYSKsueZXjqheHW4IFw
	 aLmmGrGvc8bLw==
From: Mark Brown <broonie@kernel.org>
To: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 linux-kernel@vger.kernel.org
In-Reply-To: <20230524125236.57149-1-vitalyr@opensource.cirrus.com>
References: <20230524125236.57149-1-vitalyr@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l42: Add PLL ratio table values
Message-Id: <168502662226.304042.4675453488843160773.b4-ty@kernel.org>
Date: Thu, 25 May 2023 15:57:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
Message-ID-Hash: BVL5EFGNR7J36C53SW4KGLKIGLFRQCUG
X-Message-ID-Hash: BVL5EFGNR7J36C53SW4KGLKIGLFRQCUG
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BVL5EFGNR7J36C53SW4KGLKIGLFRQCUG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 24 May 2023 13:52:36 +0100, Vitaly Rodionov wrote:
> Add 4.8Mhz 9.6Mhz and 19.2MHz SCLK values
> for MCLK 12MHz and 12.288MHz requested by Intel.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l42: Add PLL ratio table values
      commit: 13e75f4b03217226f110c5bb5d11720adb5ca9d1

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

