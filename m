Return-Path: <SRS0=Fseo=P4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FDAC433F5
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Nov 2021 22:20:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CF6C61A6C
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Nov 2021 22:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6CF6C61A6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D5359166F;
	Tue,  9 Nov 2021 23:19:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D5359166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636496445;
	bh=Rja146KzOm0/s8CDy5JgYf7S3NFAd/+ima/ub2lNy4o=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U1bM44uwJfbD/WCVfW2dbUbadDm/RUFXCKemhAloUXa7Lj1AZvzPQrvh9h71jcKdU
	 Q3Q1d9ooovknfzxokmzz73U+6WDylmBDm4WjnB2TCPLcFI4UZjXkaN1YxhJ6IMUry3
	 uQZR2LPsrK1+4QhqX/1LoaDeSPNGuP5PViXVGybo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 530EFF8050F;
	Tue,  9 Nov 2021 23:18:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 45B7BF80519; Tue,  9 Nov 2021 23:18:16 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D281EF8050F
 for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2021 23:18:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D281EF8050F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="no4BZiP1"
Received: by mail.kernel.org (Postfix) with ESMTPSA id BAA516124C;
 Tue,  9 Nov 2021 22:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636496287;
 bh=Rja146KzOm0/s8CDy5JgYf7S3NFAd/+ima/ub2lNy4o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=no4BZiP1AexfR2kg40jGP5MYf6sQr8gGeCwgawD496L9P6aB+2xoR3eJlldA5uoSZ
 xa0zBzyF/WOj/33Uj9fLKh2ysXOdNRP4apIHnFlo56zKB+CULpAzYxH4tcp53Dt9y4
 ly115o/TOUK/S2qVYkqroyXP49TcRF0WSQdaLTYZ153PhwHywwwbnoruFBmUWi9KGc
 /oGlk9t3G3KwLmlg7lIDTgSchB5+863r/JPs1B/iSKKDpLb1eVKVFJDDFkFbWg+RYJ
 V3SYNiobCNW24Ia7lPkp9lDZZIrcFDEkthuGt6wmJyawcIFFi5qxinkA81vvzfP7g8
 DZyOfSyjsykNA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 46/82] ALSA: intel-dsp-config: add quirk for
 APL/GLK/TGL devices based on ES8336 codec
Date: Tue,  9 Nov 2021 17:16:04 -0500
Message-Id: <20211109221641.1233217-46-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211109221641.1233217-1-sashal@kernel.org>
References: <20211109221641.1233217-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, Huajun Li <huajun.li@intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.com,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
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

[ Upstream commit 9d36ceab94151f07cf3fcb067213ac87937adf12 ]

These devices are based on an I2C/I2S device, we need to force the use
of the SOF driver otherwise the legacy HDaudio driver will be loaded -
only HDMI will be supported.

Co-developed-by: Huajun Li <huajun.li@intel.com>
Signed-off-by: Huajun Li <huajun.li@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Link: https://lore.kernel.org/r/20211004213512.220836-3-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/intel-dsp-config.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index c9d0ba353463b..b9ac9e9e45a48 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -31,6 +31,7 @@ struct config_entry {
 	u16 device;
 	u8 acpi_hid[ACPI_ID_LEN];
 	const struct dmi_system_id *dmi_table;
+	u8 codec_hid[ACPI_ID_LEN];
 };
 
 /*
@@ -56,7 +57,7 @@ static const struct config_entry config_table[] = {
 /*
  * Apollolake (Broxton-P)
  * the legacy HDAudio driver is used except on Up Squared (SOF) and
- * Chromebooks (SST)
+ * Chromebooks (SST), as well as devices based on the ES8336 codec
  */
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_APOLLOLAKE)
 	{
@@ -73,6 +74,11 @@ static const struct config_entry config_table[] = {
 			{}
 		}
 	},
+	{
+		.flags = FLAG_SOF,
+		.device = 0x5a98,
+		.codec_hid = "ESSX8336",
+	},
 #endif
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_APL)
 	{
@@ -137,7 +143,7 @@ static const struct config_entry config_table[] = {
 
 /*
  * Geminilake uses legacy HDAudio driver except for Google
- * Chromebooks
+ * Chromebooks and devices based on the ES8336 codec
  */
 /* Geminilake */
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_GEMINILAKE)
@@ -154,6 +160,11 @@ static const struct config_entry config_table[] = {
 			{}
 		}
 	},
+	{
+		.flags = FLAG_SOF,
+		.device = 0x3198,
+		.codec_hid = "ESSX8336",
+	},
 #endif
 
 /*
@@ -311,6 +322,11 @@ static const struct config_entry config_table[] = {
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
 		.device = 0x43c8,
 	},
+	{
+		.flags = FLAG_SOF,
+		.device = 0xa0c8,
+		.codec_hid = "ESSX8336",
+	},
 #endif
 
 /* Elkhart Lake */
@@ -354,6 +370,8 @@ static const struct config_entry *snd_intel_dsp_find_config
 			continue;
 		if (table->dmi_table && !dmi_check_system(table->dmi_table))
 			continue;
+		if (table->codec_hid[0] && !acpi_dev_present(table->codec_hid, NULL, -1))
+			continue;
 		return table;
 	}
 	return NULL;
-- 
2.33.0

