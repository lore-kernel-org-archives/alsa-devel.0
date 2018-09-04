From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/5] ALSA: cs46xx: Use
	SNDRV_PCM_INFO_SYNC_APPLPTR info flag
Date: Tue,  4 Sep 2018 08:18:50 +0200
Message-ID: <20180904061851.1934-5-tiwai@suse.de>
References: <20180904061851.1934-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F3B72678DA
 for <alsa-devel@alsa-project.org>; Tue,  4 Sep 2018 08:18:56 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 11E54AFDA
 for <alsa-devel@alsa-project.org>; Tue,  4 Sep 2018 06:18:56 +0000 (UTC)
In-Reply-To: <20180904061851.1934-1-tiwai@suse.de>
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

The recently introduced PCM info flag assures the call of ack ops at
each applptr change, and this is mandatory for the indirect PCM
helpers.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/cs46xx/cs46xx_lib.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
index 146e1a3498c7..750eec437a79 100644
--- a/sound/pci/cs46xx/cs46xx_lib.c
+++ b/sound/pci/cs46xx/cs46xx_lib.c
@@ -1443,7 +1443,8 @@ static const struct snd_pcm_hardware snd_cs46xx_playback =
 	.info =			(SNDRV_PCM_INFO_MMAP |
 				 SNDRV_PCM_INFO_INTERLEAVED | 
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER /*|*/
-				 /*SNDRV_PCM_INFO_RESUME*/),
+				 /*SNDRV_PCM_INFO_RESUME*/ |
+				 SNDRV_PCM_INFO_SYNC_APPLPTR),
 	.formats =		(SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_U8 |
 				 SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE |
 				 SNDRV_PCM_FMTBIT_U16_LE | SNDRV_PCM_FMTBIT_U16_BE),
@@ -1465,7 +1466,8 @@ static const struct snd_pcm_hardware snd_cs46xx_capture =
 	.info =			(SNDRV_PCM_INFO_MMAP |
 				 SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER /*|*/
-				 /*SNDRV_PCM_INFO_RESUME*/),
+				 /*SNDRV_PCM_INFO_RESUME*/ |
+				 SNDRV_PCM_INFO_SYNC_APPLPTR),
 	.formats =		SNDRV_PCM_FMTBIT_S16_LE,
 	.rates =		SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_48000,
 	.rate_min =		5500,
-- 
2.18.0
