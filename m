From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: sta32x: Optimize the array work to find
 rate_min and rate_max
Date: Sun, 01 Jan 2012 18:36:14 +0800
Message-ID: <1325414174.4978.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 83B3610381A
	for <alsa-devel@alsa-project.org>; Sun,  1 Jan 2012 11:36:29 +0100 (CET)
Received: by iaae16 with SMTP id e16so26987643iaa.38
	for <alsa-devel@alsa-project.org>; Sun, 01 Jan 2012 02:36:25 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

For a given ir and fs, there is at most one possible match for the case
mclk_ratios[ir][j].ratio * fs == freq.
Thus we can break from the inner loop once a match is found.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/sta32x.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index fbd1450..7db6fa5 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -522,6 +522,7 @@ static int sta32x_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 						rate_min = fs;
 					if (fs > rate_max)
 						rate_max = fs;
+					break;
 				}
 			}
 		}
-- 
1.7.5.4
