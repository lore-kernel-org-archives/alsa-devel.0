From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: cs42l52: Convert to
	devm_input_allocate_device()
Date: Tue, 25 Dec 2012 13:28:26 +0800
Message-ID: <1356413306.12984.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f43.google.com (mail-da0-f43.google.com
 [209.85.210.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CD902616BB
 for <alsa-devel@alsa-project.org>; Tue, 25 Dec 2012 06:28:38 +0100 (CET)
Received: by mail-da0-f43.google.com with SMTP id u36so3387116dak.2
 for <alsa-devel@alsa-project.org>; Mon, 24 Dec 2012 21:28:37 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Brian Austin <brian.austin@cirrus.com>, Georgi Vlaev <joe@nucleusys.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs42l52.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index 99bb1c6..73a8049 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -1040,7 +1040,7 @@ static void cs42l52_init_beep(struct snd_soc_codec *codec)
 	struct cs42l52_private *cs42l52 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
-	cs42l52->beep = input_allocate_device();
+	cs42l52->beep = devm_input_allocate_device(codec->dev);
 	if (!cs42l52->beep) {
 		dev_err(codec->dev, "Failed to allocate beep device\n");
 		return;
@@ -1061,7 +1061,6 @@ static void cs42l52_init_beep(struct snd_soc_codec *codec)
 
 	ret = input_register_device(cs42l52->beep);
 	if (ret != 0) {
-		input_free_device(cs42l52->beep);
 		cs42l52->beep = NULL;
 		dev_err(codec->dev, "Failed to register beep device\n");
 	}
@@ -1078,7 +1077,6 @@ static void cs42l52_free_beep(struct snd_soc_codec *codec)
 	struct cs42l52_private *cs42l52 = snd_soc_codec_get_drvdata(codec);
 
 	device_remove_file(codec->dev, &dev_attr_beep);
-	input_unregister_device(cs42l52->beep);
 	cancel_work_sync(&cs42l52->beep_work);
 	cs42l52->beep = NULL;
 
-- 
1.7.9.5
