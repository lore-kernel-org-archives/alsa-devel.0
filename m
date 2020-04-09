Return-Path: <SRS0=I0Ma=5Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7F5C2BA19
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:51:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2516420757
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="h7bRFiNJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2516420757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8325516AE;
	Thu,  9 Apr 2020 20:50:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8325516AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586458302;
	bh=exZgI77tV6I/HEr5Fbt+0jCDxqxoYYP7W60xwjRgHOc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h7bRFiNJaA+cAEN80YHo7v118RVqFw9L3QwpIBrnemlBhh+LB4x/xFlT6BetwLbwZ
	 KNVchB+vQ65N/sq2gHkFCGA9q+REL/CFxvMWn0hUcKDUjFNm9WesZ3+XqKhykRes+C
	 4oG+MYe0NIeZRrcYlW9oJCy/R1+GCBkakpoy44r8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6B4E9F8028C;
	Thu,  9 Apr 2020 20:49:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 20911F80216; Thu,  9 Apr 2020 20:49:12 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0B30FF801D8
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2020 20:49:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B30FF801D8
IronPort-SDR: nrSWgRzNIPQwfspeLFMdWEkSMswakuQ9xlHjsG0oTajPPE37kxmP7m4c0pePLEb4HAOuU+wJ5H
 MywljdYeR6vA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2020 11:49:05 -0700
IronPort-SDR: ZXs04YyqxZgg6WY/OXvmeC/oGk+gaxdtoHnuT1KdlZcejIoBOaODQfelAHhHEtvHd6kf//Uutz
 sVH0JWBFyRlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,363,1580803200"; d="scan'208";a="255246438"
Received: from davidadu-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.212.151.218])
 by orsmga006.jf.intel.com with ESMTP; 09 Apr 2020 11:49:04 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/2] ASoC: SOF: Intel: hda: remove unnecessary parentheses
Date: Thu,  9 Apr 2020 13:48:53 -0500
Message-Id: <20200409184853.15896-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200409184853.15896-1-pierre-louis.bossart@linux.intel.com>
References: <20200409184853.15896-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.de,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org, Payal Kshirsagar <payalskshirsagar1234@gmail.com>
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

From: Payal Kshirsagar <payalskshirsagar1234@gmail.com>

Remove unnecessary parentheses around the right hand side of an assignment
and align the code.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Payal Kshirsagar <payalskshirsagar1234@gmail.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-dsp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index 99087b6afb67..c780e1e6f895 100644
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -226,10 +226,10 @@ bool hda_dsp_core_is_enabled(struct snd_sof_dev *sdev,
 
 	val = snd_sof_dsp_read(sdev, HDA_DSP_BAR, HDA_DSP_REG_ADSPCS);
 
-	is_enable = ((val & HDA_DSP_ADSPCS_CPA_MASK(core_mask)) &&
-			(val & HDA_DSP_ADSPCS_SPA_MASK(core_mask)) &&
-			!(val & HDA_DSP_ADSPCS_CRST_MASK(core_mask)) &&
-			!(val & HDA_DSP_ADSPCS_CSTALL_MASK(core_mask)));
+	is_enable = (val & HDA_DSP_ADSPCS_CPA_MASK(core_mask)) &&
+		    (val & HDA_DSP_ADSPCS_SPA_MASK(core_mask)) &&
+		    !(val & HDA_DSP_ADSPCS_CRST_MASK(core_mask)) &&
+		    !(val & HDA_DSP_ADSPCS_CSTALL_MASK(core_mask));
 
 	dev_dbg(sdev->dev, "DSP core(s) enabled? %d : core_mask %x\n",
 		is_enable, core_mask);
-- 
2.20.1

