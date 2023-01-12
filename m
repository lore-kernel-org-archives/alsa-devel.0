Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A72C54EBC
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Jan 2023 11:30:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1CFA28B1E;
	Thu, 12 Jan 2023 12:29:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1CFA28B1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673523002;
	bh=vjV8y8LbzUXQrt45Puugictbqi3QHzP5bvn2L0BGWt0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=EJUBg0q89SB1CTayPti74N8WFWxi0Kxvs9MzeKCD4LTcuF8yLC/3zEvjdx8W+q4Vf
	 Z+Fe4KUcyZIe2BMqDfa1g4JlNijvAhIoEgspZu96EZZCDd4JktNPht1SdQIC7OKDRN
	 h91uy7+EgfT71eXkVxj5ukOQF+sGk+dNy6+NK9KU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 28989F8053A;
	Thu, 12 Jan 2023 12:28:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 03175F804BD; Thu, 12 Jan 2023 12:28:37 +0100 (CET)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1B242F804BD
 for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2023 12:28:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1B242F804BD
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=lukPGu8c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1673522915; x=1705058915;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vjV8y8LbzUXQrt45Puugictbqi3QHzP5bvn2L0BGWt0=;
 b=lukPGu8cTVRrou3Iz7wtVw8HKZxba3w1ypRRZFIefXV5e8Ri0yr4q1kO
 GJ5+X4ZcAqNX7uo6u+HMSx6Riw1kn1Pe1LSWUOshwymDzWcyc86Eo2fCL
 r0rYGZNDVGyKNCWgA0I2pQIttezhHcgRPXaf+v8nODL9krfkKH7B3kvVD
 2PA6YovXLjtQl1umufAfUDUlwH63gr/UIe1QKD/3poFwMvE44YAo6x4kV
 A5lVZAQ9LJe4w+xYB4osFj6NPNv2jIcE8l8fLBIv1fhu8odS4Mwbk5g9I
 HWFv4HyOOoHjn2zrmUFUjvSOTcO2PnrkXH78F6X+zDDbv6oqp55JRYdZv g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="385994938"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; d="scan'208";a="385994938"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2023 03:28:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="986519423"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; d="scan'208";a="986519423"
Received: from black.fi.intel.com ([10.237.72.28])
 by fmsmga005.fm.intel.com with ESMTP; 12 Jan 2023 03:28:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 7C04B14B; Thu, 12 Jan 2023 13:28:56 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] ASoC: Intel: bytcr_rt5651: Drop reference count of
 ACPI device after use
Date: Thu, 12 Jan 2023 13:28:49 +0200
Message-Id: <20230112112852.67714-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230112112852.67714-1-andriy.shevchenko@linux.intel.com>
References: <20230112112852.67714-1-andriy.shevchenko@linux.intel.com>
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
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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

Fixes: 02c0a3b3047f ("ASoC: Intel: bytcr_rt5651: add MCLK, quirks and cleanups")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 81ac6eeda2e6..8fca9b82d4d0 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -922,7 +922,6 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 	if (adev) {
 		snprintf(byt_rt5651_codec_name, sizeof(byt_rt5651_codec_name),
 			 "i2c-%s", acpi_dev_name(adev));
-		put_device(&adev->dev);
 		byt_rt5651_dais[dai_index].codecs->name = byt_rt5651_codec_name;
 	} else {
 		dev_err(dev, "Error cannot find '%s' dev\n", mach->id);
@@ -930,6 +929,7 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 	}
 
 	codec_dev = acpi_get_first_physical_node(adev);
+	acpi_dev_put(adev);
 	if (!codec_dev)
 		return -EPROBE_DEFER;
 	priv->codec_dev = get_device(codec_dev);
-- 
2.39.0

