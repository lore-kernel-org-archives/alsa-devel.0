Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33B7C3DA7A
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Jan 2023 20:31:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 83C7EA8C3;
	Mon,  2 Jan 2023 21:30:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 83C7EA8C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1672691501;
	bh=Tuh2SSmJnpDPTtlBWbyywMESzagl6YRuFPwYuCTfJEU=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=StADf+tfdu9ySx7yA1MocWjY6tqORYa9YaclnlBFsvJQJ3cvLazua8CA3dci56t/+
	 oPJoVfeY7a2RET87JjMrlcyl03MoG3vzfDAh1ebtNJZQeDhZPSejx4s8uCIGg2/wui
	 lVuBm1JReONrTZn+SSv/7qnuF4LI7/JNES1oihu0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7C738F8032D;
	Mon,  2 Jan 2023 21:30:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9B74BF80542; Mon,  2 Jan 2023 21:30:01 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AA9C1F80238
 for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2023 21:29:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AA9C1F80238
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=YIMbhNSa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1672691395; x=1704227395;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Tuh2SSmJnpDPTtlBWbyywMESzagl6YRuFPwYuCTfJEU=;
 b=YIMbhNSawYVPDiM9zPcVcZ1NwEJNAhmESfA56amU5LPMjm7PBqgrjYCu
 G4m3yQVE8emX1CqJUGbq0/I1cTwnRBbbCQmNLtampmVHx58FLGb1P0H/2
 eXF8DwgXoVDNOIEwyHBcVF73U+Ymw/Oh+hreFVO9VLpuT+VkZKKeleg5L
 +usfZrS2Ttyzsjm+GdrwqgObuuZF4iqRArOqpRktoocg3mZQEqq8RBxWJ
 zUClpRHHfvyghrVgagSgFgcQRvrK6RlheSzODAwRxcm1AE+RmGjozWzRn
 OIhOq+I6Z3MtCOUCa7LysTg5qXNlktIx06uprNzXLiOOVQ5c5Xhv/6sQ6 A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="320252183"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; d="scan'208";a="320252183"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jan 2023 12:29:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="685170309"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; d="scan'208";a="685170309"
Received: from black.fi.intel.com ([10.237.72.28])
 by orsmga008.jf.intel.com with ESMTP; 02 Jan 2023 12:29:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id A66E3F4; Mon,  2 Jan 2023 22:30:16 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/6] ASoC: amd: acp-es8336: Drop reference count of ACPI
 device after use
Date: Mon,  2 Jan 2023 22:30:09 +0200
Message-Id: <20230102203014.16041-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Theoretically the device might gone if its reference count drops to 0.
This might be the case when we try to find the first physical node of
the ACPI device. We need to keep reference to it until we get a result
of the above mentioned call. Refactor the code to drop the reference
count at the correct place.

While at it, move to acpi_dev_put() as symmetrical call to the
acpi_dev_get_first_match_dev().

Fixes: 02527c3f2300 ("ASoC: amd: add Machine driver for Jadeite platform")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/amd/acp-es8336.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/acp-es8336.c b/sound/soc/amd/acp-es8336.c
index 2fe8df86053a..89499542c803 100644
--- a/sound/soc/amd/acp-es8336.c
+++ b/sound/soc/amd/acp-es8336.c
@@ -198,9 +198,11 @@ static int st_es8336_late_probe(struct snd_soc_card *card)
 	int ret;
 
 	adev = acpi_dev_get_first_match_dev("ESSX8336", NULL, -1);
-	if (adev)
-		put_device(&adev->dev);
+	if (!adev)
+		return -ENODEV;
+
 	codec_dev = acpi_get_first_physical_node(adev);
+	acpi_dev_put(adev);
 	if (!codec_dev)
 		dev_err(card->dev, "can not find codec dev\n");
 
-- 
2.35.1

