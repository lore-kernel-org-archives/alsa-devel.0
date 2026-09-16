Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAB2C982CF
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2026 11:33:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2F588601C4;
	Thu, 17 Sep 2026 13:32:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2F588601C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789644786;
	bh=bVU8bp4iIHucX65r0y3mUOPDOCm09oiCFmlXLL3OfCg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=RN2GXRFeO2h4DrDH7aCKRJqtTjkQ39YDl3IK5Fzf7pH7EsIwrHtSQuEecNMdCkAfq
	 LB8A9JfLbq+IpK0Ft6gsNmzA41h/fze1jGjv45pT3Jk7YDCEgHYUvJtPdZ6QMqendc
	 Nnp/YOxFuCmq8Cm530LsAv3eO9M5W9KWmLfmLr8M=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9B9FBF8060C; Thu, 17 Sep 2026 13:32:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4FB9FF80611;
	Thu, 17 Sep 2026 13:32:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1F407F805F5; Thu, 17 Sep 2026 13:32:35 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789644754;
	b=O9gie4TV+asG2JEcHWnJy/gCln7vfASaVi/EPpCpm2O9Y/B4f54r/dzIcoFf/8YoPpIo
	 +UwI/zyJ2OgW4QQdXa1ay8UP21/mlJEhb3homFxtKnXi5Ax5jNAIS3GYY6Z7DP70qpF0L
	 tZVuP387QRMN0PGItgb62bqQOn7v3ZDTq5ASRqVxKNGolIFXXtc2szvDEhJtH/+T7KP3m
	 azqGlo85YhvQCVVr0zui/Oi4l4XJkhKf2V6Sk7bpVxBoKe79dYZRqvRs95WP/btJinOJO
	 jqRnXfqFK0UVI6njEs9yX3ima8+stfhk1Z2i4QyaLA0F7QD7Q+cRxbyBEkkzX76YFmQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789644754;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=bVU8bp4iIHucX65r0y3mUOPDOCm09oiCFmlXLL3OfCg=;
	b=pMTBvp0SpU8kBhsquzKvTOGNre90as5DmmF4kjyE4qC9lXlPmnLMjqTbw3Z/MDa0EAiQ
	 p7o6FBVertuCc3+xiEaBK8O8Wr3DEeDUz/4agED3qU+awVyI5cmR7gs0bZMLSCQz+jZvq
	 SUNNQFP6qBPJdA6E7skOieV93bHibFOLu7vyjvHqXEgtIxpTcuwz9gYMByGx64ggUllhE
	 h51XavdIUv2ts2uiwPDXbjtY73UYKOFARCZHq5rsFMOrrDFClcUrmS2cj7w+Q5ifVKYYR
	 TwovbnLPm4etPBKd1DbqUvsbCGh1VOXT30BbYS/M+mmbeat7K10neWa3xedAC41MQ9Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=NuS3+7HL;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D0204F800C1
	for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2026 13:32:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0204F800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=NuS3+7HL
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C786142DCD;
	Thu, 17 Sep 2026 11:32:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53611F000FF;
	Thu, 17 Sep 2026 11:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789644749;
	bh=fQ8wMCWCIy/WlWl+fLkiP1H94HLWJReXNyPVq5dItoo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=NuS3+7HLpz4N6/Ztuf9i7Ky3ytq7Z9wu/t5P2lm0SxvFQGYJ0HNo4fjp2sFmpfk16
	 CyTOHO0ZblgZeALqV6wSUp+fi1tTii4hKeHTFseS5rw99dQpHnCtTJy93MHTPl7X+Y
	 oNM0aE0bxIEPomy8SPK37VmJjlr/s7xL9x9xQgT4RmBKGd/meDul3nbMuYDOPD51Y1
	 Wr2/5ayOqwndR22xiniCSs92lxzpEzGr7oQQVSv+H6SrS/GdJLtgnhyXqhINwk4xaj
	 MPQlgyYLCepW8mq7dycPAwvjbUW/T4u5G0TAh5PyLBPdJbvBpk8P/+8EC68plFxa6i
	 1YJmU1sjKgfZQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
 Neo Chang <YLCHANG2@nuvoton.com>
Cc: error27@gmail.com, lkp@intel.com, perex@perex.cz,
 krzysztof.kozlowski@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, neo.chang70@gmail.com, kchsu0@nuvoton.com
In-Reply-To: <20260915014940.317403-1-YLCHANG2@nuvoton.com>
References: <20260915014940.317403-1-YLCHANG2@nuvoton.com>
Subject: Re: [PATCH] ASoC: codecs: nau8360: Fix misleading return in
 nau8360_message_to_dsp()
Message-Id: <178958230980.100121.14321855165528287319.b4-ty@b4>
Date: Wed, 16 Sep 2026 19:11:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1159; i=broonie@kernel.org;
 h=from:subject:message-id; bh=bVU8bp4iIHucX65r0y3mUOPDOCm09oiCFmlXLL3OfCg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqq8/JEsVMvTGGLTsQ5wpJxRFi7tRSlF/4yvbkG
 cZR7bfgMGmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaqvPyQAKCRAk1otyXVSH
 0OHAB/98XV4Ty0RKilnS2YbNh25IeCzJ+hTrZ6pRdhMUzH7MDZCw2sK65DVR8XulEVng9y632qQ
 lsbww3Vr2RsA9SnuI4SCsJl4X87FDhT8MGhuevuXbQqpYZ4fLo7bAndh+t2chVWu+B9WM5U7mAK
 4p4IK53Q/6ESsmRngWw3F/g72Ldy8wuJTY/xNim3DW9jm5NbJ2XW3WIwNmF3zl4aa4ctJfpjNKW
 nYkJNErAd0qVwEX+/6ls3aPdcHdXr55K0LRzkYZx4m6fCRHjlDEaplB65HPjlvElKCfqVKtbB3z
 wHW60QRXE7BqczEhExcxsG9UG8ElRQRCeLxdwzziqLIz2x4W
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: FYMV5BOQV73XJNTOZDJFM7U3DZQQK6ZH
X-Message-ID-Hash: FYMV5BOQV73XJNTOZDJFM7U3DZQQK6ZH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FYMV5BOQV73XJNTOZDJFM7U3DZQQK6ZH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 15 Sep 2026 09:49:40 +0800, Neo Chang wrote:
> ASoC: codecs: nau8360: Fix misleading return in nau8360_message_to_dsp()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: codecs: nau8360: Fix misleading return in nau8360_message_to_dsp()
      https://git.kernel.org/broonie/sound/c/ed7d8ed9a915

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

