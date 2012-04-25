From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: Make sure we disable FLL bypass
	when stopping the FLL
Date: Wed, 25 Apr 2012 09:52:53 +0100
Message-ID: <1335343973-19331-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BC82C104816
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Apr 2012 10:52:56 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, Kyung-Kwee Ryu <Kyung-Kwee.Ryu@wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Kyung-Kwee Ryu <Kyung-Kwee.Ryu@wolfsonmicro.com>

If FLL bypass is left enabled when we disable the CODEC then the output
clock will be left running which consumes a small amount of additional
current. Only enable bypass when there is an output.

Signed-off-by: Kyung-Kwee Ryu <Kyung-Kwee.Ryu@wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 4cebac4..746d3db 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -1982,7 +1982,7 @@ static int _wm8994_set_fll(struct snd_soc_codec *codec, int id, int src,
 			    WM8994_FLL1_ENA, 0);
 
 	if (wm8994->fll_byp && src == WM8994_FLL_SRC_BCLK &&
-	    freq_in == freq_out) {
+	    freq_in == freq_out && freq_out) {
 		dev_dbg(codec->dev, "Bypassing FLL%d\n", id + 1);
 		snd_soc_update_bits(codec, WM8994_FLL1_CONTROL_5 + reg_offset,
 				    WM8958_FLL1_BYP, WM8958_FLL1_BYP);
-- 
1.7.10
