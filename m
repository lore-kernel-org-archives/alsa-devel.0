Return-Path: <SRS0=znNF=AN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B94C433DF
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:49:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91A92207D4
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="l1KpoppG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A92207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 13CF516EB;
	Thu,  2 Jul 2020 18:48:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 13CF516EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593708586;
	bh=/FCIrISqOwqsaBHEhbVt5GdoY7iou6is5zNvq43jO+c=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l1KpoppGmKD7FUO43tb4IRCYABbpYfeSVLJMgNavMxYnvafN6SzpANSNArhd29fHR
	 6Fx7jOPvXu/ydb68qXPxfw6soQB3ROp5ulIjJeb4y/CEk/L/TP4VxR32eacuWangdX
	 hERE4VGxekCxj+Wsh4EaL78QXK+z39qmHjipdm7Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1746AF802F7;
	Thu,  2 Jul 2020 18:45:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 792E5F802F8; Thu,  2 Jul 2020 18:45:15 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DFAFDF802E3
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2020 18:45:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DFAFDF802E3
IronPort-SDR: NaUIJ1QMMAnJoSI0ACbaOxSlxsdD/q8wVFomsCpLTPgPWnGfS0Z0Y92PEwWuyTk6T/bo/kMKoo
 Dg6sjUwlELCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="231818111"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; d="scan'208";a="231818111"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:45:06 -0700
IronPort-SDR: s1aAgPnprfLMqh4Ml8wsSRlQpczx1MHoQ6hG2j4Ij4wAzX82iu0jl6oE1Kn34mm858brUK1+rf
 MOEd2LrCwkdA==
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; d="scan'208";a="426011166"
Received: from nzbastur-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.231.182])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:45:05 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 6/6] ASoC: amd: raven: acp3x-i2s: remove unused-but-set
 variable
Date: Thu,  2 Jul 2020 11:44:33 -0500
Message-Id: <20200702164433.162815-7-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702164433.162815-1-pierre-louis.bossart@linux.intel.com>
References: <20200702164433.162815-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de,
 open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 broonie@kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
 Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>,
 Akshu Agrawal <akshu.agrawal@amd.com>
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

Fix W=1 warning. The variable prtd is set but not used.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/amd/raven/acp3x-i2s.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-i2s.c b/sound/soc/amd/raven/acp3x-i2s.c
index a0e14cc91d95..c3eb9b347eaa 100644
--- a/sound/soc/amd/raven/acp3x-i2s.c
+++ b/sound/soc/amd/raven/acp3x-i2s.c
@@ -149,11 +149,9 @@ static int acp3x_i2s_trigger(struct snd_pcm_substream *substream,
 				int cmd, struct snd_soc_dai *dai)
 {
 	struct i2s_stream_instance *rtd;
-	struct snd_soc_pcm_runtime *prtd;
 	u32 ret, val, period_bytes, reg_val, ier_val, water_val;
 	u32 buf_size, buf_reg;
 
-	prtd = substream->private_data;
 	rtd = substream->runtime->private_data;
 	period_bytes = frames_to_bytes(substream->runtime,
 			substream->runtime->period_size);
-- 
2.25.1

