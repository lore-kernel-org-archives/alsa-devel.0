Return-Path: <SRS0=WmXX=E5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B7FC63777
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2020 09:02:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C0142078E
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2020 09:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hw12C5sk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0142078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 75DDA16BF;
	Mon, 23 Nov 2020 10:01:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 75DDA16BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606122156;
	bh=ujR70FJzM8byzUAFZnnbiGs+hY9QYMa1+Uyf8UjlN/E=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hw12C5skV9hyAsMasqQTEdvWk47sub73lL0gaMLmknjSQakYNMtE58NGTLeqy9TVJ
	 H9BeZq0k7wkcWe1791OuqyNfr34Sx6o4i5K+WesT7/+Y7bnXy5tjZ0Ksz9Y7WcWQzQ
	 6OSCDu1UYE3Ey7RjvVqvNcnUM7t7uZSx3u9VRmHQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5D6F3F80567;
	Mon, 23 Nov 2020 09:54:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 65ABEF80529; Mon, 23 Nov 2020 09:54:26 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 725FFF804D2
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2020 09:54:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 725FFF804D2
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 46117AE30;
 Mon, 23 Nov 2020 08:53:58 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 24/41] ALSA: usb-audio: Fix EP matching for continuous rates
Date: Mon, 23 Nov 2020 09:53:30 +0100
Message-Id: <20201123085347.19667-25-tiwai@suse.de>
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

The function to evaluate the match of the parameters with an EP
assumes only the discrete rate tables and doesn't handle the
continuous rates properly.

This patch fixes match_endpoint_audioformats() to handle the
continuous rates.  Also the almost useless debug prints there are
dropped.

Tested-by: Keith Milner <kamilner@superlative.org>
Tested-by: Dylan Robinson <dylan_robinson@motu.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/pcm.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index ac6385a4eb70..45a692512d27 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -695,41 +695,30 @@ static int match_endpoint_audioformats(struct snd_usb_substream *subs,
 				       struct audioformat *match, int rate,
 				       snd_pcm_format_t pcm_format)
 {
-	int i;
-	int score = 0;
+	int i, score;
 
-	if (fp->channels < 1) {
-		dev_dbg(&subs->dev->dev,
-			"%s: (fmt @%p) no channels\n", __func__, fp);
+	if (fp->channels < 1)
 		return 0;
-	}
 
-	if (!(fp->formats & pcm_format_to_bits(pcm_format))) {
-		dev_dbg(&subs->dev->dev,
-			"%s: (fmt @%p) no match for format %d\n", __func__,
-			fp, pcm_format);
+	if (!(fp->formats & pcm_format_to_bits(pcm_format)))
 		return 0;
-	}
 
-	for (i = 0; i < fp->nr_rates; i++) {
-		if (fp->rate_table[i] == rate) {
-			score++;
-			break;
+	if (fp->rates & SNDRV_PCM_RATE_CONTINUOUS) {
+		if (rate < fp->rate_min || rate > fp->rate_max)
+			return 0;
+	} else {
+		for (i = 0; i < fp->nr_rates; i++) {
+			if (fp->rate_table[i] == rate)
+				break;
 		}
-	}
-	if (!score) {
-		dev_dbg(&subs->dev->dev,
-			"%s: (fmt @%p) no match for rate %d\n", __func__,
-			fp, rate);
-		return 0;
+		if (i >= fp->nr_rates)
+			return 0;
 	}
 
+	score = 1;
 	if (fp->channels == match->channels)
 		score++;
 
-	dev_dbg(&subs->dev->dev,
-		"%s: (fmt @%p) score %d\n", __func__, fp, score);
-
 	return score;
 }
 
-- 
2.16.4

