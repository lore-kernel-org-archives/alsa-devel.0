Return-Path: <SRS0=wWF8=AF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC01AC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jun 2020 05:35:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1407C206EB
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jun 2020 05:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RYW0yo20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1407C206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8BC3B1807;
	Wed, 24 Jun 2020 07:34:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8BC3B1807
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592976927;
	bh=BTFdlmILnzaP3ie6Dpw5eN7d9g9OF/AnTxx8c9Odl0E=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RYW0yo203HF0wXH6FwhQD87iafKftPDZnxDec9zmc/812RVQN2ao39qdvi7l8n99S
	 g4J4N3UMRJhLoKt1E2N1KkWIRt6tJI5XUMz/d1jnVYAXCbZOzwqKYUfrdiHOvEZNEa
	 DQGPkqyknzMrVecVuA+84l7w0ncGdM7rgKDGNlOQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B7501F802EB;
	Wed, 24 Jun 2020 07:30:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9C863F802A7; Wed, 24 Jun 2020 07:30:46 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8F1C6F800B2
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2020 07:30:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8F1C6F800B2
IronPort-SDR: UdlUoIpLatGwLk3f3dyxEBLuZtTV+/F7Fgc2gDgGRUYnLWEcNWD33oDTtaCtaSpUB/h+eU3y0J
 8Nel6EzY16Jg==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="131775874"
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; d="scan'208";a="131775874"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2020 22:30:02 -0700
IronPort-SDR: /YXuIUhNkNjNpiuyXCOM96a/xMVp2Ev2JwKD0G4s5SBW3XUyaQv1OLBsHE4fe1bVkYNkIykq3Q
 DkJaSxG5J1hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; d="scan'208";a="452513257"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga005.jf.intel.com with ESMTP; 23 Jun 2020 22:29:58 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 1/9] soundwire: intel: reuse code for wait loops to set/clear
 bits
Date: Wed, 24 Jun 2020 01:35:38 +0800
Message-Id: <20200623173546.21870-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200623173546.21870-1-yung-chuan.liao@linux.intel.com>
References: <20200623173546.21870-1-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, mengdong.lin@intel.com,
 slawomir.blauciak@intel.com, sanyog.r.kale@intel.com,
 rander.wang@linux.intel.com, bard.liao@intel.com
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Refactor code and use same routines on set/clear

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 45 +++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 7a65414e5714..8c7ae07c0fe1 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -123,40 +123,33 @@ static inline void intel_writew(void __iomem *base, int offset, u16 value)
 	writew(value, base + offset);
 }
 
+static int intel_wait_bit(void __iomem *base, int offset, u32 mask, u32 target)
+{
+	int timeout = 10;
+	u32 reg_read;
+
+	do {
+		reg_read = readl(base + offset);
+		if ((reg_read & mask) == target)
+			return 0;
+
+		timeout--;
+		usleep_range(50, 100);
+	} while (timeout != 0);
+
+	return -EAGAIN;
+}
+
 static int intel_clear_bit(void __iomem *base, int offset, u32 value, u32 mask)
 {
-	int timeout = 10;
-	u32 reg_read;
-
 	writel(value, base + offset);
-	do {
-		reg_read = readl(base + offset);
-		if (!(reg_read & mask))
-			return 0;
-
-		timeout--;
-		udelay(50);
-	} while (timeout != 0);
-
-	return -EAGAIN;
+	return intel_wait_bit(base, offset, mask, 0);
 }
 
 static int intel_set_bit(void __iomem *base, int offset, u32 value, u32 mask)
 {
-	int timeout = 10;
-	u32 reg_read;
-
 	writel(value, base + offset);
-	do {
-		reg_read = readl(base + offset);
-		if (reg_read & mask)
-			return 0;
-
-		timeout--;
-		udelay(50);
-	} while (timeout != 0);
-
-	return -EAGAIN;
+	return intel_wait_bit(base, offset, mask, mask);
 }
 
 /*
-- 
2.17.1

