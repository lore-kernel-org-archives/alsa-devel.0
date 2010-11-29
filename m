From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/5] ASoC: Fix compile error for nuc900-ac97.c
Date: Mon, 29 Nov 2010 17:39:10 +0800
Message-ID: <1291023550.22911.2.camel@mola>
References: <1291023491.22911.1.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1291023491.22911.1.camel@mola>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wan ZongShun <mcuos.com@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fix below compile error by add a missing ';'.

  CC      sound/soc/nuc900/nuc900-ac97.o
sound/soc/nuc900/nuc900-ac97.c:300: warning: initialization from incompatible pointer type
sound/soc/nuc900/nuc900-ac97.c:301: warning: initialization from incompatible pointer type
sound/soc/nuc900/nuc900-ac97.c:318: error: expected ',' or ';' before 'static'
sound/soc/nuc900/nuc900-ac97.c:405: error: 'nuc900_ac97_drvprobe' undeclared here (not in a function)
make[3]: *** [sound/soc/nuc900/nuc900-ac97.o] Error 1
make[2]: *** [sound/soc/nuc900] Error 2
make[1]: *** [sound/soc] Error 2
make: *** [sound] Error 2

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/nuc900/nuc900-ac97.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
index e00e39d..4f056b4 100644
--- a/sound/soc/nuc900/nuc900-ac97.c
+++ b/sound/soc/nuc900/nuc900-ac97.c
@@ -313,7 +313,7 @@ static struct snd_soc_dai_driver nuc900_ac97_dai = {
 		.channels_max	= 2,
 	},
 	.ops = &nuc900_ac97_dai_ops,
-}
+};
 
 static int __devinit nuc900_ac97_drvprobe(struct platform_device *pdev)
 {
-- 
1.7.2
