Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2DCCD730A2
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Apr 2026 05:45:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5346E601B5;
	Fri,  3 Apr 2026 07:45:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5346E601B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775195152;
	bh=t133JVaRacEmnOW2mJ/4wocv6yNKSeFOKOjBiRvtNlQ=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=qiUVJ2HYkcT7fHXpR2ofZ5hWgRHbyp23N+uN6cWn9Y9cUa9ISunppmOuhYUA/B0ec
	 FA5qr3cpbZ6Ik+6+7+KelSUAZggZs68Uo192C0eXoBt2o11NyRWyy6q2Xam95ih9OF
	 3Nkjgqg/WYC/scBAuXIwiUoHCJtxWGLE9KzK1VSE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1B925F805EF; Fri,  3 Apr 2026 07:45:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A0739F805F3;
	Fri,  3 Apr 2026 07:45:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 254E3F80589; Fri,  3 Apr 2026 07:45:09 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011046.outbound.protection.outlook.com [40.107.208.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5DF8AF8011B
	for <alsa-devel@alsa-project.org>; Fri,  3 Apr 2026 07:45:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5DF8AF8011B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=fxYr7Vrx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/nRX3DxYsohmenKYVmbrvUc6n/kOeYs1NDYTKgwyemf5uLqXwu1QWlo4a6gDcnSpXrLUr/PtuzgWm6WE/5l9BfEZ0ydOIcWOobya2PuatQ1Np0/I3IFnJLOPI/9/remsYNYn2vg2WiJSjqor+I/JyhY+SERiOa43EH2XR6CAQ7VE8haosPpelkG4qO8aKz84aVg52SEKg8gshbFzQqRICzBQEAIXzUWhghyNycSLwIl9lm3bzMpwzi6QDQyS8t0Y+8bZybA22fEEn2KsCALXDDXQYYyHZEfziGnC9a0CsIEYgef1hz9sV9G07xF5feVWX0+vUpNj67vpCPzW/N2mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZl4kj4rJoCa0mLJ3UThK5KP9PuU+Xm2ndm9g9ewQy0=;
 b=b+oSfBTOKQRcPFQc2I7MlwHGJvlaZAoMdykktIuRUX2N67LcaX4dcdjYGBCRsgKRtRQfRIh4iZAo2SbTzIP++EGcS+NpBZkb27f7TtQfMnu91mEqDJnj8QILTSeUW1r460yvqbGgMeKLrzeMQMB/2xsMuCkax1rL/hRmQKRbYYY3IXUsoemI6wO53pXHooXxB4VPjHL90EMp5KBuHLbSkjikqX7M6FJNR9V6jAwSvoJAu+k70+rCTwjOgEkxJsgFdo0keWVTf9Xq6nzqvypJzDxLrus+j6RYLH54fHlSVf93YPP+bQEYxAG3s8YHZcFnuto9mmUVMJRUMhWtsUvnFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=alsa-project.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZl4kj4rJoCa0mLJ3UThK5KP9PuU+Xm2ndm9g9ewQy0=;
 b=fxYr7VrxuOeQyMaytPiDQXzxM/nOMbUAx6aR1a6M0OTf8FIK26pmAMRuXyq6PaFndta9WZoZ48q7VoVeJaSXVESqbopFWZPFpC6WWKihQPRY/+D9E4pKuQM++oPbttA+UNX7mfURy3nx0q0lsx+pNjPbSmVZHa1AZatopgNHvds=
Received: from CH0PR08CA0027.namprd08.prod.outlook.com (2603:10b6:610:33::32)
 by MW4PR10MB6655.namprd10.prod.outlook.com (2603:10b6:303:22c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 3 Apr
 2026 05:44:59 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::8d) by CH0PR08CA0027.outlook.office365.com
 (2603:10b6:610:33::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Fri,
 3 Apr 2026 05:44:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 3 Apr 2026 05:44:56 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 3 Apr
 2026 00:44:56 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 3 Apr
 2026 00:44:56 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 3 Apr 2026 00:44:55 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.161.26])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6335iqJD3439681;
	Fri, 3 Apr 2026 00:44:53 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <broonie@kernel.org>
CC: <andriy.shevchenko@linux.intel.com>, <tiwai@suse.de>,
	<13916275206@139.com>, <krzk@kernel.org>, <alsa-devel@alsa-project.org>,
	<baojun.xu@ti.com>, Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v1] ASoC: tas2781: Explicit association of Device,
 Device Name, and Device ID
Date: Fri, 3 Apr 2026 13:44:49 +0800
Message-ID: <20260403054449.177-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|MW4PR10MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: f8cf3258-251a-4410-d9ed-08de91442330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	WWxFKbMjEzbf3+c/3uSCvRa1UEIUZQ9aiovnHnQTGGFFGSzRAu5sabH4DJpSfQsoEacH2CiMBgneK3blNOnY1sDHtl2jkO+qg7sUTh2fE8QQuKAQPCUkdmr5qgFtn1LOKvcpjbWk9CR4vyBz3s+uhiserJIHSzwvVF1MWI7ox35/l93yqeMJ8wQlXFFfgIL0PSO+EW/9y1wwFtOynspMuZnHodQX0GQvGx2zc4NWvbGmfSPhJZynUplmSGHU9mfd9h1qr+5pD9+6bHO2DkfTtGXDo/j+591RanEXYRsHgv8d8aP7c7i3GdOHZBhCtcqAU7zIhIADKuSXtljXiB7Gu6cJ4m0sT3inqweq4cVWAfVJ89zW4L75QgtMaPOWmLX4Wu7gwedQO4pEcIjLvy+5XekE3i/nkAJBE2d6QRtH/GwAe0Cod0Y9Kdzae4NyevxJiNPzfJy794ymA1TjERvZt54EV/S4hWYccPf6qALPDdnhVzUTi3AW/EcMumj5Tr+r+q1XxeIswMRRT2tw5fDKEw6MCK6CAwzCZwL1OFIvWZ3k/kdW5FrKOmSxn4FSEkfp0ewbhFjhnhR0i+Gl3plNCdkrA4mfyGCWXEhg0K8U3Mh1V6yypBuDyFc2SnDuuUQh06sf6fT+RkcKv5FwoafjiYO8QFaW1qGn/jMgepdm27gDSb157PRgsEjOJ4l8Tethye05UjwK3YLhisMKV/mZrkOx32zD2RzItxwdbZnh81j3H7LcOXxbqgIoms00mAGC0q5DObBUscbiFeXLcgCI5g==
X-Forefront-Antispam-Report: 
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	3oQpmZsrneM9w2LbLTdmiLH24RZGL9BaRZezWAc84n3jrAtMqKE9g7po2PusgVZrGkp1Dkn7sC942MsvaRPzK+0kqZD33eFu0689jIkQIsL+AIXvfx2ogqB8zuSbiTon7p1ix9ptfdq/zKeb/H2ssQLFovhbQ3x7hd9KUX50Ff6jFbSy08v7+/5rnB2jPGaz5uk5HNdySL5vS7WKYOuL1hyItvOjzus8X4LiwpFy2Dh4SQ9qxLdOW2HtG867AYZ46h+wuvZeiU3lUCHJmpHRg1xsIVR3EwAbiRjfUq6UwpFmdO0uULL+gnzeTx3Aopu/p8kAmmSxGiBYdRIPZ+HoQMvWu6Q3sqLb4E0HOaCC+v9JcQDXpyb8esAU9X4CDoq9xDjG+GgyyPtQfLSCjKs8VmAAvbSliocd/2V0nYioZy9SQHLW8/JPSkxNgXCWo2VO
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 05:44:56.6421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 f8cf3258-251a-4410-d9ed-08de91442330
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6655
Message-ID-Hash: UHESNWR4ESYCFNG5RUWQMS6SWLGFACUF
X-Message-ID-Hash: UHESNWR4ESYCFNG5RUWQMS6SWLGFACUF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UHESNWR4ESYCFNG5RUWQMS6SWLGFACUF/>
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
index 41b89fcc69c3..b2ce420f931a 100644
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
+	{ "TXNW2020", &tasdevice_id[TAS2020] },
+	{ "TXNW2118", &tasdevice_id[TAS2118] },
+	{ "TXNW2120", &tasdevice_id[TAS2120] },
+	{ "TXNW2320", &tasdevice_id[TAS2320] },
+	{ "TXNW2563", &tasdevice_id[TAS2563] },
+	{ "TXNW2568", &tasdevice_id[TAS2568] },
+	{ "TXNW2570", &tasdevice_id[TAS2570] },
+	{ "TXNW2572", &tasdevice_id[TAS2572] },
+	{ "TXNW2574", &tasdevice_id[TAS2574] },
+	{ "TXNW2781", &tasdevice_id[TAS2781] },
+	{ "TXNW5802", &tasdevice_id[TAS5802] },
+	{ "TXNW806M", &tasdevice_id[TAS5806M] },
+	{ "TXNW806D", &tasdevice_id[TAS5806MD] },
+	{ "TXNW5815", &tasdevice_id[TAS5815] },
+	{ "TXNW5822", &tasdevice_id[TAS5822] },
+	{ "TXNW5825", &tasdevice_id[TAS5825] },
+	{ "TXNW5827", &tasdevice_id[TAS5827] },
+	{ "TXNW5828", &tasdevice_id[TAS5828] },
+	{ "TXNW5830", &tasdevice_id[TAS5830] },
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

