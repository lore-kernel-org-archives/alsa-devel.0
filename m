From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/4] ALSA: ak4114: Move EXPORT_SYMBOL() after
	each function
Date: Fri, 16 Jan 2015 18:16:41 +0100
Message-ID: <1421428603-6739-3-git-send-email-tiwai@suse.de>
References: <1421428603-6739-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F00C9260415
 for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2015 18:16:46 +0100 (CET)
In-Reply-To: <1421428603-6739-1-git-send-email-tiwai@suse.de>
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
Cc: Pavel Hofman <pavel.hofman@ivitera.com>
List-Id: alsa-devel@alsa-project.org

... just to follow the standard coding style.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/i2c/other/ak4114.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/i2c/other/ak4114.c b/sound/i2c/other/ak4114.c
index b70e6eccbd03..f6ee1e7a9bbd 100644
--- a/sound/i2c/other/ak4114.c
+++ b/sound/i2c/other/ak4114.c
@@ -122,6 +122,7 @@ int snd_ak4114_create(struct snd_card *card,
 	snd_ak4114_free(chip);
 	return err < 0 ? err : -EIO;
 }
+EXPORT_SYMBOL(snd_ak4114_create);
 
 void snd_ak4114_reg_write(struct ak4114 *chip, unsigned char reg, unsigned char mask, unsigned char val)
 {
@@ -131,6 +132,7 @@ void snd_ak4114_reg_write(struct ak4114 *chip, unsigned char reg, unsigned char
 		reg_write(chip, reg,
 			  (chip->txcsb[reg-AK4114_REG_TXCSB0] & ~mask) | val);
 }
+EXPORT_SYMBOL(snd_ak4114_reg_write);
 
 static void ak4114_init_regs(struct ak4114 *chip)
 {
@@ -159,6 +161,7 @@ void snd_ak4114_reinit(struct ak4114 *chip)
 	if (atomic_dec_and_test(&chip->wq_processing))
 		schedule_delayed_work(&chip->work, HZ / 10);
 }
+EXPORT_SYMBOL(snd_ak4114_reinit);
 
 static unsigned int external_rate(unsigned char rcs1)
 {
@@ -503,6 +506,7 @@ int snd_ak4114_build(struct ak4114 *ak4114,
 	schedule_delayed_work(&ak4114->work, HZ / 10);
 	return 0;
 }
+EXPORT_SYMBOL(snd_ak4114_build);
 
 /* notify kcontrols if any parameters are changed */
 static void ak4114_notify(struct ak4114 *ak4114,
@@ -558,6 +562,7 @@ int snd_ak4114_external_rate(struct ak4114 *ak4114)
 	rcs1 = reg_read(ak4114, AK4114_REG_RCS1);
 	return external_rate(rcs1);
 }
+EXPORT_SYMBOL(snd_ak4114_external_rate);
 
 int snd_ak4114_check_rate_and_errors(struct ak4114 *ak4114, unsigned int flags)
 {
@@ -605,6 +610,7 @@ int snd_ak4114_check_rate_and_errors(struct ak4114 *ak4114, unsigned int flags)
 	}
 	return res;
 }
+EXPORT_SYMBOL(snd_ak4114_check_rate_and_errors);
 
 static void ak4114_stats(struct work_struct *work)
 {
@@ -615,10 +621,3 @@ static void ak4114_stats(struct work_struct *work)
 	if (atomic_dec_and_test(&chip->wq_processing))
 		schedule_delayed_work(&chip->work, HZ / 10);
 }
-
-EXPORT_SYMBOL(snd_ak4114_create);
-EXPORT_SYMBOL(snd_ak4114_reg_write);
-EXPORT_SYMBOL(snd_ak4114_reinit);
-EXPORT_SYMBOL(snd_ak4114_build);
-EXPORT_SYMBOL(snd_ak4114_external_rate);
-EXPORT_SYMBOL(snd_ak4114_check_rate_and_errors);
-- 
2.2.1
