From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/18] ALSA: rme9652: Use
	snd_pcm_hw_constraint_single()
Date: Sun, 18 Oct 2015 15:39:21 +0200
Message-ID: <1445175573-11784-7-git-send-email-lars@metafoo.de>
References: <1445175573-11784-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-200.synserver.de (smtp-out-225.synserver.de
 [212.40.185.225])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DEF4261691
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2015 15:39:50 +0200 (CEST)
In-Reply-To: <1445175573-11784-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vinod.koul@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Yang A Fang <yang.a.fang@intel.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Use the new snd_pcm_hw_constraint_single() helper function instead of
calling snd_pcm_hw_constraint_minmax() with the same value for min and max
to install a constraint that limits the possible configuration values to a
single value. Using snd_pcm_hw_constraint_single() makes the indented
result clearer.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/pci/rme9652/hdspm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index cb666c7..8bc8016 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -6080,18 +6080,17 @@ static int snd_hdspm_open(struct snd_pcm_substream *substream)
 					     SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
 					     32, 4096);
 		/* RayDAT & AIO have a fixed buffer of 16384 samples per channel */
-		snd_pcm_hw_constraint_minmax(runtime,
+		snd_pcm_hw_constraint_single(runtime,
 					     SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
-					     16384, 16384);
+					     16384);
 		break;
 
 	default:
 		snd_pcm_hw_constraint_minmax(runtime,
 					     SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
 					     64, 8192);
-		snd_pcm_hw_constraint_minmax(runtime,
-					     SNDRV_PCM_HW_PARAM_PERIODS,
-					     2, 2);
+		snd_pcm_hw_constraint_single(runtime,
+					     SNDRV_PCM_HW_PARAM_PERIODS, 2);
 		break;
 	}
 
-- 
2.1.4
