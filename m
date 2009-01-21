From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] sscape: use common MPU401 macros
Date: Wed, 21 Jan 2009 08:19:27 +0100
Message-ID: <20090121081927.ccf5ad01.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 485D31037E3
	for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2009 08:16:29 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Remove local macros which redefines the
common ones.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
Just cut few lines from the driver.

 sound/isa/sscape.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/isa/sscape.c b/sound/isa/sscape.c
index 6a7f842..681e223 100644
--- a/sound/isa/sscape.c
+++ b/sound/isa/sscape.c
@@ -89,9 +89,6 @@ MODULE_DEVICE_TABLE(pnp_card, sscape_pnpids);
 #endif
 
 
-#define MPU401_IO(i)     ((i) + 0)
-#define MIDI_DATA_IO(i)  ((i) + 0)
-#define MIDI_CTRL_IO(i)  ((i) + 1)
 #define HOST_CTRL_IO(i)  ((i) + 2)
 #define HOST_DATA_IO(i)  ((i) + 3)
 #define ODIE_ADDR_IO(i)  ((i) + 4)
@@ -327,7 +324,7 @@ static int host_write_ctrl_unsafe(unsigned io_base, unsigned char data,
  */
 static inline int verify_mpu401(const struct snd_mpu401 * mpu)
 {
-	return ((inb(MIDI_CTRL_IO(mpu->port)) & 0xc0) == 0x80);
+	return ((inb(MPU401C(mpu)) & 0xc0) == 0x80);
 }
 
 /*
@@ -335,7 +332,7 @@ static inline int verify_mpu401(const struct snd_mpu401 * mpu)
  */
 static inline void initialise_mpu401(const struct snd_mpu401 * mpu)
 {
-	outb(0, MIDI_DATA_IO(mpu->port));
+	outb(0, MPU401D(mpu));
 }
 
 /*
@@ -1191,12 +1188,11 @@ static int __devinit create_sscape(int dev, struct snd_card *card)
 	}
 #define MIDI_DEVNUM  0
 	if (sscape->type != SSCAPE_VIVO) {
-		err = create_mpu401(card, MIDI_DEVNUM,
-				    MPU401_IO(xport), mpu_irq[dev]);
+		err = create_mpu401(card, MIDI_DEVNUM, xport, mpu_irq[dev]);
 		if (err < 0) {
 			printk(KERN_ERR "sscape: Failed to create "
 					"MPU-401 device at 0x%x\n",
-					MPU401_IO(xport));
+					xport);
 			goto _release_dma;
 		}
 
-- 
1.5.2.2


-----------------------------------------------------------------------
Promocja w Speak Up. Kwartal angielskiego za darmo. 
3 miesiace nauki gratis. Sprawdz teraz! >> http://link.interia.pl/f2019
