From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH 1/1] indigo-express: add missing 64KHz flags
Date: Mon, 27 Apr 2009 23:23:29 +0200
Message-ID: <20090427232329.1be6fa19@Jay>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out114.alice.it (smtp-out114.alice.it [85.37.17.114])
	by alsa0.perex.cz (Postfix) with ESMTP id E8A1210391B
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Apr 2009 23:23:15 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Indigo-express cards also support 64KHz sampling rate: this patch adds
missing SNDRV_PCM_RATE_64000 flags.


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

--- alsa-kernel/pci/echoaudio/indigodjx.c__orig	2009-04-27 22:57:20.000000000 +0200
+++ alsa-kernel/pci/echoaudio/indigodjx.c	2009-04-27 22:58:04.000000000 +0200
@@ -88,6 +88,7 @@ static struct snd_pcm_hardware pcm_hardw
 	.rates = 	SNDRV_PCM_RATE_32000 |
 			SNDRV_PCM_RATE_44100 |
 			SNDRV_PCM_RATE_48000 |
+			SNDRV_PCM_RATE_64000 |
 			SNDRV_PCM_RATE_88200 |
 			SNDRV_PCM_RATE_96000,
 	.rate_min = 32000,
--- alsa-kernel/pci/echoaudio/indigoiox.c__orig	2009-04-27 22:56:46.000000000 +0200
+++ alsa-kernel/pci/echoaudio/indigoiox.c	2009-04-27 22:57:54.000000000 +0200
@@ -89,6 +89,7 @@ static struct snd_pcm_hardware pcm_hardw
 	.rates = 	SNDRV_PCM_RATE_32000 |
 			SNDRV_PCM_RATE_44100 |
 			SNDRV_PCM_RATE_48000 |
+			SNDRV_PCM_RATE_64000 |
 			SNDRV_PCM_RATE_88200 |
 			SNDRV_PCM_RATE_96000,
 	.rate_min = 32000,


-- 
Giuliano.
