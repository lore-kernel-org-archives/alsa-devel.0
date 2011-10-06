From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Ensure DAPM widgets are set up before we
	sync jacks
Date: Thu,  6 Oct 2011 13:31:24 +0100
Message-ID: <1317904284-7846-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8C1E1103839
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Oct 2011 14:31:27 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

We synchronise jack state on startup - when we do that make sure that we
have set up all the DAPM widgets first in case we end up touching any of
the partially set up widgets when syncing the jack pins.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-jack.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 02f95aa..6c5ebd3 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -189,6 +189,8 @@ int snd_soc_jack_add_pins(struct snd_soc_jack *jack, int count,
 		list_add(&(pins[i].list), &jack->pins);
 	}
 
+	snd_soc_dapm_new_widgets(&jack->codec->card->dapm);
+
 	/* Update to reflect the last reported status; canned jack
 	 * implementations are likely to set their state before the
 	 * card has an opportunity to associate pins.
-- 
1.7.6.3
