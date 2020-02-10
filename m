Return-Path: <SRS0=5/4N=36=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE8EC352A3
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 14:12:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83CE920714
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 14:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cONg74Ap";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="x8MujdPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83CE920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9E7F21677;
	Mon, 10 Feb 2020 15:04:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9E7F21677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581343523;
	bh=7wfuiae86jtDRDUhFUCW2rAZ8YEjsT+W5BNu68AzrQw=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cONg74Ap/ieYXwDHPTFBZ4FDlfebq0RKnqs62Kmo8rrNpNepuM0Y2eX+VEX1LT/WK
	 fqMMJyqkZRRG+J602HqcGzCPGeTgyoebo1/7xBrPziiTgCml5hIE8Vp9HpT+zNFgTj
	 7PcXgP0zWV9qLRlCEP1M18ZM2q6qnS3Yb48r+X08=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 38535F80158;
	Mon, 10 Feb 2020 15:04:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3577AF8019B; Mon, 10 Feb 2020 15:04:31 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 66F43F800E7
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2020 15:04:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 66F43F800E7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="x8MujdPN"
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01AE4O7g041894;
 Mon, 10 Feb 2020 08:04:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1581343464;
 bh=M7oV+dgNDePW9F+75A8vypX+j/v5tDexHBLLV1ccDfU=;
 h=From:To:CC:Subject:Date;
 b=x8MujdPN9PMGtYJardUmXjE4MOYPRuJh3p6eY1P17yHBEOMeOlw6pQeWroHLai4ug
 A7QzYoCcsIlnPtsG/9+M5MOzoR0oLV+LqVtayhQpyFGg0/bMKX2vMvWrJCWG4IwFQc
 Jm5wAMc/isV2eOzn737sG3Lf3p4b1niknRU5s0wE=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01AE4Ols086430
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Feb 2020 08:04:24 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 10
 Feb 2020 08:04:23 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 10 Feb 2020 08:04:23 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01AE4Klm024323;
 Mon, 10 Feb 2020 08:04:21 -0600
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
 <perex@perex.cz>
Date: Mon, 10 Feb 2020 16:04:23 +0200
Message-ID: <20200210140423.10232-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, vkoul@kernel.org,
 linux-kernel@vger.kernel.org
Subject: [alsa-devel] [PATCH] ASoC: dmaengine_pcm: Consider DMA cache caused
	delay in pointer callback
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

Some DMA engines can have big FIFOs which adds to the latency.
The DMAengine framework can report the FIFO utilization in bytes. Use this
information for the delay reporting.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

5.6-rc1 now have support for reporting the DMA cached data.
With this patch we can include it to the delay calculation.
The first DMA driver which reports this is the TI K3 UDMA driver.

Regards,
Peter

 sound/core/pcm_dmaengine.c | 6 ++++++
 sound/soc/soc-pcm.c        | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index 5749a8a49784..4f1395fd0160 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -247,9 +247,15 @@ snd_pcm_uframes_t snd_dmaengine_pcm_pointer(struct snd_pcm_substream *substream)
 
 	status = dmaengine_tx_status(prtd->dma_chan, prtd->cookie, &state);
 	if (status == DMA_IN_PROGRESS || status == DMA_PAUSED) {
+		struct snd_pcm_runtime *runtime = substream->runtime;
+		int sample_bits = snd_pcm_format_physical_width(runtime->format);
+
 		buf_size = snd_pcm_lib_buffer_bytes(substream);
 		if (state.residue > 0 && state.residue <= buf_size)
 			pos = buf_size - state.residue;
+
+		sample_bits *= runtime->channels;
+		runtime->delay = state.in_flight_bytes / (sample_bits / 8);
 	}
 
 	return bytes_to_frames(substream->runtime, pos);
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index ff1b7c7078e5..58ef508d70a3 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1151,7 +1151,7 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 	}
 	delay += codec_delay;
 
-	runtime->delay = delay;
+	runtime->delay += delay;
 
 	return offset;
 }
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
