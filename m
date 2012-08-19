From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH] sound: fix pcm.h kernel-doc warning and
	notation
Date: Sat, 18 Aug 2012 17:43:05 -0700
Message-ID: <50303699.8030309@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy11-pub.bluehost.com (oproxy11-pub.bluehost.com
 [173.254.64.10]) by alsa0.perex.cz (Postfix) with SMTP id 791B7265CE0
 for <alsa-devel@alsa-project.org>; Sun, 19 Aug 2012 02:13:21 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix kernel-doc warning in <sound/pcm.h> and add function name to make
the kernel-doc notation complete.

Warning(include/sound/pcm.h:1081): No description found for parameter 'substream'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Cc:	Jaroslav Kysela <perex@perex.cz>
Cc:	Takashi Iwai <tiwai@suse.de>
Cc:	alsa-devel@alsa-project.org (moderated for non-subscribers)
---
 include/sound/pcm.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- lnx-36-rc2.orig/include/sound/pcm.h
+++ lnx-36-rc2/include/sound/pcm.h
@@ -1075,7 +1075,8 @@ static inline void snd_pcm_limit_isa_dma
 const char *snd_pcm_format_name(snd_pcm_format_t format);
 
 /**
- * Get a string naming the direction of a stream
+ * snd_pcm_stream_str - Get a string naming the direction of a stream
+ * @substream: the pcm substream instance
  */
 static inline const char *snd_pcm_stream_str(struct snd_pcm_substream *substream)
 {
