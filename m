Return-Path: <SRS0=LCrH=IG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3266C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 07:20:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 747FB65163
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 07:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 747FB65163
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0D6CF18F9;
	Mon,  8 Mar 2021 08:19:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0D6CF18F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615188011;
	bh=NJ4A897IOvHMpc5txK669/FdsNyfpFPUmBuXwA0aoHE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gqWiErTdNfiFjt+AjuR1sq4q3K4LFw2WillcHQPIXZYI5en15XbRA6ecSuVdLMlVg
	 DxhnOG1AGGApUvdu7+6zEIgJwEwL8mstX9ANTr8xua7mYcDVi6S07rAy55ySV49jLo
	 H+GDhTzewcKI9eLAfBYOHx+Z3mX8SH/gQVXirSnk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 39607F8016C;
	Mon,  8 Mar 2021 08:19:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 544FDF801D8; Mon,  8 Mar 2021 08:19:18 +0100 (CET)
Received: from out4436.biz.mail.alibaba.com (out4436.biz.mail.alibaba.com
 [47.88.44.36])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 54508F80139
 for <alsa-devel@alsa-project.org>; Mon,  8 Mar 2021 08:19:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 54508F80139
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R841e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=yang.lee@linux.alibaba.com;
 NM=1; PH=DS; RN=10; SR=0; TI=SMTPD_---0UQr502d_1615187936; 
Received: from
 j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com
 fp:SMTPD_---0UQr502d_1615187936) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 08 Mar 2021 15:18:56 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: perex@perex.cz
Subject: [PATCH] ASoC: bcm: add missing call to of_node_put()
Date: Mon,  8 Mar 2021 15:18:54 +0800
Message-Id: <1615187934-39505-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Cc: alsa-devel@alsa-project.org, sbranden@broadcom.com, lgirdwood@gmail.com,
 rjui@broadcom.com, tiwai@suse.com, linux-kernel@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, Yang Li <yang.lee@linux.alibaba.com>,
 linux-arm-kernel@lists.infradead.org
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

In one of the error paths of the for_each_child_of_node() loop,
add missing call to of_node_put().

Fix the following coccicheck warning:
./sound/soc/bcm/cygnus-ssp.c:1346:1-33: WARNING: Function
"for_each_available_child_of_node" should have of_node_put() before
return around line 1352.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 sound/soc/bcm/cygnus-ssp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/bcm/cygnus-ssp.c b/sound/soc/bcm/cygnus-ssp.c
index 6e634b4..aa16a23 100644
--- a/sound/soc/bcm/cygnus-ssp.c
+++ b/sound/soc/bcm/cygnus-ssp.c
@@ -1348,8 +1348,10 @@ static int cygnus_ssp_probe(struct platform_device *pdev)
 					&cygnus_ssp_dai[active_port_count]);
 
 		/* negative is err, 0 is active and good, 1 is disabled */
-		if (err < 0)
+		if (err < 0) {
+			of_node_put(child_node);
 			return err;
+		}
 		else if (!err) {
 			dev_dbg(dev, "Activating DAI: %s\n",
 				cygnus_ssp_dai[active_port_count].name);
-- 
1.8.3.1

