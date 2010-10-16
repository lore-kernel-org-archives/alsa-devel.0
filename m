From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] ALSA: fix unused warnings with
	snd_power_get_state
Date: Sat, 16 Oct 2010 13:24:52 -0400
Message-ID: <1287249892-27012-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id C020524436
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Oct 2010 19:25:10 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

If we compile the ASoC code with PM disabled, we hit stuff like:
sound/soc/soc-dapm.c: In function 'snd_soc_dapm_suspend_check':
sound/soc/soc-dapm.c:440: warning: unused variable 'codec'

So tweak the stub macro to avoid these issues.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 include/sound/core.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index 89e0ac1..c129f08 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -179,7 +179,7 @@ int snd_power_wait(struct snd_card *card, unsigned int power_state);
 #define snd_power_lock(card)		do { (void)(card); } while (0)
 #define snd_power_unlock(card)		do { (void)(card); } while (0)
 static inline int snd_power_wait(struct snd_card *card, unsigned int state) { return 0; }
-#define snd_power_get_state(card)	SNDRV_CTL_POWER_D0
+#define snd_power_get_state(card)	({ (void)(card); SNDRV_CTL_POWER_D0; })
 #define snd_power_change_state(card, state)	do { (void)(card); } while (0)
 
 #endif /* CONFIG_PM */
-- 
1.7.3.1
