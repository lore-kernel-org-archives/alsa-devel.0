From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 7/7] ALSA: pcxhr: fix string overflow
	warnings
Date: Tue, 18 Jul 2017 13:48:10 +0200
Message-ID: <20170718114820.3681255-7-arnd@arndb.de>
References: <20170718114820.3681255-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by alsa0.perex.cz (Postfix) with ESMTP id CBCA62671A8
 for <alsa-devel@alsa-project.org>; Tue, 18 Jul 2017 13:51:33 +0200 (CEST)
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
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

With gcc-7, we get a warning about a possible string overflow:

sound/pci/pcxhr/pcxhr.c: In function 'pcxhr_probe':
sound/pci/pcxhr/pcxhr.c:1647:28: error: ' [PCM #' directive writing 7 bytes into a region of size between 1 and 32 [-Werror=format-overflow=]

The shortname can simply be removed, and the longname can
be changed into a shorter "name" string that is used in three
places. Making it a little shorter (40 bytes) avoids the risk of
overflowing completely, but I also use snprintf() here for
extra clarity.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/pci/pcxhr/pcxhr.c | 19 ++++++++++---------
 sound/pci/pcxhr/pcxhr.h |  3 +--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/pci/pcxhr/pcxhr.c b/sound/pci/pcxhr/pcxhr.c
index bb7eee9d0c2b..fa919f52e225 100644
--- a/sound/pci/pcxhr/pcxhr.c
+++ b/sound/pci/pcxhr/pcxhr.c
@@ -1165,7 +1165,7 @@ int pcxhr_create_pcm(struct snd_pcxhr *chip)
 	struct snd_pcm *pcm;
 	char name[32];
 
-	sprintf(name, "pcxhr %d", chip->chip_idx);
+	snprintf(name, sizeof(name), "pcxhr %d", chip->chip_idx);
 	if ((err = snd_pcm_new(chip->card, name, 0,
 			       chip->nb_streams_play,
 			       chip->nb_streams_capt, &pcm)) < 0) {
@@ -1252,7 +1252,7 @@ static void pcxhr_proc_info(struct snd_info_entry *entry,
 	struct snd_pcxhr *chip = entry->private_data;
 	struct pcxhr_mgr *mgr = chip->mgr;
 
-	snd_iprintf(buffer, "\n%s\n", mgr->longname);
+	snd_iprintf(buffer, "\n%s\n", mgr->name);
 
 	/* stats available when embedded DSP is running */
 	if (mgr->dsp_loaded & (1 << PCXHR_FIRMWARE_DSP_MAIN_INDEX)) {
@@ -1339,7 +1339,7 @@ static void pcxhr_proc_sync(struct snd_info_entry *entry,
 		max_clock = PCXHR_CLOCK_TYPE_MAX;
 	}
 
-	snd_iprintf(buffer, "\n%s\n", mgr->longname);
+	snd_iprintf(buffer, "\n%s\n", mgr->name);
 	snd_iprintf(buffer, "Current Sample Clock\t: %s\n",
 		    texts[mgr->cur_clock_type]);
 	snd_iprintf(buffer, "Current Sample Rate\t= %d\n",
@@ -1597,10 +1597,9 @@ static int pcxhr_probe(struct pci_dev *pci,
 	}
 	mgr->irq = pci->irq;
 
-	sprintf(mgr->shortname, "Digigram %s", card_name);
-	sprintf(mgr->longname, "%s at 0x%lx & 0x%lx, 0x%lx irq %i",
-		mgr->shortname,
-		mgr->port[0], mgr->port[1], mgr->port[2], mgr->irq);
+	snprintf(mgr->name, sizeof(mgr->name),
+		 "Digigram at 0x%lx & 0x%lx, 0x%lx irq %i",
+		 mgr->port[0], mgr->port[1], mgr->port[2], mgr->irq);
 
 	/* ISR lock  */
 	mutex_init(&mgr->lock);
@@ -1644,8 +1643,10 @@ static int pcxhr_probe(struct pci_dev *pci,
 		}
 
 		strcpy(card->driver, DRIVER_NAME);
-		sprintf(card->shortname, "%s [PCM #%d]", mgr->shortname, i);
-		sprintf(card->longname, "%s [PCM #%d]", mgr->longname, i);
+		snprintf(card->shortname, sizeof(card->shortname),
+			 "Digigram [PCM #%d]", i);
+		snprintf(card->longname, sizeof(card->longname),
+			 "%s [PCM #%d]", mgr->name, i);
 
 		if ((err = pcxhr_create(mgr, card, i)) < 0) {
 			snd_card_free(card);
diff --git a/sound/pci/pcxhr/pcxhr.h b/sound/pci/pcxhr/pcxhr.h
index 9e39e509a3ef..d799cbd37301 100644
--- a/sound/pci/pcxhr/pcxhr.h
+++ b/sound/pci/pcxhr/pcxhr.h
@@ -75,8 +75,7 @@ struct pcxhr_mgr {
 	unsigned long port[3];
 
 	/* share the name */
-	char shortname[32];		/* short name of this soundcard */
-	char longname[96];		/* name of this soundcard */
+	char name[40];			/* name of this soundcard */
 
 	struct pcxhr_rmh *prmh;
 
-- 
2.9.0
