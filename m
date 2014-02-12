From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 17/24] ALSA: spi: Convert to snd_card_new()
	with a device pointer
Date: Wed, 12 Feb 2014 11:35:33 +0100
Message-ID: <1392201340-27113-18-git-send-email-tiwai@suse.de>
References: <1392201340-27113-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 15B16265062
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:35:51 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 8ECFEAC91
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
 sound/spi/at73c213.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/spi/at73c213.c b/sound/spi/at73c213.c
index 25c38afaee49..39522367897c 100644
--- a/sound/spi/at73c213.c
+++ b/sound/spi/at73c213.c
@@ -927,8 +927,6 @@ static int snd_at73c213_dev_init(struct snd_card *card,
 	if (retval)
 		goto out_snd_dev;
 
-	snd_card_set_dev(card, &spi->dev);
-
 	goto out;
 
 out_snd_dev:
@@ -966,8 +964,8 @@ static int snd_at73c213_probe(struct spi_device *spi)
 
 	/* Allocate "card" using some unused identifiers. */
 	snprintf(id, sizeof id, "at73c213_%d", board->ssc_id);
-	retval = snd_card_create(-1, id, THIS_MODULE,
-				 sizeof(struct snd_at73c213), &card);
+	retval = snd_card_new(&spi->dev, -1, id, THIS_MODULE,
+			      sizeof(struct snd_at73c213), &card);
 	if (retval < 0)
 		goto out;
 
-- 
1.8.5.2
