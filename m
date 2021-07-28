Return-Path: <SRS0=/xSo=MU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2919CC4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Jul 2021 11:27:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4182E60724
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Jul 2021 11:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4182E60724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D1F4117EF;
	Wed, 28 Jul 2021 13:26:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D1F4117EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627471633;
	bh=iMsQ1y4xygIVY1VJqGCYWCrmNMdinlROpxDuB9zhmyU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BE6qV6zqcJeGgNIHxB+UcuPntF1IPzeadKBTtUWB7+zo9rzv73EGtZB63N8xTBXHb
	 L0yW29L0Th6SfOIGIhVObnk3e7z5dnBHE1EukzAqTnHNhU1QpP84+k8ODKlIun4kld
	 m+5O+oqlxRiGNYeqz0My89vBtbjFZmbEOwVsa1Kg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 97B55F804EC;
	Wed, 28 Jul 2021 13:24:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ED9B9F804DA; Wed, 28 Jul 2021 13:24:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8149CF802A9
 for <alsa-devel@alsa-project.org>; Wed, 28 Jul 2021 13:23:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8149CF802A9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="jZjnFHSf"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="lm+uiI0h"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 83E691FF88;
 Wed, 28 Jul 2021 11:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1627471434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uOLAxgFmuIdFVl8t9Q3JRIAsoz6GO4ZzUHxR55M5+qk=;
 b=jZjnFHSfstJWxgB0XrDp+UolP1Zm4spmkVhfrYreQk1Nim5It1dv0K5Qgpd3eHvZO1/+2e
 QdbFJcz4MjsOgOSqovgEMcjgavsBZNoDx3Mdibj141sARGvRGvRbtWqnDPuvk4RDoLNFWJ
 ub5jOIhiMZfFPsAhkNubYRheXlno5Ic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1627471434;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uOLAxgFmuIdFVl8t9Q3JRIAsoz6GO4ZzUHxR55M5+qk=;
 b=lm+uiI0hpUG3lWwruUtGW3bJ/qKuuxB2gE/QMMuntYkAuOqbDGMChzula/mXoci1Yi/s+e
 UhGNr1bKPwxmq9Bw==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 6E388A3B81;
 Wed, 28 Jul 2021 11:23:54 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/5] ASoC: intel: atom: Fix reference to PCM buffer address
Date: Wed, 28 Jul 2021 13:23:50 +0200
Message-Id: <20210728112353.6675-3-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210728112353.6675-1-tiwai@suse.de>
References: <20210728112353.6675-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 stable@vger.kernel.org
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

PCM buffers might be allocated dynamically when the buffer
preallocation failed or a larger buffer is requested, and it's not
guaranteed that substream->dma_buffer points to the actually used
buffer.  The address should be retrieved from runtime->dma_addr,
instead of substream->dma_buffer (and shouldn't use virt_to_phys).

Also, remove the line overriding runtime->dma_area superfluously,
which was already set up at the PCM buffer allocation.

Cc: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index 4124aa2fc247..5db2f4865bbb 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -127,7 +127,7 @@ static void sst_fill_alloc_params(struct snd_pcm_substream *substream,
 	snd_pcm_uframes_t period_size;
 	ssize_t periodbytes;
 	ssize_t buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
-	u32 buffer_addr = virt_to_phys(substream->dma_buffer.area);
+	u32 buffer_addr = substream->runtime->dma_addr;
 
 	channels = substream->runtime->channels;
 	period_size = substream->runtime->period_size;
@@ -233,7 +233,6 @@ static int sst_platform_alloc_stream(struct snd_pcm_substream *substream,
 	/* set codec params and inform SST driver the same */
 	sst_fill_pcm_params(substream, &param);
 	sst_fill_alloc_params(substream, &alloc_params);
-	substream->runtime->dma_area = substream->dma_buffer.area;
 	str_params.sparams = param;
 	str_params.aparams = alloc_params;
 	str_params.codec = SST_CODEC_TYPE_PCM;
-- 
2.26.2

