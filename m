From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 30/30] ASoC: Remove snd_soc_jack_new()
Date: Wed,  4 Mar 2015 10:33:45 +0100
Message-ID: <1425461626-21103-31-git-send-email-lars@metafoo.de>
References: <1425461626-21103-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-196.synserver.de (smtp-out-198.synserver.de
 [212.40.185.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 99E72264F53
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2015 10:34:12 +0100 (CET)
In-Reply-To: <1425461626-21103-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Anatol Pomozov <anatol.pomozov@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Jie Yang <yang.jie@linux.intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Yang A Fang <yang.a.fang@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Sean Cross <xobs@kosagi.com>, Dylan Reid <dgreid@chromium.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

There are no users of snd_soc_jack_new() left and new users should use
snd_soc_card_jack_new() instead. So remove the function.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index e750e4b..bc6cfab 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1492,26 +1492,6 @@ static inline struct snd_soc_platform *snd_soc_kcontrol_platform(
 	return snd_soc_component_to_platform(snd_soc_kcontrol_component(kcontrol));
 }
 
-/**
- * snd_soc_jack_new - Create a new jack
- * @codec: ASoC CODEC
- * @id:    an identifying string for this jack
- * @type:  a bitmask of enum snd_jack_type values that can be detected by
- *         this jack
- * @jack:  structure to use for the jack
- *
- * Creates a new jack object.
- *
- * Returns zero if successful, or a negative error code on failure.
- * On success jack will be initialised.
- */
-static inline int snd_soc_jack_new(struct snd_soc_codec *codec, const char *id,
-	int type, struct snd_soc_jack *jack)
-{
-	return snd_soc_card_jack_new(codec->component.card, id, type, jack,
-		NULL, 0);
-}
-
 int snd_soc_util_init(void);
 void snd_soc_util_exit(void);
 
-- 
1.8.0
