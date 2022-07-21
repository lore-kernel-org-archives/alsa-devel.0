Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6A0C43334
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Jul 2022 10:47:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DF1F117C5;
	Thu, 21 Jul 2022 12:46:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DF1F117C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658400424;
	bh=ps6G2RMtFKrhS1JM+CHobuM8RxTyF2xqjK0hRo2QSgA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iMarf+YdB3zA7T1SOH6ePRVJKYBOYThvbXYpsanIbZTKWjfATwhfbtn4NfwFYAQH7
	 wjM4Ho3tnSjmnjH9qRUcL/97nHeZLR6K4wN/rVD+N7PYixo9DhMRulguWD/6L1R+L/
	 9q9G0bT4TXLXyOdGUHQARAox2cdc/V0nJx9R4n5M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 976A1F80169;
	Thu, 21 Jul 2022 12:45:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D0D6BF800BA; Thu, 21 Jul 2022 12:45:48 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C3F68F800BA
 for <alsa-devel@alsa-project.org>; Thu, 21 Jul 2022 12:45:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C3F68F800BA
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BAC012038FC;
 Thu, 21 Jul 2022 12:45:41 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 82FE8203903;
 Thu, 21 Jul 2022 12:45:41 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 06F3D180222C;
 Thu, 21 Jul 2022 18:45:39 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
 shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Subject: [PATCH v2 -next 1/5] ASoC: fsl_sai: Don't use plain integer as NULL
 pointer
Date: Thu, 21 Jul 2022 18:29:49 +0800
Message-Id: <1658399393-28777-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1658399393-28777-1-git-send-email-shengjiu.wang@nxp.com>
References: <1658399393-28777-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

Fix sparse warning:
sound/soc/fsl/fsl_sai.c:64:39: sparse: warning: Using plain integer as NULL pointer

Fixes: b4ee8a913e61 ("ASoc: fsl_sai: Add pinctrl operation for PDM and DSD")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 974ba0780b19..7523bb944b21 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -61,7 +61,7 @@ static inline bool fsl_sai_dir_is_synced(struct fsl_sai *sai, int dir)
 
 static struct pinctrl_state *fsl_sai_get_pins_state(struct fsl_sai *sai, u32 bclk)
 {
-	struct pinctrl_state *state = 0;
+	struct pinctrl_state *state = NULL;
 
 	if (sai->is_pdm_mode) {
 		/* DSD512@44.1kHz, DSD512@48kHz */
-- 
2.34.1

