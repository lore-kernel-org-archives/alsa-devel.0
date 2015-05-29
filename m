From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 02/10] ALSA: dummy: Replace CONFIG_PROC_FS with
	CONFIG_SND_PROC_FS
Date: Fri, 29 May 2015 08:06:03 +0200
Message-ID: <1432879571-3359-3-git-send-email-tiwai@suse.de>
References: <1432879571-3359-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AD9C2666D3
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 08:06:14 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 16776ABB3
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 06:06:14 +0000 (UTC)
In-Reply-To: <1432879571-3359-1-git-send-email-tiwai@suse.de>
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

Although there shouldn't be a problem in practice (the compiler should
handle well), it's better to follow to the new Kconfig.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/dummy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index 5912f440d30f..016e451ed506 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -914,7 +914,7 @@ static int snd_card_dummy_new_mixer(struct snd_dummy *dummy)
 	return 0;
 }
 
-#if defined(CONFIG_SND_DEBUG) && defined(CONFIG_PROC_FS)
+#if defined(CONFIG_SND_DEBUG) && defined(CONFIG_SND_PROC_FS)
 /*
  * proc interface
  */
@@ -1042,7 +1042,7 @@ static void dummy_proc_init(struct snd_dummy *chip)
 }
 #else
 #define dummy_proc_init(x)
-#endif /* CONFIG_SND_DEBUG && CONFIG_PROC_FS */
+#endif /* CONFIG_SND_DEBUG && CONFIG_SND_PROC_FS */
 
 static int snd_dummy_probe(struct platform_device *devptr)
 {
-- 
2.4.2
