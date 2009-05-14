From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH V1 01/13] Temporarily
	undo	2008f137e92220b98120c4803499cdddb2b0fb06
Date: Wed, 13 May 2009 21:59:01 -0400
Message-ID: <20090514015901.28145.40556.stgit@terra>
References: <20090514015729.28145.30483.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f206.google.com (mail-gx0-f206.google.com
	[209.85.217.206])
	by alsa0.perex.cz (Postfix) with ESMTP id A2C3124355
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 03:59:12 +0200 (CEST)
Received: by gxk2 with SMTP id 2so1985831gxk.8
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2009 18:59:11 -0700 (PDT)
In-Reply-To: <20090514015729.28145.30483.stgit@terra>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: grant.likely@secretlab.ca, broonie@sirena.org.uk
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Temporarily undo 2008f137e92220b98120c4803499cdddb2b0fb06 in sound/soc/fsl/mpc5200_psc_i2s.c so that it won't interfere with following patches that split mpc5200_psc_i2s.c.

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---
 sound/soc/fsl/mpc5200_psc_i2s.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_i2s.c
index 1111c71..3aa729d 100644
--- a/sound/soc/fsl/mpc5200_psc_i2s.c
+++ b/sound/soc/fsl/mpc5200_psc_i2s.c
@@ -504,8 +504,7 @@ static struct snd_soc_dai psc_i2s_dai_template = {
 
 static const struct snd_pcm_hardware psc_i2s_pcm_hardware = {
 	.info = SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
-		SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
-		SNDRV_PCM_INFO_BATCH,
+		SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER,
 	.formats = SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_BE |
 		   SNDRV_PCM_FMTBIT_S24_BE | SNDRV_PCM_FMTBIT_S32_BE,
 	.rate_min = 8000,
