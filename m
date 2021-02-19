Return-Path: <SRS0=G6+L=HV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49592C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Feb 2021 23:32:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B772964EB2
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Feb 2021 23:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B772964EB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 48EC81678;
	Sat, 20 Feb 2021 00:31:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 48EC81678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613777543;
	bh=EZaNOZs/MHajHBmH0ACK8A4n1/9DgCU5VVv1XrALunE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JUMYxRr/rCZj6U/+PK5IQV9OONHWWPtsjm3r7itG0shvqD8RlfExUKiyB8O+ig96t
	 Xl3zzr1Fcku931C5MU2pFrgT/qLChtoX7UBnbUTWdpElR0EVeH8w22CaR/yM6MhtyX
	 wYLu8g+ql0a3XVXezsCmVA9jDX1eSGm2LfGJfZrw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3951FF802A9;
	Sat, 20 Feb 2021 00:30:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DA1FDF80277; Sat, 20 Feb 2021 00:30:39 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8EF2EF800C7
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2021 00:30:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8EF2EF800C7
IronPort-SDR: /PMFlHb8pCC4QPQ0p64Q5NX4rJfasIxuSluU+rF/8L2CmvQ2oBX2Dc0Jos/2Sn5tEOjgm46JsM
 OJuwZ8UEjSRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9900"; a="203293707"
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; d="scan'208";a="203293707"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2021 15:30:31 -0800
IronPort-SDR: 7fuqsnI5d1rCvsuQB4y1W5hbfpKOGWCfTShDcjfpVFCd5QXr4Iz+Qk/IQP3w6Hz/3gQt/vBW90
 NOgGQyVei+hg==
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; d="scan'208";a="496662632"
Received: from lkwerake-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.251.153.34])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2021 15:30:30 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/9] ASoC: fsl: fsl_dma: remove unused variable
Date: Fri, 19 Feb 2021 17:29:30 -0600
Message-Id: <20210219232937.6440-3-pierre-louis.bossart@linux.intel.com>
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

sound/soc/fsl/fsl_dma.c:411:10: style: Variable 'channel' is assigned
a value that is never used. [unreadVariable]

 channel = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0 : 1;
         ^

Removing this line shows the variable isn't needed any longer so
remove declaration as well.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/fsl/fsl_dma.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index e0c39c5f4854..84bd8a5356eb 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -392,7 +392,6 @@ static int fsl_dma_open(struct snd_soc_component *component,
 	dma_addr_t ld_buf_phys;
 	u64 temp_link;  	/* Pointer to next link descriptor */
 	u32 mr;
-	unsigned int channel;
 	int ret = 0;
 	unsigned int i;
 
@@ -408,8 +407,6 @@ static int fsl_dma_open(struct snd_soc_component *component,
 		return ret;
 	}
 
-	channel = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0 : 1;
-
 	if (dma->assigned) {
 		dev_err(dev, "dma channel already assigned\n");
 		return -EBUSY;
-- 
2.25.1

