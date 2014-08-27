From: Konstantinos Tsimpoukas <kostaslinuxxx@gmail.com>
Subject: [PATCH 1/1] ice1712: Replacing hex with #defines
Date: Tue, 26 Aug 2014 23:21:48 -0500
Message-ID: <1409113308-4671-1-git-send-email-kostaslinuxxx@gmail.com>
Return-path: <linux-sound-owner@vger.kernel.org>
Sender: linux-sound-owner@vger.kernel.org
To: Konstantinos Tsimpoukas <kostaslinuxxx@gmail.com>, alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Adds to te readability of the ice1712 driver.

Signed-off-by: Konstantinos Tsimpoukas <kostaslinuxxx@gmail.com>
---
 sound/pci/ice1712/ice1712.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/ice1712/ice1712.c b/sound/pci/ice1712/ice1712.c
index 87f7fc4..206ed2c 100644
--- a/sound/pci/ice1712/ice1712.c
+++ b/sound/pci/ice1712/ice1712.c
@@ -2528,7 +2528,7 @@ static int snd_ice1712_free(struct snd_ice1712 *ice)
 	if (!ice->port)
 		goto __hw_end;
 	/* mask all interrupts */
-	outb(0xc0, ICEMT(ice, IRQ));
+	outb(ICE1712_MULTI_CAPTURE | ICE1712_MULTI_PLAYBACK, ICEMT(ice, IRQ));
 	outb(0xff, ICEREG(ice, IRQMASK));
 	/* --- */
 __hw_end:
-- 
1.9.1

