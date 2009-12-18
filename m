From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 4/5] ALSA: AACI: add double-rate support
Date: Fri, 18 Dec 2009 17:48:45 +0000
Message-ID: <E1NLgwX-0005NM-Bp@rmk-PC.arm.linux.org.uk>
References: <20091218174731.GE5527@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 6DD5E103941
	for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2009 18:49:08 +0100 (CET)
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
 sound/arm/aaci.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index 0b88c26..0635c62 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -366,6 +366,10 @@ static int __aaci_pcm_open(struct aaci *aaci,
 	runtime->hw.rates = aacirun->pcm->rates;
 	snd_pcm_limit_hw_rates(runtime);
 
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
+	    aacirun->pcm->r[1].slots)
+		snd_ac97_pcm_double_rate_rules(runtime);
+
 	/*
 	 * FIXME: ALSA specifies fifo_size in bytes.  If we're in normal
 	 * mode, each 32-bit word contains one sample.  If we're in
@@ -439,9 +443,12 @@ static int aaci_pcm_hw_params(struct snd_pcm_substream *substream,
 	err = snd_pcm_lib_malloc_pages(substream,
 				       params_buffer_bytes(params));
 	if (err >= 0) {
-		err = snd_ac97_pcm_open(aacirun->pcm, params_rate(params),
+		unsigned int rate = params_rate(params);
+		int dbl = rate > 48000;
+
+		err = snd_ac97_pcm_open(aacirun->pcm, rate,
 					params_channels(params),
-					aacirun->pcm->r[0].slots);
+					aacirun->pcm->r[dbl].slots);
 
 		aacirun->pcm_open = err == 0;
 		aacirun->cr = CR_FEN | CR_COMPACT | CR_SZ16;
@@ -808,6 +815,12 @@ static struct ac97_pcm ac97_defs[] __devinitdata = {
 					  (1 << AC97_SLOT_PCM_SRIGHT) |
 					  (1 << AC97_SLOT_LFE),
 			},
+			[1] = {
+				.slots	= (1 << AC97_SLOT_PCM_LEFT) |
+					  (1 << AC97_SLOT_PCM_RIGHT) |
+					  (1 << AC97_SLOT_PCM_LEFT_0) |
+					  (1 << AC97_SLOT_PCM_RIGHT_0),
+			},
 		},
 	},
 	[1] = {	/* PCM in */
-- 
1.6.2.5
