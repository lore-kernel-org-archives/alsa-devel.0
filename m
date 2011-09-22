From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Set idle_bias_off for WM1250 EV1
Date: Thu, 22 Sep 2011 11:12:41 +0100
Message-ID: <1316686361-5126-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1316686361-5126-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E3D4B103AFF
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Sep 2011 12:12:44 +0200 (CEST)
In-Reply-To: <1316686361-5126-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The WM1250 EV1 is functionally digital in a system (the analogue I/O
is either ground referenced or always powered) so flag it as idle_bias_off.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm1250-ev1.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm1250-ev1.c b/sound/soc/codecs/wm1250-ev1.c
index 0554b88..cd0ec0f 100644
--- a/sound/soc/codecs/wm1250-ev1.c
+++ b/sound/soc/codecs/wm1250-ev1.c
@@ -104,6 +104,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm1250_ev1 = {
 	.num_dapm_routes = ARRAY_SIZE(wm1250_ev1_dapm_routes),
 
 	.set_bias_level = wm1250_ev1_set_bias_level,
+	.idle_bias_off = true,
 };
 
 static int __devinit wm1250_ev1_pdata(struct i2c_client *i2c)
-- 
1.7.6.3
