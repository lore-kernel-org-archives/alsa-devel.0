Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C900DC43458
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:15:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0C4F66016C;
	Mon, 29 Jun 2026 14:14:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0C4F66016C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782735304;
	bh=j4tTC8L08dx67eEqwQjX2ZrqrjILr0i7/qz5JeYey7c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=OrjYPsr7fUCsgxQA2FbztbBT40/okcMH8DGX02pOHQ9iGS93z5U3M7Z5cb//VuM8D
	 suX62vDmR9v+UEjmPTI7v+u6987910FbUy7u+yfq5kFVEhsmHew/fnRmml5lIfRWdU
	 Y+HViB7C3xUoq80es0TqoGKB+0+IL67uzq/cF+x0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6BF9CF80601; Mon, 29 Jun 2026 14:14:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 01214F80602;
	Mon, 29 Jun 2026 14:14:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 47371F80495; Mon, 29 Jun 2026 14:14:24 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782735263;
	b=BUorrSEVQqGRZY/ixh03WKhACE+vrvEsm0uy2EtAYkUpNbqhNkEepvKorYm7HpU81X10
	 TCVWUg78tp8WglPMOohsVwt8x5mGeY9feRCUz9UeBWdl59EV+mwRH56jRBF+zXpS64kke
	 6+pZDi8fUj3/Xl0Kup0HPgHjjmMvifxUJzS+rwB3pBzKE7gubFpNyGqc0QSYC1QOpn00W
	 teh6brkBzPZHCwDMKt93LyVan+CgrPm8iJuac8J49ZM/Y7Uz6Ta42+anpBh0F8HOhGiB+
	 KWdshN4tP1vzGyYSJRrk/nuQEs60LmB5zZMukpoiWgvGLWcQJ5G2ok4cW5Ez8XxCN9A==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782735263;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=j4tTC8L08dx67eEqwQjX2ZrqrjILr0i7/qz5JeYey7c=;
	b=aIVU+cXzIujvjf1ADA5zV0bsBq54TZ2iAbNtZA8zeLEpndHRaOMwkThXKdotW4iAxy8f
	 E8XTAEl4w0JTlviovVLJdl0c/o2EzIPEiKWVjg2/VUOCcgXnXBYNllhKoAZ4XnvC8BWT2
	 frMn8oV5rT5T1ejsOvkRAcaiVajPa6ZtJMxDOqg0bdyaUzUMzdeiiVg0lkQ0MirotNBLF
	 xCCrp61dzS6HIAh2xSsRUW7F1naZYLx/12+ZF0owJ+t8/46Kra1LNE1qoNI/aR70Q03Fr
	 hSwhO4QWpZ/UhCKN5fsYWGYeYX/u6mq6ADarxri9caMicwqdRlzxO7P3Bh1k3l3YZoA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="g4AAO4w/";
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 811A0F80423
	for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2026 14:14:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 811A0F80423
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=g4AAO4w/
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2EDCB6001D;
	Mon, 29 Jun 2026 12:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8AA1F000E9;
	Mon, 29 Jun 2026 12:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782735259;
	bh=XeJBYikpzrcLaEXcXwsdkWiCmc3M7uiee5cBFjsu3tI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=g4AAO4w/+Eqb4KcTEar0BztPYyjNoJ196nIwKLHOlqopg+D3NMDjm8Vn46o64TLAc
	 6Lm7BosMl76Y8FmTm/4M1fnWW2osnSraK2elDO5rQXYzwwonZ7hVixUo0Iw/lgQyHH
	 ZJT9zS6fTeMgaGYOssIFv41b2W97hITp4Rh0jnEKlaq1yvGefbiF7Gbu1433w5WWYW
	 BIPedwK/aMGjOri25eB22FY7OItzDfNbU6crsenkuYbktMTSbiuy9U03+yYLO6FU8I
	 +CrV6OcS/CfrCIVPWFSUCQTR2COEdoCfR0+gtgOR1eM9S0qhkMZ60xvy//KD9qRtVm
	 vT02ZPfFqTIqg==
From: Mark Brown <broonie@kernel.org>
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, andriy.shevchenko@linux.intel.com, 13916275206@139.com,
 alsa-devel@alsa-project.org, shenghao-ding@ti.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, k-yi@ti.com,
 henry.lo@ti.com, robinchen@ti.com, niranjan.hy@ti.com
In-Reply-To: <20260625102815.20043-1-baojun.xu@ti.com>
References: <20260625102815.20043-1-baojun.xu@ti.com>
Subject: Re: [PATCH v1] ASoC: tas2781: Update default register address to
 TAS2563
Message-Id: <178239364221.51343.11187259135012325485.b4-ty@b4>
Date: Thu, 25 Jun 2026 14:20:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1129; i=broonie@kernel.org;
 h=from:subject:message-id; bh=j4tTC8L08dx67eEqwQjX2ZrqrjILr0i7/qz5JeYey7c=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqQmGYqab8ptxvjnPu+xehDYkB8UiXBh1H1XAld
 FfY6OjzD8qJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCakJhmAAKCRAk1otyXVSH
 0JWAB/9l8M4VR0E9CAcTdXizgF8VR1T6B0jSizFsFUcuiGZuC5VdEcJiURZ0vaMm8inqMzZIINh
 Cx64xpDXLVPmNX0ELLZhRKyuDY3r/EG2OVVmnpfn8SpdchP07gsHZILUbB93/PeqHLdYMhORG+k
 Jh5uIuN5XW8aliuvYbZTFxFllA9uQ1nUmUmtt0TGNRxwn27gyS/6Choaz41YfBP3+tHGFI1EhEH
 xrBw+kaJU6nx37YKjlwAQp3BcX4BInye3p7YsuqmdzcYS/KpKFh9AsL5plg1T4fkfGt3+brg39p
 3ipQ+OOEq+ogvKy5AG/nRd1L5/DT/f0vswHC326qY6HgJChl
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: JY75D4C7NFB2GZQ6LNC7HLE7IJJB45MN
X-Message-ID-Hash: JY75D4C7NFB2GZQ6LNC7HLE7IJJB45MN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JY75D4C7NFB2GZQ6LNC7HLE7IJJB45MN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 25 Jun 2026 18:28:15 +0800, Baojun Xu wrote:
> ASoC: tas2781: Update default register address to TAS2563

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/1] ASoC: tas2781: Update default register address to TAS2563
      https://git.kernel.org/broonie/sound/c/64184f07e751

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

