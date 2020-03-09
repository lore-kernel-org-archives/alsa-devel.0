Return-Path: <SRS0=1nsM=42=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628DDC10F25
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Mar 2020 18:59:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E74D220866
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Mar 2020 18:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="L4+crhx0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74D220866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2788B16AE;
	Mon,  9 Mar 2020 19:59:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2788B16AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583780393;
	bh=hXddkkQ0OQ5pcIROy9mM3wANjqPWK9UZ/seaqNd7Bn0=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=L4+crhx0P9jxTSWLMqEkQw66ZCtAttExl9sgiWLNoxYm8MoeSwXdxbXk14sElQ/an
	 ZnuQeNjKgCtgjKlyj1yg8/G7ripud68irdGh/9RTI12ottOyFhG381vXIjO5I0I7rD
	 kqoV3pNkOuC4LoUvo6ox1wMV90bqYlkX4NqIi7+s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 194B1F801A3;
	Mon,  9 Mar 2020 19:59:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1EE82F800B5; Mon,  9 Mar 2020 19:59:00 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6CF35F800B5
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2020 19:58:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6CF35F800B5
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 86B85AE79
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2020 18:58:56 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2] ALSA: pcm: oss: Simplify plugin frame size calculations
Date: Mon,  9 Mar 2020 19:58:55 +0100
Message-Id: <20200309185855.15693-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
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

Both snd_pcm_plug_client_size() and snd_pcm_plug_slave_size() do the
almost same calculations of calling src_frames() and dst_frames() in
the chain, but just to the different directions with each other.

This patch simplifies those functions.  Now they return -EINVAL for
the invalid direction, but practically seen, there is no functional
changes at all.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/oss/pcm_plugin.c | 120 +++++++++++++++++++++-----------------------
 1 file changed, 56 insertions(+), 64 deletions(-)

diff --git a/sound/core/oss/pcm_plugin.c b/sound/core/oss/pcm_plugin.c
index c9401832967c..58642fecd15c 100644
--- a/sound/core/oss/pcm_plugin.c
+++ b/sound/core/oss/pcm_plugin.c
@@ -196,82 +196,74 @@ int snd_pcm_plugin_free(struct snd_pcm_plugin *plugin)
 	return 0;
 }
 
-snd_pcm_sframes_t snd_pcm_plug_client_size(struct snd_pcm_substream *plug, snd_pcm_uframes_t drv_frames)
+static snd_pcm_sframes_t calc_dst_frames(struct snd_pcm_substream *plug,
+					 snd_pcm_sframes_t frames)
 {
-	struct snd_pcm_plugin *plugin, *plugin_prev, *plugin_next;
-	int stream;
+	struct snd_pcm_plugin *plugin, *plugin_next;
 
-	if (snd_BUG_ON(!plug))
-		return -ENXIO;
-	if (drv_frames == 0)
-		return 0;
-	stream = snd_pcm_plug_stream(plug);
-	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		plugin = snd_pcm_plug_last(plug);
-		while (plugin && drv_frames > 0) {
-			if (drv_frames > plugin->buf_frames)
-				drv_frames = plugin->buf_frames;
-			plugin_prev = plugin->prev;
-			if (plugin->src_frames)
-				drv_frames = plugin->src_frames(plugin, drv_frames);
-			plugin = plugin_prev;
+	plugin = snd_pcm_plug_first(plug);
+	while (plugin && frames > 0) {
+		plugin_next = plugin->next;
+		if (plugin->dst_frames) {
+			frames = plugin->dst_frames(plugin, frames);
+			if (frames < 0)
+				return frames;
 		}
-	} else if (stream == SNDRV_PCM_STREAM_CAPTURE) {
-		plugin = snd_pcm_plug_first(plug);
-		while (plugin && drv_frames > 0) {
-			plugin_next = plugin->next;
-			if (plugin->dst_frames)
-				drv_frames = plugin->dst_frames(plugin, drv_frames);
-			if (drv_frames > plugin->buf_frames)
-				drv_frames = plugin->buf_frames;
-			plugin = plugin_next;
+		if (frames > plugin->buf_frames)
+			frames = plugin->buf_frames;
+		plugin = plugin_next;
+	}
+	return frames;
+}
+
+static snd_pcm_sframes_t calc_src_frames(struct snd_pcm_substream *plug,
+					 snd_pcm_sframes_t frames)
+{
+	struct snd_pcm_plugin *plugin, *plugin_prev;
+
+	plugin = snd_pcm_plug_last(plug);
+	while (plugin && frames > 0) {
+		if (frames > plugin->buf_frames)
+			frames = plugin->buf_frames;
+		plugin_prev = plugin->prev;
+		if (plugin->src_frames) {
+			frames = plugin->src_frames(plugin, frames);
+			if (frames < 0)
+				return frames;
 		}
-	} else
+		plugin = plugin_prev;
+	}
+	return frames;
+}
+
+snd_pcm_sframes_t snd_pcm_plug_client_size(struct snd_pcm_substream *plug, snd_pcm_uframes_t drv_frames)
+{
+	if (snd_BUG_ON(!plug))
+		return -ENXIO;
+	switch (snd_pcm_plug_stream(plug)) {
+	case SNDRV_PCM_STREAM_PLAYBACK:
+		return calc_src_frames(plug, drv_frames);
+	case SNDRV_PCM_STREAM_CAPTURE:
+		return calc_dst_frames(plug, drv_frames);
+	default:
 		snd_BUG();
-	return drv_frames;
+		return -EINVAL;
+	}
 }
 
 snd_pcm_sframes_t snd_pcm_plug_slave_size(struct snd_pcm_substream *plug, snd_pcm_uframes_t clt_frames)
 {
-	struct snd_pcm_plugin *plugin, *plugin_prev, *plugin_next;
-	snd_pcm_sframes_t frames;
-	int stream;
-	
 	if (snd_BUG_ON(!plug))
 		return -ENXIO;
-	if (clt_frames == 0)
-		return 0;
-	frames = clt_frames;
-	stream = snd_pcm_plug_stream(plug);
-	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		plugin = snd_pcm_plug_first(plug);
-		while (plugin && frames > 0) {
-			plugin_next = plugin->next;
-			if (plugin->dst_frames) {
-				frames = plugin->dst_frames(plugin, frames);
-				if (frames < 0)
-					return frames;
-			}
-			if (frames > plugin->buf_frames)
-				frames = plugin->buf_frames;
-			plugin = plugin_next;
-		}
-	} else if (stream == SNDRV_PCM_STREAM_CAPTURE) {
-		plugin = snd_pcm_plug_last(plug);
-		while (plugin) {
-			if (frames > plugin->buf_frames)
-				frames = plugin->buf_frames;
-			plugin_prev = plugin->prev;
-			if (plugin->src_frames) {
-				frames = plugin->src_frames(plugin, frames);
-				if (frames < 0)
-					return frames;
-			}
-			plugin = plugin_prev;
-		}
-	} else
+	switch (snd_pcm_plug_stream(plug)) {
+	case SNDRV_PCM_STREAM_PLAYBACK:
+		return calc_dst_frames(plug, clt_frames);
+	case SNDRV_PCM_STREAM_CAPTURE:
+		return calc_src_frames(plug, clt_frames);
+	default:
 		snd_BUG();
-	return frames;
+		return -EINVAL;
+	}
 }
 
 static int snd_pcm_plug_formats(const struct snd_mask *mask,
-- 
2.16.4

