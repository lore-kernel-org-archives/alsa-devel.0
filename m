Return-Path: <SRS0=FKDJ=KC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67628C433B4
	for <alsa-devel@archiver.kernel.org>; Fri,  7 May 2021 11:11:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 826E16140F
	for <alsa-devel@archiver.kernel.org>; Fri,  7 May 2021 11:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826E16140F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 18C6E16A0;
	Fri,  7 May 2021 13:10:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 18C6E16A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620385897;
	bh=eD350NB9uSIMJ7qHSwRCu0CnFOw9pMlqucvONPPRYzs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BI1FwPkVG7WItHrn1x8hHCiZSjpDPEbMm/E6YPCXrr3qPSi4PeiFphBuUmYqnN/1I
	 4zchAClTA2O/gpw86IghTkVaTmxJrsmdMb+p7L3YmhYxiltS7UqtNXvBijW5y7OSyD
	 oqEsr9IR78fZA+LaNrYNMALrkFMHMh0D8LFAzJtM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AD435F802E3;
	Fri,  7 May 2021 13:09:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D5ED1F8021C; Thu,  6 May 2021 04:25:11 +0200 (CEST)
Received: from mail-m176218.qiye.163.com (mail-m176218.qiye.163.com
 [59.111.176.218])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4C47EF80139
 for <alsa-devel@alsa-project.org>; Thu,  6 May 2021 04:25:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4C47EF80139
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
 by mail-m176218.qiye.163.com (Hmail) with ESMTPA id D027D3200AF;
 Thu,  6 May 2021 10:25:01 +0800 (CST)
From: Wan Jiabing <wanjiabing@vivo.com>
To: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Shengjiu Wang <shengjiu.wang@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_xcvr: Remove unneeded semicolon
Date: Thu,  6 May 2021 10:24:52 +0800
Message-Id: <20210506022452.5762-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
 oVCBIfWUFZQ0hDGVYYQk1MTkkYH0tLTx9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
 hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MzI6Pjo4GD8RDkMiFTITEDEj
 MC8aCgpVSlVKTUlLSU1MQktJQ0JOVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
 TVVKTklVSk9OVUpDSVlXWQgBWUFJS01ONwY+
X-HM-Tid: 0a793f7e25a9d978kuwsd027d3200af
X-Mailman-Approved-At: Fri, 07 May 2021 13:09:49 +0200
Cc: kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
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

Fix the following coccicheck warning:

./sound/soc/fsl/fsl_xcvr.c:739:2-3: Unneeded semicolon

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 sound/soc/fsl/fsl_xcvr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index 6cb558165848..df7c189d97dd 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -736,7 +736,7 @@ static int fsl_xcvr_load_firmware(struct fsl_xcvr *xcvr)
 			/* clean current page, including data memory */
 			memset_io(xcvr->ram_addr, 0, size);
 		}
-	};
+	}
 
 err_firmware:
 	release_firmware(fw);
-- 
2.25.1

