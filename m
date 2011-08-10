From: Julia Lawall <julia@diku.dk>
Subject: [PATCH] sound/pci/azt3328.c: adjust error handling
	code to include debugging code
Date: Wed, 10 Aug 2011 11:49:04 +0200
Message-ID: <1312969744-29659-1-git-send-email-julia@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	by alsa0.perex.cz (Postfix) with ESMTP id 71C18245EE
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Aug 2011 11:49:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Mohr <andi@lisas.de>, Lucas De Marchi <lucas.demarchi@profusion.mobi>
List-Id: alsa-devel@alsa-project.org

From: Julia Lawall <julia@diku.dk>

snd_azf3328_dbgcallenter is called at the very beginning of the function,
so it could be useful to call snd_azf3328_dbgcallleave at all exit points.

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 sound/pci/azt3328.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/pci/azt3328.c b/sound/pci/azt3328.c
index e4d76a2..579fc0d 100644
--- a/sound/pci/azt3328.c
+++ b/sound/pci/azt3328.c
@@ -2625,16 +2625,19 @@ snd_azf3328_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 	int err;
 
 	snd_azf3328_dbgcallenter();
-	if (dev >= SNDRV_CARDS)
-		return -ENODEV;
+	if (dev >= SNDRV_CARDS) {
+		err = -ENODEV;
+		goto out;
+	}
 	if (!enable[dev]) {
 		dev++;
-		return -ENOENT;
+		err = -ENOENT;
+		goto out;
 	}
 
 	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
 	if (err < 0)
-		return err;
+		goto out;
 
 	strcpy(card->driver, "AZF3328");
 	strcpy(card->shortname, "Aztech AZF3328 (PCI168)");
