From: Kirill Tkhai <ktkhai@parallels.com>
Subject: [PATCH] ak4117: Do not free priv until timer handler
 hasn't actually stopped using it
Date: Fri, 14 Feb 2014 15:47:57 +0400
Message-ID: <1392378477.5384.29.camel@tkhai>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.parallels.com (relay.parallels.com [195.214.232.42])
 by alsa0.perex.cz (Postfix) with ESMTP id EFC84261609
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2014 12:47:41 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: tkhai@yandex.ru, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Function del_timer() does not guarantee that timer was really deleted.
If the timer handler is beeing executed at the moment, the function
does nothing. So, it's possible to use already freed memory in the handler:

[ref: Documentation/DocBook/kernel-locking.tmpl]

This was found using grep and compile-tested only.

Signed-off-by: Kirill Tkhai <ktkhai@parallels.com>
CC: Jaroslav Kysela <perex@perex.cz>
CC: Takashi Iwai <tiwai@suse.de>
---
 sound/i2c/other/ak4117.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/i2c/other/ak4117.c b/sound/i2c/other/ak4117.c
index 40e33c9..88452e8 100644
--- a/sound/i2c/other/ak4117.c
+++ b/sound/i2c/other/ak4117.c
@@ -62,7 +62,7 @@ static void reg_dump(struct ak4117 *ak4117)
 
 static void snd_ak4117_free(struct ak4117 *chip)
 {
-	del_timer(&chip->timer);
+	del_timer_sync(&chip->timer);
 	kfree(chip);
 }
 
