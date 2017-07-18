From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 2/7] ALSA: cs423x: fix format string
	overflow warning
Date: Tue, 18 Jul 2017 13:48:05 +0200
Message-ID: <20170718114820.3681255-2-arnd@arndb.de>
References: <20170718114820.3681255-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F9FB2664EB
 for <alsa-devel@alsa-project.org>; Tue, 18 Jul 2017 13:48:49 +0200 (CEST)
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

The snd_pcm name may overflow the card->longname total size:

sound/isa/cs423x/cs4231.c: In function 'snd_cs4231_probe':
sound/isa/cs423x/cs4231.c:115:26: error: ' at 0x' directive writing 6 bytes into a region of size between 1 and 80 [-Werror=format-overflow=] 0x%lx, irq %d, dma %d",
  sprintf(card->longname, "%s at 0x%lx, irq %d, dma %d",
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This changes the driver to use snprintf() so we truncate the string
instead of overflowing into the next field if that happens.

I decided to split out the second format string for the extra
DMA channel to keep the code simpler.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/isa/cs423x/cs4231.c | 18 +++++++++++-------
 sound/isa/cs423x/cs4236.c | 20 +++++++++++---------
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/sound/isa/cs423x/cs4231.c b/sound/isa/cs423x/cs4231.c
index e8edd9017a2f..d90ab9558f7f 100644
--- a/sound/isa/cs423x/cs4231.c
+++ b/sound/isa/cs423x/cs4231.c
@@ -109,13 +109,17 @@ static int snd_cs4231_probe(struct device *dev, unsigned int n)
 	if (error < 0)
 		goto out;
 
-	strcpy(card->driver, "CS4231");
-	strcpy(card->shortname, chip->pcm->name);
-
-	sprintf(card->longname, "%s at 0x%lx, irq %d, dma %d",
-		chip->pcm->name, chip->port, irq[n], dma1[n]);
-	if (dma2[n] >= 0)
-		sprintf(card->longname + strlen(card->longname), "&%d", dma2[n]);
+	strlcpy(card->driver, "CS4231", sizeof(card->driver));
+	strlcpy(card->shortname, chip->pcm->name, sizeof(card->shortname));
+
+	if (dma2[n] < 0)
+		snprintf(card->longname, sizeof(card->longname),
+			 "%s at 0x%lx, irq %d, dma %d",
+			 chip->pcm->name, chip->port, irq[n], dma1[n]);
+	else
+		snprintf(card->longname, sizeof(card->longname),
+			 "%s at 0x%lx, irq %d, dma %d&%d",
+			 chip->pcm->name, chip->port, irq[n], dma1[n], dma2[n]);
 
 	error = snd_wss_mixer(chip);
 	if (error < 0)
diff --git a/sound/isa/cs423x/cs4236.c b/sound/isa/cs423x/cs4236.c
index 1f9a3b2be7a1..4c09756c7353 100644
--- a/sound/isa/cs423x/cs4236.c
+++ b/sound/isa/cs423x/cs4236.c
@@ -419,15 +419,17 @@ static int snd_cs423x_probe(struct snd_card *card, int dev)
 		if (err < 0)
 			return err;
 	}
-	strcpy(card->driver, chip->pcm->name);
-	strcpy(card->shortname, chip->pcm->name);
-	sprintf(card->longname, "%s at 0x%lx, irq %i, dma %i",
-		chip->pcm->name,
-		chip->port,
-		irq[dev],
-		dma1[dev]);
-	if (dma2[dev] >= 0)
-		sprintf(card->longname + strlen(card->longname), "&%d", dma2[dev]);
+	strlcpy(card->driver, chip->pcm->name, sizeof(card->driver));
+	strlcpy(card->shortname, chip->pcm->name, sizeof(card->shortname));
+	if (dma2[dev] < 0)
+		snprintf(card->longname, sizeof(card->longname),
+			 "%s at 0x%lx, irq %i, dma %i",
+			 chip->pcm->name, chip->port, irq[dev], dma1[dev]);
+	else
+		snprintf(card->longname, sizeof(card->longname),
+			 "%s at 0x%lx, irq %i, dma %i&%d",
+			 chip->pcm->name, chip->port, irq[dev], dma1[dev],
+			 dma2[dev]);
 
 	err = snd_wss_timer(chip, 0);
 	if (err < 0)
-- 
2.9.0
