From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/6] ASoC: doc: Replace open code with
	params_set_format()
Date: Wed, 25 Jul 2018 23:17:18 +0200
Message-ID: <20180725211722.18944-3-tiwai@suse.de>
References: <20180725211722.18944-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 36A5E26776E
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:17:28 +0200 (CEST)
In-Reply-To: <20180725211722.18944-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Timur Tabi <timur@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The example code in dpcm.rst contains an open code calling
snd_mask_set(), and this can be better represented with
params_set_format() instead.  This automatically fixes the sparse
warning about snd_pcm_format_t handling, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/soc/dpcm.rst | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/sound/soc/dpcm.rst b/Documentation/sound/soc/dpcm.rst
index 395e5a516282..fe61e02277f8 100644
--- a/Documentation/sound/soc/dpcm.rst
+++ b/Documentation/sound/soc/dpcm.rst
@@ -254,9 +254,7 @@ configuration.
 	channels->min = channels->max = 2;
 
 	/* set DAI0 to 16 bit */
-	snd_mask_set(&params->masks[SNDRV_PCM_HW_PARAM_FORMAT -
-				    SNDRV_PCM_HW_PARAM_FIRST_MASK],
-				    SNDRV_PCM_FORMAT_S16_LE);
+	params_set_format(params, SNDRV_PCM_FORMAT_S16_LE);
 	return 0;
   }
 
-- 
2.18.0
