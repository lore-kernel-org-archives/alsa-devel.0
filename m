From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] ASoC: cs4349: Constify cs4349_regmap
Date: Fri, 17 Jul 2015 23:43:02 +0800
Message-ID: <1437147782.1229.4.camel@ingics.com>
References: <1437147514.1229.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com
 [209.85.192.172])
 by alsa0.perex.cz (Postfix) with ESMTP id D79652604D5
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2015 17:43:07 +0200 (CEST)
Received: by pdrg1 with SMTP id g1so63479059pdr.2
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2015 08:43:07 -0700 (PDT)
In-Reply-To: <1437147514.1229.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Tim Howe <tim.howe@cirrus.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs4349.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs4349.c b/sound/soc/codecs/cs4349.c
index 9273b06..f4fccc6 100644
--- a/sound/soc/codecs/cs4349.c
+++ b/sound/soc/codecs/cs4349.c
@@ -264,7 +264,7 @@ static struct snd_soc_codec_driver soc_codec_dev_cs4349 = {
 	.num_dapm_routes	= ARRAY_SIZE(cs4349_routes),
 };
 
-static struct regmap_config cs4349_regmap = {
+static const struct regmap_config cs4349_regmap = {
 	.reg_bits		= 8,
 	.val_bits		= 8,
 
-- 
2.1.0
