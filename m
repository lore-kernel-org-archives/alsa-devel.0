From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 03/34] pcm: change code formatting for
	snd_pcm_get_params()
Date: Thu, 14 Jul 2016 23:07:20 +0900
Message-ID: <1468505271-5769-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id C8BA12658D4
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2016 16:08:06 +0200 (CEST)
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
for snd_pcm_get_params().

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 4cace0b..23655e6 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -8484,11 +8484,9 @@ int snd_pcm_get_params(snd_pcm_t *pcm,
 	err = snd_pcm_hw_params_current(pcm, hw);
 	if (err < 0)
 	        return err;
-        err = INTERNAL(snd_pcm_hw_params_get_buffer_size)(hw, buffer_size);
-        if (err < 0)
-                return err;
-        err = INTERNAL(snd_pcm_hw_params_get_period_size)(hw, period_size, NULL);
-        if (err < 0)
-                return err;
-	return 0;
+	err = INTERNAL(snd_pcm_hw_params_get_buffer_size)(hw, buffer_size);
+	if (err < 0)
+		return err;
+	return INTERNAL(snd_pcm_hw_params_get_period_size)(hw, period_size,
+							   NULL);
 }
-- 
2.7.4
