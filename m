From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH 2/2] snd-ice1712: Add S/PDIF suspend support
	for ICE1712-based M-Audio cards
Date: Wed,  2 Apr 2014 22:35:33 +0200
Message-ID: <1396470933-2618-2-git-send-email-linux@rainbow-software.org>
References: <1396470933-2618-1-git-send-email-linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-1.atlantis.sk (mail-1.atlantis.sk [80.94.52.57])
 by alsa0.perex.cz (Postfix) with ESMTP id 17A5926555D
 for <alsa-devel@alsa-project.org>; Wed,  2 Apr 2014 22:35:44 +0200 (CEST)
In-Reply-To: <1396470933-2618-1-git-send-email-linux@rainbow-software.org>
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

Add S/PDIF suspend support for M-Audio cards based on ICE1712 chip.
Tested (playback only) on Audiophile 24/96. Capture will probably not work.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
---
 sound/pci/ice1712/delta.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/sound/pci/ice1712/delta.c b/sound/pci/ice1712/delta.c
index c19ae72..3764a27 100644
--- a/sound/pci/ice1712/delta.c
+++ b/sound/pci/ice1712/delta.c
@@ -579,6 +579,28 @@ static struct snd_ak4xxx_private akm_vx442_priv = {
 static int snd_ice1712_delta_resume(struct snd_ice1712 *ice)
 {
 	unsigned char akm_backup[AK4XXX_IMAGE_SIZE];
+
+	/* init spdif */
+	switch (ice->eeprom.subvendor) {
+	case ICE1712_SUBDEVICE_AUDIOPHILE:
+	case ICE1712_SUBDEVICE_DELTA410:
+	case ICE1712_SUBDEVICE_DELTA1010E:
+	case ICE1712_SUBDEVICE_DELTA1010LT:
+	case ICE1712_SUBDEVICE_VX442:
+	case ICE1712_SUBDEVICE_DELTA66E:
+		snd_cs8427_init(ice->i2c, ice->cs8427);
+		break;
+	case ICE1712_SUBDEVICE_DELTA1010:
+	case ICE1712_SUBDEVICE_MEDIASTATION:
+		/* nothing */
+		break;
+	case ICE1712_SUBDEVICE_DELTADIO2496:
+	case ICE1712_SUBDEVICE_DELTA66:
+		/* Set spdif defaults */
+		snd_ice1712_delta_cs8403_spdif_write(ice, ice->spdif.cs8403_bits);
+		break;
+	}
+
 	/* init codec and restore registers */
 	if (ice->akm_codecs) {
 		memcpy(akm_backup, ice->akm->images, sizeof(akm_backup));
-- 
Ondrej Zary
