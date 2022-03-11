Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B19AC433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Mar 2022 20:25:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 842A11A5F;
	Fri, 11 Mar 2022 21:24:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 842A11A5F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647030298;
	bh=0Q2U7gB1v+g5WWvIldVX0hUeSGrWPkJ2QT7hjn6A0Yo=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OQVcnxKXq9e6FwBsy8csUvPzxMIszRCcp1zJ8FKUjK6I7CxxV3QV6dd3v5QwwT9jT
	 nnZ4yVuwjzLx5BnNSSqCt6VRj50WeOtJrxirsPahqoIO/OZSA56eDyFR7tqzNVozvv
	 pKSMimLqjwpWKOikQUGSsdxYd9r1SiiK9k0AdMuk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 84BD6F8051D;
	Fri, 11 Mar 2022 21:22:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 31D23F80085; Fri, 11 Mar 2022 21:22:49 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C51B9F80085
 for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2022 21:22:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C51B9F80085
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="QrVweqGe"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 255CCB82CFB;
 Fri, 11 Mar 2022 20:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550CCC340EC;
 Fri, 11 Mar 2022 20:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647030164;
 bh=0Q2U7gB1v+g5WWvIldVX0hUeSGrWPkJ2QT7hjn6A0Yo=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=QrVweqGe+GyInwxsZiO6a4v37m+fStgNRwpgwYYe+wdYOpr1QEr16v3JBShPhcu5W
 p5gWAnI70O7KmRuOEcFUAwUyAdWVHSPo55JRgeKkPx8o+192p2lGZzVufBe6r3oxx+
 Kne4VEGgJsx0iz9PaGLGyiWFoBSplemkoNSdyQRy5DUauhKU3PS/GWroxfJ9eJOSqp
 QPV1tOfIGrfYFouBVYCnwcg0QKAALVZRhJEEh15pIS39J/inyGYGt+JqSMAncpeZ+y
 4SnLMiQJapma1nhXZj2Z2Av+xjEY1L13ioaoICTX2PxFF5grbbXdfkTKakC8JWapVc
 Jb2xQlBUVGPlQ==
From: Mark Brown <broonie@kernel.org>
To: perex@perex.cz, ludovic.desroches@microchip.com, tiwai@suse.com,
 alexandre.belloni@bootlin.com, lgirdwood@gmail.com,
 nicolas.ferre@microchip.com, Claudiu Beznea <claudiu.beznea@microchip.com>,
 codrin.ciubotariu@microchip.com
In-Reply-To: <20220311112818.1482372-1-claudiu.beznea@microchip.com>
References: <20220311112818.1482372-1-claudiu.beznea@microchip.com>
Subject: Re: [PATCH] ASoC: mchp-spdifrx: fix typo
Message-Id: <164703016207.264137.16463689754378807280.b4-ty@kernel.org>
Date: Fri, 11 Mar 2022 20:22:42 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

On Fri, 11 Mar 2022 13:28:18 +0200, Claudiu Beznea wrote:
> Fix typo in log describing failure of devm_snd_dmaengine_pcm_register().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mchp-spdifrx: fix typo
      commit: 886e09c77d2b48559d26928a5705a20ef3ac117d

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
