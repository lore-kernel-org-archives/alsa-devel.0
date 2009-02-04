From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] pcm_oss: AFMT_S24_LE is set twice in return
	value
Date: Wed, 04 Feb 2009 18:14:55 +0100
Message-ID: <4989CD0F.50700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by alsa0.perex.cz (Postfix) with ESMTP id 206E81038E1
	for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2009 18:14:56 +0100 (CET)
Received: by ug-out-1314.google.com with SMTP id z36so91950uge.24
	for <alsa-devel@alsa-project.org>; Wed, 04 Feb 2009 09:14:55 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

vi sound/core/oss/pcm_oss.c +640
#define AFMT_S24_LE      0x00008000
#define AFMT_S24_BE      0x00010000

---------------------->8----------------------8<-------------------
AFMT_S24_LE is set twice in return value

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index e178366..0a1798e 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -1767,7 +1767,7 @@ static int snd_pcm_oss_get_formats(struct snd_pcm_oss_file *pcm_oss_file)
 		       AFMT_S8 | AFMT_U16_LE |
 		       AFMT_U16_BE |
 			AFMT_S32_LE | AFMT_S32_BE |
-			AFMT_S24_LE | AFMT_S24_LE |
+			AFMT_S24_LE | AFMT_S24_BE |
 			AFMT_S24_PACKED;
 	params = kmalloc(sizeof(*params), GFP_KERNEL);
 	if (!params)
