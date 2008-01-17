From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] [ALSA] mpc8610: Add mmap support
Date: Thu, 17 Jan 2008 09:06:15 -0600
Message-ID: <12005823754197-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D0AD244BC
	for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2008 16:06:25 +0100 (CET)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m0HF6HCr018023
	for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2008 08:06:22 -0700 (MST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

Enable mmap support in the MPC8610 ASoC driver.  The driver can use ALSA's
default mmap functionality, it was just not enabled previously.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/fsl/fsl_dma.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 2173203..652514f 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -136,7 +136,9 @@ struct fsl_dma_private {
  */
 static const struct snd_pcm_hardware fsl_dma_hardware = {
 
-	.info   		= SNDRV_PCM_INFO_INTERLEAVED,
+	.info   		= SNDRV_PCM_INFO_INTERLEAVED |
+				  SNDRV_PCM_INFO_MMAP |
+				  SNDRV_PCM_INFO_MMAP_VALID,
 	.formats		= FSLDMA_PCM_FORMATS,
 	.rates  		= FSLDMA_PCM_RATES,
 	.rate_min       	= 5512,
-- 
1.5.2.4
