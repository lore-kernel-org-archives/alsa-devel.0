Return-Path: <SRS0=rI3+=CL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC724C433E2
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 15:45:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53B732083B
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 15:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mHTLP52r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B732083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E6E251884;
	Wed,  2 Sep 2020 17:44:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E6E251884
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599061524;
	bh=WXMybJEudX8Am3BIpDVxTV6LVamajaHgjkcI2cKuMVc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mHTLP52rWBtMKZzbGypEmNLXaNMH3uvvK+x4Jfwq2ITVpdO/Q+EY8vORtvu5Cjnut
	 rnyVxLLGLeVilqM7qSJwogfaW3se+tiDaI9p+hE1UoYWNyjolFtv5FFRDJHcIA3iVe
	 Ll8XI9OOnAwR9lJNA96POXuZta8AvrQcEeUYCYRw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9EFCDF802C4;
	Wed,  2 Sep 2020 17:43:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 31D95F802D2; Wed,  2 Sep 2020 17:43:52 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3B6FFF800BA
 for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2020 17:43:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3B6FFF800BA
IronPort-SDR: 9PhaYe0m0/D5BYACI6oy8UH8xkG2/5m23VgmZEMZ5wTX3w/Xdu4UnWLy7n704RzEskeUriT3Gl
 I2vYv/zx4hYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="145149097"
X-IronPort-AV: E=Sophos;i="5.76,383,1592895600"; d="scan'208";a="145149097"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 08:43:35 -0700
IronPort-SDR: 2oHJ7YZTV9UaOjzhWtpGhsSFfYf5vd6wO0boFXJNMHcEx3prY6969TNiEqznQP3HfVSALub7eA
 GBm3paHpETAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,383,1592895600"; d="scan'208";a="502178875"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga006.fm.intel.com with ESMTP; 02 Sep 2020 08:43:33 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de
Subject: [PATCH] ALSA: hda: fix a runtime pm issue in SOF when integrated GPU
 is disabled
Date: Wed,  2 Sep 2020 18:42:18 +0300
Message-Id: <20200902154218.1440441-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 kai.vehmanen@linux.intel.com,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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

From: Rander Wang <rander.wang@intel.com>

In snd_hdac_device_init pm_runtime_set_active is called to
increase child_count in parent device. But when it is failed
to build connection with GPU for one case that integrated
graphic gpu is disabled, snd_hdac_ext_bus_device_exit will be
invoked to clean up a HD-audio extended codec base device. At
this time the child_count of parent is not decreased, which
makes parent device can't get suspended.

This patch calls pm_runtime_set_suspended to decrease child_count
in parent device in snd_hdac_device_exit to match with
snd_hdac_device_init. pm_runtime_set_suspended can make sure that
it will not decrease child_count if the device is already suspended.

Signed-off-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/hda/hdac_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index 333220f0f8af..3e9e9ac804f6 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -127,6 +127,8 @@ EXPORT_SYMBOL_GPL(snd_hdac_device_init);
 void snd_hdac_device_exit(struct hdac_device *codec)
 {
 	pm_runtime_put_noidle(&codec->dev);
+	/* keep balance of runtime PM child_count in parent device */
+	pm_runtime_set_suspended(&codec->dev);
 	snd_hdac_bus_remove_device(codec->bus, codec);
 	kfree(codec->vendor_name);
 	kfree(codec->chip_name);
-- 
2.27.0

