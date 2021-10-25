Return-Path: <SRS0=4dkw=PN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B6BC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 16:41:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B69D560F6F
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 16:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B69D560F6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C30FD16D9;
	Mon, 25 Oct 2021 18:41:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C30FD16D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635180113;
	bh=n5jXr5DbnDX7GorTe71SFdt+WecgsSmfJCkOC7hSvO4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DPV2p3oHJ19d4CN3/HxPCpAleJms2c9zeGSYsqCThiGbEQMJAwZ7HwDsTsSPQUHzQ
	 HIpCyRQRNts66rRE5hMu0hQcQ/Wz37C3mpL2gQr7xq8U6f91CdlUrfwy6atrOGPWkd
	 GixELX7Ire39l6qZ5fp9a/II3c4vwWcrPl6u6QVg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D1C7DF804EC;
	Mon, 25 Oct 2021 18:39:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5A3A9F8025E; Mon, 25 Oct 2021 18:39:48 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 808D0F80431
 for <alsa-devel@alsa-project.org>; Mon, 25 Oct 2021 18:39:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 808D0F80431
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="IlU/NnkL"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 792B460EB9;
 Mon, 25 Oct 2021 16:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635179983;
 bh=n5jXr5DbnDX7GorTe71SFdt+WecgsSmfJCkOC7hSvO4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IlU/NnkLpjf3aJuwcvFtFhzJASA9jYZiovR5qFNPWI8oP/XdwIuHKayzi2xREU8Ec
 Rd9Fq0F6uHy1XK/ZjdSV32+lZzDPyVnMbjcstGjAOeGmjtWDKqtLGYKnJUX/92DAaC
 SPneeckGvnQiQDdvcnqvCswzimdDFW+axqpT033XJkrLuVd7Vcxa/57J5tVjwNGXvr
 HgJHApzEyLeDUeGmrZk7JFTQLwVmk/hwWTwwmT25WgiCGEv6g5WeBG5GyKb0LRImus
 kzbZl6jT30A4Qrb5cmIO27tD5Tdp5CSOudbISM+sOEcAcqbuLhBqYjJYJumqFj2C3u
 34tLvzZvh8uQw==
From: Mark Brown <broonie@kernel.org>
To: Adam Ford <aford173@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 patches@opensource.cirrus.com, Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] ASoC: wm8962: Convert to devm_clk_get_optional()
Date: Mon, 25 Oct 2021 17:39:23 +0100
Message-Id: <163517996156.3558038.2022301808170066410.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <c2a8a1a628804a4439732d02847e25c227083690.1634565564.git.geert+renesas@glider.be>
References: <c2a8a1a628804a4439732d02847e25c227083690.1634565564.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: linux-renesas-soc@vger.kernel.org, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Mon, 18 Oct 2021 16:01:11 +0200, Geert Uytterhoeven wrote:
> Use the existing devm_clk_get_optional() helper instead of building a
> similar construct on top of devm_clk_get() that fails to handle all
> errors but -EPROBE_DEFER.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm8962: Convert to devm_clk_get_optional()
      commit: 044c114014435fa723e2a0540cb7ef55d2c812da

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
