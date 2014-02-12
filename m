From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 05/20] ALSA: drivers: Use SNDRV_DEV_CARD for
	card objects
Date: Wed, 12 Feb 2014 11:52:12 +0100
Message-ID: <1392202347-11774-6-git-send-email-tiwai@suse.de>
References: <1392202347-11774-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0251C2651B8
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:52:48 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C4086ABFB
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 10:52:47 +0000 (UTC)
In-Reply-To: <1392202347-11774-1-git-send-email-tiwai@suse.de>
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

... instead of SNDRV_DEV_LOWLEVEL.
No functional change at this point.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/ml403-ac97cr.c  | 2 +-
 sound/drivers/pcsp/pcsp.c     | 2 +-
 sound/drivers/serial-u16550.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/drivers/ml403-ac97cr.c b/sound/drivers/ml403-ac97cr.c
index 33ed76530d0b..8868910e8ddf 100644
--- a/sound/drivers/ml403-ac97cr.c
+++ b/sound/drivers/ml403-ac97cr.c
@@ -1185,7 +1185,7 @@ snd_ml403_ac97cr_create(struct snd_card *card, struct platform_device *pfdev,
 		return err;
 	}
 
-	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, ml403_ac97cr, &ops);
+	err = snd_device_new(card, SNDRV_DEV_CARD, ml403_ac97cr, &ops);
 	if (err < 0) {
 		PDEBUG(INIT_FAILURE, "probe(): snd_device_new() failed!\n");
 		snd_ml403_ac97cr_free(ml403_ac97cr);
diff --git a/sound/drivers/pcsp/pcsp.c b/sound/drivers/pcsp/pcsp.c
index 36808cdab06f..c4493f4e63da 100644
--- a/sound/drivers/pcsp/pcsp.c
+++ b/sound/drivers/pcsp/pcsp.c
@@ -87,7 +87,7 @@ static int snd_pcsp_create(struct snd_card *card)
 	pcsp_chip.dma = -1;
 
 	/* Register device */
-	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, &pcsp_chip, &ops);
+	err = snd_device_new(card, SNDRV_DEV_CARD, &pcsp_chip, &ops);
 	if (err < 0)
 		return err;
 
diff --git a/sound/drivers/serial-u16550.c b/sound/drivers/serial-u16550.c
index 9ad4414fa25c..b2822409ce12 100644
--- a/sound/drivers/serial-u16550.c
+++ b/sound/drivers/serial-u16550.c
@@ -836,7 +836,7 @@ static int snd_uart16550_create(struct snd_card *card,
 	uart->timer_running = 0;
 
 	/* Register device */
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, uart, &ops)) < 0) {
+	if ((err = snd_device_new(card, SNDRV_DEV_CARD, uart, &ops)) < 0) {
 		snd_uart16550_free(uart);
 		return err;
 	}
-- 
1.8.5.2
