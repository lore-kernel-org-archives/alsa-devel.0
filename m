From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/5] ALSA: soc-da7219: fix inappropriate
	condition statement
Date: Tue, 26 Jul 2016 22:41:53 +0900
Message-ID: <1469540517-32466-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1469540517-32466-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id EBC9926813B
 for <alsa-devel@alsa-project.org>; Tue, 26 Jul 2016 15:42:02 +0200 (CEST)
In-Reply-To: <1469540517-32466-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

Sparse reports a below warning.

sound/soc/codecs/da7219.c:804:57: warning: dubious: x & !y

The line includes a condition statement; '(a < b) & !c'. Practically, the
evaluated value of this statement equals to the value of '(a < b) && !c'.
Although, it's not an usual way to use bitwise operations as logical
operations to several conditions.

This commit fixes the bug.

Fixes: 6d817c0e9fd7 ("ASoC: codecs: Add da7219 codec driver")
CC: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/soc/codecs/da7219.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 50ea943..b9fa8fe 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -801,7 +801,7 @@ static int da7219_dai_event(struct snd_soc_dapm_widget *w,
 				++i;
 				msleep(50);
 			}
-		} while ((i < DA7219_SRM_CHECK_RETRIES) & (!srm_lock));
+		} while ((i < DA7219_SRM_CHECK_RETRIES) && (!srm_lock));
 
 		if (!srm_lock)
 			dev_warn(codec->dev, "SRM failed to lock\n");
-- 
2.7.4
