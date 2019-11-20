Return-Path: <SRS0=+StP=ZM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E529C432C0
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:22:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1240820895
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sGRVs+tJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1240820895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 037FD1730;
	Wed, 20 Nov 2019 18:21:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 037FD1730
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574270537;
	bh=6eU+RziTSYM25wgV7+gkz0a68v2v2G2Qg2271gZB9ns=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=sGRVs+tJXJb51RYNWsGBrlKsg6vt8yubepfQ8SXyRFXPSaWE/Mj65jXJlvdiXo7dW
	 I1XquWohAfkqCe+PHXemujuPbhAUg0LcycoDnK0fgmlLMA7BH9FO6qFv8NT7+DBgWN
	 oCAQQQPSDRmvGmvNdSDHy/RAHWN5pEY1T5Ut7U20=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D9EAF801EC;
	Wed, 20 Nov 2019 18:18:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B7424F8014F; Wed, 20 Nov 2019 18:18:15 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 1E364F8014D
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2019 18:18:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1E364F8014D
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 090B51045;
 Wed, 20 Nov 2019 09:18:12 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BD1E3F703;
 Wed, 20 Nov 2019 09:18:11 -0800 (PST)
Date: Wed, 20 Nov 2019 17:18:09 +0000
From: Mark Brown <broonie@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>
In-Reply-To: <20191120060844.224607-2-tzungbi@google.com>
Message-Id: <applied-20191120060844.224607-2-tzungbi@google.com>
X-Patchwork-Hint: ignore
Cc: tzungbi@google.com, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, dgreid@google.com, cychiang@google.com
Subject: [alsa-devel] Applied "ASoC: core: add SND_SOC_BYTES_E" to the asoc
	tree
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The patch

   ASoC: core: add SND_SOC_BYTES_E

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

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

From fb5126778333d289b2623a7e6260beeb1ac1b819 Mon Sep 17 00:00:00 2001
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Wed, 20 Nov 2019 14:08:43 +0800
Subject: [PATCH] ASoC: core: add SND_SOC_BYTES_E

Add SND_SOC_BYTES_E to accept getter and putter.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
Link: https://lore.kernel.org/r/20191120060844.224607-2-tzungbi@google.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index bd943b5d7d45..c28a1ed5e8df 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -299,6 +299,12 @@
 	.put = snd_soc_bytes_put, .private_value =	      \
 		((unsigned long)&(struct soc_bytes)           \
 		{.base = xbase, .num_regs = xregs }) }
+#define SND_SOC_BYTES_E(xname, xbase, xregs, xhandler_get, xhandler_put) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = snd_soc_bytes_info, .get = xhandler_get, \
+	.put = xhandler_put, .private_value = \
+		((unsigned long)&(struct soc_bytes) \
+		{.base = xbase, .num_regs = xregs }) }
 
 #define SND_SOC_BYTES_MASK(xname, xbase, xregs, xmask)	      \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname,   \
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
