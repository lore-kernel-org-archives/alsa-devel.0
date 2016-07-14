From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 09/34] pcm: change code formatting for
	snd_pcm_direct_set_timer_params()
Date: Thu, 14 Jul 2016 23:07:26 +0900
Message-ID: <1468505271-5769-10-git-send-email-o-takashi@sakamocchi.jp>
References: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 6F01A26595B
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2016 16:08:08 +0200 (CEST)
In-Reply-To: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This commit applies code format according to typical and moderate rule,
for snd_pcm_direct_set_timer_params().

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_direct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index dbd7e2b..50d5539 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -1375,7 +1375,7 @@ int snd_pcm_direct_set_timer_params(snd_pcm_direct_t *dmix)
 	ret = snd_timer_params(dmix->timer, params);
 	if (ret < 0) {
 		SNDERR("unable to set timer parameters");
-                return ret;
+		return ret;
 	}
 	return 0;
 }
-- 
2.7.4
