From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] ASoC: Enable rbtree compression for
	WM8994/58 register cache
Date: Fri, 26 Nov 2010 17:23:42 +0000
Message-ID: <1290792224-21758-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1290792224-21758-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6A3F2243E3
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 18:23:50 +0100 (CET)
In-Reply-To: <1290792224-21758-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The WM8994 and WM8958 register map is relatively sparse so benefits
from compression. The rbtree compression gives better results than
LZO for both memory and CPU consumption on a map as sparse as this.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index d9c6dd5..5f203c5 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3033,6 +3033,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8994 = {
 	.reg_cache_size = WM8994_CACHE_SIZE,
 	.reg_cache_default = wm8994_reg_defaults,
 	.reg_word_size = 2,
+	.compress_type = SND_SOC_RBTREE_COMPRESSION,
 };
 
 static int __devinit wm8994_probe(struct platform_device *pdev)
-- 
1.7.1
