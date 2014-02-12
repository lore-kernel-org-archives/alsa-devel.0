From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 18/24] ASoC: core: Convert to snd_card_new()
	with a device pointer
Date: Wed, 12 Feb 2014 11:35:34 +0100
Message-ID: <1392201340-27113-19-git-send-email-tiwai@suse.de>
References: <1392201340-27113-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FD1C265065
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:35:51 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 91C6AAC92
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

Also remove superfluous card->dev assignment.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/soc-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index fe1df50805a3..135ddb01aadb 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1654,7 +1654,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	}
 
 	/* card bind complete so register a sound card */
-	ret = snd_card_create(SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
+	ret = snd_card_new(card->dev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
 			card->owner, 0, &card->snd_card);
 	if (ret < 0) {
 		dev_err(card->dev,
@@ -1662,7 +1662,6 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 			card->name, ret);
 		goto base_error;
 	}
-	card->snd_card->dev = card->dev;
 
 	card->dapm.bias_level = SND_SOC_BIAS_OFF;
 	card->dapm.dev = card->dev;
-- 
1.8.5.2
