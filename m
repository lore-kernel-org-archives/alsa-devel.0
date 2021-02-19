Return-Path: <SRS0=G6+L=HV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7ABC433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Feb 2021 23:34:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECD5364EAF
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Feb 2021 23:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD5364EAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 678871699;
	Sat, 20 Feb 2021 00:33:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 678871699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613777680;
	bh=mKE1HMzPrTJLJ08CjKRnomtVMWaBzLd/ttqSTXS/hfc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cA53OZRK0YHAjTRJfVU3WPMwW+H8scNEfW3h1xc18KyeXuVuLcPS6yK2AjYdhX9D9
	 wjlSuUrYKcCVYR0kzFuULt6NjNgFlvAtMRnAQdBWD3YyOPCemIFyx39ZeJeIlRGaLc
	 Wb+j/2SV3gpYJhmWLTBWqINQaCbTpjgtbQAL6mSc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 66B28F804AD;
	Sat, 20 Feb 2021 00:30:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2EE11F802DB; Sat, 20 Feb 2021 00:30:44 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3490CF8013F
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2021 00:30:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3490CF8013F
IronPort-SDR: m7YKh0p43uakeYvkjXOnZTZzqJcoVEzTtEc7zotGLWXOYDoyiGLJpyaErSnJSfTAm90kFLzxvQ
 X0VyPYx+GAkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9900"; a="203293729"
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; d="scan'208";a="203293729"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2021 15:30:34 -0800
IronPort-SDR: SurJ3CsLcPmihPJoIFAIVwZXjtmj6q5FoB2yxWqZYu+cp/yybEUUY/oge9K219ESq6ZW6eYYG0
 3l+Rk0FfDn0Q==
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; d="scan'208";a="496662695"
Received: from lkwerake-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.251.153.34])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2021 15:30:33 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 4/9] ASoC: fsl: fsl_esai: clarify expression
Date: Fri, 19 Feb 2021 17:29:32 -0600
Message-Id: <20210219232937.6440-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219232937.6440-1-pierre-louis.bossart@linux.intel.com>
References: <20210219232937.6440-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, tiwai@suse.de,
 Shengjiu Wang <shengjiu.wang@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>,
 "open list:FREESCALE SOC SOUND DRIVERS" <linuxppc-dev@lists.ozlabs.org>,
 broonie@kernel.org, Fabio Estevam <festevam@gmail.com>
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

cppcheck warning:

sound/soc/fsl/fsl_esai.c:307:16: style: Clarify calculation precedence
for '%' and '?'. [clarifyCalculation]
    clk_id % 2 ? "extal" : "fsys");
               ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/fsl/fsl_esai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 08056fa0a0fa..41b154417b92 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -304,7 +304,7 @@ static int fsl_esai_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 
 	if (IS_ERR(clksrc)) {
 		dev_err(dai->dev, "no assigned %s clock\n",
-				clk_id % 2 ? "extal" : "fsys");
+			(clk_id % 2) ? "extal" : "fsys");
 		return PTR_ERR(clksrc);
 	}
 	clk_rate = clk_get_rate(clksrc);
-- 
2.25.1

