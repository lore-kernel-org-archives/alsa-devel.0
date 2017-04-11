From: Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] ASoC: tas2552: Return the real error code
Date: Tue, 11 Apr 2017 10:42:02 -0300
Message-ID: <1491918122-15253-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0059.outbound.protection.outlook.com [104.47.38.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E6B52666E1
 for <alsa-devel@alsa-project.org>; Tue, 11 Apr 2017 15:42:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, dmurphy@ti.com
List-Id: alsa-devel@alsa-project.org

In the case of error in tas2552_codec_probe() we should better
propagate the real error code instead of always returning '-EIO'.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/codecs/tas2552.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index baf455e..fd5251e 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -611,7 +611,7 @@ static int tas2552_codec_probe(struct snd_soc_codec *codec)
 
 	regulator_bulk_disable(ARRAY_SIZE(tas2552->supplies),
 					tas2552->supplies);
-	return -EIO;
+	return ret;
 }
 
 static int tas2552_codec_remove(struct snd_soc_codec *codec)
-- 
2.7.4
