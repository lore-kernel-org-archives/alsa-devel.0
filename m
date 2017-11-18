From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] ALSA: vx222: Adjust ten function calls
 together with a variable assignment
Date: Sat, 18 Nov 2017 21:39:51 +0100
Message-ID: <76f53fb4-b7c4-ccd9-58c8-ad478bb3a9b0@users.sourceforge.net>
References: <e961ecef-9f03-0c2a-ad64-64102bbc1389@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by alsa0.perex.cz (Postfix) with ESMTP id C3BE4266EFA
 for <alsa-devel@alsa-project.org>; Sat, 18 Nov 2017 21:39:58 +0100 (CET)
In-Reply-To: <e961ecef-9f03-0c2a-ad64-64102bbc1389@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 18 Nov 2017 21:10:37 +0100

The script "checkpatch.pl" pointed information out like the following.

ERROR: do not use assignment in if condition

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/vx222/vx222.c     | 19 +++++++++++++------
 sound/pci/vx222/vx222_ops.c | 19 +++++++++++--------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/sound/pci/vx222/vx222.c b/sound/pci/vx222/vx222.c
index 55861849d7df..1f866a810a98 100644
--- a/sound/pci/vx222/vx222.c
+++ b/sound/pci/vx222/vx222.c
@@ -147,7 +147,8 @@ static int snd_vx222_create(struct snd_card *card, struct pci_dev *pci,
 	struct snd_vx_ops *vx_ops;
 
 	/* enable PCI device */
-	if ((err = pci_enable_device(pci)) < 0)
+	err = pci_enable_device(pci);
+	if (err < 0)
 		return err;
 	pci_set_master(pci);
 
@@ -161,7 +162,8 @@ static int snd_vx222_create(struct snd_card *card, struct pci_dev *pci,
 	vx = to_vx222(chip);
 	vx->pci = pci;
 
-	if ((err = pci_request_regions(pci, CARD_NAME)) < 0) {
+	err = pci_request_regions(pci, CARD_NAME);
+	if (err < 0) {
 		snd_vx222_free(chip);
 		return err;
 	}
@@ -177,7 +179,8 @@ static int snd_vx222_create(struct snd_card *card, struct pci_dev *pci,
 	}
 	chip->irq = pci->irq;
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	if (err < 0) {
 		snd_vx222_free(chip);
 		return err;
 	}
@@ -220,7 +223,9 @@ static int snd_vx222_probe(struct pci_dev *pci,
 			hw = &vx222_v2_hw;
 		break;
 	}
-	if ((err = snd_vx222_create(card, pci, hw, &vx)) < 0) {
+
+	err = snd_vx222_create(card, pci, hw, &vx);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
@@ -236,12 +241,14 @@ static int snd_vx222_probe(struct pci_dev *pci,
 	vx->core.dev = &pci->dev;
 #endif
 
-	if ((err = snd_vx_setup_firmware(&vx->core)) < 0) {
+	err = snd_vx_setup_firmware(&vx->core);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
 
-	if ((err = snd_card_register(card)) < 0) {
+	err = snd_card_register(card);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
diff --git a/sound/pci/vx222/vx222_ops.c b/sound/pci/vx222/vx222_ops.c
index d4298af6d3ee..4447d7f57dee 100644
--- a/sound/pci/vx222/vx222_ops.c
+++ b/sound/pci/vx222/vx222_ops.c
@@ -421,11 +421,12 @@ static int vx2_load_dsp(struct vx_core *vx, int index, const struct firmware *ds
 	switch (index) {
 	case 1:
 		/* xilinx image */
-		if ((err = vx2_load_xilinx_binary(vx, dsp)) < 0)
+		err = vx2_load_xilinx_binary(vx, dsp);
+		if (err < 0)
 			return err;
-		if ((err = vx2_test_xilinx(vx)) < 0)
-			return err;
-		return 0;
+
+		err = vx2_test_xilinx(vx);
+		return (err < 0) ? err : 0;
 	case 2:
 		/* DSP boot */
 		return snd_vx_dsp_boot(vx, dsp);
@@ -985,12 +986,14 @@ static int vx2_add_mic_controls(struct vx_core *_chip)
 	vx2_set_input_level(chip);
 
 	/* controls */
-	if ((err = snd_ctl_add(_chip->card, snd_ctl_new1(&vx_control_input_level, chip))) < 0)
-		return err;
-	if ((err = snd_ctl_add(_chip->card, snd_ctl_new1(&vx_control_mic_level, chip))) < 0)
+	err = snd_ctl_add(_chip->card,
+			  snd_ctl_new1(&vx_control_input_level, chip));
+	if (err < 0)
 		return err;
 
-	return 0;
+	err = snd_ctl_add(_chip->card,
+			  snd_ctl_new1(&vx_control_mic_level, chip));
+	return (err < 0) ? err : 0;
 }
 
 
-- 
2.15.0
