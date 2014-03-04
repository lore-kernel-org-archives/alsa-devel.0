From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: si476x: Fix IO setup
Date: Tue,  4 Mar 2014 09:41:53 +0100
Message-ID: <1393922513-31824-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-014.synserver.de (smtp-out-147.synserver.de
 [212.40.185.147])
 by alsa0.perex.cz (Postfix) with ESMTP id 5701E265720
 for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2014 09:41:25 +0100 (CET)
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
Cc: Andrey Smirnov <andrey.smirnov@convergeddevices.net>, alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The si476x is a MFD device and the CODEC driver is using the regmap struct of
the parent device, hence automatic IO setup will not work and we need to
manually call snd_soc_codec_set_cache_io(). The issue was introduced commit
d6173df35f ("ASoC: si476x: Remove custom register I/O implementation")

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/si476x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/si476x.c b/sound/soc/codecs/si476x.c
index 52e7cb0..fa2b8e0 100644
--- a/sound/soc/codecs/si476x.c
+++ b/sound/soc/codecs/si476x.c
@@ -210,7 +210,7 @@ out:
 static int si476x_codec_probe(struct snd_soc_codec *codec)
 {
 	codec->control_data = dev_get_regmap(codec->dev->parent, NULL);
-	return 0;
+	return snd_soc_codec_set_cache_io(codec, 0, 0, SND_SOC_REGMAP);
 }
 
 static struct snd_soc_dai_ops si476x_dai_ops = {
-- 
1.8.0
