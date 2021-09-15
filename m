Return-Path: <SRS0=xeto=OF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F891C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 07:20:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32BBB61164
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 07:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 32BBB61164
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 90CC9183A;
	Wed, 15 Sep 2021 09:19:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 90CC9183A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631690429;
	bh=6rFagH4G1oAZuoBkoq1Db3dVgTdfwbKLjLj2CWVouSE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d4ItXXD/Fwr59s0BKYqI+RbvMVSnnRWITSMod2S/6Oo2Zo0AApsn6XWnYoNHMyoU4
	 zbwlgMg5r8wZC32rOGgDqjFKQ8b3NlwF2GR+LdTcQbnVw8YvD04P3IlsyJtZ4X6qCY
	 oXJOq9dDDeHb41SotqnbRGvGRgO0uOcE8A2KRMww=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E3C5F80132;
	Wed, 15 Sep 2021 09:18:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 04313F8049E; Wed, 15 Sep 2021 09:18:29 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B1861F8049E
 for <alsa-devel@alsa-project.org>; Wed, 15 Sep 2021 09:18:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B1861F8049E
X-IronPort-AV: E=McAfee;i="6200,9189,10107"; a="285934972"
X-IronPort-AV: E=Sophos;i="5.85,294,1624345200"; d="scan'208";a="285934972"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2021 00:18:13 -0700
X-IronPort-AV: E=Sophos;i="5.85,294,1624345200"; d="scan'208";a="544655720"
Received: from msavu-mobl1.ti.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.251.216.36])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2021 00:18:11 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com
Subject: [PATCH 2/3] ASoC: SOF: Intel: hda: Remove boot_firmware skl and
 iccmax_icl declarations
Date: Wed, 15 Sep 2021 10:18:04 +0300
Message-Id: <20210915071805.5704-3-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915071805.5704-1-peter.ujfalusi@linux.intel.com>
References: <20210915071805.5704-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: guennadi.liakhovetski@linux.intel.com, alsa-devel@alsa-project.org,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com
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

hda_dsp_cl_boot_firmware_iccmax_icl and hda_dsp_cl_boot_firmware_skl is
no longer backed with an implementation, remove them from the hda.h

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/intel/hda.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 519547e65e93..4a2d1376c717 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -610,8 +610,6 @@ int hda_dsp_ipc_cmd_done(struct snd_sof_dev *sdev, int dir);
  */
 int hda_dsp_cl_boot_firmware(struct snd_sof_dev *sdev);
 int hda_dsp_cl_boot_firmware_iccmax(struct snd_sof_dev *sdev);
-int hda_dsp_cl_boot_firmware_iccmax_icl(struct snd_sof_dev *sdev);
-int hda_dsp_cl_boot_firmware_skl(struct snd_sof_dev *sdev);
 
 /* pre and post fw run ops */
 int hda_dsp_pre_fw_run(struct snd_sof_dev *sdev);
-- 
2.33.0

