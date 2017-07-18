From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 3/7] ALSA: ad1848: fix format string
	overflow warning
Date: Tue, 18 Jul 2017 13:48:06 +0200
Message-ID: <20170718114820.3681255-3-arnd@arndb.de>
References: <20170718114820.3681255-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by alsa0.perex.cz (Postfix) with ESMTP id 429F826717C
 for <alsa-devel@alsa-project.org>; Tue, 18 Jul 2017 13:49:03 +0200 (CEST)
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

The snd_pcm name is too long to fit into the card shortname
or a part of the longname:

sound/isa/ad1848/ad1848.c: In function 'snd_ad1848_probe':
sound/isa/ad1848/ad1848.c:116:26: error: ' at 0x' directive writing 6 bytes into a region of size between 1 and 80 [-Werror=format-overflow=]
  sprintf(card->longname, "%s at 0x%lx, irq %d, dma %d",
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/isa/ad1848/ad1848.c:116:2: note: 'sprintf' output between 22 and 128 bytes into a destination of size 80
  sprintf(card->longname, "%s at 0x%lx, irq %d, dma %d",
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   chip->pcm->name, chip->port, irq[n], dma1[n]);
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This changes the code to use length-checking functions that truncate
if necessary. The "[Thinkpad]" substring is now also part of the
snprintf(), as that could also overflow the buffer.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/isa/ad1848/ad1848.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/sound/isa/ad1848/ad1848.c b/sound/isa/ad1848/ad1848.c
index e739b1c85c25..7c8e92f62f3b 100644
--- a/sound/isa/ad1848/ad1848.c
+++ b/sound/isa/ad1848/ad1848.c
@@ -110,13 +110,17 @@ static int snd_ad1848_probe(struct device *dev, unsigned int n)
 	if (error < 0)
 		goto out;
 
-	strcpy(card->driver, "AD1848");
-	strcpy(card->shortname, chip->pcm->name);
-
-	sprintf(card->longname, "%s at 0x%lx, irq %d, dma %d",
-		chip->pcm->name, chip->port, irq[n], dma1[n]);
-	if (thinkpad[n])
-		strcat(card->longname, " [Thinkpad]");
+	strlcpy(card->driver, "AD1848", sizeof(card->driver));
+	strlcpy(card->shortname, chip->pcm->name, sizeof(card->shortname));
+
+	if (!thinkpad[n])
+		snprintf(card->longname, sizeof(card->longname),
+			 "%s at 0x%lx, irq %d, dma %d",
+			 chip->pcm->name, chip->port, irq[n], dma1[n]);
+	else
+		snprintf(card->longname, sizeof(card->longname),
+			 "%s at 0x%lx, irq %d, dma %d [Thinkpad]",
+			 chip->pcm->name, chip->port, irq[n], dma1[n]);
 
 	error = snd_card_register(card);
 	if (error < 0)
-- 
2.9.0
