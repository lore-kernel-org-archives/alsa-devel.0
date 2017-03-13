From: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Subject: [PATCH 1/1] ALSA: es1688: Use strcpy() instead of
	sprintf()
Date: Mon, 13 Mar 2017 20:22:50 +0100
Message-ID: <20170313192250.23497-1-nicolas.iooss_linux@m4x.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.polytechnique.org (mx1.polytechnique.org [129.104.30.34])
 by alsa0.perex.cz (Postfix) with ESMTP id 66B98266B13
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 20:23:17 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: Nicolas Iooss <nicolas.iooss_linux@m4x.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

There is no point in using sprintf() without a format string when
strcpy() can perform the same operation.

Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
---
 sound/isa/es1688/es1688_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/isa/es1688/es1688_lib.c b/sound/isa/es1688/es1688_lib.c
index e2cf508841b1..81cf26fa28d6 100644
--- a/sound/isa/es1688/es1688_lib.c
+++ b/sound/isa/es1688/es1688_lib.c
@@ -742,7 +742,7 @@ int snd_es1688_pcm(struct snd_card *card, struct snd_es1688 *chip, int device)
 
 	pcm->private_data = chip;
 	pcm->info_flags = SNDRV_PCM_INFO_HALF_DUPLEX;
-	sprintf(pcm->name, snd_es1688_chip_id(chip));
+	strcpy(pcm->name, snd_es1688_chip_id(chip));
 	chip->pcm = pcm;
 
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-- 
2.12.0
