Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA120C05027
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Jan 2023 16:44:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EF3C8E73;
	Mon, 23 Jan 2023 17:44:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EF3C8E73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674492293;
	bh=JmW7ERfPWXKm8wFtciy8l7lBJ/Sw3XypeD7gPISuKyY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=c7W4anPq001XVD/8cUVxXMrc8iDDo2Bub9mDvCAcCPd3JXM7CWBOTLaiEj3zKM2Tt
	 tdl7v8Lu7rQt8MPzUcOY5p2MBHZcs6LwRJ0s5G+dKShbXAWd44t0EBVBinPUGUD2Ne
	 w+HlXSV87ym4Soxma4z0PZCb20EF1z8S8W1d7tPE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 412D0F80548;
	Mon, 23 Jan 2023 17:43:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BB92CF8053D; Mon, 23 Jan 2023 17:43:09 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79661F80515
 for <alsa-devel@alsa-project.org>; Mon, 23 Jan 2023 17:43:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 79661F80515
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Crjh49DX
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 256ED60FBD;
 Mon, 23 Jan 2023 16:43:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9503C4339C;
 Mon, 23 Jan 2023 16:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1674492186;
 bh=JmW7ERfPWXKm8wFtciy8l7lBJ/Sw3XypeD7gPISuKyY=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=Crjh49DXCdmPmqVDmSNvRrnl6Mqg3DbPTsE8OHDkG8CB3A6uEdCAeh8+JgwPZaLZJ
 JVsgUaCK97elgZnRd8v+d/Gtg59vD3KrslYWFNXGw1FcIFMOMGxeQ9gaaXDLJxvGYl
 hF4V3k9nOGU1lTilmArbwKFYYXe66eWhRmykY1bdVp0wz9dABtR5v/xOF24MTRfO5y
 OHPCdFKEBZS7M37fYlMMatTbR4zOwW2cRxKlpFQWo9p3XF6aAPbMrs2PZS0zDv+ldw
 RZ5dBhc7TuHqiVEL95Q3f3qKWbku7N43nSmtNO7sXbJu2X6vcUGczTifVC5j9TG+QS
 uuj3IuYLAXjEw==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 alsa-devel@alsa-project.org, Faiz Abbas <faiz.abbas@arm.com>
In-Reply-To: <20230105160346.29018-1-faiz.abbas@arm.com>
References: <20230105160346.29018-1-faiz.abbas@arm.com>
Subject: Re: [PATCH] ASoC: dt-bindings: simple-card: Document
 simple-audio-card,plat
Message-Id: <167449218337.1484410.12928081501203145393.b4-ty@kernel.org>
Date: Mon, 23 Jan 2023 16:43:03 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
 Deepak.Pandey@arm.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 Anurag.Koul@arm.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Thu, 05 Jan 2023 21:33:46 +0530, Faiz Abbas wrote:
> The simple card driver has support for adding cpu, codec and platform
> nodes with the simple-audio-card prefix. Add documentation for the plat
> binding.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: simple-card: Document simple-audio-card,plat
      commit: e7e2b92e609f82cd164209509f852de941e1285b

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

