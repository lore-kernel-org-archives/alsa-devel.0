From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: ak4114: remove redundant check on err being < 0
Date: Tue, 12 Jul 2016 11:26:29 +0100
Message-ID: <1468319189-7146-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

snd_ak4114_create checks if the error return err is less than zero
or not.  This is a redundant check, err can only be < 0 to get to
the __fail label, in which case just return err and remove the
redundant check (since we never return -EIO).

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/i2c/other/ak4114.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/i2c/other/ak4114.c b/sound/i2c/other/ak4114.c
index 5a4cf3f..d53c9bb 100644
--- a/sound/i2c/other/ak4114.c
+++ b/sound/i2c/other/ak4114.c
@@ -121,7 +121,7 @@ int snd_ak4114_create(struct snd_card *card,
 
       __fail:
 	snd_ak4114_free(chip);
-	return err < 0 ? err : -EIO;
+	return err;
 }
 EXPORT_SYMBOL(snd_ak4114_create);
 
-- 
2.8.1
