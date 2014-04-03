From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH 1/2] snd-ice1712: restore AK4xxx volumes on
	resume
Date: Thu,  3 Apr 2014 23:09:37 +0200
Message-ID: <1396559378-23980-1-git-send-email-linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-1.atlantis.sk (mail-1.atlantis.sk [80.94.52.57])
 by alsa0.perex.cz (Postfix) with ESMTP id A8E432656D8
 for <alsa-devel@alsa-project.org>; Thu,  3 Apr 2014 23:09:53 +0200 (CEST)
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

Also restore AK4xxx mixer volumes on resume for M-Audio ICE1712-based cards.
This fixes incorrect (sound working) zero mixer volumes after resume.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
---
 sound/pci/ice1712/delta.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/pci/ice1712/delta.c b/sound/pci/ice1712/delta.c
index 3764a27..bb34608 100644
--- a/sound/pci/ice1712/delta.c
+++ b/sound/pci/ice1712/delta.c
@@ -578,7 +578,8 @@ static struct snd_ak4xxx_private akm_vx442_priv = {
 #ifdef CONFIG_PM_SLEEP
 static int snd_ice1712_delta_resume(struct snd_ice1712 *ice)
 {
-	unsigned char akm_backup[AK4XXX_IMAGE_SIZE];
+	unsigned char akm_img_bak[AK4XXX_IMAGE_SIZE];
+	unsigned char akm_vol_bak[AK4XXX_IMAGE_SIZE];
 
 	/* init spdif */
 	switch (ice->eeprom.subvendor) {
@@ -603,9 +604,11 @@ static int snd_ice1712_delta_resume(struct snd_ice1712 *ice)
 
 	/* init codec and restore registers */
 	if (ice->akm_codecs) {
-		memcpy(akm_backup, ice->akm->images, sizeof(akm_backup));
+		memcpy(akm_img_bak, ice->akm->images, sizeof(akm_img_bak));
+		memcpy(akm_vol_bak, ice->akm->volumes, sizeof(akm_vol_bak));
 		snd_akm4xxx_init(ice->akm);
-		memcpy(ice->akm->images, akm_backup, sizeof(akm_backup));
+		memcpy(ice->akm->images, akm_img_bak, sizeof(akm_img_bak));
+		memcpy(ice->akm->volumes, akm_vol_bak, sizeof(akm_vol_bak));
 		snd_akm4xxx_reset(ice->akm, 0);
 	}
 
-- 
Ondrej Zary
