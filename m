Return-Path: <SRS0=ofM/=CT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D333C43461
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:46:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D84B121D91
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eRZ225MY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84B121D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6617A16E0;
	Thu, 10 Sep 2020 18:45:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6617A16E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599756391;
	bh=G6tcEmTvEGdYVtduK3MEnDuyF8PnKQr07KRiCLZ99jo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eRZ225MYouzpGr1MIb7BlM4GqFzanR3woZXzxJM9vJP/naJOv4b1rNGT8da5FnuEN
	 1DZIdwyCml6aAyMETsnUde7x3oX3ZpDFyUFfIJuGvhgg8WH7Zq9FfK27yEsQAnWaTj
	 cQxHF6gdL/0nQ9U+4BwNHuVmfEQ9MZ1TQCJdoJPc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A9779F802DF;
	Thu, 10 Sep 2020 18:43:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 201BAF802E1; Thu, 10 Sep 2020 18:43:22 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A0172F802DF
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2020 18:43:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A0172F802DF
IronPort-SDR: 37Fd7JY4yPx38mYHkcPYlTyXCFBXaXgBt0vXP4ETCG5cW6kdjG7e0gFUVVGiSE6m9FEB2LsO/r
 7NzSLZphTY4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="146299759"
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; d="scan'208";a="146299759"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 09:43:05 -0700
IronPort-SDR: Xrg102ZboDBU19uLjmL3HT98xJhZyrtnZAaHgJab1EIHMJqNxfkBztH7AMxu7+rRqaNMVUyZxL
 T9MJ+iNlWMJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; d="scan'208";a="304937951"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga006.jf.intel.com with ESMTP; 10 Sep 2020 09:43:00 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 4/4] ASoC: SOF: Intel: hda-loader: s/master/primary
Date: Thu, 10 Sep 2020 19:41:25 +0300
Message-Id: <20200910164125.2033062-5-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200910164125.2033062-1-kai.vehmanen@linux.intel.com>
References: <20200910164125.2033062-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Jaska Uimonen <jaska.uimonen@intel.com>,
 Seppo Ingalsuo <seppo.ingalsuo@intel.com>, kai.vehmanen@linux.intel.com,
 lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Use inclusive language for DSP cores.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Jaska Uimonen <jaska.uimonen@intel.com>
Reviewed-by: Seppo Ingalsuo <seppo.ingalsuo@intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/intel/hda-loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda-loader.c b/sound/soc/sof/intel/hda-loader.c
index 5515c75e53e4..dfbfc89ffe70 100644
--- a/sound/soc/sof/intel/hda-loader.c
+++ b/sound/soc/sof/intel/hda-loader.c
@@ -426,7 +426,7 @@ int hda_dsp_cl_boot_firmware(struct snd_sof_dev *sdev)
 	}
 
 	/*
-	 * return master core id if both fw copy
+	 * return primary core id if both fw copy
 	 * and stream clean up are successful
 	 */
 	if (!ret)
-- 
2.27.0

