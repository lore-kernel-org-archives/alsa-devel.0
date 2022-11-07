Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD707C4332F
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Nov 2022 21:53:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 503E71DB;
	Mon,  7 Nov 2022 22:52:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 503E71DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667857992;
	bh=MHJxzMwCy2ugKCRePP+Ruw83QBTlGEnLIa4Z1gKYNXk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VQUMzT9hwzDx4dyTBwJEjiYCeGaSLdHVJiC+jEW2PP1xSrEtRuBPGVpkd5u9kWP9q
	 qtsnBJHv+5MlC3ucM6/7/rucqswwrFYp34oN5Y1GmRs8PB06/lPLH4x4to7YkldwW4
	 IYPB0HYKYqgXNRqhBYGxA3UQ++2Dm4K1AGayI+kg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D7DB3F8024C;
	Mon,  7 Nov 2022 22:52:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1FBE2F8025A; Mon,  7 Nov 2022 22:52:20 +0100 (CET)
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6F39BF800EC
 for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2022 22:52:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6F39BF800EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de
 header.b="DHdh7GEh"
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E4D4780705;
 Mon,  7 Nov 2022 22:52:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1667857932;
 bh=ukRSwF/sUMBtBQrtKLw4EhZgnm22speWMeM9FmYgEL4=;
 h=From:To:Cc:Subject:Date:From;
 b=DHdh7GEhEM+BmEzmL6tJs4y9kMCAu8eYEfUrTilrYQQeQ5wbntHUYNw/CobX9+Q++
 Soubi5PxqXirvfmXCRqpOhjNEmnOjdg9ye4s4JelhRYrxM3NCya18Tb6sHyriaJxCg
 zVwtiYIbZ+qrLO9MwYfb9bS5J6Y8jbyWEajGQR49GaIu7czukHZtWH+KKaJOGEPtm9
 S6UxyHR4FE0aWYuV/zjkQKXo5/u48/l+cRqLaeGEEsD/Trx3E2OQ6utH5ujyg9gOju
 LB25zLvpLHPTiQQ6QoAXhjVgZN5UHEz0rkMOxPjKqeMstGv1qtIPhmP6lCZ74fxab3
 Ivd/ooQUdicgg==
From: Marek Vasut <marex@denx.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: fsl_sai: Enable transmitter when generating MCLK
Date: Mon,  7 Nov 2022 22:52:01 +0100
Message-Id: <20221107215201.434212-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Cc: Marek Vasut <marex@denx.de>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Shengjiu Wang <shengjiu.wang@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>
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

For SAI to generate MCLK on external SoC pad, the transmitter must be
enabled as well. With transmitter disabled, no clock are generated.
Enable the transmitter using the TERE bit.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
To: alsa-devel@alsa-project.org
---
 sound/soc/fsl/fsl_sai.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 1c9be8a5dcb13..98c62027e5799 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -503,6 +503,10 @@ static int fsl_sai_set_bclk(struct snd_soc_dai *dai, bool tx, u32 freq)
 		/* SAI is in master mode at this point, so enable MCLK */
 		regmap_update_bits(sai->regmap, FSL_SAI_MCTL,
 				   FSL_SAI_MCTL_MCLK_EN, FSL_SAI_MCTL_MCLK_EN);
+
+		/* Transmitter must be enabled to generate MCLK on pad */
+		regmap_update_bits(sai->regmap, FSL_SAI_xCSR(1, ofs),
+				   FSL_SAI_CSR_TERE, FSL_SAI_CSR_TERE);
 	}
 
 	return 0;
@@ -1445,6 +1449,11 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	    sai->soc_data->max_register >= FSL_SAI_MCTL) {
 		regmap_update_bits(sai->regmap, FSL_SAI_MCTL,
 				   FSL_SAI_MCTL_MCLK_EN, FSL_SAI_MCTL_MCLK_EN);
+
+		/* Transmitter must be enabled to generate MCLK on pad */
+		regmap_update_bits(sai->regmap,
+				   FSL_SAI_xCSR(1, sai->soc_data->reg_offset),
+				   FSL_SAI_CSR_TERE, FSL_SAI_CSR_TERE);
 	}
 
 	ret = pm_runtime_put_sync(dev);
-- 
2.35.1

