Return-Path: <SRS0=G6+L=HV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C854C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Feb 2021 23:33:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D77DA64EB8
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Feb 2021 23:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77DA64EB8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 306D51682;
	Sat, 20 Feb 2021 00:32:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 306D51682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613777591;
	bh=eICUODfNC5hbz8ZVJfzLRkfR6HclSYesbnhzU9qUr1U=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fre2wn/1rLEbli4s9CakAEupydJxbRWu0FstBE4Z+DFBev1TlqmgjLM6GZhhe7AhL
	 JrppvvssoXYMmv/32hG/RdMQoAMd/1v2f3XKlQNgQWk6VAl1NYRDsP1OH+jyDl+RTN
	 NFf9RUVe1SwF1ophfJwp2Y5BMX4kpUB9Dc+NbnyA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 86D2FF802DF;
	Sat, 20 Feb 2021 00:30:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 81EEFF802C4; Sat, 20 Feb 2021 00:30:41 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8C99DF8020B
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2021 00:30:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8C99DF8020B
IronPort-SDR: 832Lh6Y44ReqXgYDN1hLbVAV3sc8HBdLTj1qklikjGcW2KWysMjAAyIxrmG951VKM3hM1wbL5v
 tbROufGs5wdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9900"; a="203293721"
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; d="scan'208";a="203293721"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2021 15:30:33 -0800
IronPort-SDR: bxr+gzwgM2EC+z4ap7Hb+/HcDrWux+W4ok+Ahl1lfXgyD60R2ze65NVztQwV/6ifUdACv2ULlc
 cdSrRk0p4Pnw==
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; d="scan'208";a="496662659"
Received: from lkwerake-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.251.153.34])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2021 15:30:31 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/9] ASoC: fsl: fsl_easrc: remove useless assignments
Date: Fri, 19 Feb 2021 17:29:31 -0600
Message-Id: <20210219232937.6440-4-pierre-louis.bossart@linux.intel.com>
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

cppcheck warnings:

sound/soc/fsl/fsl_easrc.c:751:53: style: Variable 'st2_mem_alloc' is
assigned a value that is never used. [unreadVariable]
 int st1_chanxexp, st1_mem_alloc = 0, st2_mem_alloc = 0;
                                                    ^
sound/soc/fsl/fsl_easrc.c:1331:11: style: Variable 'size' is assigned
a value that is never used. [unreadVariable]
 int size = 0;
          ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/fsl/fsl_easrc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index 636a702f37a6..725a5d3aaa02 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -710,7 +710,7 @@ static int fsl_easrc_max_ch_for_slot(struct fsl_asrc_pair *ctx,
 				     struct fsl_easrc_slot *slot)
 {
 	struct fsl_easrc_ctx_priv *ctx_priv = ctx->private;
-	int st1_mem_alloc = 0, st2_mem_alloc = 0;
+	int st1_mem_alloc = 0, st2_mem_alloc;
 	int pf_mem_alloc = 0;
 	int max_channels = 8 - slot->num_channel;
 	int channels = 0;
@@ -748,7 +748,7 @@ static int fsl_easrc_config_one_slot(struct fsl_asrc_pair *ctx,
 {
 	struct fsl_asrc *easrc = ctx->asrc;
 	struct fsl_easrc_ctx_priv *ctx_priv = ctx->private;
-	int st1_chanxexp, st1_mem_alloc = 0, st2_mem_alloc = 0;
+	int st1_chanxexp, st1_mem_alloc = 0, st2_mem_alloc;
 	unsigned int reg0, reg1, reg2, reg3;
 	unsigned int addr;
 
@@ -1328,7 +1328,7 @@ static int fsl_easrc_stop_context(struct fsl_asrc_pair *ctx)
 {
 	struct fsl_asrc *easrc = ctx->asrc;
 	int val, i;
-	int size = 0;
+	int size;
 	int retry = 200;
 
 	regmap_read(easrc->regmap, REG_EASRC_CC(ctx->index), &val);
-- 
2.25.1

