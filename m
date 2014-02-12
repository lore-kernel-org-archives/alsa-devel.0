From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 16/24] ALSA: sparc: Convert to snd_card_new()
	with a device pointer
Date: Wed, 12 Feb 2014 11:35:32 +0100
Message-ID: <1392201340-27113-17-git-send-email-tiwai@suse.de>
References: <1392201340-27113-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0289C265020
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:35:51 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 8C35FAC8F
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 10:35:50 +0000 (UTC)
In-Reply-To: <1392201340-27113-1-git-send-email-tiwai@suse.de>
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

Also remove superfluous snd_card_set_dev() calls.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/sparc/amd7930.c | 4 ++--
 sound/sparc/cs4231.c  | 9 +++++----
 sound/sparc/dbri.c    | 4 ++--
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/sound/sparc/amd7930.c b/sound/sparc/amd7930.c
index 174d21fb56e2..4a85e1433472 100644
--- a/sound/sparc/amd7930.c
+++ b/sound/sparc/amd7930.c
@@ -1019,8 +1019,8 @@ static int amd7930_sbus_probe(struct platform_device *op)
 		return -ENOENT;
 	}
 
-	err = snd_card_create(index[dev_num], id[dev_num], THIS_MODULE, 0,
-			      &card);
+	err = snd_card_new(&op->dev, index[dev_num], id[dev_num],
+			   THIS_MODULE, 0, &card);
 	if (err < 0)
 		return err;
 
diff --git a/sound/sparc/cs4231.c b/sound/sparc/cs4231.c
index dbb1b625eb2f..dabc1ad331e2 100644
--- a/sound/sparc/cs4231.c
+++ b/sound/sparc/cs4231.c
@@ -1565,7 +1565,8 @@ static int snd_cs4231_mixer(struct snd_card *card)
 
 static int dev;
 
-static int cs4231_attach_begin(struct snd_card **rcard)
+static int cs4231_attach_begin(struct platform_device *op,
+			       struct snd_card **rcard)
 {
 	struct snd_card *card;
 	struct snd_cs4231 *chip;
@@ -1581,8 +1582,8 @@ static int cs4231_attach_begin(struct snd_card **rcard)
 		return -ENOENT;
 	}
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE,
-			      sizeof(struct snd_cs4231), &card);
+	err = snd_card_new(&op->dev, index[dev], id[dev], THIS_MODULE,
+			   sizeof(struct snd_cs4231), &card);
 	if (err < 0)
 		return err;
 
@@ -1869,7 +1870,7 @@ static int cs4231_sbus_probe(struct platform_device *op)
 	struct snd_card *card;
 	int err;
 
-	err = cs4231_attach_begin(&card);
+	err = cs4231_attach_begin(op, &card);
 	if (err)
 		return err;
 
diff --git a/sound/sparc/dbri.c b/sound/sparc/dbri.c
index eee7afcae375..be1b1aa96b7e 100644
--- a/sound/sparc/dbri.c
+++ b/sound/sparc/dbri.c
@@ -2615,8 +2615,8 @@ static int dbri_probe(struct platform_device *op)
 		return -ENODEV;
 	}
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE,
-			      sizeof(struct snd_dbri), &card);
+	err = snd_card_new(&op->dev, index[dev], id[dev], THIS_MODULE,
+			   sizeof(struct snd_dbri), &card);
 	if (err < 0)
 		return err;
 
-- 
1.8.5.2
