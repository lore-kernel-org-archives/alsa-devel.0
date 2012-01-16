From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: core - Free platform DAPM context at
	platform removal.
Date: Mon, 16 Jan 2012 15:25:37 +0000
Message-ID: <1326727537-29776-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog107.obsmtp.com (na3sys009aog107.obsmtp.com
	[74.125.149.197])
	by alsa0.perex.cz (Postfix) with ESMTP id C82C4103813
	for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2012 16:25:43 +0100 (CET)
Received: by werh12 with SMTP id h12so1434888wer.40
	for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2012 07:25:41 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Fix platform removal by freeing the platform DAPM resources and remove
it from the DAPM list.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-core.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3986520..b5ecf6d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -907,6 +907,10 @@ static void soc_remove_dai_link(struct snd_soc_card *card, int num, int order)
 			if (err < 0)
 				printk(KERN_ERR "asoc: failed to remove %s\n", platform->name);
 		}
+
+		/* Make sure all DAPM widgets are freed */
+		snd_soc_dapm_free(&platform->dapm);
+
 		platform->probed = 0;
 		list_del(&platform->card_list);
 		module_put(platform->dev->driver->owner);
-- 
1.7.5.4
