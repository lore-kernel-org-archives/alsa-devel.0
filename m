From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 03/18] ALSA: lx6464es: Use
	snd_pcm_hw_constraint_single()
Date: Sun, 18 Oct 2015 15:39:18 +0200
Message-ID: <1445175573-11784-4-git-send-email-lars@metafoo.de>
References: <1445175573-11784-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-200.synserver.de (smtp-out-225.synserver.de
 [212.40.185.225])
 by alsa0.perex.cz (Postfix) with ESMTP id 25D422619FB
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2015 15:39:44 +0200 (CEST)
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
 sound/pci/lx6464es/lx6464es.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
index cba89be..8b8e2e5 100644
--- a/sound/pci/lx6464es/lx6464es.c
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -234,8 +234,8 @@ static int lx_pcm_open(struct snd_pcm_substream *substream)
 
 	/* the clock rate cannot be changed */
 	board_rate = chip->board_sample_rate;
-	err = snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_RATE,
-					   board_rate, board_rate);
+	err = snd_pcm_hw_constraint_single(runtime, SNDRV_PCM_HW_PARAM_RATE,
+					   board_rate);
 
 	if (err < 0) {
 		dev_warn(chip->card->dev, "could not constrain periods\n");
-- 
2.1.4
