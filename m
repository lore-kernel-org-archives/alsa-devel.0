Return-Path: <SRS0=9THl=4Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3AEC3F2CD
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Feb 2020 23:17:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D0D5246B4
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Feb 2020 23:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fLRoO13z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0D5246B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 77BB616EB;
	Sat, 29 Feb 2020 00:16:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 77BB616EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582931828;
	bh=dO1aZDexHNnh53JodSl09T+U2eHM2GO0g6dawGYnKzA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fLRoO13zqicmUQYtCL1dW2RUOZqJeYjI0S30LpOj+VIbnr4SPWLbY9mh18tUZkIfY
	 8S0d7o1wu/eeHIjwdfpG3jN+PwtiL/0nDuZ2bNWdSkk7AnuyvXInvTeKzzAZ+DxmMV
	 7gVwY8hipmHvv58KztXnLYOGuGWQZtw4WJTz33HI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D409AF802A2;
	Sat, 29 Feb 2020 00:12:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 41AF6F8027D; Sat, 29 Feb 2020 00:12:27 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 08371F8016F
 for <alsa-devel@alsa-project.org>; Sat, 29 Feb 2020 00:12:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 08371F8016F
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Feb 2020 15:12:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,497,1574150400"; d="scan'208";a="232402960"
Received: from rbconrad-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.95.100])
 by orsmga008.jf.intel.com with ESMTP; 28 Feb 2020 15:12:17 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 6/9] ASoC: Intel: skylake: (cosmetic) remove redundant
 variable initialisations
Date: Fri, 28 Feb 2020 17:12:01 -0600
Message-Id: <20200228231204.9026-7-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228231204.9026-1-pierre-louis.bossart@linux.intel.com>
References: <20200228231204.9026-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>

Variables, used as loop iterators, don't need to be initialised.

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/skylake/skl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index f755ca2484cf..1aa8114a4f77 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -359,7 +359,7 @@ static int skl_resume(struct device *dev)
 	struct pci_dev *pci = to_pci_dev(dev);
 	struct hdac_bus *bus = pci_get_drvdata(pci);
 	struct skl_dev *skl  = bus_to_skl(bus);
-	struct hdac_ext_link *hlink = NULL;
+	struct hdac_ext_link *hlink;
 	int ret;
 
 	/*
@@ -794,7 +794,7 @@ static void skl_probe_work(struct work_struct *work)
 {
 	struct skl_dev *skl = container_of(work, struct skl_dev, probe_work);
 	struct hdac_bus *bus = skl_to_bus(skl);
-	struct hdac_ext_link *hlink = NULL;
+	struct hdac_ext_link *hlink;
 	int err;
 
 	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI)) {
-- 
2.20.1

