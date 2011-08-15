From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/3] ALSA: hdspm - Correct max buffer size limit
Date: Mon, 15 Aug 2011 11:24:18 +0200
Message-ID: <1313400260-15203-1-git-send-email-tiwai@suse.de>
References: <s5h62lz6njt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 52CEC24575
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Aug 2011 11:24:46 +0200 (CEST)
In-Reply-To: <s5h62lz6njt.wl%tiwai@suse.de>
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

Old models can support up to 8192 frames per period.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/rme9652/hdspm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 92ac64c..c33f4a5 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -5737,7 +5737,7 @@ static struct snd_pcm_hardware snd_hdspm_playback_subinfo = {
 	.buffer_bytes_max =
 	    HDSPM_CHANNEL_BUFFER_BYTES * HDSPM_MAX_CHANNELS,
 	.period_bytes_min = (32 * 4),
-	.period_bytes_max = (4096 * 4) * HDSPM_MAX_CHANNELS,
+	.period_bytes_max = (8192 * 4) * HDSPM_MAX_CHANNELS,
 	.periods_min = 2,
 	.periods_max = 512,
 	.fifo_size = 0
@@ -5762,7 +5762,7 @@ static struct snd_pcm_hardware snd_hdspm_capture_subinfo = {
 	.buffer_bytes_max =
 	    HDSPM_CHANNEL_BUFFER_BYTES * HDSPM_MAX_CHANNELS,
 	.period_bytes_min = (32 * 4),
-	.period_bytes_max = (4096 * 4) * HDSPM_MAX_CHANNELS,
+	.period_bytes_max = (8192 * 4) * HDSPM_MAX_CHANNELS,
 	.periods_min = 2,
 	.periods_max = 512,
 	.fifo_size = 0
-- 
1.7.6
