From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH] ice1712: Use bitrev8
Date: Fri, 13 Nov 2009 16:02:56 +0900
Message-ID: <1258095776-13259-1-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f196.google.com (mail-yx0-f196.google.com
	[209.85.210.196])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C211245BB
	for <alsa-devel@alsa-project.org>; Fri, 13 Nov 2009 08:03:38 +0100 (CET)
Received: by yxe34 with SMTP id 34so2712657yxe.16
	for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2009 23:03:37 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Akinobu Mita <akinobu.mita@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
---
 sound/i2c/cs8427.c |   15 ++-------------
 sound/pci/Kconfig  |    1 +
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/sound/i2c/cs8427.c b/sound/i2c/cs8427.c
index 020a5d5..04ae870 100644
--- a/sound/i2c/cs8427.c
+++ b/sound/i2c/cs8427.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/bitrev.h>
 #include <asm/unaligned.h>
 #include <sound/core.h>
 #include <sound/control.h>
@@ -55,18 +56,6 @@ struct cs8427 {
 	struct cs8427_stream capture;
 };
 
-static unsigned char swapbits(unsigned char val)
-{
-	int bit;
-	unsigned char res = 0;
-	for (bit = 0; bit < 8; bit++) {
-		res <<= 1;
-		res |= val & 1;
-		val >>= 1;
-	}
-	return res;
-}
-
 int snd_cs8427_reg_write(struct snd_i2c_device *device, unsigned char reg,
 			 unsigned char val)
 {
@@ -149,7 +138,7 @@ static int snd_cs8427_send_corudata(struct snd_i2c_device *device,
 	}
 	data[0] = CS8427_REG_AUTOINC | CS8427_REG_CORU_DATABUF;
 	for (idx = 0; idx < count; idx++)
-		data[idx + 1] = swapbits(ndata[idx]);
+		data[idx + 1] = bitrev8(ndata[idx]);
 	if (snd_i2c_sendbytes(device, data, count + 1) != count + 1)
 		return -EIO;
 	return 1;
diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
index 75c602b..351654c 100644
--- a/sound/pci/Kconfig
+++ b/sound/pci/Kconfig
@@ -570,6 +570,7 @@ config SND_ICE1712
 	tristate "ICEnsemble ICE1712 (Envy24)"
 	select SND_MPU401_UART
 	select SND_AC97_CODEC
+	select BITREVERSE
 	help
 	  Say Y here to include support for soundcards based on the
 	  ICE1712 (Envy24) chip.
-- 
1.6.5.1
