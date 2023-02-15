Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 984DAC636CC
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Feb 2023 10:38:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7640A74C;
	Wed, 15 Feb 2023 11:37:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7640A74C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1676457516;
	bh=n68fiawTxsOwpWewaFenhqUlJPW9B+6t1Sx8jUFXslg=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=g1E9XUzZYHqWTNH6tCI7XoFsSddv2PCHFSVmQmWOTfbWyUHZXKGlNVEB3wt8sx5US
	 DErkY30NBlluPKIkIlgFTK2aTFbxLgPSI5jRLzsSFzrNKK0EirsGNZ507CrotJt56i
	 TrnrGj0vYn1YxNdFg/80aZCLEQR/FZh/Wb8PywgE=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F300EF8047C;
	Wed, 15 Feb 2023 11:37:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F1C04F8047C; Wed, 15 Feb 2023 11:37:16 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 09D60F80083
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2023 11:37:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 09D60F80083
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=D7VqkJFX
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 31ENlbPE008365;
	Wed, 15 Feb 2023 04:37:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=sHSvGYlnsISZ23PnykHZ2seFs84/4K/dAUTOh+6PFPM=;
 b=D7VqkJFXxquJuzVJDIkRosicdkumxv8cxk7Pdu9nesH8bPIYEQkNcW596VWZ5m3GLeeh
 fJjrC3uqmyJRE9+ueTveewFlIOKOWPmt6xpTdVFtwp2oYZLw3O2/DWN8cBhg4d/H23h3
 cYSbmr6RZ/AWUc5PILAXeW/26PrJ3zLCj2diHCnkJbY6MV4I3dZJfmJD1sko2eigbCYb
 hVOroamkcY5qxuy3mg6+fNImdftaJFK2maWqiVK9K2oDXMGk3EwHs107L3el3BcNNbkQ
 jzvNN4WctDxfJytr3wbSvkAjrOkInW23OrMSy1/Vm26bmJdpv9Khp1YGsa+gpqDCjOhX /A==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3nrm8wgk07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Feb 2023 04:37:06 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Wed, 15 Feb
 2023 04:37:05 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.21 via Frontend
 Transport; Wed, 15 Feb 2023 04:37:05 -0600
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5188D2A1;
	Wed, 15 Feb 2023 10:37:05 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
Subject: [PATCH] ASoC: cs35l45: Remove separate tables module
Date: Wed, 15 Feb 2023 10:37:05 +0000
Message-ID: <20230215103705.3302716-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: YQ7upivJme4_0c-OB85oAMaHMIULGx21
X-Proofpoint-ORIG-GUID: YQ7upivJme4_0c-OB85oAMaHMIULGx21
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: N4SUV6LSTPHGPKNLR2VD6ZREEGYBN7WK
X-Message-ID-Hash: N4SUV6LSTPHGPKNLR2VD6ZREEGYBN7WK
X-MailFrom: prvs=74104ead9d=ckeepax@opensource.cirrus.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: lgirdwood@gmail.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/N4SUV6LSTPHGPKNLR2VD6ZREEGYBN7WK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

There is no reason to have a separate module for the tables file it just
holds regmap callbacks and register patches used by the main part of the
driver. Remove the separate module and merge it into the main driver
module.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/Kconfig  | 5 -----
 sound/soc/codecs/Makefile | 4 +---
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 4621674e68bf1..bd72c426a93d1 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -688,9 +688,6 @@ config SND_SOC_CS35L41_I2C
 	select SND_SOC_CS35L41
 	select REGMAP_I2C
 
-config SND_SOC_CS35L45_TABLES
-	tristate
-
 config SND_SOC_CS35L45
 	tristate
 
@@ -699,7 +696,6 @@ config SND_SOC_CS35L45_SPI
 	depends on SPI_MASTER
 	select REGMAP
 	select REGMAP_SPI
-	select SND_SOC_CS35L45_TABLES
 	select SND_SOC_CS35L45
 	help
 	  Enable support for Cirrus Logic CS35L45 smart speaker amplifier
@@ -710,7 +706,6 @@ config SND_SOC_CS35L45_I2C
 	depends on I2C
 	select REGMAP
 	select REGMAP_I2C
-	select SND_SOC_CS35L45_TABLES
 	select SND_SOC_CS35L45
 	help
 	  Enable support for Cirrus Logic CS35L45 smart speaker amplifier
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index a0a61554548eb..f1ca18f7946ca 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -63,8 +63,7 @@ snd-soc-cs35l41-lib-objs := cs35l41-lib.o
 snd-soc-cs35l41-objs := cs35l41.o
 snd-soc-cs35l41-spi-objs := cs35l41-spi.o
 snd-soc-cs35l41-i2c-objs := cs35l41-i2c.o
-snd-soc-cs35l45-tables-objs := cs35l45-tables.o
-snd-soc-cs35l45-objs := cs35l45.o
+snd-soc-cs35l45-objs := cs35l45.o cs35l45-tables.o
 snd-soc-cs35l45-spi-objs := cs35l45-spi.o
 snd-soc-cs35l45-i2c-objs := cs35l45-i2c.o
 snd-soc-cs42l42-objs := cs42l42.o
@@ -431,7 +430,6 @@ obj-$(CONFIG_SND_SOC_CS35L41)	+= snd-soc-cs35l41.o
 obj-$(CONFIG_SND_SOC_CS35L41_LIB)	+= snd-soc-cs35l41-lib.o
 obj-$(CONFIG_SND_SOC_CS35L41_SPI)	+= snd-soc-cs35l41-spi.o
 obj-$(CONFIG_SND_SOC_CS35L41_I2C)	+= snd-soc-cs35l41-i2c.o
-obj-$(CONFIG_SND_SOC_CS35L45_TABLES)	+= snd-soc-cs35l45-tables.o
 obj-$(CONFIG_SND_SOC_CS35L45)	+= snd-soc-cs35l45.o
 obj-$(CONFIG_SND_SOC_CS35L45_SPI)	+= snd-soc-cs35l45-spi.o
 obj-$(CONFIG_SND_SOC_CS35L45_I2C)	+= snd-soc-cs35l45-i2c.o
-- 
2.30.2

