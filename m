Return-Path: <SRS0=yD/C=LC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5BCC47082
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Jun 2021 14:26:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DD5560FDB
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Jun 2021 14:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD5560FDB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AD1041792;
	Tue,  8 Jun 2021 16:25:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AD1041792
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623162395;
	bh=ojS34bKRzAWVyChP0ghZiGrVqY85MAfPLQF6hHu3mn4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e/zfUQ97UwXRRwc36ttTYg6pddMcOY5UfOuwO1Fm6MVA9Zpqee074LnAT7A7Rwh6H
	 s/9ChwCBTfD2q1z3Cxd+zJNNAdN59GkLrH5aAzlMh9Da+sbvurMd8TWVeT13Pdf6wG
	 FnqJDgTDc/GR/T1ifGPqCekhobNrPS+gsaG6gwXU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 73CCAF8068A;
	Tue,  8 Jun 2021 16:07:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 51A75F8061F; Tue,  8 Jun 2021 16:07:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D7A6EF80506
 for <alsa-devel@alsa-project.org>; Tue,  8 Jun 2021 16:05:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7A6EF80506
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="Og9iVR+j"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="v5NpJP63"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 720F0219F7
 for <alsa-devel@alsa-project.org>; Tue,  8 Jun 2021 14:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623161145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ngBZWaAxRQ6VxkkqhATNt41+hkFq28+9VORY7vSqh98=;
 b=Og9iVR+j9LMZUi20saPKniFTkkBS3MrN6asN3TyMdXjXIk5KIEEPHwyG60R14L9xdL5GuR
 rCZm7KsapxeK/lcSZfBBaay6Cxy6CmjiBj3GsB6sBeshGk/CKJjxwGKYBr6PKJD5aX8Wg1
 TFKTBWpNySDbdejg7N8qf11xr1udmXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623161145;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ngBZWaAxRQ6VxkkqhATNt41+hkFq28+9VORY7vSqh98=;
 b=v5NpJP63gJVg+ORzN8Nq65OrV85dDvTTi1NAUmibNkZ8gnGgaEg0KL33987C6Yatlr7Te4
 0/gyVgOmoU+88HBQ==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 6B1C7A3B88;
 Tue,  8 Jun 2021 14:05:45 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 54/66] ALSA: pcm: Fix assignment in if condition
Date: Tue,  8 Jun 2021 16:05:28 +0200
Message-Id: <20210608140540.17885-55-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210608140540.17885-1-tiwai@suse.de>
References: <20210608140540.17885-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

There are a few places doing assignments in if condition in ALSA PCM
core code, which is a bad coding style that may confuse readers and
occasionally lead to bugs.

This patch is merely for coding-style fixes, no functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_compat.c |  6 ++++--
 sound/core/pcm_misc.c   | 12 ++++++++----
 sound/core/pcm_native.c |  6 ++++--
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/sound/core/pcm_compat.c b/sound/core/pcm_compat.c
index 590a46a9e78d..a59de24695ec 100644
--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -239,7 +239,8 @@ static int snd_pcm_ioctl_hw_params_compat(struct snd_pcm_substream *substream,
 	struct snd_pcm_runtime *runtime;
 	int err;
 
-	if (! (runtime = substream->runtime))
+	runtime = substream->runtime;
+	if (!runtime)
 		return -ENOTTY;
 
 	data = kmalloc(sizeof(*data), GFP_KERNEL);
@@ -343,7 +344,8 @@ static int snd_pcm_ioctl_xfern_compat(struct snd_pcm_substream *substream,
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN)
 		return -EBADFD;
 
-	if ((ch = substream->runtime->channels) > 128)
+	ch = substream->runtime->channels;
+	if (ch > 128)
 		return -EINVAL;
 	if (get_user(buf, &data32->bufs) ||
 	    get_user(frames, &data32->frames))
diff --git a/sound/core/pcm_misc.c b/sound/core/pcm_misc.c
index 257d412eac5d..4866aed97aac 100644
--- a/sound/core/pcm_misc.c
+++ b/sound/core/pcm_misc.c
@@ -266,7 +266,8 @@ int snd_pcm_format_signed(snd_pcm_format_t format)
 	int val;
 	if (!valid_format(format))
 		return -EINVAL;
-	if ((val = pcm_formats[(INT)format].signd) < 0)
+	val = pcm_formats[(INT)format].signd;
+	if (val < 0)
 		return -EINVAL;
 	return val;
 }
@@ -314,7 +315,8 @@ int snd_pcm_format_little_endian(snd_pcm_format_t format)
 	int val;
 	if (!valid_format(format))
 		return -EINVAL;
-	if ((val = pcm_formats[(INT)format].le) < 0)
+	val = pcm_formats[(INT)format].le;
+	if (val < 0)
 		return -EINVAL;
 	return val;
 }
@@ -350,7 +352,8 @@ int snd_pcm_format_width(snd_pcm_format_t format)
 	int val;
 	if (!valid_format(format))
 		return -EINVAL;
-	if ((val = pcm_formats[(INT)format].width) == 0)
+	val = pcm_formats[(INT)format].width;
+	if (!val)
 		return -EINVAL;
 	return val;
 }
@@ -368,7 +371,8 @@ int snd_pcm_format_physical_width(snd_pcm_format_t format)
 	int val;
 	if (!valid_format(format))
 		return -EINVAL;
-	if ((val = pcm_formats[(INT)format].phys) == 0)
+	val = pcm_formats[(INT)format].phys;
+	if (!val)
 		return -EINVAL;
 	return val;
 }
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 11acea02bc74..eb468573f070 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -768,7 +768,8 @@ static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
 
 	if (cpu_latency_qos_request_active(&substream->latency_pm_qos_req))
 		cpu_latency_qos_remove_request(&substream->latency_pm_qos_req);
-	if ((usecs = period_to_usecs(runtime)) >= 0)
+	usecs = period_to_usecs(runtime);
+	if (usecs >= 0)
 		cpu_latency_qos_add_request(&substream->latency_pm_qos_req,
 					    usecs);
 	return 0;
@@ -2658,7 +2659,8 @@ int snd_pcm_open_substream(struct snd_pcm *pcm, int stream,
 		goto error;
 	}
 
-	if ((err = substream->ops->open(substream)) < 0)
+	err = substream->ops->open(substream);
+	if (err < 0)
 		goto error;
 
 	substream->hw_opened = 1;
-- 
2.26.2

