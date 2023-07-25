Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD33FC001DE
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Jul 2023 16:51:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 08167DEB;
	Tue, 25 Jul 2023 18:50:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 08167DEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690303870;
	bh=1F7griQ+z3bvllj2m8OXOd5aUu8hpTnYOGJgxms+w/Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=A3AvAX4lZCQkdcU5j4j4YvbT26Qu/eLZac1Ch2OqXYPF5/A3287Km8qVPGcI5FGmH
	 OCIezpL1gVSSqAmHnSGK1TtkLhmvUXcMXRDXotXtKYwGpxTTEZlT4p7AU0OhFLqoPA
	 5i6jwyvYR6ItNi35aWKgVrVx2rNRrgSxQJf0BzJk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 733AFF80571; Tue, 25 Jul 2023 18:49:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 25B69F80570;
	Tue, 25 Jul 2023 18:49:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E9145F8019B; Tue, 25 Jul 2023 18:49:20 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 74BA6F800C7
	for <alsa-devel@alsa-project.org>; Tue, 25 Jul 2023 18:49:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 74BA6F800C7
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=gfN2Yb5q
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5B99A6181D;
	Tue, 25 Jul 2023 16:49:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE4AC433C7;
	Tue, 25 Jul 2023 16:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690303756;
	bh=1F7griQ+z3bvllj2m8OXOd5aUu8hpTnYOGJgxms+w/Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gfN2Yb5qnFZhfS7QoywqxwZbY/GgJaljlE/TeJL42bf1B4d7S+c8Dzr9ZoGUCZ1ru
	 caQeMpyyi+CYAWaeBWWaf1O7kaqFKLMNBPulmx2gMWPESRYqyXE3nyR1aENY35ZjMD
	 R7zXSdGODLBG9EzhxUfUSlA70MeFPcCDCSTPAOGk0yC189yXwDTfwcSIp93y3cRoAT
	 TlL9J3Yrm+2yMgfRmsk8UijAWhkXWZYmoNEspJ4jlOTHFV0njQbKUAMrDjrOeDzg3u
	 Ama2eMDAqeS0NkSNCgtRR5zanDWZTR5ghu445OMNq+sD+g2H3Zv/hLSXQXPVvTC9KB
	 3mEpHUJClS/jA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Peter Suti <peter.suti@streamunlimited.com>
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20230713095258.3393827-1-peter.suti@streamunlimited.com>
References: <20230713095258.3393827-1-peter.suti@streamunlimited.com>
Subject: Re: [RFC PATCH] ASoC: soc-dai: don't call PCM audio ops if the
 stream is not supported
Message-Id: <169030375511.1462400.7618926843800056957.b4-ty@kernel.org>
Date: Tue, 25 Jul 2023 17:49:15 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Message-ID-Hash: MGCSJMPUBJNC7K3M3CCU4SUAQLGVABZ4
X-Message-ID-Hash: MGCSJMPUBJNC7K3M3CCU4SUAQLGVABZ4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MGCSJMPUBJNC7K3M3CCU4SUAQLGVABZ4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 13 Jul 2023 11:52:58 +0200, Peter Suti wrote:
> PCM audio ops may be called when the stream is not supported.
> We should not call the ops in that case to avoid unexpected behavior.
> 
> hw_params is handled already in soc-pcm.c
> 
> [0] https://lore.kernel.org/alsa-devel/ae06b00a-f3f7-f9d1-0b58-4d71f3394416@linux.intel.com/T/#t
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-dai: don't call PCM audio ops if the stream is not supported
      commit: 4005d1ba0a7e5cf32f669bf0014dca0dd12c2a44

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

