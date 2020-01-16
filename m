Return-Path: <SRS0=iD9L=3F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADAFC33CB1
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:29:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22AFA206D5
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OHOoTKpT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22AFA206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 674C917B4;
	Thu, 16 Jan 2020 17:28:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 674C917B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579192163;
	bh=TmrGJcaJClcCRWCdHAoDEy0BZNiu3+8f4QIYBqkB9sQ=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OHOoTKpTJOD2g+AQ5PJkg5nGu8hSW0ery+t7Mqi1Wn1tYAv74DyO+5aPSD/LhZ44S
	 yXSlcYsN24zfUTl0dZwiPJrifIfBD/RcU6qB+dltm8aI4mPjlSD1BBjqzXQHh3zh+T
	 NnIPPMXuXZQEiCYNkSaQ8s+Vbs8MSt13f6PielWQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DEA50F8014D;
	Thu, 16 Jan 2020 17:28:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 311AAF8014E; Thu, 16 Jan 2020 17:28:31 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9AD9FF800B9
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2020 17:28:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9AD9FF800B9
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 22CD3B2C05
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2020 16:28:27 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Thu, 16 Jan 2020 17:28:25 +0100
Message-Id: <20200116162825.24792-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Subject: [alsa-devel] [PATCH] ALSA: pcm: Make snd_pcm_hw_constraints_init()
	and _complete() static
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Both snd_pcm_hw_constraints_init() and _complete() functions are
called only from pcm_native.c, hence they can be static for further
optimization.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_local.h  | 3 ---
 sound/core/pcm_native.c | 4 ++--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/core/pcm_local.h b/sound/core/pcm_local.h
index 384efd002984..17a1a5d87098 100644
--- a/sound/core/pcm_local.h
+++ b/sound/core/pcm_local.h
@@ -20,9 +20,6 @@ void snd_interval_muldivk(const struct snd_interval *a,
 void snd_interval_mulkdiv(const struct snd_interval *a, unsigned int k,
 			  const struct snd_interval *b, struct snd_interval *c);
 
-int snd_pcm_hw_constraints_init(struct snd_pcm_substream *substream);
-int snd_pcm_hw_constraints_complete(struct snd_pcm_substream *substream);
-
 int snd_pcm_hw_constraint_mask(struct snd_pcm_runtime *runtime,
 			       snd_pcm_hw_param_t var, u_int32_t mask);
 
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index c375c41496f8..bb23f5066654 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2308,7 +2308,7 @@ static int snd_pcm_hw_rule_buffer_bytes_max(struct snd_pcm_hw_params *params,
 	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
 }		
 
-int snd_pcm_hw_constraints_init(struct snd_pcm_substream *substream)
+static int snd_pcm_hw_constraints_init(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_pcm_hw_constraints *constrs = &runtime->hw_constraints;
@@ -2432,7 +2432,7 @@ int snd_pcm_hw_constraints_init(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-int snd_pcm_hw_constraints_complete(struct snd_pcm_substream *substream)
+static int snd_pcm_hw_constraints_complete(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_pcm_hardware *hw = &runtime->hw;
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
