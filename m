Return-Path: <SRS0=wrte=AK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA50C433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2020 03:00:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC27206F2
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2020 03:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DUM2jKCR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tsoy.me header.i=@tsoy.me header.b="Uc8mcBSt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC27206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tsoy.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0AC731654;
	Mon, 29 Jun 2020 04:59:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0AC731654
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593399641;
	bh=MxHRlK1OfzRCHUNsTXLjfSYz1JTNNESMrUGlaxh/tBs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DUM2jKCRdareF++q+dNkn2z7fNHqeIaoz2agUDt0n0NjWXKcUa0hitdFkBilP5kot
	 osRl0q7H1vyjsiIlrp9VREfWGklSG2f85DjJTKBCgMyCSOybK6bhyWjRdC+vBmqoe9
	 q0Njw7wydABCNG69O4xhsZmS2f1ztMs7EEfqpuqM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 834F7F800BA;
	Mon, 29 Jun 2020 04:59:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ACDF9F80217; Mon, 29 Jun 2020 04:59:48 +0200 (CEST)
Received: from puleglot.ru (puleglot.ru [IPv6:2a01:4f8:1c0c:58e8::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A2007F801F8
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2020 04:59:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A2007F801F8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=tsoy.me header.i=@tsoy.me
 header.b="Uc8mcBSt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me;
 s=mymail; h=Sender:Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lM8J2mfTKi7US1ytGYTIVFlcxo6kmMRpQh1QH2TdnvA=; b=Uc8mcBStMgySh/NnX7/t1NAVdf
 xbRqest1s760W5rTFJmFIP+xT9ybDwDAyPBVS0fOzuu72e2dJMV3Al+1HCrJwwMNe4kukms8v2+Jj
 YcEXLjgLWh++5E2NW1tbdA4HEVXCujm0IA1HqR+/VgPDZfSnFf6gTjbM87c21C9ZUR68=;
Received: from [2a00:1370:8125:614e:c510:d933:d0ef:dfce]
 (helo=home.puleglot.ru)
 by puleglot.ru with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.93.0.4) (envelope-from <puleglot@puleglot.ru>)
 id 1jpk1A-000nGE-Fk; Mon, 29 Jun 2020 05:59:36 +0300
From: Alexander Tsoy <alexander@tsoy.me>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/2] ALSA: usb-audio: Replace s/frame/packet/ where appropriate
Date: Mon, 29 Jun 2020 05:59:34 +0300
Message-Id: <20200629025934.154288-2-alexander@tsoy.me>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200629025934.154288-1-alexander@tsoy.me>
References: <20200629025934.154288-1-alexander@tsoy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Peter Bui <pbui@kernel.bx612.space>
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

Replace several occurences of "frame" with a "packet" where appropriate.

Signed-off-by: Alexander Tsoy <alexander@tsoy.me>
---
 sound/usb/card.h     |  6 +++---
 sound/usb/endpoint.c | 19 +++++++++----------
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/sound/usb/card.h b/sound/usb/card.h
index d6219fba9699..de43267b9c8a 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -84,10 +84,10 @@ struct snd_usb_endpoint {
 	dma_addr_t sync_dma;		/* DMA address of syncbuf */
 
 	unsigned int pipe;		/* the data i/o pipe */
-	unsigned int framesize[2];	/* small/large frame sizes in samples */
-	unsigned int sample_rem;	/* remainder from division fs/fps */
+	unsigned int packsize[2];	/* small/large packet sizes in samples */
+	unsigned int sample_rem;	/* remainder from division fs/pps */
 	unsigned int sample_accum;	/* sample accumulator */
-	unsigned int fps;		/* frames per second */
+	unsigned int pps;		/* packets per second */
 	unsigned int freqn;		/* nominal sampling rate in fs/fps in Q16.16 format */
 	unsigned int freqm;		/* momentary sampling rate in fs/fps in Q16.16 format */
 	int	   freqshift;		/* how much to shift the feedback value to get Q16.16 */
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 11f23778f0a5..88760268fb55 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -159,11 +159,11 @@ int snd_usb_endpoint_next_packet_size(struct snd_usb_endpoint *ep)
 		return ep->maxframesize;
 
 	ep->sample_accum += ep->sample_rem;
-	if (ep->sample_accum >= ep->fps) {
-		ep->sample_accum -= ep->fps;
-		ret = ep->framesize[1];
+	if (ep->sample_accum >= ep->pps) {
+		ep->sample_accum -= ep->pps;
+		ret = ep->packsize[1];
 	} else {
-		ret = ep->framesize[0];
+		ret = ep->packsize[0];
 	}
 
 	return ret;
@@ -1088,16 +1088,15 @@ int snd_usb_endpoint_set_params(struct snd_usb_endpoint *ep,
 
 	if (snd_usb_get_speed(ep->chip->dev) == USB_SPEED_FULL) {
 		ep->freqn = get_usb_full_speed_rate(rate);
-		ep->fps = 1000;
+		ep->pps = 1000 >> ep->datainterval;
 	} else {
 		ep->freqn = get_usb_high_speed_rate(rate);
-		ep->fps = 8000;
+		ep->pps = 8000 >> ep->datainterval;
 	}
-	ep->fps >>= ep->datainterval;
 
-	ep->sample_rem = rate % ep->fps;
-	ep->framesize[0] = rate / ep->fps;
-	ep->framesize[1] = (rate + (ep->fps - 1)) / ep->fps;
+	ep->sample_rem = rate % ep->pps;
+	ep->packsize[0] = rate / ep->pps;
+	ep->packsize[1] = (rate + (ep->pps - 1)) / ep->pps;
 
 	/* calculate the frequency in 16.16 format */
 	ep->freqm = ep->freqn;
-- 
2.26.2

