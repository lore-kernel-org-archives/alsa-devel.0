Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA00C43334
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jul 2022 10:02:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 23D7D82E;
	Mon, 11 Jul 2022 12:01:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 23D7D82E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657533755;
	bh=1oSD9MqauB/qwzh9VWhLPcyk4oTHCUen8yzMNm9SlPE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JLok/W2TaL2YggOHtl6n+5rg7VVkmelssSaFMiU5ncWYBD4KH02KyqLKZSCgpqgJP
	 PDrXzq5/QgdRJ+Z/CAs14hvZKYq+uZ1YKY2ANnbLJZ5dmMUMkHpEDDSCawlMf9M36F
	 SlzI4J81Ewyd9pasqMjN+k3GbkIx0rwjPJRZ9fYI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 891E0F8047C;
	Mon, 11 Jul 2022 12:01:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 84FE1F80256; Mon, 11 Jul 2022 12:01:36 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0EA3BF80256
 for <alsa-devel@alsa-project.org>; Mon, 11 Jul 2022 12:01:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0EA3BF80256
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="gOv/2ExK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1657533691; x=1689069691;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1oSD9MqauB/qwzh9VWhLPcyk4oTHCUen8yzMNm9SlPE=;
 b=gOv/2ExK0smpU3UWjokYMtx+ZfwJqHpkLZ0/xUK29xGuQFdjFyuLYIX8
 MjoZUz3fL17qIlYN25Vz5Sw+mgJveYUkEJM5G8gX3YzZLhdQNfhlpOB5L
 BohmjqcpPho0Ve9ly2e9XAUd88EgWV7gHBIJ0ul/le6l2I3EjLSWvaUND
 /5FFDqLslZqkBGTAjT1p2pYar7pVlo/+1fvKfnIavRYKFpmOBkheXn2Ea
 UEFT/nj2lBsRVE6DCsjgCDGojct+v7/KJGnKAdcTqDS5EHkxTuB2SXFem
 qQNYPW6CGJpp1rGaf1mVkTQhiigsRbBATykovccoBcUiwf5P8bvch743k A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="282173597"
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; d="scan'208";a="282173597"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2022 03:01:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; d="scan'208";a="840955816"
Received: from black.fi.intel.com ([10.237.72.28])
 by fmsmga006.fm.intel.com with ESMTP; 11 Jul 2022 03:01:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id DD1561A0; Mon, 11 Jul 2022 13:01:30 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Takashi Iwai <tiwai@suse.de>,
 Lucas Tanure <tanureal@opensource.cirrus.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] ALSA: hda: cs35l41: Fix comments wrt
 serial-multi-instantiate reference
Date: Mon, 11 Jul 2022 13:01:29 +0300
Message-Id: <20220711100129.37326-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>,
 David Rhodes <david.rhodes@cirrus.com>, Takashi Iwai <tiwai@suse.com>,
 James Schulman <james.schulman@cirrus.com>
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

The comments are inconsistent and point to the wrong driver name.
The initially named i2c-multi-instantiate it was renamed to the
serial-multi-instantiate exactly due to support of the platforms
with multiple CS35L41 codecs.

Fix comments accordingly.

While at it, drop file names from the files.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/pci/hda/cs35l41_hda.c     | 4 ++--
 sound/pci/hda/cs35l41_hda_i2c.c | 7 ++++---
 sound/pci/hda/cs35l41_hda_spi.c | 7 ++++---
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 23a97ada7272..49b25432a9f5 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -415,8 +415,8 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 no_acpi_dsd:
 	/*
 	 * Device CLSA0100 doesn't have _DSD so a gpiod_get by the label reset won't work.
-	 * And devices created by i2c-multi-instantiate don't have their device struct pointing to
-	 * the correct fwnode, so acpi_dev must be used here.
+	 * And devices created by serial-multi-instantiate don't have their device struct
+	 * pointing to the correct fwnode, so acpi_dev must be used here.
 	 * And devm functions expect that the device requesting the resource has the correct
 	 * fwnode.
 	 */
diff --git a/sound/pci/hda/cs35l41_hda_i2c.c b/sound/pci/hda/cs35l41_hda_i2c.c
index 5cfb5aac37ac..df39fc76e6be 100644
--- a/sound/pci/hda/cs35l41_hda_i2c.c
+++ b/sound/pci/hda/cs35l41_hda_i2c.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 //
-// cs35l41.c -- CS35l41 HDA I2C driver
+// CS35l41 HDA I2C driver
 //
 // Copyright 2021 Cirrus Logic, Inc.
 //
@@ -16,8 +16,9 @@ static int cs35l41_hda_i2c_probe(struct i2c_client *clt, const struct i2c_device
 {
 	const char *device_name;
 
-	/* Compare against the device name so it works for I2C, normal ACPI
-	 * and for ACPI by i2c-multi-instantiate matching cases
+	/*
+	 * Compare against the device name so it works for SPI, normal ACPI
+	 * and for ACPI by serial-multi-instantiate matching cases.
 	 */
 	if (strstr(dev_name(&clt->dev), "CLSA0100"))
 		device_name = "CLSA0100";
diff --git a/sound/pci/hda/cs35l41_hda_spi.c b/sound/pci/hda/cs35l41_hda_spi.c
index c9a61675c4fd..2f5afad3719e 100644
--- a/sound/pci/hda/cs35l41_hda_spi.c
+++ b/sound/pci/hda/cs35l41_hda_spi.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 //
-// cs35l41.c -- CS35l41 HDA SPI driver
+// CS35l41 HDA SPI driver
 //
 // Copyright 2021 Cirrus Logic, Inc.
 //
@@ -16,8 +16,9 @@ static int cs35l41_hda_spi_probe(struct spi_device *spi)
 {
 	const char *device_name;
 
-	/* Compare against the device name so it works for SPI, normal ACPI
-	 * and for ACPI by spi-multi-instantiate matching cases
+	/*
+	 * Compare against the device name so it works for SPI, normal ACPI
+	 * and for ACPI by serial-multi-instantiate matching cases.
 	 */
 	if (strstr(dev_name(&spi->dev), "CSC3551"))
 		device_name = "CSC3551";
-- 
2.35.1

