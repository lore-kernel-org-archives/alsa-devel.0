From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] ASoC: dapm: Fix NULL pointer dereference when
	registering card with widgets
Date: Fri,  3 Oct 2014 15:32:40 +0300
Message-ID: <1412339560-18019-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 41859260466
 for <alsa-devel@alsa-project.org>; Fri,  3 Oct 2014 14:32:55 +0200 (CEST)
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
Cc: Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Commit 0bd2ac3dae74 ("ASoC: Remove CODEC pointer from snd_soc_dapm_context")
introduced regression to snd_soc_dapm_new_controls() when registering a card
with card->dapm_widgets set. Call chain is:

    snd_soc_register_card()
    -> snd_soc_instantiate_card()
       -> snd_soc_dapm_new_controls()
          -> snd_soc_dapm_new_control()

Null pointer dereference occurs since card->dapm context doesn't have
associated component. Fix this by setting widget codec pointer
conditionally.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/soc-dapm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 2d06892088d5..3f0b4108f7ca 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3125,7 +3125,8 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 	}
 
 	w->dapm = dapm;
-	w->codec = dapm->component->codec;
+	if (dapm->component)
+		w->codec = dapm->component->codec;
 	INIT_LIST_HEAD(&w->sources);
 	INIT_LIST_HEAD(&w->sinks);
 	INIT_LIST_HEAD(&w->list);
-- 
2.1.1
