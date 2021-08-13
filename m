Return-Path: <SRS0=Pedv=NE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92695C4338F
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Aug 2021 15:14:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E9D961153
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Aug 2021 15:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1E9D961153
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9E525188B;
	Fri, 13 Aug 2021 17:14:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9E525188B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628867693;
	bh=G8qzkS/GLdtX1D04ebU3OFSCfo0p/NcxL1q9RaV9Rqw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vRmSxX4ha23cQxjzYS8YFG9AsKNRngvYWwyMCg5X42qp+ECugFGJdyIcYczsLqAns
	 boMe4cyqo8KD00yRjIES3UrYnJpRgocQ+gryvs9schdE22fd/Ygnf1ysDim2exAjV2
	 DRBLEf0q5IBFdztFwftGVr/Rnk/SPr1Wcrc1lOKQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7AB48F804FB;
	Fri, 13 Aug 2021 17:11:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 85D73F804E6; Fri, 13 Aug 2021 17:11:51 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DBB45F804B4
 for <alsa-devel@alsa-project.org>; Fri, 13 Aug 2021 17:11:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DBB45F804B4
X-IronPort-AV: E=McAfee;i="6200,9189,10075"; a="215301900"
X-IronPort-AV: E=Sophos;i="5.84,319,1620716400"; d="scan'208";a="215301900"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2021 08:11:33 -0700
X-IronPort-AV: E=Sophos;i="5.84,319,1620716400"; d="scan'208";a="422888870"
Received: from mchatter-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.54.162])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2021 08:11:32 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v3 7/8] ASoC: Intel: remove device_properties for Atom boards
Date: Fri, 13 Aug 2021 10:11:15 -0500
Message-Id: <20210813151116.23931-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210813151116.23931-1-pierre-louis.bossart@linux.intel.com>
References: <20210813151116.23931-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, broonie@kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

Prepare the transition to the software node API by removing device
properties in the probe error handling and .remove callback.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcht_es8316.c | 2 ++
 sound/soc/intel/boards/bytcr_rt5640.c  | 5 ++++-
 sound/soc/intel/boards/bytcr_rt5651.c  | 5 ++++-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index d2e0a0b441fc..f3919baaad08 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -615,6 +615,7 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 	return 0;
 
 err_put_codec:
+	device_remove_properties(priv->codec_dev);
 	put_device(priv->codec_dev);
 	return ret;
 }
@@ -625,6 +626,7 @@ static int snd_byt_cht_es8316_mc_remove(struct platform_device *pdev)
 	struct byt_cht_es8316_private *priv = snd_soc_card_get_drvdata(card);
 
 	gpiod_put(priv->speaker_en_gpio);
+	device_remove_properties(priv->codec_dev);
 	put_device(priv->codec_dev);
 	return 0;
 }
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 4215bbafd2f7..41fd56d42103 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -1481,7 +1481,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	/* Must be called before register_card, also see declaration comment. */
 	ret_val = byt_rt5640_add_codec_device_props(codec_dev, priv);
 	if (ret_val)
-		goto err;
+		goto err_device;
 
 	log_quirks(&pdev->dev);
 
@@ -1584,6 +1584,8 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	return ret_val;
 
 err:
+	device_remove_properties(priv->codec_dev);
+err_device:
 	put_device(priv->codec_dev);
 	return ret_val;
 }
@@ -1593,6 +1595,7 @@ static int snd_byt_rt5640_mc_remove(struct platform_device *pdev)
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 	struct byt_rt5640_private *priv = snd_soc_card_get_drvdata(card);
 
+	device_remove_properties(priv->codec_dev);
 	put_device(priv->codec_dev);
 	return 0;
 }
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index c70dd729cdbb..cc1505e53b4f 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -997,7 +997,7 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 	/* Must be called before register_card, also see declaration comment. */
 	ret_val = byt_rt5651_add_codec_device_props(codec_dev);
 	if (ret_val)
-		goto err;
+		goto err_device;
 
 	/* Cherry Trail devices use an external amplifier enable gpio */
 	if (soc_intel_is_cht() && !byt_rt5651_gpios)
@@ -1125,6 +1125,8 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 	return ret_val;
 
 err:
+	device_remove_properties(priv->codec_dev);
+err_device:
 	put_device(priv->codec_dev);
 	return ret_val;
 }
@@ -1134,6 +1136,7 @@ static int snd_byt_rt5651_mc_remove(struct platform_device *pdev)
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 	struct byt_rt5651_private *priv = snd_soc_card_get_drvdata(card);
 
+	device_remove_properties(priv->codec_dev);
 	put_device(priv->codec_dev);
 	return 0;
 }
-- 
2.25.1

