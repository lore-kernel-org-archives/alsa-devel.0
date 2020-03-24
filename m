Return-Path: <SRS0=1tVn=5J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0D8C43331
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:31:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48C152070A
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uAn4NI+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C152070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A059A1614;
	Tue, 24 Mar 2020 13:30:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A059A1614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585053084;
	bh=h85bPyFjWSLkKPfZFuv7KYqY4pc47ys2gApEx9UC5TU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uAn4NI+rkcHFFwbxXUCFhq9TY+I2GgJXNa09yFX2zBXTojZwpOQeZdwH+vtFo1Fst
	 bSBWhfnnDZpiWeHUBvY6fKx8AHp6Xlv9AG3FoAXRaLvpN9iW+kZTdkylk1EbxLF7uK
	 F5r50u0D8hYT3Yfpn6fPdJk7j68J4Ohj97ahzmx8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8499CF80272;
	Tue, 24 Mar 2020 13:29:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 78847F80227; Tue, 24 Mar 2020 13:29:37 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DF3F4F80095;
 Tue, 24 Mar 2020 13:29:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DF3F4F80095
IronPort-SDR: wK4gX66/ucwzrrV0Wd2nbpsng1y9L7KF2BomXIqiNg0+Rafov9dcCJNIQRJaHW/58KCUnsUWsi
 yNxfx1owH2ew==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2020 05:29:25 -0700
IronPort-SDR: S8KqrppJjLf5aERalJoPrZ5boLxDs137K0FQuZHnyfC3atN92qlHMFx+ImkU1zqQq0KASHIlYm
 ypBHI3ejpAFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,300,1580803200"; d="scan'208";a="246638959"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO
 ubuntu.ger.corp.intel.com) ([10.249.33.88])
 by orsmga003.jf.intel.com with ESMTP; 24 Mar 2020 05:29:24 -0700
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/2] ASoC: SOF: (cosmetic) use for_each_pcm_streams() in
 sof_dai_load()
Date: Tue, 24 Mar 2020 13:29:20 +0100
Message-Id: <20200324122921.29582-2-guennadi.liakhovetski@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200324122921.29582-1-guennadi.liakhovetski@linux.intel.com>
References: <20200324122921.29582-1-guennadi.liakhovetski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: sound-open-firmware@alsa-project.org
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

Use for_each_pcm_streams() to enumerate streams in sof_dai_load()
instead of doing that manually.

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 sound/soc/sof/topology.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 058de94..54437ca 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -2448,7 +2448,7 @@ static int sof_dai_load(struct snd_soc_component *scomp, int index,
 	struct snd_soc_tplg_stream_caps *caps;
 	struct snd_soc_tplg_private *private = &pcm->priv;
 	struct snd_sof_pcm *spcm;
-	int stream = SNDRV_PCM_STREAM_PLAYBACK;
+	int stream;
 	int ret = 0;
 
 	/* nothing to do for BEs atm */
@@ -2460,8 +2460,9 @@ static int sof_dai_load(struct snd_soc_component *scomp, int index,
 		return -ENOMEM;
 
 	spcm->scomp = scomp;
-	spcm->stream[SNDRV_PCM_STREAM_PLAYBACK].comp_id = COMP_ID_UNASSIGNED;
-	spcm->stream[SNDRV_PCM_STREAM_CAPTURE].comp_id = COMP_ID_UNASSIGNED;
+
+	for_each_pcm_streams(stream)
+		spcm->stream[stream].comp_id = COMP_ID_UNASSIGNED;
 
 	spcm->pcm = *pcm;
 	dev_dbg(scomp->dev, "tplg: load pcm %s\n", pcm->dai_name);
@@ -2482,8 +2483,10 @@ static int sof_dai_load(struct snd_soc_component *scomp, int index,
 	if (!spcm->pcm.playback)
 		goto capture;
 
+	stream = SNDRV_PCM_STREAM_PLAYBACK;
+
 	dev_vdbg(scomp->dev, "tplg: pcm %s stream tokens: playback d0i3:%d\n",
-		 spcm->pcm.pcm_name, spcm->stream[0].d0i3_compatible);
+		 spcm->pcm.pcm_name, spcm->stream[stream].d0i3_compatible);
 
 	caps = &spcm->pcm.caps[stream];
 
@@ -2513,7 +2516,7 @@ static int sof_dai_load(struct snd_soc_component *scomp, int index,
 		return ret;
 
 	dev_vdbg(scomp->dev, "tplg: pcm %s stream tokens: capture d0i3:%d\n",
-		 spcm->pcm.pcm_name, spcm->stream[1].d0i3_compatible);
+		 spcm->pcm.pcm_name, spcm->stream[stream].d0i3_compatible);
 
 	caps = &spcm->pcm.caps[stream];
 
-- 
1.9.3

