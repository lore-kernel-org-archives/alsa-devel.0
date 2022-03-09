Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269BEC433F5
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Mar 2022 10:48:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5189C1702;
	Wed,  9 Mar 2022 11:47:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5189C1702
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646822899;
	bh=Z/MGpOGc/1yv40qqCi1+JVkgCwhl9gnX0+dzrJN/vcA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qcYcw52J7j5BMyo9blWZTAsi/3yqntuCaGLwiwvue0aqENE7n6GRdsYWJRSMBWIyx
	 NDMmsgLWna9GdC/Ev/PxgVECZNpEgqyzrdwBxDEIl639SvCOBnC92uRmwtnlPlugdq
	 H2nwPXr4wH0xr+tGqutjc4pZAN0SYkpiRWIn7SBs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DF025F80158;
	Wed,  9 Mar 2022 11:47:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 81436F80155; Wed,  9 Mar 2022 11:47:27 +0100 (CET)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 77C1FF80155
 for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2022 11:47:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77C1FF80155
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BA5E9201254;
 Wed,  9 Mar 2022 11:47:20 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 820E420090D;
 Wed,  9 Mar 2022 11:47:20 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id F2A26183ACDE;
 Wed,  9 Mar 2022 18:47:18 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
 shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: fsl_rpmsg: Remove SET_SYSTEM_SLEEP_PM_OPS callback
Date: Wed,  9 Mar 2022 18:38:13 +0800
Message-Id: <1646822293-26965-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
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

For sound need to be continuously output at suspend with rpmsg
sound card, so need to keep the clock always on at suspend,
then suspend & resume callback is not needed.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_rpmsg.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_rpmsg.c b/sound/soc/fsl/fsl_rpmsg.c
index 8508bc7f239d..19fd31250883 100644
--- a/sound/soc/fsl/fsl_rpmsg.c
+++ b/sound/soc/fsl/fsl_rpmsg.c
@@ -297,8 +297,6 @@ static const struct dev_pm_ops fsl_rpmsg_pm_ops = {
 	SET_RUNTIME_PM_OPS(fsl_rpmsg_runtime_suspend,
 			   fsl_rpmsg_runtime_resume,
 			   NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
 };
 
 static struct platform_driver fsl_rpmsg_driver = {
-- 
2.17.1

