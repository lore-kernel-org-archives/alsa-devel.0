From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Fix TDM slot length handling in
	arizona_hw_params
Date: Tue, 12 Aug 2014 15:30:32 +0100
Message-ID: <1407853832-7176-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2531D2651C9
 for <alsa-devel@alsa-project.org>; Tue, 12 Aug 2014 16:39:10 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Nikesh Oswal <Nikesh.Oswal@wolfsonmicro.com>

TDM slot length was set same as word length, regardless of the value
received in set_tdm_slot. This patch sets the TDM slot length correctly
as received in set_tdm_slot DAI callback

Signed-off-by: Nikesh Oswal <Nikesh.Oswal@wolfsonmicro.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 2f2e91a..4dfab95 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1278,6 +1278,8 @@ static int arizona_hw_params(struct snd_pcm_substream *substream,
 	else
 		rates = &arizona_48k_bclk_rates[0];
 
+	wl = snd_pcm_format_width(params_format(params));
+
 	if (tdm_slots) {
 		arizona_aif_dbg(dai, "Configuring for %d %d bit TDM slots\n",
 				tdm_slots, tdm_width);
@@ -1285,6 +1287,7 @@ static int arizona_hw_params(struct snd_pcm_substream *substream,
 		channels = tdm_slots;
 	} else {
 		bclk_target = snd_soc_params_to_bclk(params);
+		tdm_width = wl;
 	}
 
 	if (chan_limit && chan_limit < channels) {
@@ -1319,8 +1322,7 @@ static int arizona_hw_params(struct snd_pcm_substream *substream,
 	arizona_aif_dbg(dai, "BCLK %dHz LRCLK %dHz\n",
 			rates[bclk], rates[bclk] / lrclk);
 
-	wl = snd_pcm_format_width(params_format(params));
-	frame = wl << ARIZONA_AIF1TX_WL_SHIFT | wl;
+	frame = wl << ARIZONA_AIF1TX_WL_SHIFT | tdm_width;
 
 	reconfig = arizona_aif_cfg_changed(codec, base, bclk, lrclk, frame);
 
-- 
1.7.2.5
