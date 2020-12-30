Return-Path: <SRS0=YQ6z=GC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA0DC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Dec 2020 13:05:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08B0B2220B
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Dec 2020 13:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B0B2220B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6EF611859;
	Wed, 30 Dec 2020 14:04:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6EF611859
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609333549;
	bh=lAXHsb70nJP+WYyBcH4Sr0dYyef1OZUZJDEgRu/5+Wg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OAiTaRFUV0/5hq+nTsTe5ERrZEwbDP5sNW1aTE8T7Ji5uge217oPQ6/Lqg4gRpLSn
	 w7Vlimk7poaHNK90RDasgWgSMowVDgqqjhxbhsy/fkAidZYFetSNjgal/cBMLlPLt9
	 iqXMKxLggEZM1QTzyr42o7WBOcWeN1U2BKiRX+f0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 331B4F801F9;
	Wed, 30 Dec 2020 14:04:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 37C3DF804B0; Wed, 30 Dec 2020 14:04:39 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8A539F80249
 for <alsa-devel@alsa-project.org>; Wed, 30 Dec 2020 14:04:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8A539F80249
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="MT/Mg4JG"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D71B1229EF;
 Wed, 30 Dec 2020 13:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1609333474;
 bh=lAXHsb70nJP+WYyBcH4Sr0dYyef1OZUZJDEgRu/5+Wg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MT/Mg4JGG1hPSHbCbsP1k5QWOjxRowd68evOaAKrTQilr8fPT2poXfw/v9j64wfiv
 Ki/uzT4tYW8B4OxTtGCdxhQZZ9qYIgTpU9LmTb7QobcdRkngiAoI+Z3n0ej3bQI9NQ
 w1bW00PqNoiixIuyTqTz6yUUfD7R4zR2zPRJQ9Qn0osfy4noIPTdNZ4Pjrmm2I6x0x
 fgWTvLMM+9WMrQl8rsu/xOw+Zkv+E99K6hRkLNDHHmOMtHY0SHuGVm0hm3PdqHULs8
 E7d8GshT7LpAwPUX5XiWIrEalh9HNttrzYSgsNGVwX5ZeR4phmbqaAnb53vDE7o4Rt
 YdfaUGf8KuRyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 09/10] ALSA: pcm: Clear the full allocated memory
 at hw_params
Date: Wed, 30 Dec 2020 08:04:21 -0500
Message-Id: <20201230130422.3637448-9-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201230130422.3637448-1-sashal@kernel.org>
References: <20201230130422.3637448-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
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

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 618de0f4ef11acd8cf26902e65493d46cc20cc89 ]

The PCM hw_params core function tries to clear up the PCM buffer
before actually using for avoiding the information leak from the
previous usages or the usage before a new allocation.  It performs the
memset() with runtime->dma_bytes, but this might still leave some
remaining bytes untouched; namely, the PCM buffer size is aligned in
page size for mmap, hence runtime->dma_bytes doesn't necessarily cover
all PCM buffer pages, and the remaining bytes are exposed via mmap.

This patch changes the memory clearance to cover the all buffer pages
if the stream is supposed to be mmap-ready (that guarantees that the
buffer size is aligned in page size).

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
Link: https://lore.kernel.org/r/20201218145625.2045-3-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/pcm_native.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 7c12b0deb4eb5..db62dbe7eaa8a 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -753,8 +753,13 @@ static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
 		runtime->boundary *= 2;
 
 	/* clear the buffer for avoiding possible kernel info leaks */
-	if (runtime->dma_area && !substream->ops->copy_user)
-		memset(runtime->dma_area, 0, runtime->dma_bytes);
+	if (runtime->dma_area && !substream->ops->copy_user) {
+		size_t size = runtime->dma_bytes;
+
+		if (runtime->info & SNDRV_PCM_INFO_MMAP)
+			size = PAGE_ALIGN(size);
+		memset(runtime->dma_area, 0, size);
+	}
 
 	snd_pcm_timer_resolution_change(substream);
 	snd_pcm_set_state(substream, SNDRV_PCM_STATE_SETUP);
-- 
2.27.0

