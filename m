From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 07/20] ALSA: parisc/harmony: remove __dev* attributes
Date: Thu,  6 Dec 2012 12:35:16 -0500
Message-ID: <1354815329-20221-8-git-send-email-wfp5p@virginia.edu>
References: <1354815329-20221-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1354815329-20221-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-parisc-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, perex@perex.cz, gregkh@linuxfoundation.org, linux-parisc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

CONFIG_HOTPLUG is going away as an option.  As result the __dev*
markings will be going away.

Remove use of __devinit, __devexit_p, __devinitdata, __devinitconst,
and __devexit.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: linux-parisc@vger.kernel.org
---
 sound/parisc/harmony.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/parisc/harmony.c b/sound/parisc/harmony.c
index f47f9e2..0e66ba4 100644
--- a/sound/parisc/harmony.c
+++ b/sound/parisc/harmony.c
@@ -856,7 +856,7 @@ static struct snd_kcontrol_new snd_harmony_controls[] = {
 		       HARMONY_GAIN_HE_SHIFT, 1, 0),
 };
 
-static void __devinit
+static void
 snd_harmony_mixer_reset(struct snd_harmony *h)
 {
 	harmony_mute(h);
@@ -865,7 +865,7 @@ snd_harmony_mixer_reset(struct snd_harmony *h)
 	harmony_unmute(h);
 }
 
-static int __devinit
+static int
 snd_harmony_mixer_init(struct snd_harmony *h)
 {
 	struct snd_card *card;
@@ -915,7 +915,7 @@ snd_harmony_dev_free(struct snd_device *dev)
 	return snd_harmony_free(h);
 }
 
-static int __devinit
+static int
 snd_harmony_create(struct snd_card *card, 
 		   struct parisc_device *padev, 
 		   struct snd_harmony **rchip)
@@ -972,7 +972,7 @@ free_and_ret:
 	return err;
 }
 
-static int __devinit
+static int
 snd_harmony_probe(struct parisc_device *padev)
 {
 	int err;
@@ -1012,7 +1012,7 @@ free_and_ret:
 	return err;
 }
 
-static int __devexit
+static int
 snd_harmony_remove(struct parisc_device *padev)
 {
 	snd_card_free(parisc_get_drvdata(padev));
@@ -1024,7 +1024,7 @@ static struct parisc_driver snd_harmony_driver = {
 	.name = "harmony",
 	.id_table = snd_harmony_devtable,
 	.probe = snd_harmony_probe,
-	.remove = __devexit_p(snd_harmony_remove),
+	.remove = snd_harmony_remove,
 };
 
 static int __init 
-- 
1.8.0.1

