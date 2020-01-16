Return-Path: <SRS0=iD9L=3F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56352C33CB1
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jan 2020 04:45:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCF8B20748
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jan 2020 04:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sCIMgMOD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF8B20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 258E117B3;
	Thu, 16 Jan 2020 05:44:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 258E117B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579149918;
	bh=V8C9tl6YvUGngTSYNfNHRQAjlq+5TxxPXl8xHN55T7U=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sCIMgMODqYrLarNjTSDWBQhaZAwMd/gXC33Y/8AyM2oWM83BdmPefI+HDdP6fK991
	 8eK+szHIlzqiDNVo5lYHjdQIJOFfB5OMJ1EhQ6/aySfsXnwNjWO0aKDXWAlmCY5D7k
	 lUp5Zf6jcvmFk0nwWX1PzTnFCIZlc4DAnUy4kzC4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9421DF8014D;
	Thu, 16 Jan 2020 05:44:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 87FB0F8014E; Thu, 16 Jan 2020 05:44:25 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 51CF2F80086
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2020 05:44:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 51CF2F80086
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Jan 2020 20:44:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,324,1574150400"; d="scan'208";a="213946640"
Received: from unknown (HELO keyon-X299.sh.intel.com) ([10.239.159.75])
 by orsmga007.jf.intel.com with ESMTP; 15 Jan 2020 20:44:16 -0800
From: Keyon Jie <yang.jie@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Thu, 16 Jan 2020 12:53:18 +0800
Message-Id: <20200116045318.5498-1-yang.jie@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: tiwai@suse.de, Keyon Jie <yang.jie@linux.intel.com>
Subject: [alsa-devel] [PATCH] ALSA: pcm: fix buffer_bytes max constrained by
	preallocated bytes issue
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

With today's code, we preallocate DMA buffer for substreams at pcm_new()
stage, and the substream->buffer_bytes_max and substream->dma_max will
save as the actually preallocated buffer size and maximum size that the
dma buffer can be expanded by at hw_params() state, correspondingly.

At pcm_open() stage, the maximum constraint of HW_PARAM_BUFFER_BYTES is
set to substream->buffer_bytes_max and returned to user space as the max
interval of the HW_PARAM_BUFFER_BYTES, this will lead to issue that user
can't choose any buffer-bytes larger than the preallocated buffer size,
and the buffer reallocation will never happen actually.

Here change to use substream->dma_max as the maximum constraint of the
HW_PARAM_BUFFER_BYTES and fix the issue mentioned above.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
---
 sound/core/pcm_native.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index c375c41496f8..326e921006e7 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2301,7 +2301,7 @@ static int snd_pcm_hw_rule_buffer_bytes_max(struct snd_pcm_hw_params *params,
 	struct snd_interval t;
 	struct snd_pcm_substream *substream = rule->private;
 	t.min = 0;
-	t.max = substream->buffer_bytes_max;
+	t.max = substream->dma_max;
 	t.openmin = 0;
 	t.openmax = 0;
 	t.integer = 1;
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
