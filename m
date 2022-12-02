Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E993C47088
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Dec 2022 16:19:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8A1A717F5;
	Fri,  2 Dec 2022 17:18:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8A1A717F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669997955;
	bh=W+sIYRHF2swevjuTFDrM0Jl5SsttjAAjWIlOLejNZVI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fA1ftAKXI9GCrQiZ6mxqvOW5cx67kWoasH7GmbjqL2oXuG5M+Una+jAWxHEmLrq3M
	 SzCgBiyCY+sJ1dg7yfe5w2+QVpADnU5i9g53JgbWNJdq8pptteh9WQiPsdqwIx5M2Y
	 +Ho0Xn6x/7Yq5gUWUP5qUdho9kddblle7wPH/Gic=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2C167F80310;
	Fri,  2 Dec 2022 17:18:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E1A4EF800BD; Fri,  2 Dec 2022 17:18:22 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B7059F800BD
 for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2022 17:18:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7059F800BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="qxDK9pff"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2B25sRqn018164; Fri, 2 Dec 2022 10:18:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=4x7T5bgGFPWeQVLPmho0vqjLN8bDaVdyGpmi80dmNJI=;
 b=qxDK9pff+D/ZotG1XFjBPfBtQb0dIH32FT4fsjI8C2nnwB2B7O60EQzIkdYiFExUegwY
 YtN8m315vz3LjAdrmKP8KuMka99lqlQSuNhqyb2r5Gw4I1B8Gv6i00OjE3hPO3ty32Oo
 hKm8vC6VlMHVv7ii3ldzH4HPAJb9tJwG/Wu9UvihAEpUo3aFh9PXCyubrpRP0tarb6mK
 739hoKJnmb4GLWWhEMiZVEbq7BzTLOCaz+d195UkyZGoLetOMjT3k6HuiI/tSl8Z6TO/
 E1otqEEPC9CrZng7kJlZSmWsWdqUdfHSpQkN2w06CnZGejDu6G7z7sCS14q8vDV1CW6V WA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3m6k2vt0n5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Dec 2022 10:18:14 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Fri, 2 Dec
 2022 10:18:12 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.20 via
 Frontend Transport; Fri, 2 Dec 2022 10:18:12 -0600
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com
 [198.90.251.111])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 83230B12;
 Fri,  2 Dec 2022 16:18:12 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <vkoul@kernel.org>, <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 1/3] soundwire: cadence: Don't overflow the command FIFOs
Date: Fri, 2 Dec 2022 16:18:10 +0000
Message-ID: <20221202161812.4186897-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221202161812.4186897-1-rf@opensource.cirrus.com>
References: <20221202161812.4186897-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Hgsr-ASjt8q9cyhzOQadwna_WAjYWdep
X-Proofpoint-ORIG-GUID: Hgsr-ASjt8q9cyhzOQadwna_WAjYWdep
X-Proofpoint-Spam-Reason: safe
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 linux-kernel@vger.kernel.org, Richard Fitzgerald <rf@opensource.cirrus.com>,
 sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com
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

The command FIFOs in the Cadence IP can be configured during design
up to 32 entries, and the code in cadence_master.c was assuming the
full 32-entry FIFO. But all current Intel implementations use an 8-entry
FIFO.

Up to now the longest message used was 6 entries so this wasn't
causing any problem. But future Cirrus Logic codecs have downloadable
firmware or tuning blobs. It is more efficient for the codec driver to
issue long transfers that can take advantage of any queuing in the
Soundwire controller and avoid the overhead of repeatedly writing the
page registers.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Fixes: 2f52a5177caa ("soundwire: cdns: Add cadence library")
---
Changes since v1:
Commit description rewritten. No code change.
---
 drivers/soundwire/cadence_master.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index a1de363eba3f..27699f341f2c 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -127,7 +127,8 @@ MODULE_PARM_DESC(cdns_mcp_int_mask, "Cadence MCP IntMask");
 
 #define CDNS_MCP_CMD_BASE			0x80
 #define CDNS_MCP_RESP_BASE			0x80
-#define CDNS_MCP_CMD_LEN			0x20
+/* FIFO can hold 8 commands */
+#define CDNS_MCP_CMD_LEN			8
 #define CDNS_MCP_CMD_WORD_LEN			0x4
 
 #define CDNS_MCP_CMD_SSP_TAG			BIT(31)
-- 
2.30.2

