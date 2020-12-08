Return-Path: <SRS0=8QnY=FM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A1AC4361B
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Dec 2020 13:52:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8480623AA9
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Dec 2020 13:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8480623AA9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5EF0616EC;
	Tue,  8 Dec 2020 14:52:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5EF0616EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607435575;
	bh=/NZjxJrxrQwf7bNsWIBVqxJnmiGIcXleRZj+izHwU9U=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mmvUOm7A9YB/T+9ARSXrp9JREVA/5ntQc9EgHNmNTy0U77Qu+xrSQAyeKL4IAYwpR
	 hu8O34yj1cs85PIGsyNQnwBQNg4m5LWXSKPci6HtI0YISB1SOe80sYzzyfvtxXeSJF
	 z3GESgS7MWhEDfZAcyqu3CiKRlprs6gR/b9O0844=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B8BCFF80164;
	Tue,  8 Dec 2020 14:52:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5EB76F80130; Tue,  8 Dec 2020 14:52:03 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 493D7F80130
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2020 14:51:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 493D7F80130
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 1C755AC94;
 Tue,  8 Dec 2020 13:51:56 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: cx2072x: Fix doubly definitions of Playback and Capture
 streams
Date: Tue,  8 Dec 2020 14:51:54 +0100
Message-Id: <20201208135154.9188-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The cx2072x codec driver defines multiple DAIs with the same stream
name "Playback" and "Capture".  Although the current code works more
or less as is as the secondary streams are never used, it still leads
the error message like:
 debugfs: File 'Playback' in directory 'dapm' already present!
 debugfs: File 'Capture' in directory 'dapm' already present!

Fix it by renaming the secondary streams to unique names.

Fixes: a497a4363706 ("ASoC: Add support for Conexant CX2072X CODEC")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/cx2072x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cx2072x.c b/sound/soc/codecs/cx2072x.c
index 2ad00ed21bec..2f10991a8bdb 100644
--- a/sound/soc/codecs/cx2072x.c
+++ b/sound/soc/codecs/cx2072x.c
@@ -1579,7 +1579,7 @@ static struct snd_soc_dai_driver soc_codec_cx2072x_dai[] = {
 		.id	= CX2072X_DAI_DSP,
 		.probe = cx2072x_dsp_dai_probe,
 		.playback = {
-			.stream_name = "Playback",
+			.stream_name = "DSP Playback",
 			.channels_min = 2,
 			.channels_max = 2,
 			.rates = CX2072X_RATES_DSP,
@@ -1591,7 +1591,7 @@ static struct snd_soc_dai_driver soc_codec_cx2072x_dai[] = {
 		.name = "cx2072x-aec",
 		.id	= 3,
 		.capture = {
-			.stream_name = "Capture",
+			.stream_name = "AEC Capture",
 			.channels_min = 2,
 			.channels_max = 2,
 			.rates = CX2072X_RATES_DSP,
-- 
2.26.2

