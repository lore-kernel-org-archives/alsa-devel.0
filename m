From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: sgtl5000: Fix driver probe after reset
Date: Wed,  8 May 2013 14:04:06 -0300
Message-ID: <1368032653-19489-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f177.google.com (mail-qc0-f177.google.com
 [209.85.216.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 27E95261A29
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2013 19:04:51 +0200 (CEST)
Received: by mail-qc0-f177.google.com with SMTP id e1so1128059qcy.8
 for <alsa-devel@alsa-project.org>; Wed, 08 May 2013 10:04:50 -0700 (PDT)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, matt@genesi-usa.com, alsa-devel@alsa-project.org, eric.nelson@boundarydevices.com, troy.kisky@boundarydevices.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

sgtl5000 codec does not have a reset line, nor a reset command in software.

After a 'reboot' command in Linux or after pressing the system's reset button
the sgtl5000 driver fails to probe:

sgtl5000 0-000a: Device with ID register ffff is not a sgtl5000
sgtl5000 0-000a: ASoC: failed to probe CODEC -19
imx-sgtl5000 sound.12: ASoC: failed to instantiate card -19
imx-sgtl5000 sound.12: snd_soc_register_card failed (-19)

As the sgtl5000 codec did not go through a real reset, we cannot rely on the 
reg_defaults array, since these are only valid after a clean power-on reset.

To fix this issue, use 'reg_defaults_raw' which tells the regcache driver
to actually read the codec registers and then fill the cache.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/sgtl5000.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 327b443..c59fae8 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1470,8 +1470,8 @@ static const struct regmap_config sgtl5000_regmap = {
 	.readable_reg = sgtl5000_readable,
 
 	.cache_type = REGCACHE_RBTREE,
-	.reg_defaults = sgtl5000_reg_defaults,
-	.num_reg_defaults = ARRAY_SIZE(sgtl5000_reg_defaults),
+	.reg_defaults_raw = sgtl5000_reg_defaults,
+	.num_reg_defaults_raw = ARRAY_SIZE(sgtl5000_reg_defaults),
 };
 
 static int sgtl5000_i2c_probe(struct i2c_client *client,
-- 
1.7.9.5
