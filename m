Return-Path: <SRS0=WNy5=IU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13941C433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 16:39:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC1A56198E
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 16:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC1A56198E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 93E101616;
	Mon, 22 Mar 2021 17:38:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 93E101616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616431178;
	bh=uRxpWETB/mpDFe9RtdthYiJcp3fbVszmuvQjZmEYZ88=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RlMCFOMIiIXlRm05XX7CJvPW8M05kzRzv3PUdb88bQt3sucBYYkbu5f52mE2/CEsv
	 QJ7NB5jHOUH1Uosfj7MOR27NoSKsPlcWuV/xf32oMlvWAF8PpKaoPK2dYrvEw8eaF2
	 5wJxnFmqa6YRuOstnlHbWvFrMydKkTwS0vPNVVP4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5ADE0F8032B;
	Mon, 22 Mar 2021 17:38:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 943C7F8025F; Mon, 22 Mar 2021 17:37:56 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EB63AF80156
 for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2021 17:37:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EB63AF80156
IronPort-SDR: a1s/+m0Na+dPOeE9qyLg6xQVleJNRqLBAYZzYfGahpXoJZCCvrihmKFk5uhbzWFiwdonaEocPM
 tQz/KEqUYaOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="210376600"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; d="scan'208";a="210376600"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2021 09:37:41 -0700
IronPort-SDR: QXwpPRSZvMmc+io1FnIQ4fvdIEa/Uq+z/g2htAJpn9O+SjKZUkmmw86xIcuaLgOO6cFFp62UWu
 rlsRh3NAoqqQ==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; d="scan'208";a="407899057"
Received: from josemari-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.40.21])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2021 09:37:40 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/8] ASoC: SOF: Intel: HDA: fix core status verification
Date: Mon, 22 Mar 2021 11:37:21 -0500
Message-Id: <20210322163728.16616-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210322163728.16616-1-pierre-louis.bossart@linux.intel.com>
References: <20210322163728.16616-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.de,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org
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

From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>

When checking for enabled cores it isn't enough to check that
some of the requested cores are running, we have to check that
all of them are.

Fixes: 747503b1813a ("ASoC: SOF: Intel: Add Intel specific HDA DSP HW operations")
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-dsp.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index 6e24e1cb13f9..1f1ce7036764 100644
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -226,10 +226,17 @@ bool hda_dsp_core_is_enabled(struct snd_sof_dev *sdev,
 
 	val = snd_sof_dsp_read(sdev, HDA_DSP_BAR, HDA_DSP_REG_ADSPCS);
 
-	is_enable = (val & HDA_DSP_ADSPCS_CPA_MASK(core_mask)) &&
-		    (val & HDA_DSP_ADSPCS_SPA_MASK(core_mask)) &&
-		    !(val & HDA_DSP_ADSPCS_CRST_MASK(core_mask)) &&
-		    !(val & HDA_DSP_ADSPCS_CSTALL_MASK(core_mask));
+#define MASK_IS_EQUAL(v, m, field) ({	\
+	u32 _m = field(m);		\
+	((v) & _m) == _m;		\
+})
+
+	is_enable = MASK_IS_EQUAL(val, core_mask, HDA_DSP_ADSPCS_CPA_MASK) &&
+		MASK_IS_EQUAL(val, core_mask, HDA_DSP_ADSPCS_SPA_MASK) &&
+		!(val & HDA_DSP_ADSPCS_CRST_MASK(core_mask)) &&
+		!(val & HDA_DSP_ADSPCS_CSTALL_MASK(core_mask));
+
+#undef MASK_IS_EQUAL
 
 	dev_dbg(sdev->dev, "DSP core(s) enabled? %d : core_mask %x\n",
 		is_enable, core_mask);
-- 
2.25.1

