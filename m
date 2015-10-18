From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/18] ALSA: rme32: Use
	snd_pcm_hw_constraint_single()
Date: Sun, 18 Oct 2015 15:39:19 +0200
Message-ID: <1445175573-11784-5-git-send-email-lars@metafoo.de>
References: <1445175573-11784-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-200.synserver.de (smtp-out-225.synserver.de
 [212.40.185.225])
 by alsa0.perex.cz (Postfix) with ESMTP id 9838F261AAF
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2015 15:39:45 +0200 (CEST)
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
 sound/pci/rme32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/rme32.c b/sound/pci/rme32.c
index 23d7f5d..cd94ac5 100644
--- a/sound/pci/rme32.c
+++ b/sound/pci/rme32.c
@@ -831,9 +831,9 @@ static struct snd_pcm_hw_constraint_list hw_constraints_period_bytes = {
 static void snd_rme32_set_buffer_constraint(struct rme32 *rme32, struct snd_pcm_runtime *runtime)
 {
 	if (! rme32->fullduplex_mode) {
-		snd_pcm_hw_constraint_minmax(runtime,
+		snd_pcm_hw_constraint_single(runtime,
 					     SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
-					     RME32_BUFFER_SIZE, RME32_BUFFER_SIZE);
+					     RME32_BUFFER_SIZE);
 		snd_pcm_hw_constraint_list(runtime, 0,
 					   SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
 					   &hw_constraints_period_bytes);
-- 
2.1.4
