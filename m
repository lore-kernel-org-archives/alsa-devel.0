Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39345CD37B1
	for <alsa-devel@archiver.kernel.org>; Sat, 16 Sep 2023 01:13:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6AFB3E79;
	Sat, 16 Sep 2023 03:13:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6AFB3E79
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694826832;
	bh=9ubt6shoqfurOSljKyABY8Zxm7PJBbCU4kNDInxhdYc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Tw1Mbykl/8B01O0KEa/xwp++k9oCcLzmVOwU8QIAYZ8jagoa+k50S+7SyBqaOpHgw
	 jONQYJ8XJ2i6si45M6ntF1EKaB0K7Ie48VeRHcc7fxQfxEaZ0c2Hi0PYB1VKE8Ytc1
	 bgfR5zN8tngvUOGDz4gFJe22vGDKZHLUQU5oZDX0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BA95DF805AB; Sat, 16 Sep 2023 03:11:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CDBF7F80587;
	Sat, 16 Sep 2023 03:11:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2CAC6F8055C; Sat, 16 Sep 2023 03:11:44 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D3321F8007C
	for <alsa-devel@alsa-project.org>; Sat, 16 Sep 2023 03:11:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D3321F8007C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=B/AyTDIp
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id 20517CE2E4D;
	Sat, 16 Sep 2023 01:11:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F303BC433C9;
	Sat, 16 Sep 2023 01:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694826696;
	bh=9ubt6shoqfurOSljKyABY8Zxm7PJBbCU4kNDInxhdYc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=B/AyTDIpLtwdIsrvH3ofmABI+qGe0vvmoMJoUS0/BX6DUa4dSdKR92PmC5RcHkjlv
	 o6nNZ6dl9Zpyb5kwHzotuV2LAF5PPzp6JKlEesPvJr4W0GjD/p7KL6Q1cLpb9AdTxp
	 U0tFL0JrjkkyBHwnmb9sCpsYIJz+4762gGrCsRX/ANVT5+q0nQOv0yaiwHX2JzLy9B
	 w/PUOgBEK8xHtiTSYqv11cyhlaKlWvEtkFLjCXXZXHcl7nFtt+U58UkLgRN0nu+N3e
	 YHdt4Ep1lWL/vjQPWCx1p2JThIgI1HWJelcZV5io4cYR2jZeAkOMSxkN5AJcjLQvlH
	 KNmkuj3ANBvpA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
 yung-chuan.liao@linux.intel.com
In-Reply-To: <20230915093507.7242-1-peter.ujfalusi@linux.intel.com>
References: <20230915093507.7242-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH 0/2] ASoC: SOF: ipc4: Fixup dailink format based on
 copier
Message-Id: <169482669471.606223.14598259752826793606.b4-ty@kernel.org>
Date: Sat, 16 Sep 2023 02:11:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Message-ID-Hash: 6UE25J7M7UJW4AK2LEALNOCRGA7X5A4X
X-Message-ID-Hash: 6UE25J7M7UJW4AK2LEALNOCRGA7X5A4X
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6UE25J7M7UJW4AK2LEALNOCRGA7X5A4X/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 15 Sep 2023 12:35:05 +0300, Peter Ujfalusi wrote:
> If the copier supports a single format on the DAI side we should fixup the BE
> dailink to use this single format.
> 
> Regards,
> Peter
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: ipc4-topology: export sof_ipc4_copier_is_single_format
      commit: 94fc6da924072399e4f475c7d7124a7272197e6a
[2/2] ASoC: SOF: ipc4-pcm: fixup dailink based on copier format
      commit: 26dfc43461102957e33454e766d592df330ef7a0

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

