From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: multi-comp: soc-core: Fix for machine
	given DAPM widgets
Date: Thu,  5 Aug 2010 09:07:50 +0300
Message-ID: <1280988470-21133-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id B1A9124380
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Aug 2010 08:08:03 +0200 (CEST)
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Move the DAPM initialization after the machine driver has
finished it's init (dai_link driver).
Since in machine init we can add DAPM widgets we need to
take them into account as well.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---

Hello Liam, Mark!

With this patch the machine driver given DAPM routing will be functional
with the multi-comp.
This patch also removes the need to call the snd_soc_dapm_sync from
machine driver's init call, since it will be done by the core.

Please squash this patch to the core changes.

Thanks,
Peter

 sound/soc/soc-core.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a7c9a48..8afa271 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1324,9 +1324,6 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 				return ret;
 			}
 		}
-		/* Make sure all DAPM widgets are instantiated */
-		snd_soc_dapm_new_widgets(codec);
-
 		/* mark codec as probed and add to card codec list */
 		codec->probed = 1;
 		list_add(&codec->card_list, &card->codec_dev_list);
@@ -1375,6 +1372,10 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 		}
 	}
 
+	/* Make sure all DAPM widgets are instantiated */
+	snd_soc_dapm_new_widgets(codec);
+	snd_soc_dapm_sync(codec);
+
 	/* register the rtd device */
 	rtd->dev.init_name = rtd->dai_link->stream_name;
 	rtd->dev.release = rtd_release;
-- 
1.7.2
