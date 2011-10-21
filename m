From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: wm8996: Fix wrong mask for setting
 WM8996_AIF_CLOCKING_2
Date: Fri, 21 Oct 2011 10:44:07 +0800
Message-ID: <1319165047.4352.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id BED90103A69
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Oct 2011 04:44:15 +0200 (CEST)
Received: by ywp31 with SMTP id 31so60654ywp.38
	for <alsa-devel@alsa-project.org>; Thu, 20 Oct 2011 19:44:13 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8996.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 1d7b174..645c980 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -1920,7 +1920,7 @@ static int wm8996_hw_params(struct snd_pcm_substream *substream,
 	snd_soc_update_bits(codec, lrclk_reg, WM8996_AIF1RX_RATE_MASK,
 			    lrclk);
 	snd_soc_update_bits(codec, WM8996_AIF_CLOCKING_2,
-			    WM8996_DSP1_DIV_SHIFT << dsp_shift, dsp);
+			    WM8996_DSP1_DIV_MASK << dsp_shift, dsp);
 
 	return 0;
 }
-- 
1.7.5.4
