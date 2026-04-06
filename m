Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EE4EF4EC2
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Apr 2026 10:32:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A0D46601F3;
	Mon,  6 Apr 2026 12:32:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A0D46601F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775471547;
	bh=HFGetRVhreVQfTgTG+svDgXbPCAJm/5kamK5RkUFWiU=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=rX+vEVoED7FoLHuG2Hqd7vof/dZ0UZoJ7t5rfKi3MGRfgJGtdA+N5FWqXE+SRB3Az
	 QOww2/P+XskG+2JddXPYQh2lvXJdQ2k2qBQcYxX7ANlxpDrxheQD6dDCtzMrLyZ7oO
	 ovtH4jK4cMmkdGTXa5Ig+ZuhzUwQVzg0Hto3taYU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1D003F805F0; Mon,  6 Apr 2026 12:31:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 83865F805F2;
	Mon,  6 Apr 2026 12:31:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 24F35F8049C; Mon,  6 Apr 2026 12:31:47 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010003.outbound.protection.outlook.com [52.101.201.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id ED0A2F80169
	for <alsa-devel@alsa-project.org>; Mon,  6 Apr 2026 12:31:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ED0A2F80169
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=KuIvn4pJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDBq6/ptJsGvQ62SJGskaT5fREpZowEItf7LITkQ90vLWUnV43NpSWXprM2G5Ou8t1K/Ablq7R2WMGeUhEm6mB/ET6kW0Su7FDyFA9KBdmXxJvGEpsmPvcW8/F4MK9OJyfdE8wuDH7mLPuwJQ7AQFUpYCqbia8lkRK5P/LLSrxnO/bWCPd6Mkb4Oun8qAwlG2FK/b8DBQ3MS+o6Z6hsGkwNMbyHgsu8ANaHlsdqXNjgPKJdXAl7Vrl7pyVyGvGyq3f8doraW/fEudr0sF+oqUiMWJC7k6lLyxXt5bk9hRPgIbrceU+ReUbjMXeSkfEVYQ8dCPYwEWCu9owOC/E4cbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1GyKpV9T2xEqvAIOkMBUX59w31MrEc7IhsBt+9IpmY=;
 b=wjZDYIKzaymO7w/Ktx97r+GveBcweUmZDGRz+LR/jcak0sLRg848eU3QG3lxC0Zk7NvUcuJOMXt688JHfQNcYGVIcdQujK7jHSbapJhWidgabcsNj2qd2r3E48D7VWbXqiIQO09FpweidsKwAY25tr2JNnS6p2hwVXgo51ZITPYa1VDjYCEIlgMh/agaTIMBDoZYqD4pOM2aQsENkE/e8rjveXYKFl4p7vyNpxkw/lAqTm5xPZSMdMQ5Rd361VSzSGeUzwU4Y85SMqG7l1vYU0QoX3SvYnPzmlBYUjCNQFKGWaIxrOygSc8r5/mCS+SG81gBh+HDdn9UABK/1ss0fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=alsa-project.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1GyKpV9T2xEqvAIOkMBUX59w31MrEc7IhsBt+9IpmY=;
 b=KuIvn4pJlJ2SVimuD8dN/EW7XL7n9wiDk3G5JQPjOuxZIHm0QoeDHRpHOhskYvsSAe/tHI+XzPpk6y890DI1VHJ7+2XxMyLNggluKEhyS82yLx0mUIjaPGTZxe/2ucJdLJbb41oaKwhE348HhEv4pubQDUazw3Sr0C8sY5LiwRA=
Received: from DM6PR14CA0070.namprd14.prod.outlook.com (2603:10b6:5:18f::47)
 by DS4PR10MB997645.namprd10.prod.outlook.com (2603:10b6:8:31d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 10:31:38 +0000
Received: from DS2PEPF000061C2.namprd02.prod.outlook.com
 (2603:10b6:5:18f:cafe::ac) by DM6PR14CA0070.outlook.office365.com
 (2603:10b6:5:18f::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Mon,
 6 Apr 2026 10:31:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS2PEPF000061C2.mail.protection.outlook.com (10.167.23.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 6 Apr 2026 10:31:37 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Apr
 2026 05:31:36 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Apr
 2026 05:31:36 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 6 Apr 2026 05:31:36 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.161.26])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 636AVXNb1008342;
	Mon, 6 Apr 2026 05:31:34 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <broonie@kernel.org>
CC: <andriy.shevchenko@linux.intel.com>, <tiwai@suse.de>,
	<13916275206@139.com>, <krzk@kernel.org>, <alsa-devel@alsa-project.org>,
	<baojun.xu@ti.com>, Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v2] ASoC: tas2781: Explicit association of Device,
 Device Name, and Device ID
Date: Mon, 6 Apr 2026 18:31:31 +0800
Message-ID: <20260406103131.1883-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C2:EE_|DS4PR10MB997645:EE_
X-MS-Office365-Filtering-Correlation-Id: c8e0159c-2b8a-4970-a219-08de93c7aebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	WZE8Nkw76qq0tkjRwLZQjDqvK7Re5OEIFw8gff1X4qQRXEuMBkOLYcFXR7X5ikPMMsxzmhHVjXz1b6mCtTfJwKHFNttmGZ7u55TImMHl5vrolUj/mf290uHRmpvul8NdVGl1Nmz8yNScUni3DXCUQg2kqs8RXWOvqtf8KUwPYUdSC0+OW4qr8kyvBT2dG6Vy/dLSRFJqiVT55vo1sZoAc6RZcneDbCWuvwf9yVzGlgpNgtUGa03Ds9xRrePgJQ8IVaxmeGyB8KaCtaird9NCyX5Y7DmC3aQ2YjrA2yFFw7VEjHbYbYbOUOoYFk15SzHafLSEad4W6mXLlqYqx+xmnSTW/Xxpn9r8KMOvj5Q/h7BWCp7lRDL8odQVTsvcD6nHDGFcx1ourbYc4N1HbTuNoxCTsKQ47R1PQO7XIbuQsfF+MZ/kfIHUfMrWu1TEZU+zwRRKpk+BEsfjUCj59ryY/OqFad+y8teXRKa78uMdd09CpFWlNz9CJ8YlL8NqbbYNegccffDAUseR08aNU3Dd/uMFMxjpFQYV1hN03lBnjL2CfnRz9NPqMrL2MNXt6kl+O2pEMEeuIkDT7f8MmtpQ6qK1aKD7oA/jf2sJUYhmdDag8OHyveRRaFWNi9ZMsYUZBpZaiJnnVQx4yh+BWA/dX/Yj2Sap6Qgj7NWgzbBbIeTVNY9Oe7JNWU+8RFse2FgId/mpoZiQk88bMXN0TbjC6AIq/DRZwzb3wSv9ME+ilqwOlc/kTKTVwGE7jVtmbO4hZ39mCHwMmLAgs6aXAneoyw==
X-Forefront-Antispam-Report: 
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	lES3gToIbJBRPR5GDo9Z07hxUo7d2Kfbj6TcOadBg1vhuWtgbM+iHZBcC/cKoMrI+Xs0Kh8GWvfgBxIqAUxTnmGh8xE7Ag7yeYpLBrIiw7M7P//wjB43emO6oPriDTKXfTgxOUkNll9aKUqMNhwDecMful2v2naqQZ98sLDWwoR0By+MjcOk1Br0BU1E9t48TCPOZAfvhVUYO/UWmv28FtE3KwLkxQKSoNX4faaH/zlUmQjMAJd1nP5y+iD8Xj9u5C4NZWfnkpRP6FVZ4f6Onms+qvXTQMcmAdRYzxH6QkCB1AyjFA3bjDU1By7wiN77UiOpr+k3L6qIXVIo8g/ZiU11omApncxNhRqTqYhqjpgxsSYyAk9/3QqTTILiQ3zge9WsOSVX7mSyFeD329MC/dl0UMmrEghs+p30TF5yBVZq+W5q4TEIYLQ98v1+KLJQ
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 10:31:37.1753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c8e0159c-2b8a-4970-a219-08de93c7aebf
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DS2PEPF000061C2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997645
Message-ID-Hash: LOFPFAHI53RYFW3GWMQ4VXSTQ4LOBWKX
X-Message-ID-Hash: LOFPFAHI53RYFW3GWMQ4VXSTQ4LOBWKX
X-MailFrom: shenghao-ding@ti.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LOFPFAHI53RYFW3GWMQ4VXSTQ4LOBWKX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

By correlating devices with their names and IDs, the driver becomes more
discoverable.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
v2:
 - Fixed compiling error in tasdevice_acpi_match[] in case of x86_64
   allmodconfig build.
v1:
 - Added a new column to the tasdevice_acpi_match[] link each ACPI ID
   with its respective device name.
 - Introduced a similar association in the tasdevice_of_match[] by including
   device names alongside their compatible strings.
 - Refactor code to optimize device name retrieval logic.
 - remove the assignment of .id_table  in tasdevice_i2c_driver[].
---
 sound/soc/codecs/tas2781-i2c.c | 104 ++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 53 deletions(-)

diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index 41b89fcc69c3..c593f9da0c5b 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -121,29 +121,28 @@ static const struct i2c_device_id tasdevice_id[] = {
 	{ "tas5830", TAS5830 },
 	{}
 };
-MODULE_DEVICE_TABLE(i2c, tasdevice_id);
 
 #ifdef CONFIG_OF
 static const struct of_device_id tasdevice_of_match[] = {
-	{ .compatible = "ti,tas2020" },
-	{ .compatible = "ti,tas2118" },
-	{ .compatible = "ti,tas2120" },
-	{ .compatible = "ti,tas2320" },
-	{ .compatible = "ti,tas2563" },
-	{ .compatible = "ti,tas2568" },
-	{ .compatible = "ti,tas2570" },
-	{ .compatible = "ti,tas2572" },
-	{ .compatible = "ti,tas2574" },
-	{ .compatible = "ti,tas2781" },
-	{ .compatible = "ti,tas5802" },
-	{ .compatible = "ti,tas5806m" },
-	{ .compatible = "ti,tas5806md" },
-	{ .compatible = "ti,tas5815" },
-	{ .compatible = "ti,tas5822" },
-	{ .compatible = "ti,tas5825" },
-	{ .compatible = "ti,tas5827" },
-	{ .compatible = "ti,tas5828" },
-	{ .compatible = "ti,tas5830" },
+	{ .compatible = "ti,tas2020", .data = &tasdevice_id[TAS2020] },
+	{ .compatible = "ti,tas2118", .data = &tasdevice_id[TAS2118] },
+	{ .compatible = "ti,tas2120", .data = &tasdevice_id[TAS2120] },
+	{ .compatible = "ti,tas2320", .data = &tasdevice_id[TAS2320] },
+	{ .compatible = "ti,tas2563", .data = &tasdevice_id[TAS2563] },
+	{ .compatible = "ti,tas2568", .data = &tasdevice_id[TAS2568] },
+	{ .compatible = "ti,tas2570", .data = &tasdevice_id[TAS2570] },
+	{ .compatible = "ti,tas2572", .data = &tasdevice_id[TAS2572] },
+	{ .compatible = "ti,tas2574", .data = &tasdevice_id[TAS2574] },
+	{ .compatible = "ti,tas2781", .data = &tasdevice_id[TAS2781] },
+	{ .compatible = "ti,tas5802", .data = &tasdevice_id[TAS5802] },
+	{ .compatible = "ti,tas5806m", .data = &tasdevice_id[TAS5806M] },
+	{ .compatible = "ti,tas5806md", .data = &tasdevice_id[TAS5806MD] },
+	{ .compatible = "ti,tas5815", .data = &tasdevice_id[TAS5815] },
+	{ .compatible = "ti,tas5822", .data = &tasdevice_id[TAS5822] },
+	{ .compatible = "ti,tas5825", .data = &tasdevice_id[TAS5825] },
+	{ .compatible = "ti,tas5827", .data = &tasdevice_id[TAS5827] },
+	{ .compatible = "ti,tas5828", .data = &tasdevice_id[TAS5828] },
+	{ .compatible = "ti,tas5830", .data = &tasdevice_id[TAS5830] },
 	{},
 };
 MODULE_DEVICE_TABLE(of, tasdevice_of_match);
@@ -2023,15 +2022,12 @@ static void tasdevice_parse_dt(struct tasdevice_priv *tas_priv)
 	if (IS_ERR(tas_priv->reset))
 		dev_err(tas_priv->dev, "%s Can't get reset GPIO\n",
 			__func__);
-
-	strscpy(tas_priv->dev_name, tasdevice_id[tas_priv->chip_id].name,
-		sizeof(tas_priv->dev_name));
 }
 
 static int tasdevice_i2c_probe(struct i2c_client *i2c)
 {
-	const struct acpi_device_id *acpi_id;
 	struct tasdevice_priv *tas_priv;
+	struct i2c_device_id *id_data;
 	int ret;
 
 	tas_priv = tasdevice_kzalloc(i2c);
@@ -2041,20 +2037,23 @@ static int tasdevice_i2c_probe(struct i2c_client *i2c)
 	dev_set_drvdata(&i2c->dev, tas_priv);
 
 	if (ACPI_HANDLE(&i2c->dev)) {
-		acpi_id = acpi_match_device(i2c->dev.driver->acpi_match_table,
-				&i2c->dev);
-		if (!acpi_id) {
-			dev_err(&i2c->dev, "No driver data\n");
-			ret = -EINVAL;
-			goto err;
-		}
-		tas_priv->chip_id = acpi_id->driver_data;
+		id_data = (struct i2c_device_id *)
+			acpi_device_get_match_data(&i2c->dev);
 		tas_priv->isacpi = true;
 	} else {
-		tas_priv->chip_id = (uintptr_t)i2c_get_match_data(i2c);
+		id_data = (struct i2c_device_id *)i2c_get_match_data(i2c);
 		tas_priv->isacpi = false;
 	}
 
+	if (!id_data) {
+		dev_err(&i2c->dev, "No driver data\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	tas_priv->chip_id = (uintptr_t)id_data->driver_data;
+	strscpy(tas_priv->dev_name, id_data->name, sizeof(tas_priv->dev_name));
+
 	tasdevice_parse_dt(tas_priv);
 
 	ret = tasdevice_init(tas_priv);
@@ -2086,25 +2085,25 @@ static void tasdevice_i2c_remove(struct i2c_client *client)
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id tasdevice_acpi_match[] = {
-	{ "TXNW2020", TAS2020 },
-	{ "TXNW2118", TAS2118 },
-	{ "TXNW2120", TAS2120 },
-	{ "TXNW2320", TAS2320 },
-	{ "TXNW2563", TAS2563 },
-	{ "TXNW2568", TAS2568 },
-	{ "TXNW2570", TAS2570 },
-	{ "TXNW2572", TAS2572 },
-	{ "TXNW2574", TAS2574 },
-	{ "TXNW2781", TAS2781 },
-	{ "TXNW5802", TAS5802 },
-	{ "TXNW806M", TAS5806M },
-	{ "TXNW806D", TAS5806MD },
-	{ "TXNW5815", TAS5815 },
-	{ "TXNW5822", TAS5822 },
-	{ "TXNW5825", TAS5825 },
-	{ "TXNW5827", TAS5827 },
-	{ "TXNW5828", TAS5828 },
-	{ "TXNW5830", TAS5830 },
+	{ "TXNW2020", (kernel_ulong_t)&tasdevice_id[TAS2020] },
+	{ "TXNW2118", (kernel_ulong_t)&tasdevice_id[TAS2118] },
+	{ "TXNW2120", (kernel_ulong_t)&tasdevice_id[TAS2120] },
+	{ "TXNW2320", (kernel_ulong_t)&tasdevice_id[TAS2320] },
+	{ "TXNW2563", (kernel_ulong_t)&tasdevice_id[TAS2563] },
+	{ "TXNW2568", (kernel_ulong_t)&tasdevice_id[TAS2568] },
+	{ "TXNW2570", (kernel_ulong_t)&tasdevice_id[TAS2570] },
+	{ "TXNW2572", (kernel_ulong_t)&tasdevice_id[TAS2572] },
+	{ "TXNW2574", (kernel_ulong_t)&tasdevice_id[TAS2574] },
+	{ "TXNW2781", (kernel_ulong_t)&tasdevice_id[TAS2781] },
+	{ "TXNW5802", (kernel_ulong_t)&tasdevice_id[TAS5802] },
+	{ "TXNW806M", (kernel_ulong_t)&tasdevice_id[TAS5806M] },
+	{ "TXNW806D", (kernel_ulong_t)&tasdevice_id[TAS5806MD] },
+	{ "TXNW5815", (kernel_ulong_t)&tasdevice_id[TAS5815] },
+	{ "TXNW5822", (kernel_ulong_t)&tasdevice_id[TAS5822] },
+	{ "TXNW5825", (kernel_ulong_t)&tasdevice_id[TAS5825] },
+	{ "TXNW5827", (kernel_ulong_t)&tasdevice_id[TAS5827] },
+	{ "TXNW5828", (kernel_ulong_t)&tasdevice_id[TAS5828] },
+	{ "TXNW5830", (kernel_ulong_t)&tasdevice_id[TAS5830] },
 	{},
 };
 
@@ -2121,7 +2120,6 @@ static struct i2c_driver tasdevice_i2c_driver = {
 	},
 	.probe	= tasdevice_i2c_probe,
 	.remove = tasdevice_i2c_remove,
-	.id_table = tasdevice_id,
 };
 
 module_i2c_driver(tasdevice_i2c_driver);
-- 
2.43.0

