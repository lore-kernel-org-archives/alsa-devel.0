From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 6/7] ALSA: rme9652: fix format overflow
	warnings
Date: Tue, 18 Jul 2017 13:48:09 +0200
Message-ID: <20170718114820.3681255-6-arnd@arndb.de>
References: <20170718114820.3681255-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EDF626717C
 for <alsa-devel@alsa-project.org>; Tue, 18 Jul 2017 13:51:14 +0200 (CEST)
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
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, Colin Ian King <colin.king@canonical.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

gcc-7 warns about a possible sprintf format string overflow with a
temporary buffer that is used to print from another buffer of the same
size:

sound/pci/rme9652/hdspm.c: In function 'snd_hdspm_create_alsa_devices':
sound/pci/rme9652/hdspm.c:2123:17: error: ' MIDIoverMADI' directive writing 13 bytes into a region of size between 1 and 32 [-Werror=format-overflow=]

This extends the temporary buffer to twice the size, and changes
the code to use the safer snprintf() across the entire file.
The longer buffer is still necessary to avoid a format-truncation
warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/pci/rme9652/hdspm.c | 48 +++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 254c3d040118..2a3a916e5d15 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -2061,7 +2061,7 @@ static int snd_hdspm_create_midi(struct snd_card *card,
 				 struct hdspm *hdspm, int id)
 {
 	int err;
-	char buf[32];
+	char buf[64];
 
 	hdspm->midi[id].id = id;
 	hdspm->midi[id].hdspm = hdspm;
@@ -2120,19 +2120,23 @@ static int snd_hdspm_create_midi(struct snd_card *card,
 	if ((id < 2) || ((2 == id) && ((MADI == hdspm->io_type) ||
 					(MADIface == hdspm->io_type)))) {
 		if ((id == 0) && (MADIface == hdspm->io_type)) {
-			sprintf(buf, "%s MIDIoverMADI", card->shortname);
+			snprintf(buf, sizeof(buf), "%s MIDIoverMADI",
+				 card->shortname);
 		} else if ((id == 2) && (MADI == hdspm->io_type)) {
-			sprintf(buf, "%s MIDIoverMADI", card->shortname);
+			snprintf(buf, sizeof(buf), "%s MIDIoverMADI",
+				 card->shortname);
 		} else {
-			sprintf(buf, "%s MIDI %d", card->shortname, id+1);
+			snprintf(buf, sizeof(buf), "%s MIDI %d",
+				 card->shortname, id+1);
 		}
 		err = snd_rawmidi_new(card, buf, id, 1, 1,
 				&hdspm->midi[id].rmidi);
 		if (err < 0)
 			return err;
 
-		sprintf(hdspm->midi[id].rmidi->name, "%s MIDI %d",
-				card->id, id+1);
+		snprintf(hdspm->midi[id].rmidi->name,
+			 sizeof(hdspm->midi[id].rmidi->name),
+			 "%s MIDI %d", card->id, id+1);
 		hdspm->midi[id].rmidi->private_data = &hdspm->midi[id];
 
 		snd_rawmidi_set_ops(hdspm->midi[id].rmidi,
@@ -2148,14 +2152,16 @@ static int snd_hdspm_create_midi(struct snd_card *card,
 			SNDRV_RAWMIDI_INFO_DUPLEX;
 	} else {
 		/* TCO MTC, read only */
-		sprintf(buf, "%s MTC %d", card->shortname, id+1);
+		snprintf(buf, sizeof(buf), "%s MTC %d",
+			 card->shortname, id+1);
 		err = snd_rawmidi_new(card, buf, id, 1, 1,
 				&hdspm->midi[id].rmidi);
 		if (err < 0)
 			return err;
 
-		sprintf(hdspm->midi[id].rmidi->name,
-				"%s MTC %d", card->id, id+1);
+		snprintf(hdspm->midi[id].rmidi->name,
+			 sizeof(hdspm->midi[id].rmidi->name),
+			 "%s MTC %d", card->id, id+1);
 		hdspm->midi[id].rmidi->private_data = &hdspm->midi[id];
 
 		snd_rawmidi_set_ops(hdspm->midi[id].rmidi,
@@ -6869,7 +6875,8 @@ static int snd_hdspm_create(struct snd_card *card,
 		 * when running with multiple cards.
 		 */
 		if (NULL == id[hdspm->dev] && hdspm->serial != 0xFFFFFF) {
-			sprintf(card->id, "HDSPMx%06x", hdspm->serial);
+			snprintf(card->id, sizeof(card->id),
+				 "HDSPMx%06x", hdspm->serial);
 			snd_card_set_id(card, card->id);
 		}
 	}
@@ -6954,17 +6961,18 @@ static int snd_hdspm_probe(struct pci_dev *pci,
 	}
 
 	if (hdspm->io_type != MADIface) {
-		sprintf(card->shortname, "%s_%x",
-			hdspm->card_name,
-			hdspm->serial);
-		sprintf(card->longname, "%s S/N 0x%x at 0x%lx, irq %d",
-			hdspm->card_name,
-			hdspm->serial,
-			hdspm->port, hdspm->irq);
+		snprintf(card->shortname, sizeof(card->shortname), "%s_%x",
+			hdspm->card_name, hdspm->serial);
+		snprintf(card->longname, sizeof(card->longname),
+			 "%s S/N 0x%x at 0x%lx, irq %d",
+			 hdspm->card_name, hdspm->serial,
+			 hdspm->port, hdspm->irq);
 	} else {
-		sprintf(card->shortname, "%s", hdspm->card_name);
-		sprintf(card->longname, "%s at 0x%lx, irq %d",
-				hdspm->card_name, hdspm->port, hdspm->irq);
+		snprintf(card->shortname, sizeof(card->shortname), "%s",
+			 hdspm->card_name);
+		snprintf(card->longname, sizeof(card->longname),
+			 "%s at 0x%lx, irq %d",
+			 hdspm->card_name, hdspm->port, hdspm->irq);
 	}
 
 	err = snd_card_register(card);
-- 
2.9.0
