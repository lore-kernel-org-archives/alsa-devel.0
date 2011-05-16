From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Don't restart an already running
	WM8958 DSP2
Date: Sun, 15 May 2011 21:18:16 -0700
Message-ID: <1305519496-23078-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1305519496-23078-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 272BE243FD
	for <alsa-devel@alsa-project.org>;
	Mon, 16 May 2011 06:18:18 +0200 (CEST)
In-Reply-To: <1305519496-23078-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Don't want to upset the DSP.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8958-dsp2.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8958-dsp2.c b/sound/soc/codecs/wm8958-dsp2.c
index ca26779..0293763 100644
--- a/sound/soc/codecs/wm8958-dsp2.c
+++ b/sound/soc/codecs/wm8958-dsp2.c
@@ -362,6 +362,10 @@ static void wm8958_dsp_apply(struct snd_soc_codec *codec, int path, int start)
 		path, wm8994->dsp_active, start, pwr_reg, reg);
 
 	if (start && ena) {
+		/* If the DSP is already running then noop */
+		if (reg & WM8958_DSP2_ENA)
+			return;
+
 		/* If either AIFnCLK is not yet enabled postpone */
 		if (!(snd_soc_read(codec, WM8994_AIF1_CLOCKING_1)
 		      & WM8994_AIF1CLK_ENA_MASK) &&
-- 
1.7.5.1
