From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 14/20] ALSA: i2c/ak413x: Use SNDRV_DEV_CODEC
	for ak413x codec objects
Date: Wed, 12 Feb 2014 11:52:21 +0100
Message-ID: <1392202347-11774-15-git-send-email-tiwai@suse.de>
References: <1392202347-11774-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FCDF2651C7
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:52:48 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id DA42DAC88
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
 sound/i2c/other/ak4113.c | 2 +-
 sound/i2c/other/ak4114.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/i2c/other/ak4113.c b/sound/i2c/other/ak4113.c
index e04e750a77ed..1a3a6fa27158 100644
--- a/sound/i2c/other/ak4113.c
+++ b/sound/i2c/other/ak4113.c
@@ -98,7 +98,7 @@ int snd_ak4113_create(struct snd_card *card, ak4113_read_t *read,
 			AK4113_CINT | AK4113_STC);
 	chip->rcs1 = reg_read(chip, AK4113_REG_RCS1);
 	chip->rcs2 = reg_read(chip, AK4113_REG_RCS2);
-	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	err = snd_device_new(card, SNDRV_DEV_CODEC, chip, &ops);
 	if (err < 0)
 		goto __fail;
 
diff --git a/sound/i2c/other/ak4114.c b/sound/i2c/other/ak4114.c
index 15ae0250eace..c7f56339415d 100644
--- a/sound/i2c/other/ak4114.c
+++ b/sound/i2c/other/ak4114.c
@@ -111,7 +111,7 @@ int snd_ak4114_create(struct snd_card *card,
 	chip->rcs0 = reg_read(chip, AK4114_REG_RCS0) & ~(AK4114_QINT | AK4114_CINT);
 	chip->rcs1 = reg_read(chip, AK4114_REG_RCS1);
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0)
+	if ((err = snd_device_new(card, SNDRV_DEV_CODEC, chip, &ops)) < 0)
 		goto __fail;
 
 	if (r_ak4114)
-- 
1.8.5.2
