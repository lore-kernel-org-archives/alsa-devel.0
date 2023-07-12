Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084BCC001DD
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Jul 2023 11:47:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C65583A;
	Wed, 12 Jul 2023 13:47:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C65583A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689162477;
	bh=qVhulzstUJ4uSDTRxWOAXGiWsrinypPIfPE5kZRZS2U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=mprN488YDBSVToxxQIOoNST1kAlFHnelzkBOB8TATEg4Q8aDmxSwv53aRV9ZFfZ7w
	 6jRpLd2Hy6bPhTCHcPhaaKHdFxmayEQ64JuR+SlqhPXj3Tspdyzs9AwHLC1T0RQpf+
	 qUPGM5u46unXBFE8HywcR0VIH314GIZKdYUWXK/M=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E5543F80544; Wed, 12 Jul 2023 13:46:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 37EF0F80290;
	Wed, 12 Jul 2023 13:46:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1F830F8024E; Wed, 12 Jul 2023 13:46:40 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E4F33F800D2
	for <alsa-devel@alsa-project.org>; Wed, 12 Jul 2023 13:46:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E4F33F800D2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=R+Be2Q+Y
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 598A96178F;
	Wed, 12 Jul 2023 11:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52051C433CA;
	Wed, 12 Jul 2023 11:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689162394;
	bh=qVhulzstUJ4uSDTRxWOAXGiWsrinypPIfPE5kZRZS2U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=R+Be2Q+YrwTmsioW4fNMiK4k97HYGi3/lQb1W33Iwc9JtnBS9wo2ZfzqjmV0huyGp
	 ExcnxwkhkAiUlcMIm/Zgvp3Ra03TOpJrTjYS4tmU42mywcdfaiCian7cawtudEYEBR
	 HlzmrorLNyh5ru/mOj00AHOAm1orh4AxRuTEx/r5WOVSDsUVTfUdHY8mrHUGeT/K+n
	 ISjlRVOVqkYPT/rdrLTaoJXLMhpdqn8VlzuyaYtrrlVTuDBogbNMwkeg/7AcTHx1nl
	 HJ6GVZCbMfQokJG2V2DLlsf6nS/Pml3J/PV316h9vK6OyCRykJvQON7cRWzQzqQxY1
	 Pj/JcZJg+5MNw==
From: Mark Brown <broonie@kernel.org>
To: perex@perex.cz, Yang Li <yang.lee@linux.alibaba.com>
Cc: tiwai@suse.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20230625010547.7353-1-yang.lee@linux.alibaba.com>
References: <20230625010547.7353-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] ASoC: tas2781: No need to set device_driver
 owner
Message-Id: <168916239302.46574.14475207879403261091.b4-ty@kernel.org>
Date: Wed, 12 Jul 2023 12:46:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Message-ID-Hash: GQSIX5SUGAZAYOZCM53HJHDWS7OQ5RDD
X-Message-ID-Hash: GQSIX5SUGAZAYOZCM53HJHDWS7OQ5RDD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GQSIX5SUGAZAYOZCM53HJHDWS7OQ5RDD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sun, 25 Jun 2023 09:05:47 +0800, Yang Li wrote:
> Remove .owner field if calls are used which set it automatically.
> 
> to silence the warning:
> ./sound/soc/codecs/tas2781-i2c.c:746:3-8: No need to set .owner here.  The core will do it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2781: No need to set device_driver owner
      commit: 24e04c94bebc4144f790a21a93d090cf9673acd9

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

