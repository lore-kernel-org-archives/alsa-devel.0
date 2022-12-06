Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C82C352A1
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Dec 2022 09:51:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 170861898;
	Tue,  6 Dec 2022 10:50:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 170861898
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670320292;
	bh=TqBnjsY6W9h8nVSTWhKJucNnSNV9DfSlrfaeFN+ZBDM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SShM6TwpY3f6BPgDIyv2dXpQY1/hm2R4CMvnry6Xcd3s6TieM8vNrnAOsTNkJy4iM
	 olYCs7qzrvDncU6qA5ZxwQjNYDQXnYFMDRO5MKsDsERyWzm2sHivuuCp1wLu9qM5zP
	 U6eanxhrlre+IWG9TjE3WhdvCdUPG+vJg+QZeYrc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E6450F8057A;
	Tue,  6 Dec 2022 10:50:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 47D72F80564; Tue,  6 Dec 2022 10:50:07 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 370E1F80564
 for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2022 10:50:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 370E1F80564
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Tuhr277J"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id A97D9B818E3;
 Tue,  6 Dec 2022 09:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CADC433C1;
 Tue,  6 Dec 2022 09:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670320199;
 bh=TqBnjsY6W9h8nVSTWhKJucNnSNV9DfSlrfaeFN+ZBDM=;
 h=From:To:Cc:Subject:Date:From;
 b=Tuhr277J49r+XybroMGnii1O6GQF3TSQ/eyFx2FfI77tszZwki0W/s/yLdQ7sDpft
 rvccw2ylRscyIMl/vMixKKYst416i/MeLISCcBimMYZ1lY8AyQqPYvSvq5yEH9CNu8
 lqOzkqCzk8UxoqkIaTxy3ovewNlcztcRLo3naJWoWJsIl2rmP/gPn1/F9Lp+oczyvY
 DQwDz+OJP6b4Lwg2E2LCWLl9UCj5L+RlssGqlwbYwyqZjxSRvX4BY0SM46afSOt8qt
 dSxGnSA/2pooP7vRxlhBussdMrpRlDnq7FL29bgLk2R/WwtOTuy3v/kSt9m9d0nKjm
 c/Owtx+g5Ixnw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 01/12] ASoC: fsl_micfil: explicitly clear
 software reset bit
Date: Tue,  6 Dec 2022 04:49:43 -0500
Message-Id: <20221206094955.987437-1-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Xiubo.Lee@gmail.com, linuxppc-dev@lists.ozlabs.org,
 Shengjiu Wang <shengjiu.wang@nxp.com>, tiwai@suse.com, lgirdwood@gmail.com,
 Mark Brown <broonie@kernel.org>, shengjiu.wang@gmail.com
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

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit 292709b9cf3ba470af94b62c9bb60284cc581b79 ]

SRES is self-cleared bit, but REG_MICFIL_CTRL1 is defined as
non volatile register, it still remain in regmap cache after set,
then every update of REG_MICFIL_CTRL1, software reset happens.
to avoid this, clear it explicitly.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Link: https://lore.kernel.org/r/1651925654-32060-1-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_micfil.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 9f90989ac59a..cb84d95c3aac 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -191,6 +191,17 @@ static int fsl_micfil_reset(struct device *dev)
 		return ret;
 	}
 
+	/*
+	 * SRES is self-cleared bit, but REG_MICFIL_CTRL1 is defined
+	 * as non-volatile register, so SRES still remain in regmap
+	 * cache after set, that every update of REG_MICFIL_CTRL1,
+	 * software reset happens. so clear it explicitly.
+	 */
+	ret = regmap_clear_bits(micfil->regmap, REG_MICFIL_CTRL1,
+				MICFIL_CTRL1_SRES);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
2.35.1

