From: Konstantinos Tsimpoukas <kostaslinuxxx@gmail.com>
Subject: [PATCH 1/1] ice1712: tiny patch defining i2c eeprom addr to header file
Date: Sun,  5 Nov 2017 14:11:01 -0600
Message-ID: <1509912661-7070-1-git-send-email-kostaslinuxxx@gmail.com>
Return-path: <linux-sound-owner@vger.kernel.org>
Sender: linux-sound-owner@vger.kernel.org
To: Konstantinos Tsimpoukas <kostaslinuxxx@gmail.com>, alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Konstantinos Tsimpoukas <kostaslinuxxx@gmail.com>
---
 sound/pci/ice1712/ice1712.c | 2 +-
 sound/pci/ice1712/ice1712.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/pci/ice1712/ice1712.c b/sound/pci/ice1712/ice1712.c
index 0e66afa..f1fe497 100644
--- a/sound/pci/ice1712/ice1712.c
+++ b/sound/pci/ice1712/ice1712.c
@@ -2285,7 +2285,7 @@ static unsigned char snd_ice1712_read_i2c(struct snd_ice1712 *ice,
 static int snd_ice1712_read_eeprom(struct snd_ice1712 *ice,
 				   const char *modelname)
 {
-	int dev = 0xa0;		/* EEPROM device address */
+	int dev = ICE_I2C_EEPROM_ADDR;	/* I2C EEPROM device address */
 	unsigned int i, size;
 	struct snd_ice1712_card_info * const *tbl, *c;
 
diff --git a/sound/pci/ice1712/ice1712.h b/sound/pci/ice1712/ice1712.h
index 5cfba09..8ae8742 100644
--- a/sound/pci/ice1712/ice1712.h
+++ b/sound/pci/ice1712/ice1712.h
@@ -218,8 +218,9 @@
 
 
 /*
- *
+ * I2C EEPROM Address
  */
+#define ICE_I2C_EEPROM_ADDR		0xA0
 
 struct snd_ice1712;
 
-- 
2.7.4

