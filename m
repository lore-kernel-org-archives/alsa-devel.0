From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 07/18] ALSA: ak4117: Use setup_timer() and
	mod_timer()
Date: Mon, 19 Jan 2015 12:11:20 +0100
Message-ID: <1421665891-14475-8-git-send-email-tiwai@suse.de>
References: <1421665891-14475-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 40E2F2606E0
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 12:11:37 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id DA9ACAD4C
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 11:11:35 +0000 (UTC)
In-Reply-To: <1421665891-14475-1-git-send-email-tiwai@suse.de>
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

No functional change, refactoring with the standard helpers.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/i2c/other/ak4117.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/i2c/other/ak4117.c b/sound/i2c/other/ak4117.c
index 88452e899bd9..48848909a5a9 100644
--- a/sound/i2c/other/ak4117.c
+++ b/sound/i2c/other/ak4117.c
@@ -91,9 +91,7 @@ int snd_ak4117_create(struct snd_card *card, ak4117_read_t *read, ak4117_write_t
 	chip->read = read;
 	chip->write = write;
 	chip->private_data = private_data;
-	init_timer(&chip->timer);
-	chip->timer.data = (unsigned long)chip;
-	chip->timer.function = snd_ak4117_timer;
+	setup_timer(&chip->timer, snd_ak4117_timer, (unsigned long)chip);
 
 	for (reg = 0; reg < 5; reg++)
 		chip->regmap[reg] = pgm[reg];
@@ -139,8 +137,7 @@ void snd_ak4117_reinit(struct ak4117 *chip)
 	/* release powerdown, everything is initialized now */
 	reg_write(chip, AK4117_REG_PWRDN, old | AK4117_RST | AK4117_PWN);
 	chip->init = 0;
-	chip->timer.expires = 1 + jiffies;
-	add_timer(&chip->timer);
+	mod_timer(&chip->timer, 1 + jiffies);
 }
 
 static unsigned int external_rate(unsigned char rcs1)
@@ -540,8 +537,7 @@ static void snd_ak4117_timer(unsigned long data)
 	if (chip->init)
 		return;
 	snd_ak4117_check_rate_and_errors(chip, 0);
-	chip->timer.expires = 1 + jiffies;
-	add_timer(&chip->timer);
+	mod_timer(&chip->timer, 1 + jiffies);
 }
 
 EXPORT_SYMBOL(snd_ak4117_create);
-- 
2.2.1
