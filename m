From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] ASoC: Add missing new-line at end of strings
Date: Tue, 26 Aug 2008 15:47:55 +0200
Message-ID: <20080826154755.27d3ff61@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E1C1103846
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Aug 2008 15:48:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Two warning messages lack their trailing new-line, add it.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 sound/soc/at91/at91-ssc.c       |    2 +-
 sound/soc/davinci/davinci-i2s.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.27-rc4.orig/sound/soc/at91/at91-ssc.c	2008-08-13 09:51:02.000000000 +0200
+++ linux-2.6.27-rc4/sound/soc/at91/at91-ssc.c	2008-08-26 15:45:11.000000000 +0200
@@ -408,7 +408,7 @@ static int at91_ssc_hw_params(struct snd
 		dma_params->pdc_xfer_size = 4;
 		break;
 	default:
-		printk(KERN_WARNING "at91-ssc: unsupported PCM format");
+		printk(KERN_WARNING "at91-ssc: unsupported PCM format\n");
 		return -EINVAL;
 	}
 
--- linux-2.6.27-rc4.orig/sound/soc/davinci/davinci-i2s.c	2008-08-05 18:18:18.000000000 +0200
+++ linux-2.6.27-rc4/sound/soc/davinci/davinci-i2s.c	2008-08-26 15:45:04.000000000 +0200
@@ -256,7 +256,7 @@ static int davinci_i2s_hw_params(struct 
 		mcbsp_word_length = DAVINCI_MCBSP_WORD_32;
 		break;
 	default:
-		printk(KERN_WARNING "davinci-i2s: unsupported PCM format");
+		printk(KERN_WARNING "davinci-i2s: unsupported PCM format\n");
 		return -EINVAL;
 	}
 


-- 
Jean Delvare
