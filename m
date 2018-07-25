From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 09/12] ALSA: pcm: Add __force to cast in
	snd_pcm_lib_read/write()
Date: Wed, 25 Jul 2018 23:00:54 +0200
Message-ID: <20180725210057.18017-10-tiwai@suse.de>
References: <20180725210057.18017-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B0C0D26778C
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:01:05 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id BB609B37E
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 21:01:03 +0000 (UTC)
In-Reply-To: <20180725210057.18017-1-tiwai@suse.de>
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

The snd_pcm_lib_read() and snd_pcm_lib_write() inline functions have
the explicit cast from a user pointer to a kernel pointer, but they
lacks of __force prefix.

This fixes sparse warnings like:
  ./include/sound/pcm.h:1093:47: warning: cast removes address space of expression

Fixes: 68541213720d ("ALSA: pcm: Direct in-kernel read/write support")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/pcm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 1206045ccf03..d6bd3caf6878 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -1090,14 +1090,14 @@ static inline snd_pcm_sframes_t
 snd_pcm_lib_write(struct snd_pcm_substream *substream,
 		  const void __user *buf, snd_pcm_uframes_t frames)
 {
-	return __snd_pcm_lib_xfer(substream, (void *)buf, true, frames, false);
+	return __snd_pcm_lib_xfer(substream, (void __force *)buf, true, frames, false);
 }
 
 static inline snd_pcm_sframes_t
 snd_pcm_lib_read(struct snd_pcm_substream *substream,
 		 void __user *buf, snd_pcm_uframes_t frames)
 {
-	return __snd_pcm_lib_xfer(substream, (void *)buf, true, frames, false);
+	return __snd_pcm_lib_xfer(substream, (void __force *)buf, true, frames, false);
 }
 
 static inline snd_pcm_sframes_t
-- 
2.18.0
