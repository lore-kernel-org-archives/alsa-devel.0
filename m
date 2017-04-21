From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ASoC: Call snd_soc_set_dmi_name()
	unconditionally
Date: Fri, 21 Apr 2017 17:55:25 +0200
Message-ID: <20170421155525.15012-2-tiwai@suse.de>
References: <20170421155525.15012-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4616C267101
 for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2017 17:55:28 +0200 (CEST)
In-Reply-To: <20170421155525.15012-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Since recently UCM can pick up a configuration specific to the board
via card longname field, and we introduced a helper function
snd_soc_set_dmi_name() for that.  So far, it was used only in one
place (sound/soc/intel/boards/broadwell.c), but it should be more
widely applied.

This patch puts a big hammer for that: it lets snd_soc_register_card()
calling snd_soc_set_dmi_name() unconditionally, so that all x86
devices get the better longname string.  This would have no impact for
other systems without DMI support, as snd_soc_set_dmi_name() is no-op
on them.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/intel/boards/broadwell.c | 3 ---
 sound/soc/soc-core.c               | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/broadwell.c b/sound/soc/intel/boards/broadwell.c
index faf865bb1765..6dcbbcefc25b 100644
--- a/sound/soc/intel/boards/broadwell.c
+++ b/sound/soc/intel/boards/broadwell.c
@@ -269,9 +269,6 @@ static struct snd_soc_card broadwell_rt286 = {
 static int broadwell_audio_probe(struct platform_device *pdev)
 {
 	broadwell_rt286.dev = &pdev->dev;
-
-	snd_soc_set_dmi_name(&broadwell_rt286, NULL);
-
 	return devm_snd_soc_register_card(&pdev->dev, &broadwell_rt286);
 }
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index aac73ff8a92a..6536eccdafae 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2192,6 +2192,9 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 		snd_soc_dapm_add_routes(&card->dapm, card->of_dapm_routes,
 					card->num_of_dapm_routes);
 
+	/* try to set some sane longname if DMI is available */
+	snd_soc_set_dmi_name(card);
+
 	snprintf(card->snd_card->shortname, sizeof(card->snd_card->shortname),
 		 "%s", card->name);
 	snprintf(card->snd_card->longname, sizeof(card->snd_card->longname),
-- 
2.11.1
