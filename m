Return-Path: <SRS0=1ACS=ZD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098D9C43331
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 22:37:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FD7B21925
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 22:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JXsLWL/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD7B21925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BB081167C;
	Mon, 11 Nov 2019 23:36:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BB081167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573511865;
	bh=idLQBC/56N4zf715QRM2mk6tfgknuTV+2moPuyNKTa8=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JXsLWL/STUdKbUdMCDpH6yLgx7bZ+gaA1PVH6pnxN3tkmWgTlkXG/lPF6fMnrGP0M
	 t3lZSMv6FyPm9++bNnm8o2BZ1vmbtbqP27xeVoG2rQ1F6KPAfthL5lGGHu5ILJpI1H
	 YkwVAvf1fK6jkLWjpVhiKTV3cyprz62R+jOTMtJU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 91C3CF80611;
	Mon, 11 Nov 2019 23:34:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 96269F805FF; Mon, 11 Nov 2019 23:34:01 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2CEE6F80506
 for <alsa-devel@alsa-project.org>; Mon, 11 Nov 2019 23:33:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2CEE6F80506
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Nov 2019 14:33:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,294,1569308400"; d="scan'208";a="354903235"
Received: from kathyche-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.27.186])
 by orsmga004.jf.intel.com with ESMTP; 11 Nov 2019 14:33:52 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Mon, 11 Nov 2019 16:33:42 -0600
Message-Id: <20191111223343.19986-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191111223343.19986-1-pierre-louis.bossart@linux.intel.com>
References: <20191111223343.19986-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org, Keyon Jie <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH 3/4] ASoC: SOF: add helper to check if we
	should enter d0i3 suspend
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Keyon Jie <yang.jie@linux.intel.com>

Add helper to check if the DSP should be put in D0i3. This function
returns true if a stream has ignored the SUSPEND trigger to keep the
pipelines running in the DSP.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/core.c     | 13 +++++++++++++
 sound/soc/sof/sof-priv.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
index 8661c2cca76b..805918d3bcc0 100644
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -132,6 +132,19 @@ struct snd_sof_dai *snd_sof_find_dai(struct snd_sof_dev *sdev,
 	return NULL;
 }
 
+bool snd_sof_dsp_d0i3_on_suspend(struct snd_sof_dev *sdev)
+{
+	struct snd_sof_pcm *spcm;
+
+	list_for_each_entry(spcm, &sdev->pcm_list, list) {
+		if (spcm->stream[SNDRV_PCM_STREAM_PLAYBACK].suspend_ignored ||
+		    spcm->stream[SNDRV_PCM_STREAM_CAPTURE].suspend_ignored)
+			return true;
+	}
+
+	return false;
+}
+
 /*
  * FW Panic/fault handling.
  */
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index 6408ac88a3e5..c7c2c70ee4d0 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -553,6 +553,8 @@ struct snd_sof_pcm *snd_sof_find_spcm_dai(struct snd_sof_dev *sdev,
 	return NULL;
 }
 
+bool snd_sof_dsp_d0i3_on_suspend(struct snd_sof_dev *sdev);
+
 struct snd_sof_pcm *snd_sof_find_spcm_name(struct snd_sof_dev *sdev,
 					   const char *name);
 struct snd_sof_pcm *snd_sof_find_spcm_comp(struct snd_sof_dev *sdev,
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
