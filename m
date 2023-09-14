Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B8FEDE9A5
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Sep 2023 11:21:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DD97093A;
	Thu, 14 Sep 2023 13:20:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DD97093A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694690505;
	bh=L4aZkVJLe+acGFlr054UbgYKiGbGxVEfjTT4ozQy/zM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=vTn3ipR3Fwl7p4LbJ68ZjVijBuq4UmkGgSfEYAKs3OH0X2FPbwkhBgl5tQPl78qYh
	 j0+463NcZWTeDICqwoJEuZFQhsugAYEynsZbhSBfxDF+sVyZIvmQQwCwtehD5vFrZu
	 T6NWD5uHMUup3sY0pJZkoi9RboX9ig2+h9OJA+RE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2E9B1F80589; Thu, 14 Sep 2023 13:20:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7E22EF8057D;
	Thu, 14 Sep 2023 13:20:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F186DF8047D; Thu, 14 Sep 2023 13:19:54 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 45A5FF80141
	for <alsa-devel@alsa-project.org>; Thu, 14 Sep 2023 13:19:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 45A5FF80141
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Xemy/p2B
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 3BC83B82843;
	Thu, 14 Sep 2023 11:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1CDC433C8;
	Thu, 14 Sep 2023 11:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694690383;
	bh=L4aZkVJLe+acGFlr054UbgYKiGbGxVEfjTT4ozQy/zM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Xemy/p2Bng1q+bqEdjNrLrQQFsRRpa0lNmULAJpNGpQ6nhdUATmm+LFcDtdAdFCMJ
	 6oM1RYbRGkejedgh+tY/8lFG3gEaQzNQgQLAeuqOr9IFlHrxdjzeGqwBqaSzNrpoeh
	 Ykg86C5KI9lrkWYxgWA0HhewNoRzmNyG+D8MyFU/n6Zb/9GQeDkmVJhJnQo4G+lVEq
	 n8uBRyBhyJ0aMXWGtPvz7RU3Qq9rWj1yPwgd6stLsCu6R/jRzmeDWEjXViCab25GZ8
	 qCrdSDUdCQwI/x2ke8Z80bRMHK4q+FFPY64SuGd+0Uf4f9lrC4b5JS3oAfEtvtchsY
	 OFMO5kB0+m/tg==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 linux-kernel@vger.kernel.org
In-Reply-To: <20230913160523.3701189-1-rf@opensource.cirrus.com>
References: <20230913160523.3701189-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] firmware: cirrus: cs_dsp: Only log list of algorithms
 in debug build
Message-Id: <169469038276.23670.6191780374716105761.b4-ty@kernel.org>
Date: Thu, 14 Sep 2023 12:19:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Message-ID-Hash: WTDDTHVNMCZ636M57XDAWS7E5Z3NLCHN
X-Message-ID-Hash: WTDDTHVNMCZ636M57XDAWS7E5Z3NLCHN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WTDDTHVNMCZ636M57XDAWS7E5Z3NLCHN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 13 Sep 2023 17:05:23 +0100, Richard Fitzgerald wrote:
> Change the logging of each algorithm from info level to debug level.
> 
> On the original devices supported by this code there were typically only
> one or two algorithms in a firmware and one or two DSPs so this logging
> only used a small number of log lines.
> 
> However, for the latest devices there could be 30-40 algorithms in a
> firmware and 8 DSPs being loaded in parallel, so using 300+ lines of log
> for information that isn't particularly important to have logged.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] firmware: cirrus: cs_dsp: Only log list of algorithms in debug build
      commit: 69343ce91435f222052015c5af86b550391bac85

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

