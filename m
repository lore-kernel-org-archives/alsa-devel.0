Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C9ACD8C9D
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Jun 2026 19:33:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 95E766024D;
	Thu, 11 Jun 2026 21:33:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 95E766024D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781206392;
	bh=WAB/nfD4lrQzioEwAae2gCKasVdSNkjgoMLQ3BElqwg=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=vR7JI8vAiM+KbTOzt5ittZz28FUU9X4v0HLi27gYcygYLIeV0X3liKdSS+nL62SPF
	 iMMWCwRaCXzI4vOQGxNQqg2K8+MT2MNzbHM/Dr8vgwkQ5gPwucrwug3C+BTIjviDff
	 tSYPN19Kiwa7gVA5b1ceYA1aXHk2cYEyvo9PdRvM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 19B92F806B8; Thu, 11 Jun 2026 21:31:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6DF9DF806BC;
	Thu, 11 Jun 2026 21:31:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A7812F805B1; Thu, 11 Jun 2026 14:54:41 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.57
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1781182481;
	b=BU3ZkznTDgZnGC51peaI93LU1OUiLDPSE2N4EfY4gREeEy0TMvVy7gm39TqSugii3/c3
	 G8Evq8942Taljoz7AkVDg0E0xE7dKXX4IFk13D8qSHcviDOA49DJWe977NSpjouhU9nJ8
	 JrR0sN8hAq3qh6Wy5A7hgh4qAmkPNH3S0S+PWzCkPSbZxP2hRpjfE3lf9Ax182IP76KMf
	 T3DZKIF5BYnkNVhCfnHv3X60eDGrYeX9nGR6K44iyNONPevn7lJfgDdi3k/rGfkr33/yg
	 SFIp18qr2GEc9TrSye64j2gqCq3exUIbsRyhM25RnSIQA7S0Z0lyb0WyEKwKsM3z2Lw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781182481;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=WAB/nfD4lrQzioEwAae2gCKasVdSNkjgoMLQ3BElqwg=;
	b=L3CiD7xOgxtRziTOnf504vffL9MV2naf1J448o1h6rdXd85NhKNGoudqYxNdkWyR2K75
	 qhFQXSFfL/OyGsBW7Me+4OL1SW1p8e/dvf+xc4NGJkVeggQ0HjTijFu1b4ytdWMgnFbhO
	 t4vaZ1jY9i+NIeE9jxfE8r+Tg1YAq4yTHy1qySe2pv1N7NOui4L9FKHqLB2fFtggG3Kw4
	 dXJy7pCgD5tbSQ1dZ5VfixqSV/4igykPxkA0MvCYQRqb2CJ3bSOB5PlmlQfCpoVslOLEJ
	 V7sBbI2d3IAjGVUtGt7XRvvyUPMIbHvQ4JMEA9oqwwDleafLlkubQgnN2J5aPawvD1Q==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=lXL9KAyQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.57
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012057.outbound.protection.outlook.com [40.107.209.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B0B23F80020
	for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2026 14:54:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0B23F80020
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=lXL9KAyQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmJ2XKPNopaZStbLrUvce3CDKPXJPdRgJogYsdQJpwVNeYrGFNWMzQ1h0mOYUfS+ygE1J4uIRWc0VL2WuH3HZgccvGPxLcgbqPUu7cWvhxUN6x3VBnZU8l9UKTwHyi3lREV/SvQkEod+XCrb/3BwQV12zxza3G17soyn0DcN+1KzglE/Di2A7rTV8O+HzDiFrQmONWRiGzXTO63W7Mb4mGFabFRUcnMwe/mKb4VuOQn8OD6QDpRkR7V1xuNUQ51Tbk32ntcVZglRlXTpYmWx0QpuIiERBpNbHqFsoNUc6BoTGN04KeCvIldkgeYrNWAve/D0R/WktVKdLWImrgrNyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbZE0vN+P/MEbkj+KHxkYSE3LZXT6pd6Gc0cl8cK/A0=;
 b=eVID8/HxBpjFPp8tBTzo5shqXj3d6Vvwp+ADRi99hSMORXp7qF6xYfnLdSV1QV4ykWyWHf5V+oBGstG/tOzErT4xaIhXb91gIRMv3kWZsLsPnfiXluvudg5nwSFDCgoiQEhilg1pwLoQ6R8Fut1yCI1z5engLOLOTi62v66E0s1UuZszhFtzIXT8OEJgSOz/rpfjgjL1u8aqYmt9/ShcDOUEVkDgQRtaYW6WSFUOpMBn9n5tNt6YlqhNl1Broj5FCeKNg97Spr1lkDLEoDnt4cfytoHFv7z00Ij5nUuygpDuHT0d2HZdC0N2GqBE3tKpKSDaTBL1gc9z/ce8/w5nRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbZE0vN+P/MEbkj+KHxkYSE3LZXT6pd6Gc0cl8cK/A0=;
 b=lXL9KAyQmA+eFWh0K5q5Xhjd2+KPLfNVBIsOdamoawOJpZuiKRG3oVQCAkCTzWfREgoUBLY2fiohwCwQinBGDh8yaDO+41XmalLDAr2gvIGCR7XgkEI82Q5TXU6skopCAadUesyF2Rx33gpnYoqMsx3F5pNgPUdM942y3j/4x70=
Received: from BL1PR13CA0325.namprd13.prod.outlook.com (2603:10b6:208:2c1::30)
 by SN4PR10MB5589.namprd10.prod.outlook.com (2603:10b6:806:204::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Thu, 11 Jun
 2026 12:54:31 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::73) by BL1PR13CA0325.outlook.office365.com
 (2603:10b6:208:2c1::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Thu,
 11 Jun 2026 12:54:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 12:54:29 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 07:54:29 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 07:54:29 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 11 Jun 2026 07:54:29 -0500
Received: from lelvem-mr06.itg.ti.com ([10.250.165.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65BCsNkJ1341087;
	Thu, 11 Jun 2026 07:54:24 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <broonie@kernel.org>
CC: <tiwai@suse.de>, <andriy.shevchenko@linux.intel.com>,
	<13916275206@139.com>, <alsa-devel@alsa-project.org>, <shenghao-ding@ti.com>,
	<baojun.xu@ti.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <k-yi@ti.com>, <henry.lo@ti.com>,
	<robinchen@ti.com>, <niranjan.hy@ti.com>
Subject: [PATCH v1] ASoC: sdw_utils: Add missed component_name strings for TI
 amps
Date: Thu, 11 Jun 2026 20:53:59 +0800
Message-ID: <20260611125359.19839-1-baojun.xu@ti.com>
X-Mailer: git-send-email 2.43.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|SN4PR10MB5589:EE_
X-MS-Office365-Filtering-Correlation-Id: cec5a3e9-06c2-4379-56d3-08dec7b893bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	jQNlUIhZxIEumZJfbhThs+NvtfKbgW9PaAeFWIZo9vxTYZRAfpWqhccjAqFH/9oBvplCzuBNKCg4gRYxjlhnOZ8ksKHmGeLSsoHD8cPi1Vj1Kneuui+M868kA/1TWheWZ0P+dzI0ZEdgeG1xyyphzKfKO6KDR77UQxkC/IAl9O+9W6Qdj15ll+ttshtIzOCMO413OQ2/CqCYFB2sHgMsaOshhIbTDpbAMcEFA3p6ebXMQYxqZWKkBtAysCJnTPdAGr1VJaFMhfxbCz5sRX5CtJXoG6lNXALTQCI0AGq5uNyO/IHAF59qP2DMnXKyYJLXvZ4RvHZIzFKyi00VbvpXkV7zYeLFZ82Cwxw+nFPYTdoeclFf70q/G5oo7NLUpAjr++LA5VdFVX0BHu608WKjKZINBgCQHEC+6CPaIW4eBSRv3yP58Mi4e+tVwWANboFhNTV4rTwtd2GSZiyitHogih9k5Kk9Xtu98KlZnvtC/4HtquBCNJhbIHprr9GUhytfrmPGy2xq5VVp+nnLmb+CA3y1ckmefGSFk4Uf6Mn/4OAdKHE77+Bfvwc8rqedOfjYFx0K7yUrKrgtzB7Nv8paYuIRgyTv0dqat97e/j2cWFtxfeHLCHt2Jj4MZKa4MTlHdocfoe0CD/ZKU20Io3SjE3stenPws3tYsb5Mc33c9gXvNEs2oGUrzz35io5ZmNOncUBSYmAHs2o2ZC3dZVYX4MycPUGOjKWO5I0+HLHK970=
X-Forefront-Antispam-Report: 
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	bZ60E+dBFoQdT0DsAsN3jIipXIC8y6+fwB1AZky0PNMbv7z52iM7NZyo80QoQ2LqY8BgGSA7626dWgHB2zDhUJhnEyqSUj3nX72E7d1/wlB8A7R2jnxAecQ3k/3hMIPlDg949pLPpM0xbwhOq1Ln7NS9s8IshJatRdCNHeWNghJAOQSe1HbMjb/dt1ixkJqX+t2ZocxV6xW8b4UOt/Thpj3S29UO2+nYSHPod5V4c14ZklaV8A+mH0Lfjv2ArgDHdfuZ9jj0HdWaX2yB4xjqBUKMK/XmdBcYfKPuiFDRqYvFu7xZlxnEazdLGpPjBkEDZVuSJgTiYthcLgRXxgdIWsqKL9kkyQd4aU7hmAQaLQtj/J9yiGv+EdbtHY9/xOcbZk6C4QhirJEQNlmZXt0m08jKLs/dciIOHcp9jC9XrQrBSpacwcOCn2jbvPViTl5N
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 12:54:29.8351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 cec5a3e9-06c2-4379-56d3-08dec7b893bb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5589
X-MailFrom: baojun.xu@ti.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: PE2VYOJ4CJ4K6HVWES4D3L2Y53F6QWH6
X-Message-ID-Hash: PE2VYOJ4CJ4K6HVWES4D3L2Y53F6QWH6
X-Mailman-Approved-At: Thu, 11 Jun 2026 19:31:26 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PE2VYOJ4CJ4K6HVWES4D3L2Y53F6QWH6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Added component_name for UCM.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
 sound/soc/sdw_utils/soc_sdw_utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sdw_utils/soc_sdw_utils.c b/sound/soc/sdw_utils/soc_sdw_utils.c
index 681452bb89f2..ac77bed20e0f 100644
--- a/sound/soc/sdw_utils/soc_sdw_utils.c
+++ b/sound/soc/sdw_utils/soc_sdw_utils.c
@@ -231,6 +231,7 @@ struct asoc_sdw_codec_info codec_info_list[] = {
 			{
 				.direction = {true, true},
 				.dai_name = "tas2783-codec",
+				.component_name = "tas2783",
 				.dai_type = SOC_SDW_DAI_TYPE_AMP,
 				.dailink = {SOC_SDW_AMP_OUT_DAI_ID, SOC_SDW_AMP_IN_DAI_ID},
 				.init = asoc_sdw_ti_amp_init,
-- 
2.25.1

