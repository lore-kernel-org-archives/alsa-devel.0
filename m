Return-Path: <SRS0=znNF=AN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B70C433E2
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:48:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE43F2084C
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gQCnoGi3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE43F2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7105616E6;
	Thu,  2 Jul 2020 18:47:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7105616E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593708503;
	bh=1YMgphesGLiZWmMzXvzR1zOKqTV8YECKq0JK7cli5iE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gQCnoGi3TuBAs0N5MCsLEpXOt94ZYbXOzFsi7QmxHunT+gYu6mjhFSeetJJf5ab0X
	 65EQK0rMjkjMFEqf5AAFzI1e+kXW/RAYNTbw0B92pLlyaW4CSyQDLmWMBhI4DVydN6
	 jFVkzxY8/EAOijL23XoRdDoneqwBO50051iCb/dQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 365F3F802E7;
	Thu,  2 Jul 2020 18:45:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 81ACCF802E8; Thu,  2 Jul 2020 18:45:10 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 14415F802C4
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2020 18:45:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 14415F802C4
IronPort-SDR: QrMvEkK1tczKohbI82oh9cJNBzcnSCPHkB8KO59/3oVcauN/Qzi+qYhq15G2Q/nb3QPnVeln57
 2xsifaKYYObQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="231818047"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; d="scan'208";a="231818047"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:45:01 -0700
IronPort-SDR: 1BYtnU1QvnJ0SaGRufgPIkJdUX/d4RO1VRyBiwHCqYwA+1N/ku7nEm/U18cdKSsp7/Fj26s4eB
 FTDKRkOCvNMw==
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; d="scan'208";a="426011084"
Received: from nzbastur-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.231.182])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:45:00 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 4/6] ASoC: amd: raven: acp3x-i2s: fix 'set but not used'
 warning
Date: Thu,  2 Jul 2020 11:44:31 -0500
Message-Id: <20200702164433.162815-5-pierre-louis.bossart@linux.intel.com>
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

Fix W=1 warning. the card variable is useless here

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/amd/raven/acp3x-i2s.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-i2s.c b/sound/soc/amd/raven/acp3x-i2s.c
index 14607563abd2..a0e14cc91d95 100644
--- a/sound/soc/amd/raven/acp3x-i2s.c
+++ b/sound/soc/amd/raven/acp3x-i2s.c
@@ -150,13 +150,11 @@ static int acp3x_i2s_trigger(struct snd_pcm_substream *substream,
 {
 	struct i2s_stream_instance *rtd;
 	struct snd_soc_pcm_runtime *prtd;
-	struct snd_soc_card *card;
 	u32 ret, val, period_bytes, reg_val, ier_val, water_val;
 	u32 buf_size, buf_reg;
 
 	prtd = substream->private_data;
 	rtd = substream->runtime->private_data;
-	card = prtd->card;
 	period_bytes = frames_to_bytes(substream->runtime,
 			substream->runtime->period_size);
 	buf_size = frames_to_bytes(substream->runtime,
-- 
2.25.1

