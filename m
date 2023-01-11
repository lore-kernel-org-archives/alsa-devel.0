Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6D5C54EBC
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Jan 2023 16:04:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B9622930B;
	Thu, 12 Jan 2023 17:03:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B9622930B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673539450;
	bh=0dfNRqDELJzeMbKeK2k3puxktlH9TAfo1+WGxCaJWzw=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=O+SEzXQwdalQS66dU/3NfY86IckqoOoVZsQeNtWOPtsLMDhs8M84ajlrhvoa3Xw5i
	 IUPbjTJJ+ZGPuf2n+HtJLg9bLfmrFSW9zqCfEJxpq8Hb68SdKmqCYmostTOZkdcd+l
	 oxd2FjFfhwHjVUj/eZsRduEjPXnR83BTB39ogzOY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CBDD7F805AA;
	Thu, 12 Jan 2023 16:59:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EE36DF80424; Wed, 11 Jan 2023 17:11:50 +0100 (CET)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DC988F803DC
 for <alsa-devel@alsa-project.org>; Wed, 11 Jan 2023 17:11:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC988F803DC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key, unprotected) header.d=tq-group.com
 header.i=@tq-group.com header.a=rsa-sha256 header.s=key1 header.b=RghrCwOM; 
 dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com
 header.a=rsa-sha256 header.s=key1 header.b=i/TqBNK9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1673453509; x=1704989509;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=c9cpAyHWzxXjJFF8d9KlzwQ1StQxFYBmw6tvDxixwNc=;
 b=RghrCwOM/ZWkbsDu6Ri1sUtVPKlbnmwEE6pK5eRKu1KZBQElXBzAvS3N
 r4yF5sM8yymhlUk3+80ZZj4Z8eDdnri3yAef0DHl6C3u2sihcYajbwdFe
 Oi74jJMHDa+/xGy7xpwRAD2D3wIE0FTMxLgu/zsWuP+uvLMh5+ZiEt04p
 nuc+JKgE+HqSmYIdlAmsN9GcxtCJ8KbtB/RlnqrdpGe8T5fyKIpUZZ6si
 dV7I3Kvp4R6LzfZui8d7qnfnSEgfdBm+75R0As9KQTTRAEv3DmD1j8Qw8
 DP/bbwQe2Ml9pGJqtSGFUKkrHAxn2FwzUg1twtQpbPt/JL6B+iHtTiImH Q==;
X-IronPort-AV: E=Sophos;i="5.96,317,1665439200"; d="scan'208";a="28363764"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
 by mx1-pgp.tq-group.com with ESMTP; 11 Jan 2023 17:11:48 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
 by tq-pgp-pr1.tq-net.de (PGP Universal service);
 Wed, 11 Jan 2023 17:11:48 +0100
X-PGP-Universal: processed;
 by tq-pgp-pr1.tq-net.de on Wed, 11 Jan 2023 17:11:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1673453508; x=1704989508;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=c9cpAyHWzxXjJFF8d9KlzwQ1StQxFYBmw6tvDxixwNc=;
 b=i/TqBNK9qdyc3cvLiA0cZxg4/yFPkYSOhUQU3zGK/47xLCmIOfSUdwdI
 f8AsrNbC49D2ylz/YnlMEsEhQHtVVo92beEvxz52cXu6dD+tP+I09iayT
 cp77FohBCEGfNnsc72JrbnlsGNrmwJibOKgarO14H1tF/+khJMfylS6ig
 jrRiOwhIIi46yiTgNd33/a/p7MQzq3QgUK40zcUk7ilsUfvqoIcMpyLZk
 JRI72sYAtQysxkV4fHEayQ/p2y36iTAQqpXHZMEz+FM39+qRulobUyVNl
 YKMSF2gNw5qwg32T9Uzkm0+XPYQ9zDQdP7YYOsK2pLI8xQlVUKQ/WdsJJ Q==;
X-IronPort-AV: E=Sophos;i="5.96,317,1665439200"; d="scan'208";a="28363763"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
 by mx1.tq-group.com with ESMTP; 11 Jan 2023 17:11:48 +0100
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 9A204280056;
 Wed, 11 Jan 2023 17:11:47 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 1/1] ASoC: fsl_sai: Use dev_err_probe
Date: Wed, 11 Jan 2023 17:11:44 +0100
Message-Id: <20230111161144.3275546-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Jan 2023 16:59:42 +0100
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
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

This helps figuring out why the device probe is deferred, e.g. missing
FSL_EDMA driver.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Old:
root@ls1021:~# cat /sys/kernel/debug/devices_deferred 
sound   fsl-asoc-card: snd_soc_register_card failed: -517
2b50000.sai

New:
root@ls1021:~# cat /sys/kernel/debug/devices_deferred 
sound   fsl-asoc-card: snd_soc_register_card failed: -517
2b50000.sai     fsl-sai: Registering PCM dmaengine failed

 sound/soc/fsl/fsl_sai.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 1c9be8a5dcb13..2a38e2bdf9893 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1458,14 +1458,17 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	if (sai->soc_data->use_imx_pcm) {
 		ret = imx_pcm_dma_init(pdev);
 		if (ret) {
+			dev_err_probe(dev, ret, "PCM DMA init failed\n");
 			if (!IS_ENABLED(CONFIG_SND_SOC_IMX_PCM_DMA))
 				dev_err(dev, "Error: You must enable the imx-pcm-dma support!\n");
 			goto err_pm_get_sync;
 		}
 	} else {
 		ret = devm_snd_dmaengine_pcm_register(dev, NULL, 0);
-		if (ret)
+		if (ret) {
+			dev_err_probe(dev, ret, "Registering PCM dmaengine failed\n");
 			goto err_pm_get_sync;
+		}
 	}
 
 	ret = devm_snd_soc_register_component(dev, &fsl_component,
-- 
2.34.1

