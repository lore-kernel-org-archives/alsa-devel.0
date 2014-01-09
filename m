From: Anton Khirnov <anton@khirnov.net>
Subject: [PATCH] a52: switch to AV_CODEC_ID identifiers
Date: Thu,  9 Jan 2014 21:14:17 +0100
Message-ID: <1389298457-18515-1-git-send-email-anton@khirnov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lain.khirnov.net (lain.khirnov.net [176.97.15.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A7AB261ADE
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 21:14:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by lain.khirnov.net (Postfix) with ESMTP id A70A8C215C
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 21:14:26 +0100 (CET)
Received: from lain.khirnov.net ([127.0.0.1])
 by localhost (mail.khirnov.net [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bQfs9gEi6i-Y for <alsa-devel@alsa-project.org>;
 Thu,  9 Jan 2014 21:14:25 +0100 (CET)
Received: from daenerys.khirnov.net (daenerys.khirnov.net
 [IPv6:2002:b061:f0a:2:3d16:23a9:c37:b166])
 by lain.khirnov.net (Postfix) with ESMTP id 70288C2031
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 21:14:25 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fixes build with latest libavcodec versions.
---
 a52/pcm_a52.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/a52/pcm_a52.c b/a52/pcm_a52.c
index 359608f..b467ec8 100644
--- a/a52/pcm_a52.c
+++ b/a52/pcm_a52.c
@@ -58,6 +58,9 @@
 #endif
 #endif
 
+#if LIBAVCODEC_VERSION_INT < AV_VERSION_INT(54, 25, 0)
+#define AV_CODEC_ID_AC3 CODEC_ID_AC3
+#endif
 
 struct a52_ctx {
 	snd_pcm_ioplug_t io;
@@ -916,7 +919,7 @@ SND_PCM_PLUGIN_DEFINE_FUNC(a52)
 	if (rec->codec == NULL)
 		rec->codec = avcodec_find_encoder_by_name("ac3");
 	if (rec->codec == NULL) 
-		rec->codec = avcodec_find_encoder(CODEC_ID_AC3);
+		rec->codec = avcodec_find_encoder(AV_CODEC_ID_AC3);
 	if (rec->codec == NULL) {
 		SNDERR("Cannot find codec engine");
 		err = -EINVAL;
-- 
1.7.10.4
