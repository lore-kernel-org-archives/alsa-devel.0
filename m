From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] ALSA: use ktime_get_raw_ts64() instead of
	getrawmonotonic64()
Date: Mon, 18 Jun 2018 17:41:00 +0200
Message-ID: <20180618154108.2227779-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AC8F266D4C
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 17:41:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

The API got renamed for consistency and the old name will
be removed once the last users are gone.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/sound/pcm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 5d5daa190b08..f566611f0fef 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -1187,7 +1187,7 @@ static inline void snd_pcm_gettime(struct snd_pcm_runtime *runtime,
 		ktime_get_ts64(tv);
 		break;
 	case SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW:
-		getrawmonotonic64(tv);
+		ktime_get_raw_ts64(tv);
 		break;
 	default:
 #ifdef CONFIG_SND_TSTAMP_REALTIME
-- 
2.9.0
