From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 02/18] ALSA: korg1212: Use
	snd_pcm_hw_constraint_single()
Date: Sun, 18 Oct 2015 15:39:17 +0200
Message-ID: <1445175573-11784-3-git-send-email-lars@metafoo.de>
References: <1445175573-11784-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-200.synserver.de (smtp-out-225.synserver.de
 [212.40.185.225])
 by alsa0.perex.cz (Postfix) with ESMTP id A49452619F5
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2015 15:39:42 +0200 (CEST)
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

While we are at it also fix some code style issues in the affected lines.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/pci/korg1212/korg1212.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/pci/korg1212/korg1212.c b/sound/pci/korg1212/korg1212.c
index 7acbc21..9e1ad11 100644
--- a/sound/pci/korg1212/korg1212.c
+++ b/sound/pci/korg1212/korg1212.c
@@ -1394,7 +1394,9 @@ static int snd_korg1212_playback_open(struct snd_pcm_substream *substream)
 
         spin_unlock_irqrestore(&korg1212->lock, flags);
 
-        snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, kPlayBufferFrames, kPlayBufferFrames);
+	snd_pcm_hw_constraint_single(runtime, SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
+				     kPlayBufferFrames);
+
         return 0;
 }
 
@@ -1422,8 +1424,8 @@ static int snd_korg1212_capture_open(struct snd_pcm_substream *substream)
 
         spin_unlock_irqrestore(&korg1212->lock, flags);
 
-        snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
-				     kPlayBufferFrames, kPlayBufferFrames);
+	snd_pcm_hw_constraint_single(runtime, SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
+				     kPlayBufferFrames);
         return 0;
 }
 
-- 
2.1.4
