Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D012C2BD09
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Jun 2024 12:49:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 72DCE20C0;
	Thu, 27 Jun 2024 14:48:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 72DCE20C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1719492549;
	bh=ZSLfv18TPLtxO7NM7kuw1m/QWZeg3i2KDlFZOp8uhPI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=SmHR1g2Dwo8ZoUwf0qeMwRsVDg+D65vjOY4HmUG8k+UVQy032hmKYqTJoHuLnjRsV
	 skj2QJtIshI+3CShsSsgG43gvIbFyiRlHuaNkSAtZ6wvE8l478DWmBuf1Vmj7TKuDk
	 I4FatTbCpfaWMWWYIXfrS8XU8qN8Bc6eGjyD40KQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 42189F805D9; Thu, 27 Jun 2024 14:48:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 35EDEF805D6;
	Thu, 27 Jun 2024 14:48:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F35A5F80154; Thu, 27 Jun 2024 14:48:13 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8D2D2F800E4
	for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2024 14:48:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8D2D2F800E4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=BOJvLtm1
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 30E4FCE2E9D;
	Thu, 27 Jun 2024 12:48:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B8DC32786;
	Thu, 27 Jun 2024 12:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719492480;
	bh=ZSLfv18TPLtxO7NM7kuw1m/QWZeg3i2KDlFZOp8uhPI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BOJvLtm1GkcoTRy+WOzgbU7r/Oe/0Xz7nvroqA5qLxEgzWByDvUGsa2qMpVrcTPKK
	 7FK8JrKCosMIWiE2y+Gx/KXbnJ/C/eRqb9Av98AV62xyizopNUlqjhyr5O13KawpmR
	 bB32IO/nGX5uE6L2lXNZYCVQxgW8cEK1WrjhlMyyZYVbnvkn2KXA+W7WTSq6wGWN8j
	 DiDAUYqYoTGkHbVaUkp3qDTb+P+rceX5VEb+A6+ge4u1HtIlyqPA1wGgXge1E26CZg
	 HrWi3t6jKAiTIQmHzXwO2RDTsHg9/jRC/d3tMtysaH2P7NMFCrxIZ6NKIJhYmkWIpt
	 AXhkM9FnO25QQ==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-sound@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: viorel.suman@nxp.com
In-Reply-To: <1718174452-17596-1-git-send-email-shengjiu.wang@nxp.com>
References: <1718174452-17596-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 0/3] ASoC: imx-audmix: Split capture device to be a new
 device
Message-Id: <171949247673.260548.13585472243049698949.b4-ty@kernel.org>
Date: Thu, 27 Jun 2024 13:47:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707
Message-ID-Hash: XC34KIVL7UWUNMKOOJFJXG55JKYTWKKP
X-Message-ID-Hash: XC34KIVL7UWUNMKOOJFJXG55JKYTWKKP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XC34KIVL7UWUNMKOOJFJXG55JKYTWKKP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 12 Jun 2024 14:40:49 +0800, Shengjiu Wang wrote:
> The transmitter and receiver part of the SAI interface need to be
> configured with different master/slave mode, especially to work
> with the audiomix module.
> 
> The SAI1 TX is in master mode, but SAI1 RX is in slave mode.
> So add another two DAIs for TX and RX separately in fsl_sai driver.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: fsl_sai: Add separate DAI for transmitter and receiver
      commit: 15c958390460f964ec707ae6c5d1843638ebfe69
[2/3] ASoC: fsl_audmix: Split playback and capture stream to different DAI
      commit: 6232a7eb1afc842d0daf1c0314e1eda65731783f
[3/3] ASoC: imx-audmix: Split capture device for audmix
      commit: 05d996e113481fdd9ac40ccf5cadabd1e73f2404

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

