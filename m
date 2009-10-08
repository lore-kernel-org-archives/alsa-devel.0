From: Robert Hancock <hancockrwd@gmail.com>
Subject: [PATCH] ice1724: increase SPDIF and independent stereo
	buffer sizes
Date: Wed, 07 Oct 2009 20:19:21 -0600
Message-ID: <4ACD4C29.8020007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f187.google.com (mail-qy0-f187.google.com
	[209.85.221.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 666B71038C8
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Oct 2009 04:19:25 +0200 (CEST)
Received: by qyk17 with SMTP id 17so5524110qyk.2
	for <alsa-devel@alsa-project.org>; Wed, 07 Oct 2009 19:19:24 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-Devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Increase the default and maximum PCM buffer prellocation size for ice1724's
SPDIF and independent stereo pair outputs to 256K, which is the hardware's
maximum supported size. This allows a reduction in interrupt rate and
potentially power usage when an application is not latency-critical.

Signed-off-by: Robert Hancock <hancockrwd@gmail.com>

diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
index af6e001..3ae4407 100644
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -1294,7 +1294,7 @@ static int __devinit snd_vt1724_pcm_spdif(struct snd_ice1712 *ice, int device)
 
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
 					      snd_dma_pci_data(ice->pci),
-					      64*1024, 64*1024);
+					      256*1024, 256*1024);
 
 	ice->pcm = pcm;
 
@@ -1408,7 +1408,7 @@ static int __devinit snd_vt1724_pcm_indep(struct snd_ice1712 *ice, int device)
 
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
 					      snd_dma_pci_data(ice->pci),
-					      64*1024, 64*1024);
+					      256*1024, 256*1024);
 
 	ice->pcm_ds = pcm;
