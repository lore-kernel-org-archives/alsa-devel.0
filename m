Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A08BC43334
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Jul 2022 15:59:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 48016171D;
	Mon,  4 Jul 2022 17:58:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 48016171D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656950368;
	bh=U8MDGOj5FFXPmmfgfJbJQRYIZ1IcA2PZQe3iwee1+MU=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fYiKnpsn6Njp89iQg29Mchz+vg/4VdRrXgrzvXEGPeX7qhamGJIUHYWi2REmO3q5X
	 tlXnITHxrI8ycl2G7GQZ+Bh0+/iA31u1Dp5nZOrlYEj4hdc2s8wdK7rWCAV0A5sxoi
	 EC6wJYfUDSgYJFLVRaybPeGs/B7rZTwAm3k9QyMk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5F7BFF80539;
	Mon,  4 Jul 2022 17:57:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A2E25F8053A; Mon,  4 Jul 2022 17:57:55 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3BF56F80141
 for <alsa-devel@alsa-project.org>; Mon,  4 Jul 2022 17:57:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3BF56F80141
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="CPXLe+X/"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 80DD360ECD;
 Mon,  4 Jul 2022 15:57:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B532FC3411E;
 Mon,  4 Jul 2022 15:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1656950267;
 bh=U8MDGOj5FFXPmmfgfJbJQRYIZ1IcA2PZQe3iwee1+MU=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=CPXLe+X/cFRMSPP98YaMuV5SxF1tYOewYdWdS3Z9akQyKIiuD4X14jAUlYmYy5frl
 Y3Ws72Q8d/WckikWAUlbJ4SVBIFZErMmfmvwiHM+lL+7cEj2qf8KKnZpo7iZRshfs9
 ydGuO0wkShAk9EXR7u8hreywhMnhu4gYERfvl+9RBgJeQW2x3wqMKv/koJFrgLtYPW
 9L8RLGgTfk+v0mVf59chXtXh3m3C62obqYBOE69XTK3mevWOZh4CJTSiWz0CgaQ1PH
 0QpB/9GfQeG1V8c+T43I3bYMKInZIYCOoKKRWKDeb2h4h6zh6tEtW0Bop4R8sfvd0x
 itszqJeo+sDgA==
From: Mark Brown <broonie@kernel.org>
To: robh+dt@kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 airlied@linux.ie, Eugeniy.Paltsev@synopsys.com,
 krzysztof.kozlowski+dt@linaro.org, sam@ravnborg.org,
 Liam Girdwood <lgirdwood@gmail.com>, daniel@ffwll.ch, palmer@dabbelt.com,
 palmer@rivosinc.com, conor@kernel.org, daniel.lezcano@linaro.org,
 vkoul@kernel.org, fancer.lancer@gmail.com
In-Reply-To: <20220701192300.2293643-1-conor@kernel.org>
References: <20220701192300.2293643-1-conor@kernel.org>
Subject: Re: (subset) [PATCH v4 00/14] Canaan devicetree fixes
Message-Id: <165695026144.481068.15330746749392879216.b4-ty@kernel.org>
Date: Mon, 04 Jul 2022 16:57:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 aou@eecs.berkeley.edu, niklas.cassel@wdc.com, damien.lemoal@opensource.wdc.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 conor.dooley@microchip.com, joabreu@synopsys.com, geert@linux-m68k.org,
 paul.walmsley@sifive.com, dmaengine@vger.kernel.org,
 linux-riscv@lists.infradead.org, dillon.minfei@gmail.com, masahiroy@kernel.org
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

On Fri, 1 Jul 2022 20:22:46 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Hey all,
> This series should rid us of dtbs_check errors for the RISC-V Canaan k210
> based boards. To make keeping it that way a little easier, I changed the
> Canaan devicetree Makefile so that it would build all of the devicetrees
> in the directory if SOC_CANAAN.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[03/14] ASoC: dt-bindings: convert designware-i2s to dt-schema
        commit: bc4c9d85179ca90679c8bb046cf7aad16fb88076

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
