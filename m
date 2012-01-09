From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: core - Improve card registration error
	messaging for large DAI links.
Date: Mon,  9 Jan 2012 12:09:29 +0000
Message-ID: <1326110969-6173-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog102.obsmtp.com (na3sys009aog102.obsmtp.com
	[74.125.149.69])
	by alsa0.perex.cz (Postfix) with ESMTP id CBF79103A76
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2012 13:09:40 +0100 (CET)
Received: by mail-we0-f175.google.com with SMTP id m13so2912743wer.20
	for <alsa-devel@alsa-project.org>; Mon, 09 Jan 2012 04:09:37 -0800 (PST)
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

Print out the offending DAI link entry when a naming error occurs. Makes
thing easier to debug for machines with a large number of DAI links.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-core.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index acbb960..e1d8433 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2854,7 +2854,8 @@ int snd_soc_register_card(struct snd_soc_card *card)
 		 */
 		if (!!link->codec_name == !!link->codec_of_node) {
 			dev_err(card->dev,
-				"Neither/both codec name/of_node are set\n");
+				"Neither/both codec name/of_node are set for %s\n",
+				link->name);
 			return -EINVAL;
 		}
 
@@ -2864,7 +2865,7 @@ int snd_soc_register_card(struct snd_soc_card *card)
 		 */
 		if (link->platform_name && link->platform_of_node) {
 			dev_err(card->dev,
-				"Both platform name/of_node are set\n");
+				"Both platform name/of_node are set for %s\n", link->name);
 			return -EINVAL;
 		}
 
@@ -2874,7 +2875,8 @@ int snd_soc_register_card(struct snd_soc_card *card)
 		 */
 		if (!!link->cpu_dai_name == !!link->cpu_dai_of_node) {
 			dev_err(card->dev,
-				"Neither/both cpu_dai name/of_node are set\n");
+				"Neither/both cpu_dai name/of_node are set for %s\n",
+				link->name);
 			return -EINVAL;
 		}
 	}
-- 
1.7.5.4
