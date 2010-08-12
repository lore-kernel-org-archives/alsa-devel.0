From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Set up debugfs only once per CODEC
Date: Thu, 12 Aug 2010 15:50:31 +0100
Message-ID: <1281624632-17992-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 16B64103868
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Aug 2010 16:50:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Since the debugfs directory is current per CODEC we should only init
it when the CODEC is initialised, otherwise we end up with errors
being generated when an attempt is made to add duplicate debugfs
entries.

Since most of this stuff is actually for the card we should refactor
but this can come later.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a004876..ac0fa22 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1323,6 +1323,9 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 				return ret;
 			}
 		}
+
+		soc_init_codec_debugfs(codec);
+
 		/* mark codec as probed and add to card codec list */
 		codec->probed = 1;
 		list_add(&codec->card_list, &card->codec_dev_list);
@@ -1400,8 +1403,6 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 	if (ret < 0)
 		printk(KERN_WARNING "asoc: failed to add codec sysfs files\n");
 
-	soc_init_codec_debugfs(codec);
-
 	/* create the pcm */
 	ret = soc_new_pcm(rtd, num);
 	if (ret < 0) {
-- 
1.7.1
