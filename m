From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 3/5] ALSA: AACI: factor common hw_params logic
	into aaci_pcm_hw_params
Date: Fri, 18 Dec 2009 17:48:40 +0000
Message-ID: <E1NLgwS-0005NJ-WE@rmk-PC.arm.linux.org.uk>
References: <20091218174731.GE5527@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id A5B4710393A
	for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2009 18:49:03 +0100 (CET)
In-Reply-To: <20091218174731.GE5527@n2100.arm.linux.org.uk>
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
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/arm/aaci.c |   22 +++++++---------------
 1 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index 9af8ef8..0b88c26 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -444,6 +444,11 @@ static int aaci_pcm_hw_params(struct snd_pcm_substream *substream,
 					aacirun->pcm->r[0].slots);
 
 		aacirun->pcm_open = err == 0;
+		aacirun->cr = CR_FEN | CR_COMPACT | CR_SZ16;
+		aacirun->fifosz = aaci->fifosize * 4;
+
+		if (aacirun->cr & CR_COMPACT)
+			aacirun->fifosz >>= 1;
 	}
 
 	return err;
@@ -554,14 +559,9 @@ static int aaci_pcm_playback_hw_params(struct snd_pcm_substream *substream,
 	 * Enable FIFO, compact mode, 16 bits per sample.
 	 * FIXME: double rate slots?
 	 */
-	if (ret >= 0) {
-		aacirun->cr = CR_FEN | CR_COMPACT | CR_SZ16;
+	if (ret >= 0)
 		aacirun->cr |= channels_to_txmask[channels];
 
-		aacirun->fifosz	= aaci->fifosize * 4;
-		if (aacirun->cr & CR_COMPACT)
-			aacirun->fifosz >>= 1;
-	}
 	return ret;
 }
 
@@ -648,18 +648,10 @@ static int aaci_pcm_capture_hw_params(struct snd_pcm_substream *substream,
 	int ret;
 
 	ret = aaci_pcm_hw_params(substream, aacirun, params);
-
-	if (ret >= 0) {
-		aacirun->cr = CR_FEN | CR_COMPACT | CR_SZ16;
-
+	if (ret >= 0)
 		/* Line in record: slot 3 and 4 */
 		aacirun->cr |= CR_SL3 | CR_SL4;
 
-		aacirun->fifosz = aaci->fifosize * 4;
-
-		if (aacirun->cr & CR_COMPACT)
-			aacirun->fifosz >>= 1;
-	}
 	return ret;
 }
 
-- 
1.6.2.5
