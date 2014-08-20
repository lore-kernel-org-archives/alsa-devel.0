From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/4] ASoC: Add snd_soc_component_{get,
	set}_drvdata()
Date: Wed, 20 Aug 2014 13:08:46 +0200
Message-ID: <1408532929-26978-2-git-send-email-lars@metafoo.de>
References: <1408532929-26978-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-032.synserver.de (smtp-out-036.synserver.de
 [212.40.185.36])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A6E42656DE
 for <alsa-devel@alsa-project.org>; Wed, 20 Aug 2014 13:08:55 +0200 (CEST)
In-Reply-To: <1408532929-26978-1-git-send-email-lars@metafoo.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

Add Add snd_soc_component_{get,set}_drvdata() similar to
snd_soc_codec_{get,set}_drvdata() and snd_soc_platform_{get,set}_drvdata().
Also update them to use the new functions internally.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index e43fbb6..e6440d8 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1299,26 +1299,37 @@ static inline void *snd_soc_card_get_drvdata(struct snd_soc_card *card)
 	return card->drvdata;
 }
 
+static inline void snd_soc_component_set_drvdata(struct snd_soc_component *c,
+		void *data)
+{
+	dev_set_drvdata(c->dev, data);
+}
+
+static inline void *snd_soc_component_get_drvdata(struct snd_soc_component *c)
+{
+	return dev_get_drvdata(c->dev);
+}
+
 static inline void snd_soc_codec_set_drvdata(struct snd_soc_codec *codec,
 		void *data)
 {
-	dev_set_drvdata(codec->dev, data);
+	snd_soc_component_set_drvdata(&codec->component, data);
 }
 
 static inline void *snd_soc_codec_get_drvdata(struct snd_soc_codec *codec)
 {
-	return dev_get_drvdata(codec->dev);
+	return snd_soc_component_get_drvdata(&codec->component);
 }
 
 static inline void snd_soc_platform_set_drvdata(struct snd_soc_platform *platform,
 		void *data)
 {
-	dev_set_drvdata(platform->dev, data);
+	snd_soc_component_set_drvdata(&platform->component, data);
 }
 
 static inline void *snd_soc_platform_get_drvdata(struct snd_soc_platform *platform)
 {
-	return dev_get_drvdata(platform->dev);
+	return snd_soc_component_get_drvdata(&platform->component);
 }
 
 static inline void snd_soc_pcm_set_drvdata(struct snd_soc_pcm_runtime *rtd,
-- 
1.8.0
