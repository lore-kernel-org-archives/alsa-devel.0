Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D56C636CD
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Feb 2023 09:31:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC159210;
	Tue,  7 Feb 2023 10:30:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC159210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675762265;
	bh=Mb1FKRQwKMP7gGg6MSMYD0pJ1yeNk4inkYK3BWSdVoA=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=qZy34Qg3G3fp6dpoY2c4/aHW+VF5vAF/LB5FH5r1Jhhj4oggyYq99309X9sPDntZI
	 acGmJIKNuY9UzeCMvlxe6+N23TJnqno1k/n7EgQRoZLuoiTc6n3K3gYqIHJ52lbjta
	 sehXzWG7hia7xwkJ95dfvJ4XVtdDXxF5b76psJzk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 853EEF80240;
	Tue,  7 Feb 2023 10:30:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B9531F8045D; Tue,  7 Feb 2023 10:30:14 +0100 (CET)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 67912F8014C
 for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2023 10:30:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 67912F8014C
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 83126200301;
 Tue,  7 Feb 2023 10:30:08 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4C8052013CC;
 Tue,  7 Feb 2023 10:30:08 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B4804183ABF0;
 Tue,  7 Feb 2023 17:30:06 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
 shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: fsl_sai: fix getting version from VERID
Date: Tue,  7 Feb 2023 17:04:24 +0800
Message-Id: <1675760664-25193-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The version information is at the bit31 ~ bit16 in the VERID
register, so need to right shift 16bit to get it, otherwise
the result of comparison "sai->verid.version >= 0x0301" is
wrong.

Fixes: 99c1e74f25d4 ("ASoC: fsl_sai: store full version instead of major/minor")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index c365afd6c4ea..1b197478b3d9 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1142,6 +1142,7 @@ static int fsl_sai_check_version(struct device *dev)
 
 	sai->verid.version = val &
 		(FSL_SAI_VERID_MAJOR_MASK | FSL_SAI_VERID_MINOR_MASK);
+	sai->verid.version >>= FSL_SAI_VERID_MINOR_SHIFT;
 	sai->verid.feature = val & FSL_SAI_VERID_FEATURE_MASK;
 
 	ret = regmap_read(sai->regmap, FSL_SAI_PARAM, &val);
-- 
2.34.1

