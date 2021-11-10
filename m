Return-Path: <SRS0=1gO0=P5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6350C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Nov 2021 10:31:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A8676115A
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Nov 2021 10:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0A8676115A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5A1281674;
	Wed, 10 Nov 2021 11:30:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5A1281674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636540279;
	bh=krT5KLSah6ko04AdVzMqvvmEqIEQNbl7113Sl3Gegig=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JoOxf5frszoLmKI5wIm4PmUTqY0PX5fHtq5L0mV9FkYYvzG23HsPYhB0CJrZWHSB8
	 0GQqXIYsMmaPzr4gR/iWntKzKGCnNlP7Gp+wmh0DIs0Y6bZNHGO/VmVsRUdeMoTlZk
	 LIlE9b3Pk1cCYaIbVye9PrhU0I7RbxDf67vFb+Zo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3F7C8F804E2;
	Wed, 10 Nov 2021 11:29:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D10B1F80227; Wed, 10 Nov 2021 11:29:19 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 349AEF8049E
 for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2021 11:29:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 349AEF8049E
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="232489619"
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; d="scan'208";a="232489619"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2021 02:29:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; d="scan'208";a="452270871"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by orsmga006.jf.intel.com with ESMTP; 10 Nov 2021 02:29:07 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v3 3/4] ALSA: hda: Simplify DMIC-in-NHLT check
Date: Wed, 10 Nov 2021 11:31:16 +0100
Message-Id: <20211110103117.3142450-4-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211110103117.3142450-1-cezary.rojewski@intel.com>
References: <20211110103117.3142450-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: pierre-louis.bossart@linux.intel.com,
 Cezary Rojewski <cezary.rojewski@intel.com>, tiwai@suse.com,
 hdegoede@redhat.com, broonie@kernel.org,
 =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
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

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

Only DMIC endpoint presence is relevant, not its configuration.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/hda/intel-dsp-config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index 64b6c6ab591e..d97152a3a331 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -384,7 +384,7 @@ static int snd_intel_dsp_check_dmic(struct pci_dev *pci)
 
 	nhlt = intel_nhlt_init(&pci->dev);
 	if (nhlt) {
-		if (intel_nhlt_get_dmic_geo(&pci->dev, nhlt))
+		if (intel_nhlt_has_endpoint_type(nhlt, NHLT_LINK_DMIC))
 			ret = 1;
 		intel_nhlt_free(nhlt);
 	}
-- 
2.25.1

