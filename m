Return-Path: <SRS0=/Ps/=6F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57659C54FCC
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Apr 2020 20:26:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCBEA206D5
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Apr 2020 20:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MN1JwN80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCBEA206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4104616CB;
	Tue, 21 Apr 2020 22:25:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4104616CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587500763;
	bh=Adk0sBGn4bLrdBK6Y+7gptuQwJODiL1+281MO2ERjNg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MN1JwN80O0YzZ9V0h4O9eGtRmy8CC71UXKxljk4ttWfQxB4vbmmRz2pQv0H5lt6hs
	 RRI8UX9GH4l21pTsy0ejBotMWnaXuAa88jVOkkHVO4gYVJUKCsJOgCuG5nkwuRkh2U
	 FwH3mfZcsQNUDuZfrIk8013jVZobilprOk27xpk4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2A99AF80212;
	Tue, 21 Apr 2020 22:24:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0136FF80212; Tue, 21 Apr 2020 22:24:32 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 98035F800E7
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2020 22:24:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 98035F800E7
IronPort-SDR: MbxLIv/C7ppObZZFg+623BQSgN9I9DDe5nL0L9+cAnz1UIPNoA/UmwKABmCfhT7aj1YS/5joBq
 JG8aAKulj3Cw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2020 13:24:18 -0700
IronPort-SDR: E/aiDdgltIvdz83ByElHTt+kS4yFOEBqezm67/1e4D6DZGwbNOCm0a9o41dBtjoNXgMOPGXBkt
 p2cJYyE8J9zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,411,1580803200"; d="scan'208";a="456236664"
Received: from mgorski-all-series.igk.intel.com ([10.237.149.201])
 by fmsmga005.fm.intel.com with ESMTP; 21 Apr 2020 13:24:16 -0700
From: Mateusz Gorski <mateusz.gorski@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/4] ASoC: Intel: Skylake: Change the order of machine device
 and platform registration
Date: Tue, 21 Apr 2020 22:25:16 +0200
Message-Id: <20200421202519.4008-2-mateusz.gorski@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200421202519.4008-1-mateusz.gorski@linux.intel.com>
References: <20200421202519.4008-1-mateusz.gorski@linux.intel.com>
Cc: cezary.rojewski@intel.com, Mateusz Gorski <mateusz.gorski@linux.intel.com>,
 tiwai@suse.com
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

Swap the order of machine device and platform device registration.
This change ensures that even if the codec enumeration falls late - during
the driver module or topology reload - i2s_dev field is always ready to
be used.

Follow-up patch uses data from this field to create alternative topology
name based on used machine device.

Signed-off-by: Mateusz Gorski <mateusz.gorski@linux.intel.com>
---
 sound/soc/intel/skylake/skl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 63182bfd7941..8473eb13ea65 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -819,16 +819,16 @@ static void skl_probe_work(struct work_struct *work)
 	/* create codec instances */
 	skl_codec_create(bus);
 
-	/* register platform dai and controls */
-	err = skl_platform_register(bus->dev);
+	err = skl_machine_device_register(skl);
 	if (err < 0) {
-		dev_err(bus->dev, "platform register failed: %d\n", err);
+		dev_err(bus->dev, "machine register failed: %d\n", err);
 		goto out_err;
 	}
 
-	err = skl_machine_device_register(skl);
+	/* register platform dai and controls */
+	err = skl_platform_register(bus->dev);
 	if (err < 0) {
-		dev_err(bus->dev, "machine register failed: %d\n", err);
+		dev_err(bus->dev, "platform register failed: %d\n", err);
 		goto out_err;
 	}
 
-- 
2.17.1

