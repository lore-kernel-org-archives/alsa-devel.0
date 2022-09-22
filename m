Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E83ECAAD8
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Sep 2022 21:39:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7474F1E8;
	Thu, 22 Sep 2022 23:38:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7474F1E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663882750;
	bh=q0FrN7OLwl8n/1/soggUvLiaxyxQQ32AwfsDgCUrUcQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hZomP8Yhe6ahcwfZWhkOdMPB/gj6R6+eKEIbhQGOeUcXQZ8GKQCzXl2l1Xf19UNib
	 p6Xw+VcgQiKYCn+2+A1Is8lFcDuz9+X/lCgaT55JLlmcRwDUV5Uxpp6XfCkRSjX+qh
	 jvtPP0teR73PWVG4dglB2HdDMSsZXMPkqK9jV33c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C0CC7F80557;
	Thu, 22 Sep 2022 23:37:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 30E0FF80552; Thu, 22 Sep 2022 23:37:09 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8AE3FF8030F
 for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2022 23:36:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8AE3FF8030F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="iLhS00H+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1663882619; x=1695418619;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=q0FrN7OLwl8n/1/soggUvLiaxyxQQ32AwfsDgCUrUcQ=;
 b=iLhS00H+qV8uBRdV55WnsiCej11QxENhAUMuQ0kgvtUEeb3zaJdA5MKC
 qKei0hvm9IlR0qyJug+p9kdy1j+iHxqxYbpER5GmrjF3uXr+NQsI/eVPK
 e5Qs7oCQ6IwKu6IbojtmJeOnQ4H6by72eos2t3O+FH34wUaV67ytII5fo
 hl6N/rggnl+9tFdhLi624Y54ZK+VnrJAAVhcmMzcGmU14RdG+QAOIqp21
 bdtOFAyldYqS2OzKHY1eQHQxVVJG8uYvvX7xboYxAXKC/mjpk+Qjw0J8D
 Nrz6GE+2s74TNnMIpN19Zke0Ti81lCxzRhuqT8VvdzlybwJFMYjQNdLaJ g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="386725780"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; d="scan'208";a="386725780"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2022 14:36:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; d="scan'208";a="745550849"
Received: from jpwarner-mobl2.amr.corp.intel.com (HELO
 rsridh2-mobl1.localdomain) ([10.254.13.62])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2022 14:36:50 -0700
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 04/10] ASoC: SOF: Intel: use power_down_dsp op in
 hda_dsp_remove
Date: Thu, 22 Sep 2022 14:36:38 -0700
Message-Id: <20220922213644.666315-5-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922213644.666315-1-ranjani.sridharan@linux.intel.com>
References: <20220922213644.666315-1-ranjani.sridharan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>, Fred Oh <fred.oh@linux.intel.com>,
 broonie@kernel.org, Bard Liao <yung-chuan.liao@linux.intel.com>
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

From: Fred Oh <fred.oh@linux.intel.com>

Use power_down_dsp op to differentiate power down sequences in platforms.

Signed-off-by: Fred Oh <fred.oh@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/intel/hda.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index c7fe13dee06c..35f074aa69da 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -1191,9 +1191,9 @@ int hda_dsp_remove(struct snd_sof_dev *sdev)
 	snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR, SOF_HDA_INTCTL,
 				SOF_HDA_INT_CTRL_EN | SOF_HDA_INT_GLOBAL_EN, 0);
 
-	/* disable cores */
-	if (chip)
-		hda_dsp_core_reset_power_down(sdev, chip->host_managed_cores_mask);
+	/* no need to check for error as the DSP will be disabled anyway */
+	if (chip && chip->power_down_dsp)
+		chip->power_down_dsp(sdev);
 
 	/* disable DSP */
 	snd_sof_dsp_update_bits(sdev, HDA_DSP_PP_BAR, SOF_HDA_REG_PP_PPCTL,
-- 
2.25.1

