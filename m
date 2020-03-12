Return-Path: <SRS0=Zr1M=45=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C85C10DCE
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:02:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FE83206E7
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SUIub15v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE83206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7B81916DA;
	Thu, 12 Mar 2020 13:01:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7B81916DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584014520;
	bh=4Kl5Q8tsur137cVYpXBU3kvIsUvbDcjzbu321p5WDgQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SUIub15vfCFPno6ZcvvcuwulETALy4MqSXBCcNi2R3rLgxYD+kLFIJPGP0bss1yE3
	 1gJ4lgdu+uCj/T1gLhmW/tvMy71S5ae72kR5doGDHMRnuYX8zwPID+UKHxS5gwZd+H
	 GUCO3NgEbxYIzYKUTfVfpHxVlYngf3zVKQZJNuQ0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 075C4F801D9;
	Thu, 12 Mar 2020 13:01:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 242C3F8020C; Thu, 12 Mar 2020 13:01:09 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B5357F800BE
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2020 13:01:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5357F800BE
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Mar 2020 05:01:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,544,1574150400"; d="scan'208";a="236611615"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga008.fm.intel.com with ESMTP; 12 Mar 2020 05:01:00 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v3] ASoC: SOF: Intel: Fix stream cleanup on hw free
Date: Thu, 12 Mar 2020 13:00:58 +0100
Message-Id: <20200312120058.15057-1-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.17.1
Cc: lgirdwood@gmail.com, Cezary Rojewski <cezary.rojewski@intel.com>,
 broonie@kernel.org, tiwai@suse.com, pierre-louis.bossart@linux.intel.com
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

Field "substream" gets assigned during stream setup in
hda_dsp_pcm_hw_params() but it is never cleared afterwards during
cleanup procedure. Now, any non-pcm operation e.g.: compress can
mistakenly make use of that pointer as it's bypassing all
"if (s->substream)" checks.

Nulling the pointer during hw_free operation ensures no wild pointers
are left behind.

Fixes: cdae3b9a47aa ("ASoC: SOF: Intel: Add Intel specific HDA PCM operations")
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---

Changes in v3:
- simple rewording of commit title & message

Changes in v2:
- relocated stream->substream assignment from _pcm_close() to _hw_free()


 sound/soc/sof/intel/hda-stream.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sof/intel/hda-stream.c b/sound/soc/sof/intel/hda-stream.c
index 7daa913dbde0..5d386956906f 100644
--- a/sound/soc/sof/intel/hda-stream.c
+++ b/sound/soc/sof/intel/hda-stream.c
@@ -547,6 +547,8 @@ int hda_dsp_stream_hw_free(struct snd_sof_dev *sdev,
 					SOF_HDA_REG_PP_PPCTL, mask, 0);
 	spin_unlock_irq(&bus->reg_lock);
 
+	stream->substream = NULL;
+
 	return 0;
 }
 
-- 
2.17.1

