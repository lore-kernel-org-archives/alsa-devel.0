Return-Path: <SRS0=Aorx=C2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B7EC35263
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 12:06:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33D4A21974
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 12:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kk+lSP+t";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnq60uFp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D4A21974
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 65364165D;
	Thu, 17 Sep 2020 14:05:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 65364165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600344404;
	bh=78qtzeKRkRNwsvQiXtOt2CVpYBGVSGTOPg60lRX+q4Q=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kk+lSP+tBbXc6erS4kNHNwX698pVylQTzgsXnh0cp0KHUYo+rRWiC5YmbLB9o9h6u
	 dbrg/igp+5nJ1FLKiGP8tgzb5X0oqtVQGac7fgwRkrmNqsH0pHYqlWEUO37hPPEgqo
	 rRgzr4sySSWJ4ATLjNulSrBUppQ4VDv87EoCy5Yw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4A4A3F802E1;
	Thu, 17 Sep 2020 14:02:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DF532F802FE; Thu, 17 Sep 2020 14:02:15 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BF739F802E1
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2020 14:02:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BF739F802E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="cnq60uFp"
Received: from localhost.localdomain (unknown [136.185.111.192])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3C21721D7F;
 Thu, 17 Sep 2020 12:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600344127;
 bh=78qtzeKRkRNwsvQiXtOt2CVpYBGVSGTOPg60lRX+q4Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cnq60uFpdMbhblMaErMXp+Z3mVJnxPIIh83cD6vyvHQ9eaG/hfFDrTCJef1rCidke
 65xpwvUYxkqVUqeFKHbX79GLqOaLHvwlpl1fRM7xO4Krp+ao3D5jfDHU5Y8n0azli0
 mRjwrwLQtZjVE+m169Kg6mjYnvQHvQP1sl/Pv3E0=
From: Vinod Koul <vkoul@kernel.org>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 2/2] soundwire: intel: use {u32|u16}p_replace_bits
Date: Thu, 17 Sep 2020 17:31:46 +0530
Message-Id: <20200917120146.1780323-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200917120146.1780323-1-vkoul@kernel.org>
References: <20200917120146.1780323-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Vinod Koul <vkoul@kernel.org>
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

FIELD_PREP() does not replace the bits so it is not apt in case where we
modify a register.

Use u32_replace_bits() or u16_replace_bits() instead.

Fixes: 3b4979cabd4b ("soundwire: intel: use FIELD_{GET|PREP}")
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soundwire/intel.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index e047910d73f5..5a5a645bdb3f 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -329,7 +329,7 @@ static int intel_link_power_up(struct sdw_intel *sdw)
 
 		/* set SyncPRD period */
 		sync_reg = intel_readl(shim, SDW_SHIM_SYNC);
-		sync_reg |= FIELD_PREP(SDW_SHIM_SYNC_SYNCPRD, syncprd);
+		u32p_replace_bits(&sync_reg, syncprd, SDW_SHIM_SYNC_SYNCPRD);
 
 		/* Set SyncCPU bit */
 		sync_reg |= SDW_SHIM_SYNC_SYNCCPU;
@@ -448,7 +448,7 @@ static int intel_shim_init(struct sdw_intel *sdw, bool clock_stop)
 
 	intel_shim_glue_to_master_ip(sdw);
 
-	act |= FIELD_PREP(SDW_SHIM_CTMCTL_DOAIS, 0x1);
+	u16p_replace_bits(&act, 0x1, SDW_SHIM_CTMCTL_DOAIS);
 	act |= SDW_SHIM_CTMCTL_DACTQE;
 	act |= SDW_SHIM_CTMCTL_DODS;
 	intel_writew(shim, SDW_SHIM_CTMCTL(link_id), act);
@@ -712,9 +712,9 @@ intel_pdi_shim_configure(struct sdw_intel *sdw, struct sdw_cdns_pdi *pdi)
 	else
 		pdi_conf &= ~(SDW_SHIM_PCMSYCM_DIR);
 
-	pdi_conf |= FIELD_PREP(SDW_SHIM_PCMSYCM_STREAM, pdi->intel_alh_id);
-	pdi_conf |= FIELD_PREP(SDW_SHIM_PCMSYCM_LCHN, pdi->l_ch_num);
-	pdi_conf |= FIELD_PREP(SDW_SHIM_PCMSYCM_HCHN, pdi->h_ch_num);
+	u32p_replace_bits(&pdi_conf, pdi->intel_alh_id, SDW_SHIM_PCMSYCM_STREAM);
+	u32p_replace_bits(&pdi_conf, pdi->l_ch_num, SDW_SHIM_PCMSYCM_LCHN);
+	u32p_replace_bits(&pdi_conf, pdi->h_ch_num, SDW_SHIM_PCMSYCM_HCHN);
 
 	intel_writew(shim, SDW_SHIM_PCMSYCHM(link_id, pdi->num), pdi_conf);
 }
@@ -734,8 +734,8 @@ intel_pdi_alh_configure(struct sdw_intel *sdw, struct sdw_cdns_pdi *pdi)
 	/* Program Stream config ALH register */
 	conf = intel_readl(alh, SDW_ALH_STRMZCFG(pdi->intel_alh_id));
 
-	conf |= FIELD_PREP(SDW_ALH_STRMZCFG_DMAT, SDW_ALH_STRMZCFG_DMAT_VAL);
-	conf |= FIELD_PREP(SDW_ALH_STRMZCFG_CHN, pdi->ch_count - 1);
+	u32p_replace_bits(&conf, SDW_ALH_STRMZCFG_DMAT_VAL, SDW_ALH_STRMZCFG_DMAT);
+	u32p_replace_bits(&conf, pdi->ch_count - 1, SDW_ALH_STRMZCFG_CHN);
 
 	intel_writel(alh, SDW_ALH_STRMZCFG(pdi->intel_alh_id), conf);
 }
-- 
2.26.2

