Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4043FCD5BCF
	for <alsa-devel@archiver.kernel.org>; Mon, 25 May 2026 08:32:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F288F6021E;
	Mon, 25 May 2026 10:32:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F288F6021E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779697976;
	bh=vNyy7llkJ7s8Xp/k4/jnXmvlgUCHgaVhSmR850EYfpg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=odKn6pcAFijl9KKtZW7dSwkTYZ40BEAAFQbhzSpnjtz0Kx8dnXYokk005qkJe6RH0
	 0n+HSKJOsWP+ONY34DFbtomtLA81nAXMMAT0sUJRcRFhTZhpWuCr08NOoW56bNflyw
	 I/WfWqJj+tyHqchw6MTUVwvHA/1R8fkcwFbA3eiM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CD4CEF805F1; Mon, 25 May 2026 10:32:17 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7022AF805F5;
	Mon, 25 May 2026 10:32:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 63AD6F80557; Mon, 25 May 2026 10:32:12 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CBEA6F8047D
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2026 10:32:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CBEA6F8047D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=BqpK1nv8
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EED3E601F3;
	Fri, 22 May 2026 10:22:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CDF1F00A3D;
	Fri, 22 May 2026 10:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779445326;
	bh=NLMKfI2fb0dfxireerzHPvAHLMdnpnDstRPphQaFKP4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=BqpK1nv8s48Uf1fMLOJycR5RytGWvf1NvQcOLc7gsYfA8ND3+2DzXBW/Mwwy6TlyN
	 DyM1QEoKbOsJccgGJVInmUXfK+d29i9QauR/LhE4/kf89vCuurMG/k0Lkvq4VFIb/Y
	 88KpJrde8jfC9S13hsoFeBC2s+gZE1F5Hqw3rRHSsu0suQvg+YBboN4Eu4Ds8D/Q4w
	 m40XYqjMQXHproezqDOqRLqph/faIPWAl3O854SYss91fdPOj6X9+sOZ3G+pycLxnI
	 KknBZYK7rTgATONF9L+cPt5HK8VygHlvdBczIySNxki5d//XNp4lNOrJO8TS3ddN4E
	 ky2zUD5vMTkRw==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, jack.yu@realtek.com
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com,
 oder_chiou@realtek.com, shumingf@realtek.com, derek.fang@realtek.com
In-Reply-To: <20260520053243.3645180-1-jack.yu@realtek.com>
References: <20260520053243.3645180-1-jack.yu@realtek.com>
Subject: Re: [PATCH v4] ASoC: rt722-sdca: Add a control to support CAE
 firmware update
Message-Id: <177927607396.56665.7490075193597504337.b4-ty@b4>
Date: Wed, 20 May 2026 12:21:13 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149; i=broonie@kernel.org;
 h=from:subject:message-id; bh=vNyy7llkJ7s8Xp/k4/jnXmvlgUCHgaVhSmR850EYfpg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqEC5MXsT+r0jm3OJOb/amB8lpJlS/BZZt0Drxe
 XeaPreoIByJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCahAuTAAKCRAk1otyXVSH
 0HlNB/9+43On4E+BbI9vpkbolt5vQQbygmbGiXFl4zL1U0jclFZnPrxp2fEF9kPhcTX6AGrLTYp
 4Ucr6zes+3WQfRXlBru0CyQNWo7nwEiyeQvN1slBJSt2OLSBdhmo51TIvWqRM5VVCmtu/THGZsD
 RfcwZyL+sNbDmcuOnt+srffHszyM3MnoLoP8nNA9Z0/3w2YM3/6aIcZEG2rmTjZsIraxBP/vzUY
 w+e+7N81RpkEPQ4/lOF5aGvK6c/gZNXg+TW537dvx/ygoz9vk8nmkM5tyQbF89H3g7Lv81X9ULE
 s/oFXt9bRCPxeHf44QPMDb9gyp7tT2Tftc+6kOkEgtJPigvR
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: 2WAAWPJ4X5DIQ2ZCXV2RR53UOAE5AZVX
X-Message-ID-Hash: 2WAAWPJ4X5DIQ2ZCXV2RR53UOAE5AZVX
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2WAAWPJ4X5DIQ2ZCXV2RR53UOAE5AZVX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 20 May 2026 13:32:43 +0800, jack.yu@realtek.com wrote:
> ASoC: rt722-sdca: Add a control to support CAE firmware update

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/1] ASoC: rt722-sdca: Add a control to support CAE firmware update
      https://git.kernel.org/broonie/sound/c/14b5795b633c

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

