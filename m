From: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: [PATCH] ASoC: codecs/wm8978: Remove remuxing of GPIO1
	pin
Date: Thu, 15 Nov 2012 14:46:02 -0500
Message-ID: <1353008762-38012-1-git-send-email-emillbrandt@dekaresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from norco.coldhaus.com (norco.coldhaus.com [64.32.230.18])
 by alsa0.perex.cz (Postfix) with ESMTP id ED7F4261624
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2012 20:46:26 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org

Remove remuxing GPIO1.  Leave control of this up to the platform device.

Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>
---
 sound/soc/codecs/wm8978.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index e329187..2fcc6da 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -529,9 +529,6 @@ static int wm8978_configure_pll(struct snd_soc_codec *codec)
 			return idx;
 
 		wm8978->mclk_idx = idx;
-
-		/* GPIO1 into default mode as input - before configuring PLL */
-		snd_soc_update_bits(codec, WM8978_GPIO_CONTROL, 7, 0);
 	} else {
 		return -EINVAL;
 	}
-- 
1.7.2.5
