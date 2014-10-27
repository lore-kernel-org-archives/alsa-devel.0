From: Joe Perches <joe@perches.com>
Subject: [PATCH 11/11] sound: ad1889: Fix probable mask then right shift defects
Date: Sun, 26 Oct 2014 22:25:07 -0700
Message-ID: <20f33139e87eb74f0ac50d0503a241936d4e0ff5.1414387334.git.joe@perches.com>
References: <cover.1414387334.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1414387334.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Thibaut Varene <T-Bone@parisc-linux.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-parisc@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Precedence of & and >> is not the same and is not left to right.
shift has higher precedence and should be done after the mask.

Add parentheses around the mask.

Signed-off-by: Joe Perches <joe@perches.com>
---
 sound/pci/ad1889.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/ad1889.c b/sound/pci/ad1889.c
index 7bfdf9c..1610c38 100644
--- a/sound/pci/ad1889.c
+++ b/sound/pci/ad1889.c
@@ -681,7 +681,7 @@ snd_ad1889_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffe
 	
 	/* WARQ is at offset 12 */
 	tmp = (reg & AD_DS_WSMC_WARQ) ?
-			(((reg & AD_DS_WSMC_WARQ >> 12) & 0x01) ? 12 : 18) : 4;
+		((((reg & AD_DS_WSMC_WARQ) >> 12) & 0x01) ? 12 : 18) : 4;
 	tmp /= (reg & AD_DS_WSMC_WAST) ? 2 : 1;
 	
 	snd_iprintf(buffer, "Wave FIFO: %d %s words\n\n", tmp,
@@ -693,7 +693,7 @@ snd_ad1889_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffe
 	
 	/* SYRQ is at offset 4 */
 	tmp = (reg & AD_DS_WSMC_SYRQ) ?
-			(((reg & AD_DS_WSMC_SYRQ >> 4) & 0x01) ? 12 : 18) : 4;
+		((((reg & AD_DS_WSMC_SYRQ) >> 4) & 0x01) ? 12 : 18) : 4;
 	tmp /= (reg & AD_DS_WSMC_WAST) ? 2 : 1;
 	
 	snd_iprintf(buffer, "Synthesis FIFO: %d %s words\n\n", tmp,
@@ -709,7 +709,7 @@ snd_ad1889_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffe
 	
 	/* ACRQ is at offset 4 */
 	tmp = (reg & AD_DS_RAMC_ACRQ) ?
-			(((reg & AD_DS_RAMC_ACRQ >> 4) & 0x01) ? 12 : 18) : 4;
+		((((reg & AD_DS_RAMC_ACRQ) >> 4) & 0x01) ? 12 : 18) : 4;
 	tmp /= (reg & AD_DS_RAMC_ADST) ? 2 : 1;
 	
 	snd_iprintf(buffer, "ADC FIFO: %d %s words\n\n", tmp,
@@ -720,7 +720,7 @@ snd_ad1889_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffe
 			
 	/* RERQ is at offset 12 */
 	tmp = (reg & AD_DS_RAMC_RERQ) ?
-			(((reg & AD_DS_RAMC_RERQ >> 12) & 0x01) ? 12 : 18) : 4;
+		((((reg & AD_DS_RAMC_RERQ) >> 12) & 0x01) ? 12 : 18) : 4;
 	tmp /= (reg & AD_DS_RAMC_ADST) ? 2 : 1;
 	
 	snd_iprintf(buffer, "Resampler FIFO: %d %s words\n\n", tmp,
-- 
2.1.2
