Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E596CC77B75
	for <alsa-devel@archiver.kernel.org>; Mon, 15 May 2023 10:34:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DEABE826;
	Mon, 15 May 2023 12:33:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DEABE826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684146883;
	bh=p2uX+IljLHfiAMPBmVabsDnzPcdbIqbeTiEpYuxTutc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=pMrCnq5+knrSTocTcvrBNt1B05cN4lpWN4Vijqz9oQ6v0bmVd8RZVZqm8v9xYpLew
	 HYAb1JoQOudF48mOIoxrUfaiYJjNCkRgMUaEUezD3zhjHYUekRWwe+u88yRa6033WV
	 74Ns+WcVY33SC3/dvu0vTi7Pz4+exI2gD9PEqBvI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ECC12F8057A; Mon, 15 May 2023 12:33:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E2BA6F80563;
	Mon, 15 May 2023 12:33:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 808E4F80431; Mon, 15 May 2023 12:32:55 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8588CF8025A
	for <alsa-devel@alsa-project.org>; Mon, 15 May 2023 12:32:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8588CF8025A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ZM5xBx6U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684146771; x=1715682771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p2uX+IljLHfiAMPBmVabsDnzPcdbIqbeTiEpYuxTutc=;
  b=ZM5xBx6UGn7bre75WiyP1inJNEGo4Jifu2CAad9tAfqqv3rLqY1lx6Ld
   g2CN7WE0RLD7Ry5zPjqjBK2rAvEbjTYhODbgh3V4K1xYpTRqYycTAaz4+
   1QkORlc0df9bUUDPQQcmcw38dCeO5RHNBHHTmQUu1tQoMfD0QFSdOWBGz
   jrbUw+ZdYt+B+OOqucymM3vPe0CvRLcYbvHwXtwBUQs7KkygOlLHR5bPV
   KUQaMaWKCsm8rt/FRb+VtiwlQI3TobjyTGCDX9euF8R4hj0dZHhoyNGH3
   z+3mc/FlJ38yLWit/1wFOVl5UY+Rh71VygzpknjCCCmGzeUr89WY4x9EU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="351200349"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200";
   d="scan'208";a="351200349"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2023 03:32:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="694967649"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200";
   d="scan'208";a="694967649"
Received: from lpilolli-mobl.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.48.230])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2023 03:32:45 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	pierre-louis.bossart@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	yung-chuan.liao@linux.intel.com
Subject: [PATCH 2/9] ASoC: SOF: ipc4-topology: Add a helper function for
 output format selection
Date: Mon, 15 May 2023 13:33:29 +0300
Message-Id: <20230515103336.16132-3-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515103336.16132-1-peter.ujfalusi@linux.intel.com>
References: <20230515103336.16132-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: T2TYNNL36UVQCBMSIY2WK6YVNMYGF4YA
X-Message-ID-Hash: T2TYNNL36UVQCBMSIY2WK6YVNMYGF4YA
X-MailFrom: peter.ujfalusi@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/T2TYNNL36UVQCBMSIY2WK6YVNMYGF4YA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

Add a helper function to select the output format.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/ipc4-topology.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 3e59551b2367..7c448342ff92 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -1028,6 +1028,26 @@ static int sof_ipc4_update_hw_params(struct snd_sof_dev *sdev, struct snd_pcm_hw
 	return 0;
 }
 
+static int sof_ipc4_init_output_audio_fmt(struct snd_sof_dev *sdev,
+					  struct sof_ipc4_base_module_cfg *base_config,
+					  struct sof_ipc4_available_audio_format *available_fmt,
+					  int input_audio_format_index)
+{
+	int i;
+
+	/* pick the only available output format */
+	if (available_fmt->num_output_formats == 1)
+		i = 0;
+	else
+		i = input_audio_format_index;
+
+	if (available_fmt->num_output_formats && i < available_fmt->num_output_formats)
+		base_config->obs = available_fmt->output_pin_fmts[i].buffer_size;
+
+	/* Return the index of the chosen output format */
+	return i;
+}
+
 static int sof_ipc4_init_audio_fmt(struct snd_sof_dev *sdev,
 				   struct snd_sof_widget *swidget,
 				   struct sof_ipc4_base_module_cfg *base_config,
@@ -1110,15 +1130,7 @@ static int sof_ipc4_init_audio_fmt(struct snd_sof_dev *sdev,
 		sof_ipc4_dbg_audio_format(sdev->dev, &available_fmt->input_pin_fmts[i], 1);
 	}
 
-	/* pick the only available output format */
-	if (available_fmt->num_output_formats == 1)
-		i = 0;
-
-	if (available_fmt->num_output_formats && i < available_fmt->num_output_formats)
-		base_config->obs = available_fmt->output_pin_fmts[i].buffer_size;
-
-	/* Return the index of the matched format */
-	return i;
+	return sof_ipc4_init_output_audio_fmt(sdev, base_config, available_fmt, i);
 }
 
 static void sof_ipc4_unprepare_copier_module(struct snd_sof_widget *swidget)
-- 
2.40.1

