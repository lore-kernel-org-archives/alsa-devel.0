From: Ricardo Biehl Pasquali <pasqualirb@gmail.com>
Subject: [PATCH] ALSA: pcm: Fix function name in kernel-doc
	comment
Date: Wed, 13 Mar 2019 16:06:48 -0300
Message-ID: <20190313190648.GA18221@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw1-xc44.google.com (mail-yw1-xc44.google.com
 [IPv6:2607:f8b0:4864:20::c44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D2E9EF80799
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2019 20:06:54 +0100 (CET)
Received: by mail-yw1-xc44.google.com with SMTP id v127so2079099ywe.13
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2019 12:06:54 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ricardo Biehl Pasquali <pasqualirb@gmail.com>
---
 include/sound/pcm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 465d7d033..18bd8c3ea 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -750,7 +750,7 @@ static inline snd_pcm_uframes_t snd_pcm_playback_avail(struct snd_pcm_runtime *r
 }
 
 /**
- * snd_pcm_playback_avail - Get the available (readable) space for capture
+ * snd_pcm_capture_avail - Get the available (readable) space for capture
  * @runtime: PCM runtime instance
  *
  * Result is between 0 ... (boundary - 1)
-- 
2.19.1
