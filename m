Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102F7C2D0BF
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 07:16:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 858F020838
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 07:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nwpo24F1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858F020838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 01540170C;
	Tue, 10 Dec 2019 08:08:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 01540170C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575961775;
	bh=Y5LRhsgUjVmN2oXQCjAKC3xklWR3dGc7ODzZaspbksM=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nwpo24F1VaLkxS1Cz5ynit/e1zrsVhWQHmyikha3JBXeF0nhCrJY2kK42FRreowKY
	 nmpMD7Qv6T6OxlmkdNxf2JWULjQMIBid4tL+gT3LlhO3zUqWmXx+0MXpn6g8LDY/Dt
	 xB4KcYR/kzFNrmXCvbJnhDnDiqBIC5hukGLn+M+Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 79A19F804DB;
	Tue, 10 Dec 2019 07:37:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0AA83F80362; Tue, 10 Dec 2019 07:36:54 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 622E1F802A0
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 07:35:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 622E1F802A0
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 00241B320
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 06:35:01 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Tue, 10 Dec 2019 07:34:54 +0100
Message-Id: <20191210063454.31603-56-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210063454.31603-1-tiwai@suse.de>
References: <20191210063454.31603-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 55/55] ALSA: usb-audio: Support PCM sync_stop
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

USB-audio driver had some implementation of its own sync-stop
mechanism.  This patch moved a part of it to the common PCM sync_stop
ops.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/pcm.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 33c1e971e61e..8a52996041e9 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -260,18 +260,31 @@ static int start_endpoints(struct snd_usb_substream *subs)
 	return 0;
 }
 
-static void stop_endpoints(struct snd_usb_substream *subs, bool wait)
+static void sync_pending_stops(struct snd_usb_substream *subs)
+{
+	snd_usb_endpoint_sync_pending_stop(subs->sync_endpoint);
+	snd_usb_endpoint_sync_pending_stop(subs->data_endpoint);
+}
+
+static void stop_endpoints(struct snd_usb_substream *subs)
 {
 	if (test_and_clear_bit(SUBSTREAM_FLAG_SYNC_EP_STARTED, &subs->flags))
 		snd_usb_endpoint_stop(subs->sync_endpoint);
 
 	if (test_and_clear_bit(SUBSTREAM_FLAG_DATA_EP_STARTED, &subs->flags))
 		snd_usb_endpoint_stop(subs->data_endpoint);
+}
 
-	if (wait) {
-		snd_usb_endpoint_sync_pending_stop(subs->sync_endpoint);
-		snd_usb_endpoint_sync_pending_stop(subs->data_endpoint);
+/* PCM sync_stop callback */
+static int snd_usb_pcm_sync_stop(struct snd_pcm_substream *substream)
+{
+	struct snd_usb_substream *subs = substream->runtime->private_data;
+
+	if (!snd_usb_lock_shutdown(subs->stream->chip)) {
+		sync_pending_stops(subs);
+		snd_usb_unlock_shutdown(subs->stream->chip);
 	}
+	return 0;
 }
 
 static int search_roland_implicit_fb(struct usb_device *dev, int ifnum,
@@ -697,7 +710,8 @@ static int configure_endpoint(struct snd_usb_substream *subs)
 	int ret;
 
 	/* format changed */
-	stop_endpoints(subs, true);
+	stop_endpoints(subs);
+	sync_pending_stops(subs);
 	ret = snd_usb_endpoint_set_params(subs->data_endpoint,
 					  subs->pcm_format,
 					  subs->channels,
@@ -842,7 +856,8 @@ static int snd_usb_hw_free(struct snd_pcm_substream *substream)
 	subs->cur_rate = 0;
 	subs->period_bytes = 0;
 	if (!snd_usb_lock_shutdown(subs->stream->chip)) {
-		stop_endpoints(subs, true);
+		stop_endpoints(subs);
+		sync_pending_stops(subs);
 		snd_usb_endpoint_deactivate(subs->sync_endpoint);
 		snd_usb_endpoint_deactivate(subs->data_endpoint);
 		snd_usb_unlock_shutdown(subs->stream->chip);
@@ -877,9 +892,6 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
 		goto unlock;
 	}
 
-	snd_usb_endpoint_sync_pending_stop(subs->sync_endpoint);
-	snd_usb_endpoint_sync_pending_stop(subs->data_endpoint);
-
 	ret = snd_usb_pcm_change_state(subs, UAC3_PD_STATE_D0);
 	if (ret < 0)
 		goto unlock;
@@ -1337,7 +1349,6 @@ static int snd_usb_pcm_close(struct snd_pcm_substream *substream)
 	struct snd_usb_substream *subs = &as->substream[direction];
 	int ret;
 
-	stop_endpoints(subs, true);
 	snd_media_stop_pipeline(subs);
 
 	if (!as->chip->keep_iface &&
@@ -1714,7 +1725,7 @@ static int snd_usb_substream_playback_trigger(struct snd_pcm_substream *substrea
 		subs->running = 1;
 		return 0;
 	case SNDRV_PCM_TRIGGER_STOP:
-		stop_endpoints(subs, false);
+		stop_endpoints(subs);
 		subs->running = 0;
 		return 0;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
@@ -1744,7 +1755,7 @@ static int snd_usb_substream_capture_trigger(struct snd_pcm_substream *substream
 		subs->running = 1;
 		return 0;
 	case SNDRV_PCM_TRIGGER_STOP:
-		stop_endpoints(subs, false);
+		stop_endpoints(subs);
 		subs->running = 0;
 		return 0;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
@@ -1767,6 +1778,7 @@ static const struct snd_pcm_ops snd_usb_playback_ops = {
 	.hw_free =	snd_usb_hw_free,
 	.prepare =	snd_usb_pcm_prepare,
 	.trigger =	snd_usb_substream_playback_trigger,
+	.sync_stop =	snd_usb_pcm_sync_stop,
 	.pointer =	snd_usb_pcm_pointer,
 };
 
@@ -1777,6 +1789,7 @@ static const struct snd_pcm_ops snd_usb_capture_ops = {
 	.hw_free =	snd_usb_hw_free,
 	.prepare =	snd_usb_pcm_prepare,
 	.trigger =	snd_usb_substream_capture_trigger,
+	.sync_stop =	snd_usb_pcm_sync_stop,
 	.pointer =	snd_usb_pcm_pointer,
 };
 
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
