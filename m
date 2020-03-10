Return-Path: <SRS0=NKE9=43=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0F5C10F27
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Mar 2020 16:38:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07D32215A4
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Mar 2020 16:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ou1MRgis"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D32215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5F0C31678;
	Tue, 10 Mar 2020 17:37:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5F0C31678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583858327;
	bh=eAwLyfWWRdAMzC/6jweVhUTew67XY5YvVm6dtZZWHJE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ou1MRgisEm8u5yVaiQ8DbkUo3e0PolRpK241buQCVIr4mUEbYYf/jNpogdmjeyQnJ
	 ctCKFED13tVnvJ+9AW7dqlGIfUNs4pjLnE0oYfQFcizPLk1fGt2cDZhgyBqhVWokoz
	 bEWk3O8SWQLl2eEr6tOqxWeuajZ+cHnFF/GFvGwE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D615F80290;
	Tue, 10 Mar 2020 17:36:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 05DE6F80291; Tue, 10 Mar 2020 17:36:31 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3723BF80247
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2020 17:36:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3723BF80247
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 22A08AC84;
 Tue, 10 Mar 2020 16:36:27 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH for-5.7] ASoC: pcm: Fix (again) possible buffer overflow in
 dpcm state sysfs output
Date: Tue, 10 Mar 2020 17:36:25 +0100
Message-Id: <20200310163625.10838-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Cc: alsa-devel@alsa-project.org
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

This is re-applying the fix that went into 5.6 (commit 6c89ffea60aa)
as the changes were wiped out after merging the other code
refactoring.  Basically the same changes, just replacing the
suspicious calls of snprintf() with scnprintf().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/soc-pcm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index e7915adaaf0a..34ee54ea7b30 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -66,16 +66,16 @@ static ssize_t dpcm_show_state(struct snd_soc_pcm_runtime *fe,
 	unsigned long flags;
 
 	/* FE state */
-	offset += snprintf(buf + offset, size - offset,
+	offset += scnprintf(buf + offset, size - offset,
 			   "[%s - %s]\n", fe->dai_link->name,
 			   stream ? "Capture" : "Playback");
 
-	offset += snprintf(buf + offset, size - offset, "State: %s\n",
+	offset += scnprintf(buf + offset, size - offset, "State: %s\n",
 			   dpcm_state_string(fe->dpcm[stream].state));
 
 	if ((fe->dpcm[stream].state >= SND_SOC_DPCM_STATE_HW_PARAMS) &&
 	    (fe->dpcm[stream].state <= SND_SOC_DPCM_STATE_STOP))
-		offset += snprintf(buf + offset, size - offset,
+		offset += scnprintf(buf + offset, size - offset,
 				   "Hardware Params: "
 				   "Format = %s, Channels = %d, Rate = %d\n",
 				   snd_pcm_format_name(params_format(params)),
@@ -83,10 +83,10 @@ static ssize_t dpcm_show_state(struct snd_soc_pcm_runtime *fe,
 				   params_rate(params));
 
 	/* BEs state */
-	offset += snprintf(buf + offset, size - offset, "Backends:\n");
+	offset += scnprintf(buf + offset, size - offset, "Backends:\n");
 
 	if (list_empty(&fe->dpcm[stream].be_clients)) {
-		offset += snprintf(buf + offset, size - offset,
+		offset += scnprintf(buf + offset, size - offset,
 				   " No active DSP links\n");
 		goto out;
 	}
@@ -96,16 +96,16 @@ static ssize_t dpcm_show_state(struct snd_soc_pcm_runtime *fe,
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 		params = &dpcm->hw_params;
 
-		offset += snprintf(buf + offset, size - offset,
+		offset += scnprintf(buf + offset, size - offset,
 				   "- %s\n", be->dai_link->name);
 
-		offset += snprintf(buf + offset, size - offset,
+		offset += scnprintf(buf + offset, size - offset,
 				   "   State: %s\n",
 				   dpcm_state_string(be->dpcm[stream].state));
 
 		if ((be->dpcm[stream].state >= SND_SOC_DPCM_STATE_HW_PARAMS) &&
 		    (be->dpcm[stream].state <= SND_SOC_DPCM_STATE_STOP))
-			offset += snprintf(buf + offset, size - offset,
+			offset += scnprintf(buf + offset, size - offset,
 					   "   Hardware Params: "
 					   "Format = %s, Channels = %d, Rate = %d\n",
 					   snd_pcm_format_name(params_format(params)),
-- 
2.16.4

