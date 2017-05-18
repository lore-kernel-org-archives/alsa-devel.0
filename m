From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] ALSA: pcm: use "do {} while (0)" for empty
	macro
Date: Thu, 18 May 2017 15:35:54 +0200
Message-ID: <20170518133610.1914235-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DA04267019
 for <alsa-devel@alsa-project.org>; Thu, 18 May 2017 15:36:18 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

Recent compilers produce a harmless warning for the new pcm_call_notify()
macro when CONFIG_SND_PCM_OSS is disabled:

sound/core/pcm.c: In function 'snd_pcm_free':
sound/core/pcm.c:905:37: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]

This turns the empty macro into a 'do {} while (0)' statement to avoid
the warning.

Fixes: 58f30d650c7f ("ALSA: pcm: Build pcm notifier code conditionally")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/core/pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 24acbfb5c531..d30dba0ee688 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -894,7 +894,7 @@ static void snd_pcm_free_stream(struct snd_pcm_str * pstr)
 			_notify->call(pcm);				\
 	} while (0)
 #else
-#define pcm_call_notify(pcm, call) /* NOP */
+#define pcm_call_notify(pcm, call) do {} while (0)
 #endif
 
 static int snd_pcm_free(struct snd_pcm *pcm)
-- 
2.9.0
