From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Add card driver data
Date: Fri, 28 Jan 2011 13:15:23 +0000
Message-ID: <1296220523-26815-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 696AB2456C
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2011 14:15:06 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Stephen Warren <swarren@nvidia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Provide driver data for cards within the card structure. To simplify the
implementation of the PM operations we don't use the struct device driver
data as this is used by the core to retrieve the card in callbacks from
the device model and PM core.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 7ecdaef..4b6c0a8 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -705,6 +705,8 @@ struct snd_soc_card {
 	struct dentry *debugfs_pop_time;
 #endif
 	u32 pop_time;
+
+	void *drvdata;
 };
 
 /* SoC machine DAI configuration, glues a codec and cpu DAI together */
@@ -756,6 +758,17 @@ unsigned int snd_soc_write(struct snd_soc_codec *codec,
 
 /* device driver data */
 
+static inline void snd_soc_card_set_drvdata(struct snd_soc_card *card,
+		void *data)
+{
+	card->drvdata = data;
+}
+
+static inline void *snd_soc_card_get_drvdata(struct snd_soc_card *card)
+{
+	return card->drvdata;
+}
+
 static inline void snd_soc_codec_set_drvdata(struct snd_soc_codec *codec,
 		void *data)
 {
-- 
1.7.2.3
