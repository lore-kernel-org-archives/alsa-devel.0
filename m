From: Kangjie Lu <kjlu@umn.edu>
Subject: [PATCH] pci: fix a missing check of snd_i2c_sendbytes
Date: Tue, 25 Dec 2018 23:12:04 -0600
Message-ID: <20181226051206.74467-1-kjlu@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kjlu@umn.edu
Cc: pakki001@umn.edu, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

snd_i2c_sendbytes could fail. The fix checks its return value: if it
fails, issues an error message and returns with its error code.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 sound/pci/ice1712/ews.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/pci/ice1712/ews.c b/sound/pci/ice1712/ews.c
index b8af747ecb43..b978cdb0fc20 100644
--- a/sound/pci/ice1712/ews.c
+++ b/sound/pci/ice1712/ews.c
@@ -826,7 +826,10 @@ static int snd_ice1712_6fire_read_pca(struct snd_ice1712 *ice, unsigned char reg
 
 	snd_i2c_lock(ice->i2c);
 	byte = reg;
-	snd_i2c_sendbytes(spec->i2cdevs[EWS_I2C_6FIRE], &byte, 1);
+	if (snd_i2c_sendbytes(spec->i2cdevs[EWS_I2C_6FIRE], &byte, 1)) {
+		dev_err(ice->card->dev, "cannot send pca\n");
+		return -EIO;
+	}
 	byte = 0;
 	if (snd_i2c_readbytes(spec->i2cdevs[EWS_I2C_6FIRE], &byte, 1) != 1) {
 		snd_i2c_unlock(ice->i2c);
-- 
2.17.2 (Apple Git-113)
