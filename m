From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH] wss_lib: fix suspend/resume
Date: Thu, 12 Jul 2012 23:30:31 +0200
Message-ID: <201207122330.34585.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.atlantis.sk (mail-1.atlantis.sk [80.94.52.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 9138724626
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jul 2012 23:31:01 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

By setting SNDRV_PCM_INFO_RESUME, wss_lib claims that it can restore the card
state fully on resume. But in fact, it can't as DMA is not restored so any
playback/capture running during suspend will fail to continue after resume.

Remove SNDRV_PCM_INFO_RESUME flag from pcm info field to fix the problem.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

--- a/sound/isa/wss/wss_lib.c
+++ b/sound/isa/wss/wss_lib.c
@@ -1456,7 +1456,6 @@ static struct snd_pcm_hardware snd_wss_playback =
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_MMAP_VALID |
-				 SNDRV_PCM_INFO_RESUME |
 				 SNDRV_PCM_INFO_SYNC_START),
 	.formats =		(SNDRV_PCM_FMTBIT_MU_LAW | SNDRV_PCM_FMTBIT_A_LAW | SNDRV_PCM_FMTBIT_IMA_ADPCM |
 				 SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE),

-- 
Ondrej Zary
