Return-Path: <SRS0=/1nv=PD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F45EC433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Oct 2021 16:40:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A59160E0C
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Oct 2021 16:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4A59160E0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8CCE11865;
	Fri, 15 Oct 2021 18:39:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8CCE11865
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634316042;
	bh=MKpvxJlUeDFzDhk7ngCxxqKAK3ALRWuMHqH1/zzhY4w=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tx2X1sKX2XNfHYCTS9MI38h3YWZU5QJNf87uW/Wy62Wjyo7Gzr5IUFpWQka/S3K5K
	 ns177MhSywd5wWbDMpg6lqbDPtNC50/T9v22cEbfTMLYX8SeNYwnlS8A2C13TXCYqr
	 i50mI+FLLihHOcaXo4y3AdXarkgYmCI0+loiYnGg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 94A53F804FB;
	Fri, 15 Oct 2021 18:38:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C51DFF804ED; Fri, 15 Oct 2021 18:38:36 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E7F32F8016C
 for <alsa-devel@alsa-project.org>; Fri, 15 Oct 2021 18:38:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E7F32F8016C
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="251395145"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; d="scan'208";a="251395145"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2021 09:38:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; d="scan'208";a="593028341"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by orsmga004.jf.intel.com with ESMTP; 15 Oct 2021 09:38:26 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 4/5] ALSA: hda: Simplify DMIC-in-NHLT check
Date: Fri, 15 Oct 2021 18:40:46 +0200
Message-Id: <20211015164047.44492-5-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015164047.44492-1-cezary.rojewski@intel.com>
References: <20211015164047.44492-1-cezary.rojewski@intel.com>
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
---
 sound/hda/intel-dsp-config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index 4c9d5bc39cbd..e8fc5557436b 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -384,7 +384,7 @@ static int snd_intel_dsp_check_dmic(struct pci_dev *pci)
 
 	nhlt = intel_nhlt_init();
 	if (nhlt) {
-		if (intel_nhlt_get_dmic_geo(nhlt))
+		if (intel_nhlt_has_endpoint_type(nhlt, NHLT_LINK_DMIC))
 			ret = 1;
 		intel_nhlt_free(nhlt);
 	}
-- 
2.25.1

