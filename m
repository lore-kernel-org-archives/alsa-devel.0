Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A68C5AE59
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Jun 2025 07:44:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 041A5601EF;
	Thu,  5 Jun 2025 09:44:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 041A5601EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1749109477;
	bh=4ozWqUmXXrZJXnr0+vysAd7smD9Bmmy2pGqVcniyJco=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=IDY4JGqB478wtJ2IBJ+16TH4aff629+54Q23mxpR4PSDfzv/ETpd7oog+Yf2nRzCx
	 t2ZRYET1HxuZYH8Fr+MZNdE8ck4TK/NkKAWgivzL0KEc4DW4c3rQvO0vbI6CkMFpB+
	 nKrUQaHSz3K1agkT+Cvb/67uK2Ey+gVfnDBbOn5E=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 59474F8063B; Thu,  5 Jun 2025 09:43:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 298F0F8062D;
	Thu,  5 Jun 2025 09:43:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5985DF80533; Mon,  2 Jun 2025 03:58:51 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 41D18F800F8
	for <alsa-devel@alsa-project.org>; Mon,  2 Jun 2025 03:58:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41D18F800F8
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=ti-com-17Q1 header.b=phvpv5NJ
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5521wfBE3078494;
	Sun, 1 Jun 2025 20:58:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1748829521;
	bh=75PyF2RwwFtLYBwrQfL9HZkeuGb78OlKBRJWzyIzhFc=;
	h=From:To:CC:Subject:Date;
	b=phvpv5NJFyHCVvNm0DXbeAYZM2hG8PWck+6+8brq5bPCryD1Ec6Iz2WyYvQexHokf
	 t7XodOZQk69BFqyO06Cn9/Qqesk9gy3u3C2VqgFbo49bj2V30rpFPKBQy7U60+S+7p
	 dHlcEdZWkDP3WcU9CzdikYxrMOhdwnqiiG7dDmdo=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5521we6r2623112
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sun, 1 Jun 2025 20:58:40 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 1
 Jun 2025 20:58:40 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 1 Jun 2025 20:58:40 -0500
Received: from lelvem-mr06.itg.ti.com ([10.250.165.138])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5521wYM12290387;
	Sun, 1 Jun 2025 20:58:35 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <tiwai@suse.de>
CC: <broonie@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <shenghao-ding@ti.com>,
 <navada@ti.com>,
        <13916275206@139.com>, <v-hampiholi@ti.com>, <v-po@ti.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <baojun.xu@ti.com>
Subject: [PATCH v1] ALSA: hda/tas2781: Add missed brace and hardware id
 re-order
Date: Mon, 2 Jun 2025 09:58:09 +0800
Message-ID: <20250602015809.20344-1-baojun.xu@ti.com>
X-Mailer: git-send-email 2.43.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-MailFrom: baojun.xu@ti.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: ROH2UAG4HJ4QMCUTFYACAMCFHIMNBTXR
X-Message-ID-Hash: ROH2UAG4HJ4QMCUTFYACAMCFHIMNBTXR
X-Mailman-Approved-At: Thu, 05 Jun 2025 07:43:17 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ROH2UAG4HJ4QMCUTFYACAMCFHIMNBTXR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This patch is do code clean and prepare for next patch,
which is relative with hardware id.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
 sound/pci/hda/tas2781_hda_i2c.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index d91eed9f7..eb2295b49 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -591,8 +591,9 @@ static int tas2781_hda_i2c_probe(struct i2c_client *clt)
 		device_name = "INT8866";
 		hda_priv->save_calibration = tas2563_save_calibration;
 		tas_hda->priv->global_addr = TAS2563_GLOBAL_ADDR;
-	} else
+	} else {
 		return -ENODEV;
+	}
 
 	tas_hda->priv->irq = clt->irq;
 	ret = tas2781_read_acpi(tas_hda->priv, device_name);
@@ -722,8 +723,8 @@ static const struct i2c_device_id tas2781_hda_i2c_id[] = {
 };
 
 static const struct acpi_device_id tas2781_acpi_hda_match[] = {
-	{"TIAS2781", 0 },
 	{"INT8866", 0 },
+	{"TIAS2781", 0 },
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, tas2781_acpi_hda_match);
-- 
2.43.0

