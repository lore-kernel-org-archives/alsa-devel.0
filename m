From: Dirk Opfer <Dirk@Opfer-Online.de>
Subject: [Patch] Fix compiler warnings in PXA2XX-AC97
Date: Sun, 07 Aug 2005 16:37:53 +0200
Message-ID: <0MKwtQ-1E1mHi2L9x-00028d@mrelayeu.kundenserver.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020000070001070006090309"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020000070001070006090309
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

This patch fixes compiler warnings in the file pxa2xx-ac97.c.

Changes:

    -  change pxa2xx_ac97_do_suspend and pxa2xx_ac97_do_resume to use
the expected arguments


Signed-off-by: Dirk Opfer <dirk <at> do13.de>

Dirk

--------------020000070001070006090309
Content-Type: text/plain;
 name="fix-warning-pxa2xx-ac97.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-warning-pxa2xx-ac97.diff"

--- orig.sound/arm/pxa2xx-ac97.c	2005-08-05 21:55:21.000000000 +0200
+++ sound/arm/pxa2xx-ac97.c	2005-08-06 14:46:27.713915616 +0200
-static int pxa2xx_ac97_do_suspend(snd_card_t *card, unsigned int state)
+static int pxa2xx_ac97_do_suspend(snd_card_t *card, pm_message_t state)
 {
 	if (card->power_state != SNDRV_CTL_POWER_D3cold) {
 		pxa2xx_audio_ops_t *platform_ops = card->dev->platform_data;
@@ -261,7 +261,7 @@
 	return 0;
 }
 
-static int pxa2xx_ac97_do_resume(snd_card_t *card, unsigned int state)
+static int pxa2xx_ac97_do_resume(snd_card_t *card)
 {
 	if (card->power_state != SNDRV_CTL_POWER_D0) {
 		pxa2xx_audio_ops_t *platform_ops = card->dev->platform_data;
@@ -275,13 +275,13 @@
 	return 0;
 }
 
-static int pxa2xx_ac97_suspend(struct device *_dev, u32 state, u32 level)
+static int pxa2xx_ac97_suspend(struct device *_dev, pm_message_t state, u32 level)
 {
 	snd_card_t *card = dev_get_drvdata(_dev);
 	int ret = 0;
 
 	if (card && level == SUSPEND_DISABLE)
-		ret = pxa2xx_ac97_do_suspend(card, SNDRV_CTL_POWER_D3cold);
+		ret = pxa2xx_ac97_do_suspend(card, PMSG_SUSPEND);
 
 	return ret;
 }
@@ -292,7 +292,7 @@
 	int ret = 0;
 
 	if (card && level == RESUME_ENABLE)
-		ret = pxa2xx_ac97_do_resume(card, SNDRV_CTL_POWER_D0);
+		ret = pxa2xx_ac97_do_resume(card);
 
 	return ret;
 }

--------------020000070001070006090309--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
