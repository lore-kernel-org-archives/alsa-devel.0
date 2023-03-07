Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849C0C678D5
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Mar 2023 09:41:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 41E071402;
	Tue,  7 Mar 2023 10:40:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 41E071402
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678182072;
	bh=I7joKohvavWyQSqvSbnJOvTmio0viXgERUb4Y7n4YbE=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=p0nbYPWhp9R19ZEnIAnBRJ78mRXo0NaQ2EetHwb8/+TI57fev+eX1/8p1jgcT3P5d
	 RUjDmw0UbHu1KYGNKtNdKHQ8wJd0bQmZsKtgE0KyDBTxZ8j8P4KjYpTwqkUTVNmOrJ
	 UxVGaS6AR7ibSK4kbKcq9TRZC1jjhfIAd82qoPEM=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D228AF80520;
	Tue,  7 Mar 2023 10:39:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D437BF80482; Tue,  7 Mar 2023 10:39:12 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E592DF80236
	for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2023 10:39:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E592DF80236
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=jDiic4uc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678181946; x=1709717946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I7joKohvavWyQSqvSbnJOvTmio0viXgERUb4Y7n4YbE=;
  b=jDiic4uchhegYIVGCLp9IIcAJ2V6uR+qIlA43FefEyc+s/5BjbVH8Ywg
   zwR9fNRYIlcrdXGbPgSOKs3kOTj/GfxxDCPQpZd28pXyLyFZUDPxFwTAZ
   4jihSCU/4AjD9cQ3YK4wC4Gsc38RiVgtaDpEHIp9DTexrGZNNlRYCyCBH
   DLbCBd2izbIjV7BPIpcRmQAnpsJzDDdKwFzFhK4iLI0yYyS1VU1TyO9Nh
   OTB5b2u2yH1t3d8RgQsh0cmkYYZ8rBhx3jj/8IYBSpOU79NpP714DB0Iu
   rSjNVfUiv6k3ffg+Ogu9+NJMTtynjbopFx3HOzdC1jfpfBZ0oWN5iYcMP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="338132623"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400";
   d="scan'208";a="338132623"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2023 01:39:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="676504888"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400";
   d="scan'208";a="676504888"
Received: from rganesh-mobl.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.47.75])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2023 01:39:00 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Subject: [PATCH 3/4] ASoC: SOF: Intel: SKL: Fix device description
Date: Tue,  7 Mar 2023 11:39:13 +0200
Message-Id: <20230307093914.25409-4-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307093914.25409-1-peter.ujfalusi@linux.intel.com>
References: <20230307093914.25409-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 5JYAU3TGIOB5ABIHORPMTF3W3YPOSQEI
X-Message-ID-Hash: 5JYAU3TGIOB5ABIHORPMTF3W3YPOSQEI
X-MailFrom: peter.ujfalusi@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
 yung-chuan.liao@linux.intel.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: <>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

Add missing ops_free callback for SKL/KBL platforms.

Fixes: 52d7939d10f2 ("ASoC: SOF: Intel: add ops for SKL/KBL")

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/intel/pci-skl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sof/intel/pci-skl.c b/sound/soc/sof/intel/pci-skl.c
index 3a99dc444f92..5b4bccf81965 100644
--- a/sound/soc/sof/intel/pci-skl.c
+++ b/sound/soc/sof/intel/pci-skl.c
@@ -38,6 +38,7 @@ static struct sof_dev_desc skl_desc = {
 	.nocodec_tplg_filename = "sof-skl-nocodec.tplg",
 	.ops = &sof_skl_ops,
 	.ops_init = sof_skl_ops_init,
+	.ops_free = hda_ops_free,
 };
 
 static struct sof_dev_desc kbl_desc = {
@@ -61,6 +62,7 @@ static struct sof_dev_desc kbl_desc = {
 	.nocodec_tplg_filename = "sof-kbl-nocodec.tplg",
 	.ops = &sof_skl_ops,
 	.ops_init = sof_skl_ops_init,
+	.ops_free = hda_ops_free,
 };
 
 /* PCI IDs */
-- 
2.39.2

