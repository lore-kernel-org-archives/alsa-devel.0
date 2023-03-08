Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9072AC678D5
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Mar 2023 13:55:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 482DA1820;
	Wed,  8 Mar 2023 14:54:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 482DA1820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678283718;
	bh=AuK4CKnzQEWi93qQERncoqJKaIKQ7COvBj0DiqnTYP4=;
	h=From:To:In-Reply-To:References:Subject:Date:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=HngejCfsANROqHElKBg+Uo9dmkjyLJ3TytscZDH6QldZEfkOLdbQQpoYeHoZmVZ64
	 Ew9YX1hXEfSzsbkO4ED4v+KhzOqGsZ5IOz3et+AzI+yHDGhsvwBe8Ue2DXok5DzrSA
	 m+iPKG7rFb2FbphoyMkt/+Jz4Y+CQ1O7OmCsNQrY=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CC502F80557;
	Wed,  8 Mar 2023 14:52:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C27FFF80527; Wed,  8 Mar 2023 14:52:41 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7972BF80482
	for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2023 14:52:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7972BF80482
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=bDLsq+C9
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id DFDEF6181B;
	Wed,  8 Mar 2023 13:52:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEE2C433D2;
	Wed,  8 Mar 2023 13:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678283556;
	bh=AuK4CKnzQEWi93qQERncoqJKaIKQ7COvBj0DiqnTYP4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bDLsq+C9CkrxwvUMmklFt7a67rsycyS3BxAAAUcCXcm229bE/WrkOnQ8aGr7XNP4U
	 MkP+qNXuWB34OdJljp/E9DgqPBmJBUxrSOCgCvlAICDWVC5GXUc+xGB1XP1gi8mmKE
	 55SZT+gto019qpHNd0UGWM9gwZhyZ3JGulbuzxyn7UFMH7WlcWEjXi+7RGzEB2Hs1h
	 mXTZmwf2HfVroEUWPv9YUNjftg18dhdfMQZQpiS6tSaAXCyMGypsnvSvO8GcepRIUg
	 gwKMizpSxHyeu5UBoWiN+cJMTdF3M3xHB16IZp/luAytFaEvQIBQ4J3ETIAt+e0VqF
	 XaUzcADKxlU5Q==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20230307095251.3058-1-peter.ujfalusi@linux.intel.com>
References: <20230307095251.3058-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: Intel: mtl: Access MTL_HFPWRCTL from
 HDA_DSP_BAR
Message-Id: <167828355425.31859.17762075950694375037.b4-ty@kernel.org>
Date: Wed, 08 Mar 2023 13:52:34 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
Message-ID-Hash: SINO7CFUJZZVID3ULQVWBOC2T5O4XXA6
X-Message-ID-Hash: SINO7CFUJZZVID3ULQVWBOC2T5O4XXA6
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
 yung-chuan.liao@linux.intel.com, yong.zhi@intel.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SINO7CFUJZZVID3ULQVWBOC2T5O4XXA6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 07 Mar 2023 11:52:51 +0200, Peter Ujfalusi wrote:
> The Host Power Management/Clock Control (ULP) Registers in
> the HDA BAR shadow the values of the same registers in the DSP BAR,
> so let's modify the latter - as done already for other accesses.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Intel: mtl: Access MTL_HFPWRCTL from HDA_DSP_BAR
      commit: 418d2b2fad7cdce5d39d0e2fdbe2460f584b5432

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

