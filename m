Return-Path: <SRS0=v/9x=ND=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0AFC4338F
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Aug 2021 22:47:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E947A6104F
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Aug 2021 22:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E947A6104F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5A28D1933;
	Fri, 13 Aug 2021 00:46:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5A28D1933
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628808425;
	bh=lU99ajfUqVQHRJ8fkMvkTmoBQM8hlPLI79g3AoTRMxE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qts6mBBNsh3c1EfRakzcNXORvLT8DsAluuHkI8V80Mn+IGcudMRdBBLaKF8+tpKRQ
	 smm2CudUAQWQfd+menYaoNLZGCA0D2Fs10UjC0X5Jyo2R+9V9+pGV39ViCNzqa1AWU
	 qGBSTsSnA0Ec2A72QBlAUMI/CDbWD1q24MtsUFvg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 66713F804CF;
	Fri, 13 Aug 2021 00:45:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1633DF804E2; Fri, 13 Aug 2021 00:45:24 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 47942F800E5
 for <alsa-devel@alsa-project.org>; Fri, 13 Aug 2021 00:45:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 47942F800E5
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="212349752"
X-IronPort-AV: E=Sophos;i="5.84,317,1620716400"; d="scan'208";a="212349752"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2021 15:45:09 -0700
X-IronPort-AV: E=Sophos;i="5.84,317,1620716400"; d="scan'208";a="517647192"
Received: from evanklei-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.77.110])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2021 15:45:09 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 2/8] ASoC: Intel: boards: handle errors with
 acpi_dev_get_first_match_dev()
Date: Thu, 12 Aug 2021 17:44:37 -0500
Message-Id: <20210812224443.170144-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210812224443.170144-1-pierre-louis.bossart@linux.intel.com>
References: <20210812224443.170144-1-pierre-louis.bossart@linux.intel.com>
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

acpi_dev_get_first_match_dev() searches for an acpi_handle
instantiated by the ACPI table scanning done early during boot.

Two of three machine drivers using this search don't deal with errors
and the one which does (bytcr_rt5651) returns -ENODEV, which doesn't
make sense here: an alternate driver will not be probed.

Add consistent error handling and report -ENXIO

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcht_es8316.c | 3 +++
 sound/soc/intel/boards/bytcr_rt5640.c  | 3 +++
 sound/soc/intel/boards/bytcr_rt5651.c  | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index fcf7c9c04069..7c078a9f6deb 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -492,6 +492,9 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 			 "i2c-%s", acpi_dev_name(adev));
 		put_device(&adev->dev);
 		byt_cht_es8316_dais[dai_index].codecs->name = codec_name;
+	} else {
+		dev_err(&pdev->dev, "Error cannot find '%s' dev\n", mach->id);
+		return -ENXIO;
 	}
 
 	/* override plaform name, if required */
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 808bfb7fd81e..60ed954d7277 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -1396,6 +1396,9 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 			 "i2c-%s", acpi_dev_name(adev));
 		put_device(&adev->dev);
 		byt_rt5640_dais[dai_index].codecs->name = byt_rt5640_codec_name;
+	} else {
+		dev_err(&pdev->dev, "Error cannot find '%s' dev\n", mach->id);
+		return -ENXIO;
 	}
 
 	/*
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 7033c07f8fd6..b4307d1d5527 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -921,7 +921,7 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 		byt_rt5651_dais[dai_index].codecs->name = byt_rt5651_codec_name;
 	} else {
 		dev_err(&pdev->dev, "Error cannot find '%s' dev\n", mach->id);
-		return -ENODEV;
+		return -ENXIO;
 	}
 
 	codec_dev = bus_find_device_by_name(&i2c_bus_type, NULL,
-- 
2.25.1

