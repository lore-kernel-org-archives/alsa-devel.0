Return-Path: <SRS0=ybvW=5K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE0EC2D0E7
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Mar 2020 21:14:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0DA62082E
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Mar 2020 21:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rl2PgfYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0DA62082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D61D41686;
	Wed, 25 Mar 2020 22:13:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D61D41686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585170879;
	bh=1VoW8UreAxFqppAY6B0u4M8ITEn0JtW2pBHbMo94VXU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rl2PgfYPN7f4mNwoUmgcCROm+6jdAIQKM88fILaelrGH4eaAxQ0YAiwVHtXdkftzJ
	 k9fNYr+NgiQGfVTsIRgfhgM9DqQk6aCOI+3UcwO5OzuUzbdGY75EkNRbtZsTIvnYD7
	 GUbTFFwPPc7R3WpNV96sZWYE1I0Ca0tKFjbYbYOM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A64BF8011E;
	Wed, 25 Mar 2020 22:12:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E43CBF801DA; Wed, 25 Mar 2020 22:12:52 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B6E6DF80095
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2020 22:12:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B6E6DF80095
IronPort-SDR: xI3M0cf3S/WwQ8yYGNZkKIzlwG8TWokzh1EVsjbC97ZwQHDNsfIerH6ty/RsuV4MBkdoi0qkSC
 XmvzYdKajNRQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2020 14:12:44 -0700
IronPort-SDR: Egcjvnx49ciHlo/MJO/rQzbQYYsZb6EfPk7oAgaJULdKg8rXqS61XG7GUUqAgm0w4oEaiXFBN2
 JtSKGK+qExfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,305,1580803200"; d="scan'208";a="357935807"
Received: from abeljans.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.233.195])
 by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2020 14:12:44 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/5] ASoC: SOF: Intel: hda: Improve DSP state logging
Date: Wed, 25 Mar 2020 16:12:29 -0500
Message-Id: <20200325211233.27394-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200325211233.27394-1-pierre-louis.bossart@linux.intel.com>
References: <20200325211233.27394-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

Improve the DSP power state logs with the state names
instead of values.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-dsp.c | 43 +++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index 79ce52c32ef1..c396b7ef0328 100644
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -452,6 +452,46 @@ static int hda_dsp_set_D0_state(struct snd_sof_dev *sdev,
 	return ret;
 }
 
+/* helper to log DSP state */
+static void hda_dsp_state_log(struct snd_sof_dev *sdev)
+{
+	switch (sdev->dsp_power_state.state) {
+	case SOF_DSP_PM_D0:
+		switch (sdev->dsp_power_state.substate) {
+		case SOF_HDA_DSP_PM_D0I0:
+			dev_dbg(sdev->dev, "Current DSP power state: D0I0\n");
+			break;
+		case SOF_HDA_DSP_PM_D0I3:
+			dev_dbg(sdev->dev, "Current DSP power state: D0I3\n");
+			break;
+		default:
+			dev_dbg(sdev->dev, "Unknown DSP D0 substate: %d\n",
+				sdev->dsp_power_state.substate);
+			break;
+		}
+		break;
+	case SOF_DSP_PM_D1:
+		dev_dbg(sdev->dev, "Current DSP power state: D1\n");
+		break;
+	case SOF_DSP_PM_D2:
+		dev_dbg(sdev->dev, "Current DSP power state: D2\n");
+		break;
+	case SOF_DSP_PM_D3_HOT:
+		dev_dbg(sdev->dev, "Current DSP power state: D3_HOT\n");
+		break;
+	case SOF_DSP_PM_D3:
+		dev_dbg(sdev->dev, "Current DSP power state: D3\n");
+		break;
+	case SOF_DSP_PM_D3_COLD:
+		dev_dbg(sdev->dev, "Current DSP power state: D3_COLD\n");
+		break;
+	default:
+		dev_dbg(sdev->dev, "Unknown DSP power state: %d\n",
+			sdev->dsp_power_state.state);
+		break;
+	}
+}
+
 /*
  * All DSP power state transitions are initiated by the driver.
  * If the requested state change fails, the error is simply returned.
@@ -511,8 +551,7 @@ int hda_dsp_set_power_state(struct snd_sof_dev *sdev,
 	}
 
 	sdev->dsp_power_state = *target_state;
-	dev_dbg(sdev->dev, "New DSP state %d substate %d\n",
-		target_state->state, target_state->substate);
+	hda_dsp_state_log(sdev);
 	return ret;
 }
 
-- 
2.20.1

