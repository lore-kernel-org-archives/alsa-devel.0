From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: ak4117: remove redundant check on err being < 0
Date: Tue, 12 Jul 2016 11:22:40 +0100
Message-ID: <1468318960-6979-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

snd_ak4117_create checks if the error return err is less than zero
or not.  This is a redundant check, err can only be < 0 to get to
the __fail label, in which case just return err and remove the
redundant check (since we never return -EIO).

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/i2c/other/ak4117.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/i2c/other/ak4117.c b/sound/i2c/other/ak4117.c
index 48848909..0702f05 100644
--- a/sound/i2c/other/ak4117.c
+++ b/sound/i2c/other/ak4117.c
@@ -110,7 +110,7 @@ int snd_ak4117_create(struct snd_card *card, ak4117_read_t *read, ak4117_write_t
 
       __fail:
 	snd_ak4117_free(chip);
-	return err < 0 ? err : -EIO;
+	return err;
 }
 
 void snd_ak4117_reg_write(struct ak4117 *chip, unsigned char reg, unsigned char mask, unsigned char val)
-- 
2.8.1
