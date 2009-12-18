From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 2/5] ALSA: AACI: cleanup aaci_pcm_hw_params
Date: Fri, 18 Dec 2009 17:48:37 +0000
Message-ID: <E1NLgwP-0005NG-Vn@rmk-PC.arm.linux.org.uk>
References: <20091218174731.GE5527@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 3F0F0103920
	for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2009 18:48:56 +0100 (CET)
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

Since the recording and playback paths are now the same, eliminate
the needless conditionals.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/arm/aaci.c |   18 +++++++-----------
 1 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index 106e0b7..9af8ef8 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -438,18 +438,14 @@ static int aaci_pcm_hw_params(struct snd_pcm_substream *substream,
 
 	err = snd_pcm_lib_malloc_pages(substream,
 				       params_buffer_bytes(params));
-	if (err < 0)
-		goto out;
-
-	err = snd_ac97_pcm_open(aacirun->pcm, params_rate(params),
-				params_channels(params),
-				aacirun->pcm->r[0].slots);
-	if (err)
-		goto out;
+	if (err >= 0) {
+		err = snd_ac97_pcm_open(aacirun->pcm, params_rate(params),
+					params_channels(params),
+					aacirun->pcm->r[0].slots);
 
-	aacirun->pcm_open = 1;
+		aacirun->pcm_open = err == 0;
+	}
 
- out:
 	return err;
 }
 
@@ -458,7 +454,7 @@ static int aaci_pcm_prepare(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct aaci_runtime *aacirun = runtime->private_data;
 
-	aacirun->start	= (void *)runtime->dma_area;
+	aacirun->start	= runtime->dma_area;
 	aacirun->end	= aacirun->start + snd_pcm_lib_buffer_bytes(substream);
 	aacirun->ptr	= aacirun->start;
 	aacirun->period	=
-- 
1.6.2.5
