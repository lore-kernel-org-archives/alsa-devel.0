Return-Path: <SRS0=j21J=6I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E28FC54FCB
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 19:34:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 091DB21569
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 19:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZYAsr9jg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 091DB21569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5EB2916A9;
	Fri, 24 Apr 2020 21:34:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5EB2916A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587756891;
	bh=NhUTk+IlpzRpv4hmDBZ9ZsVTavc5iPAhAw/lZeYoXE8=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZYAsr9jgcbSrYtENhywDH98qmRUluafQLPBeY4hKXJSKFp14ACp1u+v/8Yu+HxbAB
	 OXMgmo9nCH5V1zm6OkJwtAPoJYPvCD4ax3jwfBuo/l94JXR7XupWjPuH7cl7PtFWiV
	 ClmfWOwxDbid98SobwN0udK+KDCXW5nHz3+hyAgA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E154FF800BE;
	Fri, 24 Apr 2020 21:34:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9AAD2F80142; Fri, 24 Apr 2020 21:33:58 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E0F40F800BE
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2020 21:33:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E0F40F800BE
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 3CA0DAD88
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2020 19:33:51 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: pcm: oss: Place the plugin buffer overflow checks
 correctly
Date: Fri, 24 Apr 2020 21:33:50 +0200
Message-Id: <20200424193350.19678-1-tiwai@suse.de>
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

The checks of the plugin buffer overflow in the previous fix by commit
  f2ecf903ef06 ("ALSA: pcm: oss: Avoid plugin buffer overflow")
are put in the wrong places mistakenly, which leads to the expected
(repeated) sound when the rate plugin is involved.  Fix in the right
places.

Also, at those right places, the zero check is needed for the
termination node, so added there as well, and let's get it done,
finally.

Fixes: f2ecf903ef06 ("ALSA: pcm: oss: Avoid plugin buffer overflow")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/oss/pcm_plugin.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/sound/core/oss/pcm_plugin.c b/sound/core/oss/pcm_plugin.c
index 3ecc070738e8..c1315ce98b54 100644
--- a/sound/core/oss/pcm_plugin.c
+++ b/sound/core/oss/pcm_plugin.c
@@ -211,21 +211,23 @@ static snd_pcm_sframes_t plug_client_size(struct snd_pcm_substream *plug,
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		plugin = snd_pcm_plug_last(plug);
 		while (plugin && drv_frames > 0) {
-			if (check_size && drv_frames > plugin->buf_frames)
-				drv_frames = plugin->buf_frames;
 			plugin_prev = plugin->prev;
 			if (plugin->src_frames)
 				drv_frames = plugin->src_frames(plugin, drv_frames);
+			if (check_size && plugin->buf_frames &&
+			    drv_frames > plugin->buf_frames)
+				drv_frames = plugin->buf_frames;
 			plugin = plugin_prev;
 		}
 	} else if (stream == SNDRV_PCM_STREAM_CAPTURE) {
 		plugin = snd_pcm_plug_first(plug);
 		while (plugin && drv_frames > 0) {
 			plugin_next = plugin->next;
+			if (check_size && plugin->buf_frames &&
+			    drv_frames > plugin->buf_frames)
+				drv_frames = plugin->buf_frames;
 			if (plugin->dst_frames)
 				drv_frames = plugin->dst_frames(plugin, drv_frames);
-			if (check_size && drv_frames > plugin->buf_frames)
-				drv_frames = plugin->buf_frames;
 			plugin = plugin_next;
 		}
 	} else
@@ -251,26 +253,28 @@ static snd_pcm_sframes_t plug_slave_size(struct snd_pcm_substream *plug,
 		plugin = snd_pcm_plug_first(plug);
 		while (plugin && frames > 0) {
 			plugin_next = plugin->next;
+			if (check_size && plugin->buf_frames &&
+			    frames > plugin->buf_frames)
+				frames = plugin->buf_frames;
 			if (plugin->dst_frames) {
 				frames = plugin->dst_frames(plugin, frames);
 				if (frames < 0)
 					return frames;
 			}
-			if (check_size && frames > plugin->buf_frames)
-				frames = plugin->buf_frames;
 			plugin = plugin_next;
 		}
 	} else if (stream == SNDRV_PCM_STREAM_CAPTURE) {
 		plugin = snd_pcm_plug_last(plug);
 		while (plugin) {
-			if (check_size && frames > plugin->buf_frames)
-				frames = plugin->buf_frames;
 			plugin_prev = plugin->prev;
 			if (plugin->src_frames) {
 				frames = plugin->src_frames(plugin, frames);
 				if (frames < 0)
 					return frames;
 			}
+			if (check_size && plugin->buf_frames &&
+			    frames > plugin->buf_frames)
+				frames = plugin->buf_frames;
 			plugin = plugin_prev;
 		}
 	} else
-- 
2.16.4

