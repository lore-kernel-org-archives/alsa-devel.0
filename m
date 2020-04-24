Return-Path: <SRS0=j21J=6I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61492C54FD0
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 19:39:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3F8421569
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 19:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GsAwv1KX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F8421569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 379ED1684;
	Fri, 24 Apr 2020 21:38:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 379ED1684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587757186;
	bh=hGaH/+NynImM8JBum3kHeBMCo0zs1MEERt7QLtuFsc8=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GsAwv1KXi0kwfAuhn4LPA6UV6ULyJjDY7PtAAJi5/bI6PmMlVWmmuNMOCXb2NzsON
	 OPTth/sP6z9uzdyc4D9yBo4P3RGahL0u7qhhCMCC38Wf4zGKBsjrHgoZ6ObQ1+mF6U
	 6mCoIZRzm4NXboKUiKvaX65tshKGl1UsM+3iV/6s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9FE54F80121;
	Fri, 24 Apr 2020 21:38:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1F9A2F80142; Fri, 24 Apr 2020 21:38:49 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7071BF800BE
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2020 21:38:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7071BF800BE
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id DBB5BADD7
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2020 19:38:44 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: pcm: oss: Place the plugin buffer overflow checks
 correctly (for 5.7)
Date: Fri, 24 Apr 2020 21:38:43 +0200
Message-Id: <20200424193843.20397-1-tiwai@suse.de>
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

[ This is again a forward-port of the fix applied for 5.6-base code
  (commit 4285de0725b1) to 5.7-base, hence neither Fixes nor
  Cc-to-stable tags are included here -- tiwai ]

The checks of the plugin buffer overflow in the previous fix by commit
  f2ecf903ef06 ("ALSA: pcm: oss: Avoid plugin buffer overflow")
are put in the wrong places mistakenly, which leads to the expected
(repeated) sound when the rate plugin is involved.  Fix in the right
places.

Also, at those right places, the zero check is needed for the
termination node, so added there as well, and let's get it done,
finally.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/oss/pcm_plugin.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/core/oss/pcm_plugin.c b/sound/core/oss/pcm_plugin.c
index 59d62f05658f..1545f8fdb4db 100644
--- a/sound/core/oss/pcm_plugin.c
+++ b/sound/core/oss/pcm_plugin.c
@@ -205,13 +205,14 @@ static snd_pcm_sframes_t calc_dst_frames(struct snd_pcm_substream *plug,
 	plugin = snd_pcm_plug_first(plug);
 	while (plugin && frames > 0) {
 		plugin_next = plugin->next;
+		if (check_size && plugin->buf_frames &&
+		    frames > plugin->buf_frames)
+			frames = plugin->buf_frames;
 		if (plugin->dst_frames) {
 			frames = plugin->dst_frames(plugin, frames);
 			if (frames < 0)
 				return frames;
 		}
-		if (check_size && frames > plugin->buf_frames)
-			frames = plugin->buf_frames;
 		plugin = plugin_next;
 	}
 	return frames;
@@ -225,14 +226,15 @@ static snd_pcm_sframes_t calc_src_frames(struct snd_pcm_substream *plug,
 
 	plugin = snd_pcm_plug_last(plug);
 	while (plugin && frames > 0) {
-		if (check_size && frames > plugin->buf_frames)
-			frames = plugin->buf_frames;
 		plugin_prev = plugin->prev;
 		if (plugin->src_frames) {
 			frames = plugin->src_frames(plugin, frames);
 			if (frames < 0)
 				return frames;
 		}
+		if (check_size && plugin->buf_frames &&
+		    frames > plugin->buf_frames)
+			frames = plugin->buf_frames;
 		plugin = plugin_prev;
 	}
 	return frames;
-- 
2.16.4

