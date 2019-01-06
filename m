From: Aditya Pakki <pakki001@umn.edu>
Subject: [PATCH] [v2] ALSA: ice1712: fix a missing check of snd_i2c_sendbytes
Date: Sun,  6 Jan 2019 10:31:44 -0600
Message-ID: <20190106163146.9518-1-pakki001@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pakki001@umn.edu
Cc: kjlu@umn.edu, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

snd_i2c_sendbytes could fail. The fix checks its return value: if it
fails, issues an error message and returns with its error code.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 sound/pci/ice1712/ews.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/pci/ice1712/ews.c b/sound/pci/ice1712/ews.c
index b8af747ecb43..7646c93e8268 100644
--- a/sound/pci/ice1712/ews.c
+++ b/sound/pci/ice1712/ews.c
@@ -826,7 +826,12 @@ static int snd_ice1712_6fire_read_pca(struct snd_ice1712 *ice, unsigned char reg
 
 	snd_i2c_lock(ice->i2c);
 	byte = reg;
-	snd_i2c_sendbytes(spec->i2cdevs[EWS_I2C_6FIRE], &byte, 1);
+	if (snd_i2c_sendbytes(spec->i2cdevs[EWS_I2C_6FIRE], &byte, 1)) {
+		snd_i2c_unlock(ice->i2c);
+		dev_err(ice->card->dev, "cannot send pca\n");
+		return -EIO;
+	}
+
 	byte = 0;
 	if (snd_i2c_readbytes(spec->i2cdevs[EWS_I2C_6FIRE], &byte, 1) != 1) {
 		snd_i2c_unlock(ice->i2c);
-- 
2.17.1
