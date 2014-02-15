From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/3] ALSA: hda - Remove dependency on bus->pci
	in hda_beep.c
Date: Sat, 15 Feb 2014 10:17:33 +0100
Message-ID: <1392455855-10594-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 556872615F3
 for <alsa-devel@alsa-project.org>; Sat, 15 Feb 2014 10:17:36 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D3668ABB2
 for <alsa-devel@alsa-project.org>; Sat, 15 Feb 2014 09:17:35 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The default parent device can be obtained directly via card object, so
we don't need to rely on pci->dev.parent.  Since there is no access to
pci_dev, we can reduce the inclusion of linux/pci.h, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_beep.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_beep.c b/sound/pci/hda/hda_beep.c
index 0589b39cda6e..d8c437a94559 100644
--- a/sound/pci/hda/hda_beep.c
+++ b/sound/pci/hda/hda_beep.c
@@ -20,7 +20,6 @@
  */
 
 #include <linux/input.h>
-#include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 #include <linux/export.h>
@@ -167,7 +166,7 @@ static int snd_hda_do_attach(struct hda_beep *beep)
 	input_dev->evbit[0] = BIT_MASK(EV_SND);
 	input_dev->sndbit[0] = BIT_MASK(SND_BELL) | BIT_MASK(SND_TONE);
 	input_dev->event = snd_hda_beep_event;
-	input_dev->dev.parent = &codec->bus->pci->dev;
+	input_dev->dev.parent = codec->bus->card->dev;
 	input_set_drvdata(input_dev, beep);
 
 	err = input_register_device(input_dev);
-- 
1.8.5.2
