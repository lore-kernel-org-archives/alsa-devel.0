Return-Path: <SRS0=n32M=CG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F603C433E6
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Aug 2020 07:23:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAD3820CC7
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Aug 2020 07:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qqwVrPIA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmLvYEQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD3820CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 737E31846;
	Fri, 28 Aug 2020 09:23:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 737E31846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598599437;
	bh=6Qm1pfoso/rr6pnXCaCWRsDhA+AiselS3GuGIfHOdxc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qqwVrPIARW0AcSYIU6AxOTfklyBdz12IuL4A62q77+AcY6bsbhqbaAhVEdO2+lE0F
	 V/BQJGFm+LS7P1rzYsp6TbaySOr+qOABr0rbsxvQ46lou8R8UpwsCsS3+IRl2h1vQF
	 5q6mXjbO7gXnlYZ43bNj8aCa3c6GW2qKATtOue/Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E0F9AF80118;
	Fri, 28 Aug 2020 09:21:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 11E3EF80105; Fri, 28 Aug 2020 09:21:28 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C8657F80118
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2020 09:21:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C8657F80118
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="lmLvYEQV"
Received: from localhost.localdomain (unknown [122.171.38.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 58DA620DD4;
 Fri, 28 Aug 2020 07:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598599276;
 bh=6Qm1pfoso/rr6pnXCaCWRsDhA+AiselS3GuGIfHOdxc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lmLvYEQVF1Hh2UWK3S7Q4wLZjtD036nOV5n9sij+uZvpUKC1rDDluVz74f98V1J7H
 Z/YdX2VZbuF4zMNF13uJRT2w604wyGzoNz9OAVOzVCsyQI5QHGdxMa4cwsVFVLynLL
 CSUWA/BrDDcli+LQs20A7RXexK4aTmFWf3yWswd8=
From: Vinod Koul <vkoul@kernel.org>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/9] soundwire: define and use addr bit masks
Date: Fri, 28 Aug 2020 12:50:53 +0530
Message-Id: <20200828072101.3781956-2-vkoul@kernel.org>
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

Soundwire addr is a 52bit value encoding link, version, unique id,
mfg id, part id and class id. Define bit masks for these and use
FIELD_GET() to extract these fields.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 include/linux/soundwire/sdw.h | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 76052f12c9f7..c7462c333480 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -5,6 +5,7 @@
 #define __SOUNDWIRE_H
 
 #include <linux/mod_devicetable.h>
+#include <linux/bitfield.h>
 
 struct sdw_bus;
 struct sdw_slave;
@@ -455,13 +456,19 @@ struct sdw_slave_id {
  *
  * The MIPI DisCo for SoundWire defines in addition the link_id as bits 51:48
  */
-
-#define SDW_DISCO_LINK_ID(adr)	(((adr) >> 48) & GENMASK(3, 0))
-#define SDW_VERSION(adr)	(((adr) >> 44) & GENMASK(3, 0))
-#define SDW_UNIQUE_ID(adr)	(((adr) >> 40) & GENMASK(3, 0))
-#define SDW_MFG_ID(adr)		(((adr) >> 24) & GENMASK(15, 0))
-#define SDW_PART_ID(adr)	(((adr) >> 8) & GENMASK(15, 0))
-#define SDW_CLASS_ID(adr)	((adr) & GENMASK(7, 0))
+#define SDW_DISCO_LINK_ID_MASK	GENMASK(51, 48)
+#define SDW_VERSION_MASK	GENMASK(47, 44)
+#define SDW_UNIQUE_ID_MASK	GENMASK(43, 40)
+#define SDW_MFG_ID_MASK		GENMASK(39, 24)
+#define SDW_PART_ID_MASK	GENMASK(23, 8)
+#define SDW_CLASS_ID_MASK	GENMASK(7, 0)
+
+#define SDW_DISCO_LINK_ID(adr)	FIELD_GET(SDW_DISCO_LINK_ID_MASK, addr)
+#define SDW_VERSION(adr)	FIELD_GET(SDW_VERSION_MASK, addr)
+#define SDW_UNIQUE_ID(adr)	FIELD_GET(SDW_UNIQUE_ID_MASK, addr)
+#define SDW_MFG_ID(adr)		FIELD_GET(SDW_MFG_ID_MASK, addr)
+#define SDW_PART_ID(adr)	FIELD_GET(SDW_PART_ID_MASK, addr)
+#define SDW_CLASS_ID(adr)	FIELD_GET(SDW_CLASS_ID_MASK, addr)
 
 /**
  * struct sdw_slave_intr_status - Slave interrupt status
-- 
2.26.2

