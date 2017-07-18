From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 4/7] ALSA: opti9xx: fix format string
	overflow warning
Date: Tue, 18 Jul 2017 13:48:07 +0200
Message-ID: <20170718114820.3681255-4-arnd@arndb.de>
References: <20170718114820.3681255-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by alsa0.perex.cz (Postfix) with ESMTP id E114C26719C
 for <alsa-devel@alsa-project.org>; Tue, 18 Jul 2017 13:50:29 +0200 (CEST)
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
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

We pass a long name from "codec->pcm->name" into the longname
string of the same length:

sound/isa/opti9xx/miro.c: In function 'snd_miro_probe':
sound/isa/opti9xx/miro.c:1356:39: error: '%s' directive writing up to 79 bytes into a region of size between 35 and 72 [-Werror=format-overflow=]
  sprintf(card->longname, "%s: OPTi%s, %s at 0x%lx, irq %d, dma %d&%d",
                                       ^~
sound/isa/opti9xx/miro.c:1356:26: note: using the range [0, 4294967295] for directive argument
  sprintf(card->longname, "%s: OPTi%s, %s at 0x%lx, irq %d, dma %d&%d",
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/isa/opti9xx/miro.c:1356:2: note: 'sprintf' output between 32 and 185 bytes into a destination of size 80
  sprintf(card->longname, "%s: OPTi%s, %s at 0x%lx, irq %d, dma %d&%d",

There is no easy way to avoid the theoretical overflow in this case,
but using snprintf() will turn it into a harmless truncation.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/isa/opti9xx/miro.c           |  7 ++++---
 sound/isa/opti9xx/opti92x-ad1848.c | 14 ++++++++------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/sound/isa/opti9xx/miro.c b/sound/isa/opti9xx/miro.c
index bcbff56f060d..1c5a12fa8be3 100644
--- a/sound/isa/opti9xx/miro.c
+++ b/sound/isa/opti9xx/miro.c
@@ -1353,9 +1353,10 @@ static int snd_miro_probe(struct snd_card *card)
 	}
 
 	strcpy(card->driver, "miro");
-	sprintf(card->longname, "%s: OPTi%s, %s at 0x%lx, irq %d, dma %d&%d",
-		card->shortname, miro->name, codec->pcm->name,
-		miro->wss_base + 4, miro->irq, miro->dma1, miro->dma2);
+	snprintf(card->longname, sizeof(card->longname),
+		 "%s: OPTi%s, %s at 0x%lx, irq %d, dma %d&%d",
+		 card->shortname, miro->name, codec->pcm->name,
+		 miro->wss_base + 4, miro->irq, miro->dma1, miro->dma2);
 
 	if (mpu_port <= 0 || mpu_port == SNDRV_AUTO_PORT)
 		rmidi = NULL;
diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index ceddb392b1e3..56dc581c57d5 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -879,13 +879,15 @@ static int snd_opti9xx_probe(struct snd_card *card)
 	strcpy(card->driver, chip->name);
 	sprintf(card->shortname, "OPTi %s", card->driver);
 #if defined(CS4231) || defined(OPTi93X)
-	sprintf(card->longname, "%s, %s at 0x%lx, irq %d, dma %d&%d",
-		card->shortname, codec->pcm->name,
-		chip->wss_base + 4, irq, dma1, xdma2);
+	snprintf(card->longname, sizeof(card->longname),
+		 "%s, %s at 0x%lx, irq %d, dma %d&%d",
+		 card->shortname, codec->pcm->name,
+		 chip->wss_base + 4, irq, dma1, xdma2);
 #else
-	sprintf(card->longname, "%s, %s at 0x%lx, irq %d, dma %d",
-		card->shortname, codec->pcm->name, chip->wss_base + 4, irq,
-		dma1);
+	snprintf(card->longname, sizeof(card->longname),
+		 "%s, %s at 0x%lx, irq %d, dma %d",
+		 card->shortname, codec->pcm->name, chip->wss_base + 4, irq,
+		 dma1);
 #endif	/* CS4231 || OPTi93X */
 
 	if (mpu_port <= 0 || mpu_port == SNDRV_AUTO_PORT)
-- 
2.9.0
