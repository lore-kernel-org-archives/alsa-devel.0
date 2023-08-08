Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A542C04A6A
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Aug 2023 17:59:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0696286E;
	Tue,  8 Aug 2023 19:58:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0696286E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691517557;
	bh=OSvszJttxNAF7oaPs45J3swOAdc7/JMUBzffXY6Edss=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=KIWpAOTFPoBsRlYvb7Vkr1YyiaHRZ2BVhOLwO76kmib9TkcYU+Au0VIky497a1nGO
	 I5j1lgAzTZlvvmqomCWgJGR+IoAXMdzCa7hKeactJE9uEf1rzbDOZUGGarSnGqktYR
	 lfplqM7ltyhXqoircWNKVoRW+3nDDRxYa3aIUTrQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AEBAEF805AF; Tue,  8 Aug 2023 19:57:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 273BBF805AB;
	Tue,  8 Aug 2023 19:57:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 27A10F80563; Tue,  8 Aug 2023 19:57:16 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D1D49F800B8
	for <alsa-devel@alsa-project.org>; Tue,  8 Aug 2023 19:57:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D1D49F800B8
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=aZHoibeW
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3A8F362942;
	Tue,  8 Aug 2023 17:57:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D9FC433C9;
	Tue,  8 Aug 2023 17:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691517422;
	bh=OSvszJttxNAF7oaPs45J3swOAdc7/JMUBzffXY6Edss=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aZHoibeWEnNsRHe/zO9TGlWimRpA4oNcnXQASGyFEKe5Re49eOODnUTTcaHI23R7v
	 Ox8IGYorhl/F9RSj2ZLqwSp4V+HF43zvHCyBy2FSyglLLhDrW6uYz2sW9GGBOaYums
	 +a6nHaMfQszQImDYDHbLps7pokh7gifO6OJccffAAFBUbOVuSVNjyl39A/zXVpkPyI
	 aQ8vToo0H4K5nDp9kNaRCR4C/8Y1Hgp1xxu1i+OO2iDF4IFAYWbiW2fuHX+EwQQd8/
	 qVjEzfoWsnx+QOOrdLHFgpJfFdoOaO7YKg1zZadz76Jrk2cA80XXlKeuJe5R6ze7e1
	 RkpThx2ohYqVw==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de
In-Reply-To: <20230807215000.515846-1-pierre-louis.bossart@linux.intel.com>
References: <20230807215000.515846-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/2] ASoC: Intel: sof_sdw: fix two settings
Message-Id: <169151742166.78353.4135993880316558369.b4-ty@kernel.org>
Date: Tue, 08 Aug 2023 18:57:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Message-ID-Hash: 4E54YSDVODNA56Y2RUVP22NTXK525ZOW
X-Message-ID-Hash: 4E54YSDVODNA56Y2RUVP22NTXK525ZOW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4E54YSDVODNA56Y2RUVP22NTXK525ZOW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 07 Aug 2023 16:49:58 -0500, Pierre-Louis Bossart wrote:
> Fix button mapping for CS42L42 and jack detection for LunarLake RVP.
> 
> Pierre-Louis Bossart (1):
>   ASoC: Intel: sof-sdw: update jack detection quirk for LunarLake RVP
> 
> jairaj-arava (1):
>   ASoC: Intel: sof-sdw-cs42142: fix for codec button mapping
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: Intel: sof-sdw-cs42142: fix for codec button mapping
      commit: e61994882611d1a49387be37fda005e0ef6226ac
[2/2] ASoC: Intel: sof-sdw: update jack detection quirk for LunarLake RVP
      commit: bd76caa26ab53ed3bf13ad541d69f119e910d764

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

