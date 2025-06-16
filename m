Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52DDBC71136
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Jun 2025 15:51:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A193F60201;
	Mon, 16 Jun 2025 17:51:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A193F60201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1750089087;
	bh=Pk/FBo5zZdbkOTTOWZWdZP7Rkead/gzoaWBxkdW7vCc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=e36tOS8/vSjSS4sErY4NEHFvBMZvrgYoZWyiCkWy0MI+X5iy8QJQJxS352H7juZSL
	 JyU9HrB5R8tqeWfMykORJW3pkKZC0dmBfb1ze04jbWAkqNzj9wJ3hnVBozAYuapPtS
	 k9mC808FZdhU3jS6LLyTGMVg4S3CwBiu1VF1bZU0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 23581F805C9; Mon, 16 Jun 2025 17:50:53 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 004A9F805BB;
	Mon, 16 Jun 2025 17:50:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D6B35F80124; Mon, 16 Jun 2025 17:50:50 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0CAB1F800E4
	for <alsa-devel@alsa-project.org>; Mon, 16 Jun 2025 17:50:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0CAB1F800E4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=uFtOCks7
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 346DA5C62B2;
	Mon, 16 Jun 2025 15:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F590C4CEEA;
	Mon, 16 Jun 2025 15:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750089046;
	bh=Pk/FBo5zZdbkOTTOWZWdZP7Rkead/gzoaWBxkdW7vCc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uFtOCks7DIaB3S/8Cd5OXtwNVcXD9amLStNHOCrRfk6SnmnnnEo1cI5rGAf9Jtb+3
	 AQZOrgWdlYWRv6yGp82XiaS4Wuxzyp9E5LrqEImD6577fGq+f/zy1eFq5gvgktO4pC
	 ggpqGPFlsjzanv1656m+NniTyifhw7IUg1gAteZ3MamDJ2c3Lz3lQ/uZDq3nVOqAsq
	 4IedB6FjUQL5G2SiPJCsRb0Bo42v5+tRi1fQQ/QJpY6+lu7LHKcFEz0MYEo67X7ze3
	 hNHRtFddn268WuKApgRXYAiKTgyN4hOjA+G+SLOmnhViJz5gxNfQpUraZJ+PdeSoqa
	 37Az6ShKTtMBQ==
From: Mark Brown <broonie@kernel.org>
To: Sachin Mokashi <sachin.mokashi@intel.com>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
 tiwai@suse.com, pierre-louis.bossart@linux.dev
In-Reply-To: <20250613163530.1165690-1-sachin.mokashi@intel.com>
References: <20250613163530.1165690-1-sachin.mokashi@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Replace deprecated strcpy() with
 strscpy()
Message-Id: <175008904526.262284.7856990729788013892.b4-ty@kernel.org>
Date: Mon, 16 Jun 2025 16:50:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-08c49
Message-ID-Hash: 7BGO7UDMMCQJ3LLB6AKB742COI7KZ7RZ
X-Message-ID-Hash: 7BGO7UDMMCQJ3LLB6AKB742COI7KZ7RZ
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7BGO7UDMMCQJ3LLB6AKB742COI7KZ7RZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 13 Jun 2025 12:35:30 -0400, Sachin Mokashi wrote:
> strcpy() is deprecated, use strscpy() instead.
> As strcpy() performs no bounds checking on the destination buffer. This
> could result in buffer overflow. The safe replacement is strscpy().
> 
> Link: https://github.com/KSPP/linux/issues/88
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: Replace deprecated strcpy() with strscpy()
      commit: 47972c1c3315672352f25c68f91dd88543541947

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

