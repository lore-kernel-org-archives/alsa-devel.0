Return-Path: <SRS0=AF2s=O2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A609EC4332F
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 15:12:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 264E560F22
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 15:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 264E560F22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9469A112;
	Wed,  6 Oct 2021 17:11:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9469A112
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633533145;
	bh=HBCcvCSsw2g9sZdqfhWU/8t9mUvR9ZaKG31ekb4nE0Q=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BEOGH6RpCglVe58f5oRkQIy0D3bbHRsJxDQzlf2iqq87wREdFVk4Xex2WDyQzzuc2
	 2X8nCxMbG+Mk90N4a3cbTstmGruYSPoWgNyRkiFVr7q4Mhb8RfiHRGUR7+wa1YQ3IW
	 qnOtGP4JWcNsaGYtWRHN+L8OMvInDxZcggfcah7M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1DED0F80240;
	Wed,  6 Oct 2021 17:11:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6663FF80249; Wed,  6 Oct 2021 17:11:33 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5396FF8020D
 for <alsa-devel@alsa-project.org>; Wed,  6 Oct 2021 17:11:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5396FF8020D
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="223411042"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; d="scan'208";a="223411042"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2021 08:04:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; d="scan'208";a="714830220"
Received: from black.fi.intel.com ([10.237.72.28])
 by fmsmga005.fm.intel.com with ESMTP; 06 Oct 2021 08:04:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id EAE281C8; Wed,  6 Oct 2021 18:04:31 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/4] ASoC: Intel: bytcht_es8316: Switch to use
 gpiod_get_optional()
Date: Wed,  6 Oct 2021 18:04:27 +0300
Message-Id: <20211006150428.16434-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006150428.16434-1-andriy.shevchenko@linux.intel.com>
References: <20211006150428.16434-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>
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

First of all, replace indexed API by plain one since we have index 0.
Second, switch to optional variant and drop duplicated code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/intel/boards/bytcht_es8316.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 171f3d8c5996..d8dcf63825a6 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -566,16 +566,12 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 
 	devm_acpi_dev_add_driver_gpios(codec_dev, byt_cht_es8316_gpios);
 	priv->speaker_en_gpio =
-		gpiod_get_index(codec_dev, "speaker-enable", 0,
-				/* see comment in byt_cht_es8316_resume */
-				GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
-
+		gpiod_get_optional(codec_dev, "speaker-enable",
+				   /* see comment in byt_cht_es8316_resume() */
+				   GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
 	if (IS_ERR(priv->speaker_en_gpio)) {
 		ret = PTR_ERR(priv->speaker_en_gpio);
 		switch (ret) {
-		case -ENOENT:
-			priv->speaker_en_gpio = NULL;
-			break;
 		default:
 			dev_err(dev, "get speaker GPIO failed: %d\n", ret);
 			fallthrough;
-- 
2.33.0

