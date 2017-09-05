From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] ALSA: rme9652: Use common error handling
 code in snd_hdspm_probe()
Date: Tue, 5 Sep 2017 22:38:16 +0200
Message-ID: <684da935-9423-70bd-2dca-32bea89cae92@users.sourceforge.net>
References: <9832906e-3b04-b708-2c26-4755e0beb811@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DE3E267342
 for <alsa-devel@alsa-project.org>; Tue,  5 Sep 2017 22:38:24 +0200 (CEST)
In-Reply-To: <9832906e-3b04-b708-2c26-4755e0beb811@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 5 Sep 2017 22:22:21 +0200

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/rme9652/hdspm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 25284d8d9758..f20d42714e4d 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -6949,10 +6949,8 @@ static int snd_hdspm_probe(struct pci_dev *pci,
 	hdspm->pci = pci;
 
 	err = snd_hdspm_create(card, hdspm);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 
 	if (hdspm->io_type != MADIface) {
 		snprintf(card->shortname, sizeof(card->shortname), "%s_%x",
@@ -6970,15 +6968,17 @@ static int snd_hdspm_probe(struct pci_dev *pci,
 	}
 
 	err = snd_card_register(card);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 
 	pci_set_drvdata(pci, card);
 
 	dev++;
 	return 0;
+
+free_card:
+	snd_card_free(card);
+	return err;
 }
 
 static void snd_hdspm_remove(struct pci_dev *pci)
-- 
2.14.1
