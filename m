Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050FFCD37B0
	for <alsa-devel@archiver.kernel.org>; Sat, 16 Sep 2023 01:13:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 12897E0F;
	Sat, 16 Sep 2023 03:12:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 12897E0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694826805;
	bh=ic8FddN6BAcES8WHpLHqJl92TlDBnuUDAtvaplE9vpw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=IEeUSJcUImMwtoWeQyldRWU55/tEj8GRb89M66MXhy43iEx1j0Lr/OkC9w3rzYtIF
	 wY7PILWivVdMYXL0ETd81AJ5oEknhrqQDlHcWECATSu67QkXmVIld3ktb1KkynroKb
	 vxobzh0eAlwdpLZ0IRyX8OofR5EgFoiOj73kx/ZY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AE4F0F80578; Sat, 16 Sep 2023 03:11:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 03D28F80568;
	Sat, 16 Sep 2023 03:11:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 91773F80431; Sat, 16 Sep 2023 03:11:39 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4062BF8007C
	for <alsa-devel@alsa-project.org>; Sat, 16 Sep 2023 03:11:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4062BF8007C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=NG+6wnjG
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 8791FB82BF7;
	Sat, 16 Sep 2023 01:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1377C433CA;
	Sat, 16 Sep 2023 01:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694826694;
	bh=ic8FddN6BAcES8WHpLHqJl92TlDBnuUDAtvaplE9vpw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NG+6wnjG6c3b1GPPHCAsCbpKErpGM6P2HuBlDSii5ex8g8pHdcw/N2DO++JF5wJem
	 iHy4UZH51rfyK9l6PtZ6QvxEzq4I6UrKSgaINulKTCYXurdKuaGwpHsXfLfeyqUIay
	 /MiSQhnCIg5dRv86hIhf0gXLCQky4JjOL8mRQHayNOiKT7UZ+EaOi3iWX+5LeCdIgT
	 cnca+TZASF9KbR0o+1w+BY4PYiWrhoHOSLChkvv2RLEC0bYpPIcoXl+GXHnb2GoxPQ
	 bR13VBhOPPt6f4um1T6r7IQWKniCuf2cDqr/SIfz1dL0hbO3e07sTxarroGk1swvrg
	 CIlGyCkDj7hiQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, shumingf@realtek.com
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com,
 oder_chiou@realtek.com, jack.yu@realtek.com, derek.fang@realtek.com,
 judyhsiao@google.com
In-Reply-To: <20230915020530.83452-1-shumingf@realtek.com>
References: <20230915020530.83452-1-shumingf@realtek.com>
Subject: Re: [PATCH] ASoC: rt1015: fix the first word being cut off
Message-Id: <169482669244.606223.14087611369554477136.b4-ty@kernel.org>
Date: Sat, 16 Sep 2023 02:11:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Message-ID-Hash: ZKQYUWTV4KJPED2ZXVYHSNTK55PMG7Y6
X-Message-ID-Hash: ZKQYUWTV4KJPED2ZXVYHSNTK55PMG7Y6
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZKQYUWTV4KJPED2ZXVYHSNTK55PMG7Y6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 15 Sep 2023 10:05:30 +0800, shumingf@realtek.com wrote:
> This patch adds a control that there are four options to control the digital volume output.
> The user could select "immediate" to make volume updates immediately.
> In default, the driver selects the volume update with "zero detection + soft inc/dec change".
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt1015: fix the first word being cut off
      commit: 74d71f628db99987d43d242ea4d3631ef0a906d0

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

