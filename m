Return-Path: <SRS0=jKKe=K3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B7EC4708F
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 16:27:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0615613C8
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 16:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0615613C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5D47B16E5;
	Tue,  1 Jun 2021 18:26:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5D47B16E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622564863;
	bh=wYBBhNXpK4iiSD2Ep5PdIX+jSL5eyKHUsOIup0Qr7rA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TDK0Qb6OeCyTNMTWzv2g0o17nSY6g3Z2wmUhqBCwR6uWYO+ktHn8vuY346emxtMGW
	 ffpVG460D31KZLrdNFBNMZKuwuSWg1VRVGiEc3SfZa2EufzjxFLJmlffDilzBjhO9N
	 /aiAAmvl2DAaUp0RQX82rJvDLuek1Wc6oACdipE8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DC77EF804CB;
	Tue,  1 Jun 2021 18:25:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 99ED5F8025B; Tue,  1 Jun 2021 18:25:14 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E89D0F802E7
 for <alsa-devel@alsa-project.org>; Tue,  1 Jun 2021 18:24:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E89D0F802E7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="QuUYmSRz"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="sOmtYLYk"
Received: from relay2.suse.de (unknown [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id BD5891FD58
 for <alsa-devel@alsa-project.org>; Tue,  1 Jun 2021 16:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1622564698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sZD8j97SubT2o6prBLaEK8syMxFxCRQzWFe7mWPOoNE=;
 b=QuUYmSRzbiIKx8g+TTnxfCQ4GQMYaMuVAWwpVWruFmEGEV1BX9y+i/5Ty4iT/VRCOdmUcJ
 ed73x7penNedXEOfc10BwAt3Gu8WAY8fE2OKPYYcTUW5rTQC3NFPY8sQxEkQpz4aqHQGSc
 fjK2rNI/BGfpwe3U13emqTuADGK25N4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1622564698;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sZD8j97SubT2o6prBLaEK8syMxFxCRQzWFe7mWPOoNE=;
 b=sOmtYLYkY4BO/e4JtlsJi91RQiwQyZdKbP0afkrA0PcEJwdqpaV9O5vDgY3y44JRUizQp/
 +9JWk/7ivLC9zdCg==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id AED57A3B88;
 Tue,  1 Jun 2021 16:24:58 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 4/5] ALSA: usb-audio: Factor out DSD bitrev copy function
Date: Tue,  1 Jun 2021 18:24:56 +0200
Message-Id: <20210601162457.4877-5-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210601162457.4877-1-tiwai@suse.de>
References: <20210601162457.4877-1-tiwai@suse.de>
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

Just minor code refactoring.  Like DOP DSD code, it can be better in a
separate function for code readability.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/pcm.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 8ee45f2e8dce..e26d37365f02 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1250,6 +1250,24 @@ static inline void fill_playback_urb_dsd_dop(struct snd_usb_substream *subs,
 	urb_ctx_queue_advance(subs, urb, queued);
 }
 
+/* copy bit-reversed bytes onto transfer buffer */
+static void fill_playback_urb_dsd_bitrev(struct snd_usb_substream *subs,
+					 struct urb *urb, unsigned int bytes)
+{
+	struct snd_pcm_runtime *runtime = subs->pcm_substream->runtime;
+	const u8 *src = runtime->dma_area;
+	u8 *buf = urb->transfer_buffer;
+	int i, ofs = subs->hwptr_done;
+
+	for (i = 0; i < bytes; i++) {
+		*buf++ = bitrev8(src[ofs]);
+		if (++ofs >= subs->buffer_bytes)
+			ofs = 0;
+	}
+
+	urb_ctx_queue_advance(subs, urb, bytes);
+}
+
 static void copy_to_urb(struct snd_usb_substream *subs, struct urb *urb,
 			int offset, int stride, unsigned int bytes)
 {
@@ -1360,15 +1378,7 @@ static void prepare_playback_urb(struct snd_usb_substream *subs,
 		fill_playback_urb_dsd_dop(subs, urb, bytes);
 	} else if (unlikely(ep->cur_format == SNDRV_PCM_FORMAT_DSD_U8 &&
 			   subs->cur_audiofmt->dsd_bitrev)) {
-		/* bit-reverse the bytes */
-		u8 *buf = urb->transfer_buffer;
-		for (i = 0; i < bytes; i++) {
-			int idx = (subs->hwptr_done + i) % subs->buffer_bytes;
-
-			buf[i] = bitrev8(runtime->dma_area[idx]);
-		}
-
-		urb_ctx_queue_advance(subs, urb, bytes);
+		fill_playback_urb_dsd_bitrev(subs, urb, bytes);
 	} else {
 		/* usual PCM */
 		if (!subs->tx_length_quirk)
-- 
2.26.2

