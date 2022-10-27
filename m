Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BFCFA3740
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Oct 2022 19:39:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 240EC2DC7;
	Thu, 27 Oct 2022 21:38:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 240EC2DC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666899583;
	bh=KDmkBbSjkY8BCjKuM7SlR6305BR9vVq6KNCxp0eQlyQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PdPDSyaX9cpPJQGokeBKfGihUasuV378xh0tX9PtenjPdK0aEJugKyGSL8sVSVOpb
	 QAZJqIi9doTDwNdm51uydyXr4MbenOXu+G5IutQvwPGg/c2AMV92+G5AFea7uNbr/B
	 mKBKuEB+szV4SQdlMGIMDKmPMUa3ymTjYUKPDDR8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F0D8F805B3;
	Thu, 27 Oct 2022 21:36:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C2A0AF8054A; Thu, 27 Oct 2022 21:36:27 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6D56FF804D9
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2022 21:36:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6D56FF804D9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="mdyMkY8z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1666899381; x=1698435381;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KDmkBbSjkY8BCjKuM7SlR6305BR9vVq6KNCxp0eQlyQ=;
 b=mdyMkY8zRNDGV0IdVKSx9ku/BjVD5P11pZy0ZzcW/+dBce/vYTvXAKkc
 zyCHaNL7w2RfAVkLQP7XWlPRZjX2/RIVtrmaNmH0vXZb+5GOh/2f03h/W
 Lm3es6lm9AWUuv/qJ+CXJ8DAaA+6ZXkP4zexGGav/9X05l12NOBqQRmDl
 eU6G+Ar9Q8yIAxr8zFo4okbA5b+XfHAV4rvjCJJ2ajl960WoaBm6/mSaI
 zOjECDDD9vvNCnvfhBs9ouCey28zJf2oZrGk7rburJxCDXAtapn47aJT6
 iIvwsNt/VXiG5P5BZjrIF8av+i4csrSTPXooHPvpCEAFJosM0dSx/OBJL w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="334957843"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; d="scan'208";a="334957843"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2022 12:36:18 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="632527039"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; d="scan'208";a="632527039"
Received: from vmehta-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.212.6.254])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2022 12:36:17 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 13/21] ASoC: SOF: Intel: hda-ctrl: use helper to clear RIRB
 status
Date: Thu, 27 Oct 2022 15:35:32 -0400
Message-Id: <20221027193540.259520-14-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027193540.259520-1-pierre-louis.bossart@linux.intel.com>
References: <20221027193540.259520-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, tiwai@suse.de,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>, broonie@kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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

Change to use helper and avoid conditional compilation.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/intel/hda-ctrl.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/sof/intel/hda-ctrl.c b/sound/soc/sof/intel/hda-ctrl.c
index f94c6be336f3..3aea36c077c9 100644
--- a/sound/soc/sof/intel/hda-ctrl.c
+++ b/sound/soc/sof/intel/hda-ctrl.c
@@ -290,10 +290,7 @@ void hda_dsp_ctrl_stop_chip(struct snd_sof_dev *sdev)
 	snd_sof_dsp_write(sdev, HDA_DSP_HDA_BAR, SOF_HDA_WAKESTS,
 			  SOF_HDA_WAKESTS_INT_MASK);
 
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
-	/* clear rirb status */
-	snd_hdac_chip_writeb(bus, RIRBSTS, RIRB_INT_MASK);
-#endif
+	hda_codec_rirb_status_clear(sdev);
 
 	/* clear interrupt status register */
 	snd_sof_dsp_write(sdev, HDA_DSP_HDA_BAR, SOF_HDA_INTSTS,
-- 
2.34.1

