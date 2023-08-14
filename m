Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C9CEB64DD
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Aug 2023 00:35:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E8584847;
	Mon, 14 Aug 2023 02:34:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E8584847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691973332;
	bh=2nf2vFvL3OWkDejUuD7ZwglngtCbKLDgZukeAuSV1aQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=plsLpydKWSGKzH2gpop1gT/xLPwn0HqfVpwug9z0qdM2jaab7mKmqiNR+suMGKhbD
	 HNof4ZAAJdOVUEGWxpZRA4SjufWXcJTRV9EkjQlymzAQz08Z5yunv4c61E3qf/7AM8
	 NloAlVJSxMIQe9HBYZoqRuAsg1n38ISVqNO3O23Q=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AAC5FF8057C; Mon, 14 Aug 2023 02:33:34 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1EA05F80568;
	Mon, 14 Aug 2023 02:33:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C3439F80272; Mon, 14 Aug 2023 02:33:28 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 738A4F80074
	for <alsa-devel@alsa-project.org>; Mon, 14 Aug 2023 02:33:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 738A4F80074
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ReMPTYlt
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9B47660AC3;
	Mon, 14 Aug 2023 00:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F305C433C7;
	Mon, 14 Aug 2023 00:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691973199;
	bh=2nf2vFvL3OWkDejUuD7ZwglngtCbKLDgZukeAuSV1aQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ReMPTYlteN4rDHklE4/fXx/5Fgyr0v9i8s3EptcTMVXO50qrDuMcTFgpml6i9onJH
	 ZBPo4riu1N4xvB02h1+3dDOqetHWM3vhCqjncc/LO8bCE1KIkOklZD+75whJVlLpS3
	 eKcVCW9Lp3GNQwp/q5YbIPFF7i5U0NKHq8IUHFUkp2V5FBnPLM1l67O429bar4lHnH
	 3NIEvqIrTrsIyztjTszZcYfe7ITfERb/rqFt3ZhHvbUCqHJe6T8cjoefaZC+h32I0C
	 CqbnhYRs0Haovb3sXynIQ2DutVZNBz5AtahcKlEkWLpLX9M87J+/zuY8OUELqmhhxT
	 rC/0X7JJWVxMw==
From: Mark Brown <broonie@kernel.org>
To: srinivas.kandagatla@linaro.org, bgoswami@quicinc.com,
 lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
 Yue Haibing <yuehaibing@huawei.com>
Cc: alsa-devel@alsa-project.org
In-Reply-To: <20230811100130.36664-1-yuehaibing@huawei.com>
References: <20230811100130.36664-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] ASoC: q6dsp: Remove unused declaration
Message-Id: <169197319706.2741913.13881055187171720732.b4-ty@kernel.org>
Date: Mon, 14 Aug 2023 01:33:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Message-ID-Hash: JJLKPJSLUQ2S6HGQKR6SGOM64ONDBGHY
X-Message-ID-Hash: JJLKPJSLUQ2S6HGQKR6SGOM64ONDBGHY
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JJLKPJSLUQ2S6HGQKR6SGOM64ONDBGHY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 11 Aug 2023 18:01:30 +0800, Yue Haibing wrote:
> Commit 5477518b8a0e ("ASoC: qdsp6: audioreach: add q6apm support")
> declared but never implemented these.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: q6dsp: Remove unused declaration
      commit: bb6979c5ac592e11b456da728f645c9bea965489

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

