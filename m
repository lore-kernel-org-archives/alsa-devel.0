From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 08/14] ASoC: n810: replace BUG() with BUG_ON()
Date: Tue, 14 Apr 2009 13:33:07 +0100
Message-ID: <1239712393-6428-9-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090414123220.GA6342@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CE94D10385A
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 14:33:16 +0200 (CEST)
In-Reply-To: <20090414123220.GA6342@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Alexander Beregalov <a.beregalov@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Alexander Beregalov <a.beregalov@gmail.com>

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/omap/n810.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index a6d1178..e54e1c2 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -383,10 +383,9 @@ static int __init n810_soc_init(void)
 	clk_set_parent(sys_clkout2_src, func96m_clk);
 	clk_set_rate(sys_clkout2, 12000000);
 
-	if (gpio_request(N810_HEADSET_AMP_GPIO, "hs_amp") < 0)
-		BUG();
-	if (gpio_request(N810_SPEAKER_AMP_GPIO, "spk_amp") < 0)
-		BUG();
+	BUG_ON((gpio_request(N810_HEADSET_AMP_GPIO, "hs_amp") < 0) ||
+	       (gpio_request(N810_SPEAKER_AMP_GPIO, "spk_amp") < 0));
+
 	gpio_direction_output(N810_HEADSET_AMP_GPIO, 0);
 	gpio_direction_output(N810_SPEAKER_AMP_GPIO, 0);
 
-- 
1.6.2.2
