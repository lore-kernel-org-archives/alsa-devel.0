Return-Path: <SRS0=Zr1M=45=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92566C10DCE
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:49:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FF9B206FA
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pF8jm0/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF9B206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 79353171F;
	Thu, 12 Mar 2020 15:48:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 79353171F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584024588;
	bh=8e2S/U+kp08mrCdLAThG8ojTPA4hK6yC2BAzeJqLfOc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pF8jm0/tUzkfDBYodTzaw8FW9SCANO3HxAsVugPdqZkeFhGYpZfN5fqb2OT8TkxUh
	 lg1dlGWfCvnJNfqeHlY5OKhAhG0HuQxdZxMAOIAYb/uGZin6+0Uhr1nosymaNUn6mi
	 g7KG59SoE5dTkRwaHkYAtwVwKuGdkx40eQXb37BY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C857CF80306;
	Thu, 12 Mar 2020 15:45:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E0904F802BD; Thu, 12 Mar 2020 15:45:00 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0CD82F80292;
 Thu, 12 Mar 2020 15:44:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0CD82F80292
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Mar 2020 07:44:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; d="scan'208";a="443957580"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO
 ubuntu.ger.corp.intel.com) ([10.249.40.3])
 by fmsmga006.fm.intel.com with ESMTP; 12 Mar 2020 07:44:42 -0700
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 07/14] ASoC: SOF: add two helper lookup functions
Date: Thu, 12 Mar 2020 15:44:22 +0100
Message-Id: <20200312144429.17959-8-guennadi.liakhovetski@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312144429.17959-1-guennadi.liakhovetski@linux.intel.com>
References: <20200312144429.17959-1-guennadi.liakhovetski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
 sound-open-firmware@alsa-project.org
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

Add two helper lookup functions for finding a widget by its component
ID and a DAI by a pipeline ID.

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 sound/soc/sof/sof-audio.c | 24 ++++++++++++++++++++++++
 sound/soc/sof/sof-audio.h |  4 ++++
 2 files changed, 28 insertions(+)

diff --git a/sound/soc/sof/sof-audio.c b/sound/soc/sof/sof-audio.c
index fc4ed2a..b4c5fe2 100644
--- a/sound/soc/sof/sof-audio.c
+++ b/sound/soc/sof/sof-audio.c
@@ -395,6 +395,30 @@ struct snd_sof_dai *snd_sof_find_dai(struct snd_soc_component *scomp,
 	return NULL;
 }
 
+struct snd_sof_widget *snd_sof_find_swidget_id(struct snd_sof_dev *sdev,
+					       unsigned int comp_id)
+{
+	struct snd_sof_widget *swidget;
+
+	list_for_each_entry(swidget, &sdev->widget_list, list)
+		if (swidget->comp_id == comp_id)
+			return swidget;
+
+	return NULL;
+}
+
+struct snd_sof_dai *snd_sof_find_dai_pipe(struct snd_sof_dev *sdev,
+					  unsigned int pipeline_id)
+{
+	struct snd_sof_dai *dai;
+
+	list_for_each_entry(dai, &sdev->dai_list, list)
+		if (dai->pipeline_id == pipeline_id)
+			return dai;
+
+	return NULL;
+}
+
 /*
  * SOF Driver enumeration.
  */
diff --git a/sound/soc/sof/sof-audio.h b/sound/soc/sof/sof-audio.h
index eacd10e..e9a6091 100644
--- a/sound/soc/sof/sof-audio.h
+++ b/sound/soc/sof/sof-audio.h
@@ -188,6 +188,10 @@ struct snd_sof_pcm *snd_sof_find_spcm_comp(struct snd_soc_component *scomp,
 					   int *direction);
 struct snd_sof_pcm *snd_sof_find_spcm_pcm_id(struct snd_soc_component *scomp,
 					     unsigned int pcm_id);
+struct snd_sof_widget *snd_sof_find_swidget_id(struct snd_sof_dev *sdev,
+					       unsigned int comp_id);
+struct snd_sof_dai *snd_sof_find_dai_pipe(struct snd_sof_dev *sdev,
+					  unsigned int pipeline_id);
 void snd_sof_pcm_period_elapsed(struct snd_pcm_substream *substream);
 
 /*
-- 
1.9.3

