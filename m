From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ALSA: Export snd_pcm_constraint_mask64()
Date: Thu, 20 Feb 2014 12:16:07 +0900
Message-ID: <1392866167-15735-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CD4BD26546B
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 04:16:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Allow modules to use it, fixing a build failure when the newly added
ADAU1977 driver is built as a module.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Mark Brown <broonie@linaro.org>
---

OK to apply this to the ASoC tree?

 sound/core/pcm_lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 6630a4e..ce83def 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1240,6 +1240,7 @@ int snd_pcm_hw_constraint_mask64(struct snd_pcm_runtime *runtime, snd_pcm_hw_par
 		return -EINVAL;
 	return 0;
 }
+EXPORT_SYMBOL(snd_pcm_hw_constraint_mask64);
 
 /**
  * snd_pcm_hw_constraint_integer - apply an integer constraint to an interval
-- 
1.9.0.rc3
