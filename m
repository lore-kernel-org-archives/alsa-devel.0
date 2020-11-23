Return-Path: <SRS0=WmXX=E5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE8AC56202
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2020 09:00:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 876AB20732
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2020 09:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pxvJkOhd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876AB20732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0135985D;
	Mon, 23 Nov 2020 09:59:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0135985D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606122001;
	bh=SEw26tcJl3GDpzbhoqaskF332gJiDSdG+ONa4OVoWV8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pxvJkOhdAd2sZK7cZfRjXzGGMY1klwrMtFANGSm0KL7385YnGbGQJ8wHN62C88ki0
	 uM46js1j4pnseVPcLoDkzMdR3DLequcRU5EhDVHxqz+hQ8uOqMqUxW2A3hoItxPb3u
	 BSJ1jiqrTJPFKUb5Jo318sghyBvaCezqP72fMwwk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BABECF8053D;
	Mon, 23 Nov 2020 09:54:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9AB19F80528; Mon, 23 Nov 2020 09:54:19 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 49A15F804C1
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2020 09:53:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 49A15F804C1
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 7CDB6AF9C;
 Mon, 23 Nov 2020 08:53:57 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 11/41] ALSA: usb-audio: Simplify hw_params rules
Date: Mon, 23 Nov 2020 09:53:17 +0100
Message-Id: <20201123085347.19667-12-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201123085347.19667-1-tiwai@suse.de>
References: <20201123085347.19667-1-tiwai@suse.de>
Cc: Matwey Kornilov <matwey.kornilov@gmail.com>,
 Dylan Robinson <dylan_robinson@motu.com>,
 Keith Milner <kamilner@superlative.org>
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

Several hw_params functions narrows the interval via min/max rule in
the very similar way, so factor out those into a helper function and
use commonly.

No functional changes, just minor code refactoring.

Tested-by: Keith Milner <kamilner@superlative.org>
Tested-by: Dylan Robinson <dylan_robinson@motu.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/pcm.c | 110 ++++++++++++++++++++------------------------------------
 1 file changed, 38 insertions(+), 72 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 6d1f5277cd90..ecc6bf9b42f0 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1121,6 +1121,36 @@ static int hw_check_valid_format(struct snd_usb_substream *subs,
 	return 1;
 }
 
+static int apply_hw_params_minmax(struct snd_interval *it, unsigned int rmin,
+				  unsigned int rmax)
+{
+	int changed;
+
+	if (rmin > rmax) {
+		hwc_debug("  --> get empty\n");
+		it->empty = 1;
+		return -EINVAL;
+	}
+
+	changed = 0;
+	if (it->min < rmin) {
+		it->min = rmin;
+		it->openmin = 0;
+		changed = 1;
+	}
+	if (it->max > rmax) {
+		it->max = rmax;
+		it->openmax = 0;
+		changed = 1;
+	}
+	if (snd_interval_checkempty(it)) {
+		it->empty = 1;
+		return -EINVAL;
+	}
+	hwc_debug("  --> (%d, %d) (changed = %d)\n", it->min, it->max, changed);
+	return changed;
+}
+
 static int hw_rule_rate(struct snd_pcm_hw_params *params,
 			struct snd_pcm_hw_rule *rule)
 {
@@ -1128,7 +1158,6 @@ static int hw_rule_rate(struct snd_pcm_hw_params *params,
 	struct audioformat *fp;
 	struct snd_interval *it = hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
 	unsigned int rmin, rmax, r;
-	int changed;
 	int i;
 
 	hwc_debug("hw_rule_rate: (%d,%d)\n", it->min, it->max);
@@ -1151,29 +1180,7 @@ static int hw_rule_rate(struct snd_pcm_hw_params *params,
 		}
 	}
 
-	if (rmin > rmax) {
-		hwc_debug("  --> get empty\n");
-		it->empty = 1;
-		return -EINVAL;
-	}
-
-	changed = 0;
-	if (it->min < rmin) {
-		it->min = rmin;
-		it->openmin = 0;
-		changed = 1;
-	}
-	if (it->max > rmax) {
-		it->max = rmax;
-		it->openmax = 0;
-		changed = 1;
-	}
-	if (snd_interval_checkempty(it)) {
-		it->empty = 1;
-		return -EINVAL;
-	}
-	hwc_debug("  --> (%d, %d) (changed = %d)\n", it->min, it->max, changed);
-	return changed;
+	return apply_hw_params_minmax(it, rmin, rmax);
 }
 
 
@@ -1184,48 +1191,18 @@ static int hw_rule_channels(struct snd_pcm_hw_params *params,
 	struct audioformat *fp;
 	struct snd_interval *it = hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
 	unsigned int rmin, rmax;
-	int changed;
 
 	hwc_debug("hw_rule_channels: (%d,%d)\n", it->min, it->max);
-	changed = 0;
-	rmin = rmax = 0;
+	rmin = UINT_MAX;
+	rmax = 0;
 	list_for_each_entry(fp, &subs->fmt_list, list) {
 		if (!hw_check_valid_format(subs, params, fp))
 			continue;
-		if (changed++) {
-			if (rmin > fp->channels)
-				rmin = fp->channels;
-			if (rmax < fp->channels)
-				rmax = fp->channels;
-		} else {
-			rmin = fp->channels;
-			rmax = fp->channels;
-		}
+		rmin = min(rmin, fp->channels);
+		rmax = max(rmax, fp->channels);
 	}
 
-	if (!changed) {
-		hwc_debug("  --> get empty\n");
-		it->empty = 1;
-		return -EINVAL;
-	}
-
-	changed = 0;
-	if (it->min < rmin) {
-		it->min = rmin;
-		it->openmin = 0;
-		changed = 1;
-	}
-	if (it->max > rmax) {
-		it->max = rmax;
-		it->openmax = 0;
-		changed = 1;
-	}
-	if (snd_interval_checkempty(it)) {
-		it->empty = 1;
-		return -EINVAL;
-	}
-	hwc_debug("  --> (%d, %d) (changed = %d)\n", it->min, it->max, changed);
-	return changed;
+	return apply_hw_params_minmax(it, rmin, rmax);
 }
 
 static int hw_rule_format(struct snd_pcm_hw_params *params,
@@ -1267,7 +1244,6 @@ static int hw_rule_period_time(struct snd_pcm_hw_params *params,
 	struct snd_interval *it;
 	unsigned char min_datainterval;
 	unsigned int pmin;
-	int changed;
 
 	it = hw_param_interval(params, SNDRV_PCM_HW_PARAM_PERIOD_TIME);
 	hwc_debug("hw_rule_period_time: (%u,%u)\n", it->min, it->max);
@@ -1283,18 +1259,8 @@ static int hw_rule_period_time(struct snd_pcm_hw_params *params,
 		return -EINVAL;
 	}
 	pmin = 125 * (1 << min_datainterval);
-	changed = 0;
-	if (it->min < pmin) {
-		it->min = pmin;
-		it->openmin = 0;
-		changed = 1;
-	}
-	if (snd_interval_checkempty(it)) {
-		it->empty = 1;
-		return -EINVAL;
-	}
-	hwc_debug("  --> (%u,%u) (changed = %d)\n", it->min, it->max, changed);
-	return changed;
+
+	return apply_hw_params_minmax(it, pmin, UINT_MAX);
 }
 
 /* apply PCM hw constraints from the concurrent sync EP */
-- 
2.16.4

