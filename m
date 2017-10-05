From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] ASoC: Intel: cht_bsw_max98090: remove useless
	code, align with ChromeOS driver
Date: Wed,  4 Oct 2017 23:04:27 -0500
Message-ID: <20171005040427.26612-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id B59B2267463
 for <alsa-devel@alsa-project.org>; Thu,  5 Oct 2017 06:04:50 +0200 (CEST)
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
Cc: vinod.koul@intel.com, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Thierry Escande <thierry.escande@collabora.com>
List-Id: alsa-devel@alsa-project.org

Remove dead code which was missed in previous changes. This is not
visible with git diff but there is a test+return on the same condition
just above.

Also reuse local variable instead of fetching the jack information twice.

Tested on Acer R11 (cyan)

Fixes: 3bbda5a38601 ('ASoC: Intel: cht_bsw_max98090_ti: Fix jack initialization')
Cc: Thierry Escande <thierry.escande@collabora.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index 74c047a4b05c..119da5503fee 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -219,10 +219,6 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 		return ret;
 	}
 
-
-	if (ctx->ts3a227e_present)
-		snd_soc_jack_notifier_register(jack, &cht_jack_nb);
-
 	ret = snd_soc_jack_add_gpiods(runtime->card->dev->parent, jack,
 				      ARRAY_SIZE(hs_jack_gpios),
 				      hs_jack_gpios);
@@ -323,7 +319,7 @@ static int cht_max98090_headset_init(struct snd_soc_component *component)
 		return ret;
 	}
 
-	return ts3a227e_enable_jack_detect(component, &ctx->jack);
+	return ts3a227e_enable_jack_detect(component, jack);
 }
 
 static const struct snd_soc_ops cht_aif1_ops = {
-- 
2.11.0
