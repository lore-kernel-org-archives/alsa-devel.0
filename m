Return-Path: <SRS0=1nsM=42=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4BCC10F27
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Mar 2020 08:22:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F54A20848
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Mar 2020 08:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bNx0h/Aw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F54A20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D69601616;
	Mon,  9 Mar 2020 09:21:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D69601616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583742167;
	bh=OPpZBA1ezt3shfu+hdcCy5Ij6+x8NJ629vacfhVy2bY=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bNx0h/Aw1VDJGWsiDEokynxmp6195C7EXh+ijpqkzjFqUdWwPjm3zK3TrjOoKN1Kn
	 6m7OGKmU0exvVoUevh2JBDA4Yz57ZxNPd38krLS6XPkjfuS9fPDgtsSoR5N3lToIMy
	 MusmvTn03fAm7y9Rp2SZsIwaK/+yXJlDROw9HbOY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4C195F801A3;
	Mon,  9 Mar 2020 09:21:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 13CF8F801EB; Mon,  9 Mar 2020 09:21:54 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6E419F800B5
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2020 09:21:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E419F800B5
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id CF359B245
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2020 08:21:49 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: pcm: oss: Avoid plugin buffer overflow
Date: Mon,  9 Mar 2020 09:21:48 +0100
Message-Id: <20200309082148.19855-1-tiwai@suse.de>
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

Each OSS PCM plugins allocate its internal buffer per pre-calculation
of the max buffer size through the chain of plugins (calling
src_frames and dst_frames callbacks).  This works for most plugins,
but the rate plugin might behave incorrectly.  The calculation in the
rate plugin involves with the fractional position, i.e. it may vary
depending on the input position.  Since the buffer size
pre-calculation is always done with the offset zero, it may return a
shorter size than it might be; this may result in the out-of-bound
access as spotted by fuzzer.

This patch addresses those possible buffer overflow accesses by simply
setting the upper limit per the given buffer size for each plugin
before src_frames() and after dst_frames() calls.

Reported-by: syzbot+e1fe9f44fb8ecf4fb5dd@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/000000000000b25ea005a02bcf21@google.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/oss/pcm_plugin.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/core/oss/pcm_plugin.c b/sound/core/oss/pcm_plugin.c
index 240e4702c098..c9401832967c 100644
--- a/sound/core/oss/pcm_plugin.c
+++ b/sound/core/oss/pcm_plugin.c
@@ -209,6 +209,8 @@ snd_pcm_sframes_t snd_pcm_plug_client_size(struct snd_pcm_substream *plug, snd_p
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		plugin = snd_pcm_plug_last(plug);
 		while (plugin && drv_frames > 0) {
+			if (drv_frames > plugin->buf_frames)
+				drv_frames = plugin->buf_frames;
 			plugin_prev = plugin->prev;
 			if (plugin->src_frames)
 				drv_frames = plugin->src_frames(plugin, drv_frames);
@@ -220,6 +222,8 @@ snd_pcm_sframes_t snd_pcm_plug_client_size(struct snd_pcm_substream *plug, snd_p
 			plugin_next = plugin->next;
 			if (plugin->dst_frames)
 				drv_frames = plugin->dst_frames(plugin, drv_frames);
+			if (drv_frames > plugin->buf_frames)
+				drv_frames = plugin->buf_frames;
 			plugin = plugin_next;
 		}
 	} else
@@ -248,11 +252,15 @@ snd_pcm_sframes_t snd_pcm_plug_slave_size(struct snd_pcm_substream *plug, snd_pc
 				if (frames < 0)
 					return frames;
 			}
+			if (frames > plugin->buf_frames)
+				frames = plugin->buf_frames;
 			plugin = plugin_next;
 		}
 	} else if (stream == SNDRV_PCM_STREAM_CAPTURE) {
 		plugin = snd_pcm_plug_last(plug);
 		while (plugin) {
+			if (frames > plugin->buf_frames)
+				frames = plugin->buf_frames;
 			plugin_prev = plugin->prev;
 			if (plugin->src_frames) {
 				frames = plugin->src_frames(plugin, frames);
-- 
2.16.4

