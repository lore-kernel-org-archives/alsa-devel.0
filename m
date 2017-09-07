From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: asihpi: Kill BUG_ON() usages
Date: Thu,  7 Sep 2017 10:53:42 +0200
Message-ID: <20170907085342.3060-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BFEC5267478
 for <alsa-devel@alsa-project.org>; Thu,  7 Sep 2017 10:53:46 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 56A37AE6D
 for <alsa-devel@alsa-project.org>; Thu,  7 Sep 2017 08:53:46 +0000 (UTC)
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

BUG_ON() is the worst choice for a trivial sanity check.
Either it should be removed or replaced with a softer one like
WARN_ON() if still really needed.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/asihpi/asihpi.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index 976a3d23557e..70d023a85bf5 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -558,12 +558,10 @@ static void snd_card_asihpi_pcm_int_start(struct snd_pcm_substream *substream)
 	struct snd_card_asihpi_pcm *dpcm;
 	struct snd_card_asihpi *card;
 
-	BUG_ON(!substream);
-
 	dpcm = (struct snd_card_asihpi_pcm *)substream->runtime->private_data;
 	card = snd_pcm_substream_chip(substream);
 
-	BUG_ON(in_interrupt());
+	WARN_ON(in_interrupt());
 	tasklet_disable(&card->t);
 	card->llmode_streampriv = dpcm;
 	tasklet_enable(&card->t);
@@ -578,8 +576,6 @@ static void snd_card_asihpi_pcm_int_stop(struct snd_pcm_substream *substream)
 	struct snd_card_asihpi_pcm *dpcm;
 	struct snd_card_asihpi *card;
 
-	BUG_ON(!substream);
-
 	dpcm = (struct snd_card_asihpi_pcm *)substream->runtime->private_data;
 	card = snd_pcm_substream_chip(substream);
 
-- 
2.14.1
