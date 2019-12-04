Return-Path: <SRS0=elh7=Z2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A084AC43603
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Dec 2019 14:49:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A02E0207DD
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Dec 2019 14:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nMPd2qGg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02E0207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F6751663;
	Wed,  4 Dec 2019 15:48:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F6751663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575470964;
	bh=vX0z4sWzSFWEsOX+LD+GnoP1mFB8S/F0dvbSN1L4AhU=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nMPd2qGgL+gozyRjlq89qu7ssSyGhATFM4GscKElwdoQu/9IwT+umYJEVbfiLyEMy
	 1lQM4/peGL4q2SUULxiMhydm0wnFUDn+MWoG/L0T3qvdLkXLrOjr1hcxgviiG8KLT4
	 8ealjqF2C2GcgvHZmhDiMqeGyccO6Or4d4pbUL8k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DFA68F8010F;
	Wed,  4 Dec 2019 15:48:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EBC00F801EC; Wed,  4 Dec 2019 15:48:31 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4C17CF800F0
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2019 15:48:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4C17CF800F0
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id DEE66AC28
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2019 14:48:25 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Wed,  4 Dec 2019 15:48:24 +0100
Message-Id: <20191204144824.17801-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Subject: [alsa-devel] [PATCH] ALSA: pcm: oss: Avoid potential buffer
	overflows
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

syzkaller reported an invalid access in PCM OSS read, and this seems
to be an overflow of the internal buffer allocated for a plugin.
Since the rate plugin adjusts its transfer size dynamically, the
calculation for the chained plugin might be bigger than the given
buffer size in some extreme cases, which lead to such an buffer
overflow as caught by KASAN.

Fix it by limiting the max transfer size properly by checking against
the destination size in each plugin transfer callback.

Reported-by: syzbot+f153bde47a62e0b05f83@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/oss/linear.c | 2 ++
 sound/core/oss/mulaw.c  | 2 ++
 sound/core/oss/route.c  | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/sound/core/oss/linear.c b/sound/core/oss/linear.c
index 2045697f449d..797d838a2f9e 100644
--- a/sound/core/oss/linear.c
+++ b/sound/core/oss/linear.c
@@ -107,6 +107,8 @@ static snd_pcm_sframes_t linear_transfer(struct snd_pcm_plugin *plugin,
 		}
 	}
 #endif
+	if (frames > dst_channels[0].frames)
+		frames = dst_channels[0].frames;
 	convert(plugin, src_channels, dst_channels, frames);
 	return frames;
 }
diff --git a/sound/core/oss/mulaw.c b/sound/core/oss/mulaw.c
index 7915564bd394..3788906421a7 100644
--- a/sound/core/oss/mulaw.c
+++ b/sound/core/oss/mulaw.c
@@ -269,6 +269,8 @@ static snd_pcm_sframes_t mulaw_transfer(struct snd_pcm_plugin *plugin,
 		}
 	}
 #endif
+	if (frames > dst_channels[0].frames)
+		frames = dst_channels[0].frames;
 	data = (struct mulaw_priv *)plugin->extra_data;
 	data->func(plugin, src_channels, dst_channels, frames);
 	return frames;
diff --git a/sound/core/oss/route.c b/sound/core/oss/route.c
index c8171f5783c8..72dea04197ef 100644
--- a/sound/core/oss/route.c
+++ b/sound/core/oss/route.c
@@ -57,6 +57,8 @@ static snd_pcm_sframes_t route_transfer(struct snd_pcm_plugin *plugin,
 		return -ENXIO;
 	if (frames == 0)
 		return 0;
+	if (frames > dst_channels[0].frames)
+		frames = dst_channels[0].frames;
 
 	nsrcs = plugin->src_format.channels;
 	ndsts = plugin->dst_format.channels;
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
