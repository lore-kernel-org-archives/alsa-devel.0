From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 5/7] ALSA: mixart: fix string overflow
	warning
Date: Tue, 18 Jul 2017 13:48:08 +0200
Message-ID: <20170718114820.3681255-5-arnd@arndb.de>
References: <20170718114820.3681255-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D01E2671D1
 for <alsa-devel@alsa-project.org>; Tue, 18 Jul 2017 13:49:51 +0200 (CEST)
In-Reply-To: <20170718114820.3681255-1-arnd@arndb.de>
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

Using a temporary string produces warnings about a possible overflow
in sprintf:

sound/pci/mixart/mixart.c: In function 'snd_mixart_probe':
sound/pci/mixart/mixart.c:1353:28: error: ' [PCM #' directive writing 7 bytes into a region of size between 1 and 32 [-Werror=format-overflow=]
   sprintf(card->shortname, "%s [PCM #%d]", mgr->shortname, i);
                            ^~~~~~~~~~~~~~
sound/pci/mixart/mixart.c:1353:28: note: using the range [-2147483648, 2147483647] for directive argument
sound/pci/mixart/mixart.c:1353:3: note: 'sprintf' output between 10 and 51 bytes into a destination of size 32
   sprintf(card->shortname, "%s [PCM #%d]", mgr->shortname, i);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/pci/mixart/mixart.c:1354:27: error: ' [PCM #' directive writing 7 bytes into a region of size between 1 and 80 [-Werror=format-overflow=]
   sprintf(card->longname, "%s [PCM #%d]", mgr->longname, i);
                           ^~~~~~~~~~~~~~
sound/pci/mixart/mixart.c:1354:27: note: using the range [-2147483648, 2147483647] for directive argument
sound/pci/mixart/mixart.c:1354:3: note: 'sprintf' output between 10 and 99 bytes into a destination of size 80

Skipping the intermediate, we can get gcc to see that it is in fact
safe here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/pci/mixart/mixart.c | 10 +++++-----
 sound/pci/mixart/mixart.h |  4 ----
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/sound/pci/mixart/mixart.c b/sound/pci/mixart/mixart.c
index 80d439944cb5..6d7fbf30618b 100644
--- a/sound/pci/mixart/mixart.c
+++ b/sound/pci/mixart/mixart.c
@@ -1313,9 +1313,6 @@ static int snd_mixart_probe(struct pci_dev *pci,
 	}
 	mgr->irq = pci->irq;
 
-	sprintf(mgr->shortname, "Digigram miXart");
-	sprintf(mgr->longname, "%s at 0x%lx & 0x%lx, irq %i", mgr->shortname, mgr->mem[0].phys, mgr->mem[1].phys, mgr->irq);
-
 	/* init mailbox  */
 	mgr->msg_fifo_readptr = 0;
 	mgr->msg_fifo_writeptr = 0;
@@ -1350,8 +1347,11 @@ static int snd_mixart_probe(struct pci_dev *pci,
 		}
 
 		strcpy(card->driver, CARD_NAME);
-		sprintf(card->shortname, "%s [PCM #%d]", mgr->shortname, i);
-		sprintf(card->longname, "%s [PCM #%d]", mgr->longname, i);
+		snprintf(card->shortname, sizeof(card->shortname),
+			 "Digigram miXart [PCM #%d]", i);
+		snprintf(card->longname, sizeof(card->longname),
+			"Digigram miXart at 0x%lx & 0x%lx, irq %i [PCM #%d]",
+			mgr->mem[0].phys, mgr->mem[1].phys, mgr->irq, i);
 
 		if ((err = snd_mixart_create(mgr, card, i)) < 0) {
 			snd_card_free(card);
diff --git a/sound/pci/mixart/mixart.h b/sound/pci/mixart/mixart.h
index 426743871540..69b3ece099ad 100644
--- a/sound/pci/mixart/mixart.h
+++ b/sound/pci/mixart/mixart.h
@@ -74,10 +74,6 @@ struct mixart_mgr {
 	/* memory-maps */
 	struct mem_area mem[2];
 
-	/* share the name */
-	char shortname[32];         /* short name of this soundcard */
-	char longname[80];          /* name of this soundcard */
-
 	/* one and only blocking message or notification may be pending  */
 	u32 pending_event;
 	wait_queue_head_t msg_sleep;
-- 
2.9.0
