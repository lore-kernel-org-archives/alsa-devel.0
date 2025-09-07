Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6F3CA101F
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Sep 2025 22:30:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 21114601F8;
	Mon,  8 Sep 2025 00:30:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 21114601F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1757284214;
	bh=4MPBud9tVUqifZN583Fp4NLbvT6urspuOu1Pb90NyIQ=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=CDyNEFUPyJB0P9vNNu3iYvzsfkvRQZC8AaxCNbAuaSlqww3MAA5zNa+KtmlBhmRxv
	 9tR3hj4rQS1RDl4NQnRiHYYHmZbe23DRohjmAluDRduMgMGHbOrzBQGsy8wYZnpWNJ
	 jyJlOWwlX2O1tYIOgNrL4jlQYgUFQpBLVNS3w8vQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0E447F805C9; Mon,  8 Sep 2025 00:29:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2E534F80535;
	Mon,  8 Sep 2025 00:29:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 15BD3F80185; Mon,  8 Sep 2025 00:28:46 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3F090F80169
	for <alsa-devel@alsa-project.org>; Mon,  8 Sep 2025 00:28:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3F090F80169
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=ti-com-17Q1 header.b=jV5cJsy1
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 587MRaoJ3729158;
	Sun, 7 Sep 2025 17:27:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757284056;
	bh=gypNAM4Hpg7PEPlRPUtvsQ+DMkDWUbUx77nQpfzw5a0=;
	h=From:To:CC:Subject:Date;
	b=jV5cJsy1HYuzPZBs7cHFC2O06MHZydDrJ2CLbkPJC8Y7qYS48FNXxbKxcEHsiwFu2
	 qnmvVzmekOkJwpb5ZwW/MSWNbNxtqzFh37hRHimmftXo+CjWOTKMugQh8oKRvVa4/1
	 YK8iproN7SkxmU5Uyl12r1y9CdnYjM5AhYElhRRQ=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 587MRZ5H2543997
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sun, 7 Sep 2025 17:27:35 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sun, 7
 Sep 2025 17:27:34 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Sun, 7 Sep 2025 17:27:35 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.161.79])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 587MRVGH4072722;
	Sun, 7 Sep 2025 17:27:32 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <tiwai@suse.de>
CC: <broonie@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <13564923607@139.com>, <13916275206@139.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <baojun.xu@ti.com>, <Baojun.Xu@fpt.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v4] ALSA: hda/tas2781: Fix the order of TAS2781
 calibrated-data
Date: Mon, 8 Sep 2025 06:27:27 +0800
Message-ID: <20250907222728.988-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
Message-ID-Hash: STPYQH5PZWBNSQE6H6NNM43LFAPPJIUT
X-Message-ID-Hash: STPYQH5PZWBNSQE6H6NNM43LFAPPJIUT
X-MailFrom: shenghao-ding@ti.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/STPYQH5PZWBNSQE6H6NNM43LFAPPJIUT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

A bug reported by one of my customers that the order of TAS2781
calibrated-data is incorrect, the correct way is to move R0_Low
and insert it between R0 and InvR0.

Fixes: 4fe238513407 ("ALSA: hda/tas2781: Move and unified the calibrated-data getting function for SPI and I2C into the tas2781_hda lib")
Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
v4:
 - Add missing base into cali_cnv().
v3:
 - Take Tiwai's advice on cali_cnv() to make it more simpler.
v2:
 - Submit to the sound branch maintained by Tiwai instead of linux-next
   branch
 - Drop other fix
---
 sound/hda/codecs/side-codecs/tas2781_hda.c | 25 +++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/sound/hda/codecs/side-codecs/tas2781_hda.c b/sound/hda/codecs/side-codecs/tas2781_hda.c
index f46d2e06c64f..536940c78f00 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda.c
@@ -33,6 +33,23 @@ const efi_guid_t tasdev_fct_efi_guid[] = {
 };
 EXPORT_SYMBOL_NS_GPL(tasdev_fct_efi_guid, "SND_HDA_SCODEC_TAS2781");
 
+/*
+ * The order of calibrated-data writing function is a bit different from the
+ * order in UEFI. Here is the conversion to match the order of calibrated-data
+ * writing function.
+ */
+static void cali_cnv(unsigned char *data, unsigned int base, int offset)
+{
+	struct cali_reg reg_data;
+
+	memcpy(&reg_data, &data[base], sizeof(reg_data));
+	/* the data order has to be swapped between r0_low_reg and inv0_reg */
+	swap(reg_data.r0_low_reg, reg_data.invr0_reg);
+
+	cpu_to_be32_array((__force __be32 *)(data + offset + 1),
+		(u32 *)&reg_data, TASDEV_CALIB_N);
+}
+
 static void tas2781_apply_calib(struct tasdevice_priv *p)
 {
 	struct calidata *cali_data = &p->cali_data;
@@ -103,8 +120,7 @@ static void tas2781_apply_calib(struct tasdevice_priv *p)
 
 				data[l] = k;
 				oft++;
-				for (i = 0; i < TASDEV_CALIB_N * 4; i++)
-					data[l + i + 1] = data[4 * oft + i];
+				cali_cnv(data, 4 * oft, l);
 				k++;
 			}
 		}
@@ -130,9 +146,8 @@ static void tas2781_apply_calib(struct tasdevice_priv *p)
 
 		for (j = p->ndev - 1; j >= 0; j--) {
 			l = j * (cali_data->cali_dat_sz_per_dev + 1);
-			for (i = TASDEV_CALIB_N * 4; i > 0 ; i--)
-				data[l + i] = data[p->index * 5 + i];
-			data[l+i] = j;
+			cali_cnv(data, cali_data->cali_dat_sz_per_dev * j, l);
+			data[l] = j;
 		}
 	}
 
-- 
2.43.0

