From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH 4/4] pcm: fix wrong comments for some
	cases of linear interpolation of PCM samples
Date: Thu, 21 Dec 2017 02:17:03 +0900
Message-ID: <20171220171703.10609-5-o-takashi@sakamocchi.jp>
References: <20171220171703.10609-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 16952267823
 for <alsa-devel@alsa-project.org>; Wed, 20 Dec 2017 18:17:09 +0100 (CET)
In-Reply-To: <20171220171703.10609-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

A commit 16b3bf447c28 ('Enhanced bitmasks in PCM - added support for more
formats by Takashi and me') adds support for some cases of linear
interpolation of PCM samples, however some of added comments are not
proper. This commit fixes them.
---
 src/pcm/plugin_ops.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/pcm/plugin_ops.h b/src/pcm/plugin_ops.h
index 63e3c827..6392073c 100644
--- a/src/pcm/plugin_ops.h
+++ b/src/pcm/plugin_ops.h
@@ -593,14 +593,14 @@ static void *const put32_labels[5 * 2 * 2 + 4 * 3] = {
 	&&put32_1234_923,	 /* 32h ^> 24h */
 	&&put32_1234_321,	 /* 32h -> 24s */
 	&&put32_1234_329,	 /* 32h ^> 24s */
-	&&put32_1234_123_20,	 /* 32h -> 24h */
-	&&put32_1234_923_20,	 /* 32h ^> 24h */
-	&&put32_1234_321_20,	 /* 32h -> 24s */
-	&&put32_1234_329_20,	 /* 32h ^> 24s */
-	&&put32_1234_123_18,	 /* 32h -> 24h */
-	&&put32_1234_923_18,	 /* 32h ^> 24h */
-	&&put32_1234_321_18,	 /* 32h -> 24s */
-	&&put32_1234_329_18,	 /* 32h ^> 24s */
+	&&put32_1234_123_20,	 /* 32h -> 20h */
+	&&put32_1234_923_20,	 /* 32h ^> 20h */
+	&&put32_1234_321_20,	 /* 32h -> 20s */
+	&&put32_1234_329_20,	 /* 32h ^> 20s */
+	&&put32_1234_123_18,	 /* 32h -> 18h */
+	&&put32_1234_923_18,	 /* 32h ^> 18h */
+	&&put32_1234_321_18,	 /* 32h -> 18s */
+	&&put32_1234_329_18,	 /* 32h ^> 18s */
 };
 #endif
 
-- 
2.14.1
