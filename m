Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6DFDC433F5
	for <alsa-devel@archiver.kernel.org>; Sun, 27 Feb 2022 07:14:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AEAE516F3;
	Sun, 27 Feb 2022 08:13:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AEAE516F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645946049;
	bh=bzwovRdVmM8I8rZEb9vWKfEY1XpyuRYyCQb2CGya4bY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=h4St7buzXYjZH+opE84/vVMgCcPBNrjyGZ0357ehTPmXZSV1vegs2wVX8DdrA696F
	 AtDNDIaih6bv6r7h5kS6eoNZ5RIMsNDHQus//l9QUuRCdFNs/Ad6J5GzYVGdu10XFh
	 UHNZFXbCCUWUaqGlfJ4aao+/0DPA8QsRLsIA2EF4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 241CBF80128;
	Sun, 27 Feb 2022 08:13:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 80AF0F80155; Sun, 27 Feb 2022 08:13:17 +0100 (CET)
Received: from smtpproxy21.qq.com (smtpbg704.qq.com [203.205.195.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9CA7EF80128
 for <alsa-devel@alsa-project.org>; Sun, 27 Feb 2022 08:13:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9CA7EF80128
X-QQ-mid: bizesmtp70t1645945981tu3if8ky
Received: from localhost.localdomain (unknown [58.240.82.166])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sun, 27 Feb 2022 15:12:56 +0800 (CST)
X-QQ-SSF: 01400000002000C0F000B00A0000000
X-QQ-FEAT: 3uawQE1sH+3cdVihck04CziGgFHh4ATJm3GZakzx+Xs4mrV+/TiNB0yQq6ycm
 hSVDp20Clsidmp1bFmYpqhACq8pFf+ntNDhYjkIeS6xZx5q/yjR6U98dkV/gCbl3LIArWw9
 VcuiKiJbBvuprbJbgeR6qYN1P/cAx1UdPG26ITK+pyeGAMr3lObdHjzuxrzo36xX5H+M+E8
 +hZp+o1K+nA33j7srjpUp9t10JRqkN6ELO2Gln6txoooE3+ua8RuWatI2Iby370HWQY75vn
 6POAW+fALJWY5Dcj07CaWjOpkJH+p+YbY1+mnyWzniu1wqqNMM4/fGvCrPnyNbjJO+Z1IP0
 0GLFndG1HrRfRve/565GMfQq3MhVWYkv5uNcsUe
X-QQ-GoodBg: 2
From: Meng Tang <tangmeng@uniontech.com>
To: perex@perex.cz,
	tiwai@suse.com
Subject: [PATCH 1/2] ALSA: core: remove initialise static variables to 0
Date: Sun, 27 Feb 2022 15:12:52 +0800
Message-Id: <20220227071253.28193-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
Cc: Meng Tang <tangmeng@uniontech.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

Initializing the static variable to 0 causes the following error
when exec checkpatch:

ERROR: do not initialise statics to 0
FILE: sound/sound_core.c:142:
static int preclaim_oss = 0;

Static variable does not need to be initialised to 0, because
compiler will initialise all uninitialised statics to 0. Thus,
remove the unneeded initializations.

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 sound/sound_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/sound_core.c b/sound/sound_core.c
index 90d118cd9164..2ee54070b2b5 100644
--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -139,7 +139,7 @@ struct sound_unit
 #ifdef CONFIG_SOUND_OSS_CORE_PRECLAIM
 static int preclaim_oss = 1;
 #else
-static int preclaim_oss = 0;
+static int preclaim_oss;
 #endif
 
 module_param(preclaim_oss, int, 0444);
-- 
2.20.1



