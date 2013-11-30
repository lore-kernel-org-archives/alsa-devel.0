From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH] ASoC: omap: n810: Convert to
	clk_prepare_enable/clk_disable_unprepare
Date: Sat, 30 Nov 2013 18:05:28 +0200
Message-ID: <1385827528-32149-1-git-send-email-jarkko.nikula@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 39BCD2616E1
 for <alsa-devel@alsa-project.org>; Sat, 30 Nov 2013 17:05:45 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

N810 audio driver has stopped working at some point. Probably when
OMAP2 was converted to common clock framework since now call to clk_enable
dumps the stack trace in drivers/clk/clk.c: __clk_enable() due
clk->prepare_count is zero.

Fix this by converting clk_enable/_disable calls to those that take care
of clock prepare/unprepare.

I'm not queueing this to linux-stable since OMAP2 common clock framework
conversion in commit ed1ebc4948fd ("ARM: OMAP2: clock: Convert to common clk")
happened before N810 was really usable in mainline and user base for N810 is
anyway small. Potential linux-stable candidates are only those after
commit 3d3a6d18abc6 ("watchdog: introduce retu_wdt driver").

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 sound/soc/omap/n810.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index 6d216cb6c19b..3fde9e402710 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -100,12 +100,12 @@ static int n810_startup(struct snd_pcm_substream *substream)
 				     SNDRV_PCM_HW_PARAM_CHANNELS, 2, 2);
 
 	n810_ext_control(&codec->dapm);
-	return clk_enable(sys_clkout2);
+	return clk_prepare_enable(sys_clkout2);
 }
 
 static void n810_shutdown(struct snd_pcm_substream *substream)
 {
-	clk_disable(sys_clkout2);
+	clk_disable_unprepare(sys_clkout2);
 }
 
 static int n810_hw_params(struct snd_pcm_substream *substream,
-- 
1.8.4.3
