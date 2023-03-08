Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C95C74A44
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Mar 2023 13:55:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE94F1845;
	Wed,  8 Mar 2023 14:54:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE94F1845
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678283734;
	bh=zkRltTNdLXRC5MRn0DVpS9sVik70jG8hG8ywHMSk9PE=;
	h=From:To:In-Reply-To:References:Subject:Date:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=b4tmTBucxdXEyFp45lRqPMgcjLp3VFdfE0kfaMblrX8nF3WV7iReuF+OM73xoP5nU
	 yV2/mcm75hzKpsV3hZpX1PPc5MP5qoTQZneb6tUD3SYVzUSCT5xVXjLQvYRr9GxEUp
	 39UCcQbXNpwSbX5m5+hLmmet00+sDcDBt3v9CDSM=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6D22AF80558;
	Wed,  8 Mar 2023 14:52:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DB3D3F8052D; Wed,  8 Mar 2023 14:52:43 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F1330F804FE
	for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2023 14:52:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1330F804FE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=O5UNAZDB
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id F2A8E61821;
	Wed,  8 Mar 2023 13:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFA9C433EF;
	Wed,  8 Mar 2023 13:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678283558;
	bh=zkRltTNdLXRC5MRn0DVpS9sVik70jG8hG8ywHMSk9PE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=O5UNAZDBPmioocMNreSEYX+WC/qo2x1BcAKVDVIRJ26KwpnkBPOMmQu1lIlclKFBx
	 GbiFHIqE3B8/dUWtJrDMC4L7FsNet30MEqQrdKzKOYwpnVAruJywtEFNrqlXsaegyK
	 79uSQQKRS4boNWzkoPMurCAfJZ2oByr62vE50g3FuukmaizmQeF457wIlmeYl3f2bN
	 7hYpqgSGnv2ySqQbz/4CXG6SqnRv+wLGq61CEZZwQaXWHZ7E6+L65WDYu/Q6eA4yev
	 e3uxGt/JdnfvVdrKOv/LjO7+6jOKsXCLcaE96eJ5mfnvN+9xoEJTWX2x11yDO1I8TM
	 aIUiqJGu4rGUA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20230307095341.3222-1-peter.ujfalusi@linux.intel.com>
References: <20230307095341.3222-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: Intel: pci-tng: revert invalid bar size
 setting
Message-Id: <167828355654.31859.15712524327409522515.b4-ty@kernel.org>
Date: Wed, 08 Mar 2023 13:52:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
Message-ID-Hash: DBP2VVW2HEYQ6L34TQA6R3ZV7BVYFKY2
X-Message-ID-Hash: DBP2VVW2HEYQ6L34TQA6R3ZV7BVYFKY2
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
 fntoth@gmail.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DBP2VVW2HEYQ6L34TQA6R3ZV7BVYFKY2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 07 Mar 2023 11:53:41 +0200, Peter Ujfalusi wrote:
> The logic for the ioremap is to find the resource index 3 (IRAM) and
> infer the BAR address by subtracting the IRAM offset. The BAR size
> defined in hardware specifications is 2MB.
> 
> The commit 5947b2726beb6 ("ASoC: SOF: Intel: Check the bar size before
> remapping") tried to find the BAR size by querying the resource length
> instead of a pre-canned value, but by requesting the size for index 3
> it only gets the size of the IRAM. That's obviously wrong and prevents
> the probe from proceeding.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Intel: pci-tng: revert invalid bar size setting
      commit: ca09e2a351fbc7836ba9418304ff0c3e72addfe0

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

