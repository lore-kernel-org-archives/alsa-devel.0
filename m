From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: ak4104: Remove superfluous
	codec->control_data initialization
Date: Tue,  4 Mar 2014 09:19:37 +0100
Message-ID: <1393921177-24294-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-014.synserver.de (smtp-out-147.synserver.de
 [212.40.185.147])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EB27261AC7
 for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2014 09:19:11 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

The driver uses automatic IO setup, which will also initialize the control_data
field of the CODEC, no need to do it manually.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ak4104.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/ak4104.c b/sound/soc/codecs/ak4104.c
index b4819dc..10adf25 100644
--- a/sound/soc/codecs/ak4104.c
+++ b/sound/soc/codecs/ak4104.c
@@ -174,8 +174,6 @@ static int ak4104_probe(struct snd_soc_codec *codec)
 	struct ak4104_private *ak4104 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
-	codec->control_data = ak4104->regmap;
-
 	/* set power-up and non-reset bits */
 	ret = regmap_update_bits(ak4104->regmap, AK4104_REG_CONTROL1,
 				 AK4104_CONTROL1_PW | AK4104_CONTROL1_RSTN,
-- 
1.8.0
