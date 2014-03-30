From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH 2/2] snd-ice1712: Add suspend support for
	M-Audio ICE1712-based cards
Date: Sun, 30 Mar 2014 23:37:31 +0200
Message-ID: <1396215451-24128-2-git-send-email-linux@rainbow-software.org>
References: <1396215451-24128-1-git-send-email-linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-1.atlantis.sk (mail-1.atlantis.sk [80.94.52.57])
 by alsa0.perex.cz (Postfix) with ESMTP id EBC442650BA
 for <alsa-devel@alsa-project.org>; Sun, 30 Mar 2014 23:37:56 +0200 (CEST)
In-Reply-To: <1396215451-24128-1-git-send-email-linux@rainbow-software.org>
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

Add suspend support for M-Audio cards based on ICE1712 chip.
Tested with M-Audio Audiophile 24/96. S/PDIF will probably not work.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
---
 sound/pci/ice1712/delta.c |   30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/sound/pci/ice1712/delta.c b/sound/pci/ice1712/delta.c
index 9e28cc1..c19ae72 100644
--- a/sound/pci/ice1712/delta.c
+++ b/sound/pci/ice1712/delta.c
@@ -575,6 +575,30 @@ static struct snd_ak4xxx_private akm_vx442_priv = {
 	.mask_flags = 0,
 };
 
+#ifdef CONFIG_PM_SLEEP
+static int snd_ice1712_delta_resume(struct snd_ice1712 *ice)
+{
+	unsigned char akm_backup[AK4XXX_IMAGE_SIZE];
+	/* init codec and restore registers */
+	if (ice->akm_codecs) {
+		memcpy(akm_backup, ice->akm->images, sizeof(akm_backup));
+		snd_akm4xxx_init(ice->akm);
+		memcpy(ice->akm->images, akm_backup, sizeof(akm_backup));
+		snd_akm4xxx_reset(ice->akm, 0);
+	}
+
+	return 0;
+}
+
+static int snd_ice1712_delta_suspend(struct snd_ice1712 *ice)
+{
+	if (ice->akm_codecs) /* reset & mute codec */
+		snd_akm4xxx_reset(ice->akm, 1);
+
+	return 0;
+}
+#endif
+
 static int snd_ice1712_delta_init(struct snd_ice1712 *ice)
 {
 	int err;
@@ -621,7 +645,11 @@ static int snd_ice1712_delta_init(struct snd_ice1712 *ice)
 		ice->num_total_adcs = 4;
 		break;
 	}
-
+#ifdef CONFIG_PM_SLEEP
+	ice->pm_resume = snd_ice1712_delta_resume;
+	ice->pm_suspend = snd_ice1712_delta_suspend;
+	ice->pm_suspend_enabled = 1;
+#endif
 	/* initialize the SPI clock to high */
 	tmp = snd_ice1712_read(ice, ICE1712_IREG_GPIO_DATA);
 	tmp |= ICE1712_DELTA_AP_CCLK;
-- 
Ondrej Zary
