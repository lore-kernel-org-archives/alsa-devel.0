Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AC5C54EAA
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Jan 2023 21:01:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 395E2E77;
	Mon, 30 Jan 2023 22:00:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 395E2E77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675112503;
	bh=0qCJs9x+zx7S/aIAKZoN20zb3eVW8TP2fNPskc4zsFI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=NayashMreOQg4gVUkLhd/Y8H/YMI5Re/WRHBV9UWt4d14Or/arhVaEj2877pnZvUC
	 iEHnVd2D3BIyksp972dvK4H09tmoPg0B2GTxfEYl4VlHCj4XAQ+mM74qIrPzrsjnsQ
	 4alyIsOiFjPAK4uPQ1/UdGdJSZEtqg6g7byk4bos=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 05A92F80552;
	Mon, 30 Jan 2023 22:00:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 818E9F80552; Mon, 30 Jan 2023 22:00:21 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 67622F8045D
 for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2023 22:00:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 67622F8045D
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=dW5zXp+w
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9F38B61263;
 Mon, 30 Jan 2023 21:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97280C433D2;
 Mon, 30 Jan 2023 21:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1675112412;
 bh=0qCJs9x+zx7S/aIAKZoN20zb3eVW8TP2fNPskc4zsFI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=dW5zXp+wTF0m5Cl5G2k5/bxOp7QKsCfHltK1ATA0LFpGExD2s/aXfCwvUZOD+AL+l
 sVUHIY/snYS533s+4ZPRQcr2DQBf/i/ulp56px7D5pNdTGGMlXgUFJhQUOzeBz7eW+
 4gf8WkaorlU1Fd6O2lEPeuHcyDiDty4A2IdpMaDtG8KFBdEN7Bzx5AzqbJoQJotBc4
 XjyisQV0z4XmU3IKU02KHLRJujlgcdP7MOfQ6M8jLYMRnTbrqNIu+izlZMsumGzpr1
 PJq0gzAyScgd5VTNbEwZMm/FF9t/ZPon99opINQNSvEl9FyElBt03hGFuckwgZJSDY
 nzV6F/F1guIdA==
From: Mark Brown <broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>
In-Reply-To: <20230105144145.165010-1-marex@denx.de>
References: <20230105144145.165010-1-marex@denx.de>
Subject: Re: (subset) [PATCH 1/2] ASoC: dt-bindings: fsl-sai: Simplify the
 VFxxx dmas binding
Message-Id: <167511240513.2141894.10630659697412696608.b4-ty@kernel.org>
Date: Mon, 30 Jan 2023 21:00:05 +0000
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
Cc: Peng Fan <peng.fan@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Alexander Stein <alexander.stein@ew.tq-group.com>, alsa-devel@alsa-project.org,
 Stefan Agner <stefan@agner.ch>, Liam Girdwood <lgirdwood@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Fabio Estevam <festevam@gmail.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Paul Elder <paul.elder@ideasonboard.com>, NXP Linux Team <linux-imx@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
 Richard Zhu <hongxing.zhu@nxp.com>, Richard Cochran <richardcochran@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Adam Ford <aford173@gmail.com>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Lucas Stach <l.stach@pengutronix.de>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Thu, 05 Jan 2023 15:41:44 +0100, Marek Vasut wrote:
> Get rid of the vf610 sai special case, instead update the vfxxx.dtsi
> DT to use the same DMA channel ordering as all the other devices. The
> sai DMA channel ordering has not been aligned with other IP DMA channel
> ordering in the vfxxx.dtsi anyway.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: fsl-sai: Simplify the VFxxx dmas binding
      commit: 21d64f6f63eeca9f136ac514ca801a5a6485cd78

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

