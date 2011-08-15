From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/3] ALSA: hdspm - Add missing KNOT flag for
	AES32 rate restriction
Date: Mon, 15 Aug 2011 11:24:19 +0200
Message-ID: <1313400260-15203-2-git-send-email-tiwai@suse.de>
References: <s5h62lz6njt.wl%tiwai@suse.de>
	<1313400260-15203-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 54FB424576
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Aug 2011 11:24:46 +0200 (CEST)
In-Reply-To: <1313400260-15203-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

SNDRV_PCM_RATE_KNOW must be set for allowing non-standard sample rates
like 128kHz supported by AES32.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/rme9652/hdspm.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index c33f4a5..4add485 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -6006,6 +6006,7 @@ static int snd_hdspm_playback_open(struct snd_pcm_substream *substream)
 	}
 
 	if (AES32 == hdspm->io_type) {
+		runtime->hw.rates |= SNDRV_PCM_RATE_KNOT;
 		snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				&hdspm_hw_constraints_aes32_sample_rates);
 	} else {
@@ -6076,6 +6077,7 @@ static int snd_hdspm_capture_open(struct snd_pcm_substream *substream)
 	}
 
 	if (AES32 == hdspm->io_type) {
+		runtime->hw.rates |= SNDRV_PCM_RATE_KNOT;
 		snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				&hdspm_hw_constraints_aes32_sample_rates);
 	} else {
-- 
1.7.6
