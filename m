From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 1/7] ALSA: als100: fix format string
	overflow warning
Date: Tue, 18 Jul 2017 13:48:04 +0200
Message-ID: <20170718114820.3681255-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 100EE2664EB
 for <alsa-devel@alsa-project.org>; Tue, 18 Jul 2017 13:49:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

The compiler sees that the format string might overflow for the longname:

sound/isa/als100.c: In function 'snd_als100_pnp_detect':
sound/isa/als100.c:225:27: error: ', dma ' directive writing 6 bytes into a region of size between 0 and 64 [-Werror=format-overflow=]
   sprintf(card->longname, "%s, %s at 0x%lx, irq %d, dma %d",
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/isa/als100.c:225:3: note: 'sprintf' output between 24 and 113 bytes into a destination of size 80
   sprintf(card->longname, "%s, %s at 0x%lx, irq %d, dma %d",

Open-coding "shortname" here gets us below the limit, and using
snprintf() is a good idea too.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/isa/als100.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sound/isa/als100.c b/sound/isa/als100.c
index bc9ea306ee02..6a2c5b48f3ae 100644
--- a/sound/isa/als100.c
+++ b/sound/isa/als100.c
@@ -222,15 +222,16 @@ static int snd_card_als100_probe(int dev,
 	if (pid->driver_data == SB_HW_DT019X) {
 		strcpy(card->driver, "DT-019X");
 		strcpy(card->shortname, "Diamond Tech. DT-019X");
-		sprintf(card->longname, "%s, %s at 0x%lx, irq %d, dma %d",
-			card->shortname, chip->name, chip->port,
-			irq[dev], dma8[dev]);
+		snprintf(card->longname, sizeof(card->longname),
+			 "Diamond Tech. DT-019X, %s at 0x%lx, irq %d, dma %d",
+			 chip->name, chip->port, irq[dev], dma8[dev]);
 	} else {
 		strcpy(card->driver, "ALS100");
 		strcpy(card->shortname, "Avance Logic ALS100");
-		sprintf(card->longname, "%s, %s at 0x%lx, irq %d, dma %d&%d",
-			card->shortname, chip->name, chip->port,
-			irq[dev], dma8[dev], dma16[dev]);
+		snprintf(card->longname, sizeof(card->longname),
+			 "Avance Logic ALS100, %s at 0x%lx, irq %d, dma %d&%d",
+			 chip->name, chip->port, irq[dev], dma8[dev],
+			 dma16[dev]);
 	}
 
 	if ((error = snd_sb16dsp_pcm(chip, 0)) < 0) {
-- 
2.9.0
