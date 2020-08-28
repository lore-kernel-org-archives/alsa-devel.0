Return-Path: <SRS0=n32M=CG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8EAC433E2
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Aug 2020 07:24:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05FDC20CC7
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Aug 2020 07:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QVPYtL3D";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHCkkteO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05FDC20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 784BD183D;
	Fri, 28 Aug 2020 09:23:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 784BD183D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598599454;
	bh=weA419a+xC1jcTxulzyOYS/qNThRhkh6zQRQsVsEt48=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QVPYtL3DKSSqNQm8Blt9mibTLeOajoeEG90UvAu35YTwpC60sUJlilsHDGNPB1xJo
	 qDQjP1qhUAHWweqMQCJ7guHm8qSA9Mfcg3vO5VwH6rCC0nPWL7NTgwUP749RWTuIBD
	 yHkuBAO3vhtUfySzNSfbKbNP08KhNLrqz8KbatCE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 63AB5F802DB;
	Fri, 28 Aug 2020 09:21:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 94B81F802BC; Fri, 28 Aug 2020 09:21:32 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 608D5F801F2
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2020 09:21:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 608D5F801F2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ZHCkkteO"
Received: from localhost.localdomain (unknown [122.171.38.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 93C5420CC7;
 Fri, 28 Aug 2020 07:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598599282;
 bh=weA419a+xC1jcTxulzyOYS/qNThRhkh6zQRQsVsEt48=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZHCkkteOy45g1aR6QM60uzr+gk+nMedLCE3TGJS3LHJzfOJdTgb06fanVkZG0rX+h
 /xL9wvtznw3e9iPq8timCBxQoMuKXz7u0pSkA5fl/MRIyGb2V5tgzkopu0qRp1gaYK
 RYHiZCCsBpDqiNhmLAOJ/P+AAnG4YvjJ2h3xcaM8=
From: Vinod Koul <vkoul@kernel.org>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/9] soundwire: slave: use SDW_DISCO_LINK_ID()
Date: Fri, 28 Aug 2020 12:50:55 +0530
Message-Id: <20200828072101.3781956-4-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200828072101.3781956-1-vkoul@kernel.org>
References: <20200828072101.3781956-1-vkoul@kernel.org>
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

use SDW_DISCO_LINK_ID() in slave code to extract field values instead of
open coding masks and shift operations to extract link_id

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soundwire/slave.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index 0839445ee07b..72bf15322526 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -102,7 +102,7 @@ static bool find_slave(struct sdw_bus *bus,
 	}
 
 	/* Extract link id from ADR, Bit 51 to 48 (included) */
-	link_id = (addr >> 48) & GENMASK(3, 0);
+	link_id = SDW_DISCO_LINK_ID(addr);
 
 	/* Check for link_id match */
 	if (link_id != bus->link_id)
-- 
2.26.2

