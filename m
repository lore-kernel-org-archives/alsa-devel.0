Return-Path: <SRS0=nNdU=W2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82770C3A5A4
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Aug 2019 11:50:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0919921721
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Aug 2019 11:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DXXA1WC1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="rFflmqWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0919921721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5A3B1166F;
	Fri, 30 Aug 2019 13:49:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5A3B1166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567165816;
	bh=VqVGH6rqP0m0IJV3PQGTUa2FJhgryV33mnaxrx8qvGw=;
	h=From:To:In-Reply-To:Date:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=DXXA1WC1liDz6GQerBxBsEilcqL/sQ2ckm2hXwbKhZqoHZYhFV/MFscXCOmAfgUrv
	 Uh8kWCJvbVElMIMFQIyC5rdjXptt0UtSXydu7NWe7fxjoaDl1Zr1l8xoPKrHVi7V9d
	 qXFqOGRhnNLlaars1pq1acYVBxIgIqoD2gOFEpBc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 31750F80639;
	Fri, 30 Aug 2019 13:45:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5147FF80600; Fri, 30 Aug 2019 13:45:30 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3AB65F8036C
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2019 13:45:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3AB65F8036C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="rFflmqWU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=l68QFNdu1EXdp5qT796OwRuGerPX7eKQpeISah7vZXI=; b=rFflmqWU+YBt
 N+tpmJ+sSQwl2Z9U/fW6j8zqoy+RNK9NMAo9fRIjWQBFPvONlDVlvyJuC2yV2LpTm4K75vtkYo84M
 JbPNtKZcPb+wBfsUCcSNcwfXQYD37t/prkvOhKtxY802z1s4wHPp/3GN6R9LQGWfF4PjT56jAYVcf
 FToSE=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1i3fLD-0006Ig-Iq; Fri, 30 Aug 2019 11:45:19 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id C2A672742CA1; Fri, 30 Aug 2019 12:45:18 +0100 (BST)
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
In-Reply-To: <20190830103841.25128-4-peter.ujfalusi@ti.com>
X-Patchwork-Hint: ignore
Message-Id: <20190830114518.C2A672742CA1@ypsilon.sirena.org.uk>
Date: Fri, 30 Aug 2019 12:45:18 +0100 (BST)
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 nsekhar@ti.com, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
Subject: [alsa-devel] Applied "ASoC: ti: edma-pcm: Fix for legacy
	dma_slave_map based channel lookup" to the asoc tree
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
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Message-ID: <20190830114518.VzZbzUm3cmjbcT01WQKdeHFKvN2zqY4KOUuSqCi2Fmg@z>

The patch

   ASoC: ti: edma-pcm: Fix for legacy dma_slave_map based channel lookup

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

From 27b7def93aaba0838eb90e6b3c3110a856bb09fc Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Fri, 30 Aug 2019 13:38:40 +0300
Subject: [PATCH] ASoC: ti: edma-pcm: Fix for legacy dma_slave_map based
 channel lookup

Most of the daVinci devices does not boot with DT. In this case the DMA
channel is looked up with dma_slave_map and for that the chan_names[]
must be configured.

Both McASP and ASP/McBSP uses "tx" and "rx" as channel names, so we can
just do this when the dev->of_node is not valid.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/20190830103841.25128-4-peter.ujfalusi@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/edma-pcm.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/sound/soc/ti/edma-pcm.c b/sound/soc/ti/edma-pcm.c
index 3ebea1bd15cb..634b040b65f0 100644
--- a/sound/soc/ti/edma-pcm.c
+++ b/sound/soc/ti/edma-pcm.c
@@ -39,7 +39,22 @@ static const struct snd_dmaengine_pcm_config edma_dmaengine_pcm_config = {
 
 int edma_pcm_platform_register(struct device *dev)
 {
-	return devm_snd_dmaengine_pcm_register(dev, &edma_dmaengine_pcm_config, 0);
+	struct snd_dmaengine_pcm_config *config;
+
+	if (dev->of_node)
+		return devm_snd_dmaengine_pcm_register(dev,
+						&edma_dmaengine_pcm_config, 0);
+
+	config = devm_kzalloc(dev, sizeof(*config), GFP_KERNEL);
+	if (!config)
+		return -ENOMEM;
+
+	*config = edma_dmaengine_pcm_config;
+
+	config->chan_names[0] = "tx";
+	config->chan_names[1] = "rx";
+
+	return devm_snd_dmaengine_pcm_register(dev, config, 0);
 }
 EXPORT_SYMBOL_GPL(edma_pcm_platform_register);
 
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
