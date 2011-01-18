From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: core: Remove dapm_sync call from
	soc_post_component_init
Date: Tue, 18 Jan 2011 15:51:45 +0200
Message-ID: <1295358705-17871-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id C311C10383D
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 14:51:47 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

snd_soc_dapm_new_widgets will call dapm_power_widgets at
the end, so there is no need to call snd_soc_dapm_sync
after snd_soc_dapm_new_widgets.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/soc-core.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index bac7291..952f104 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1467,7 +1467,6 @@ static int soc_post_component_init(struct snd_soc_card *card,
 
 	/* Make sure all DAPM widgets are instantiated */
 	snd_soc_dapm_new_widgets(&codec->dapm);
-	snd_soc_dapm_sync(&codec->dapm);
 
 	/* register the rtd device */
 	rtd->codec = codec;
-- 
1.7.4.rc2
