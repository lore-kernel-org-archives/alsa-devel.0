From: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: [PATCH] ASoC: codecs/wm8978: pll incorrectly
	configured when codec is master
Date: Fri,  2 Nov 2012 17:05:44 -0400
Message-ID: <1351890344-9938-1-git-send-email-emillbrandt@dekaresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from norco.coldhaus.com (norco.coldhaus.com [64.32.230.18])
 by alsa0.perex.cz (Postfix) with ESMTP id EEC872650F6
 for <alsa-devel@alsa-project.org>; Fri,  2 Nov 2012 22:06:00 +0100 (CET)
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

When MCLK is supplied externally and BCLK and LRC are configured as outputs
(codec is master), the PLL values are only calculated correctly on the first
transmission.  On subsequent transmissions, at differenct sample rates, the
wrong PLL values are used.  Test for f_opclk instead of f_pllout to determine
if the PLL values are needed.

Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>
---
 sound/soc/codecs/wm8978.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index a706262..e329187 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -784,7 +784,7 @@ static int wm8978_hw_params(struct snd_pcm_substream *substream,
 		wm8978->mclk_idx = -1;
 		f_sel = wm8978->f_mclk;
 	} else {
-		if (!wm8978->f_pllout) {
+		if (!wm8978->f_opclk) {
 			/* We only enter here, if OPCLK is not used */
 			int ret = wm8978_configure_pll(codec);
 			if (ret < 0)
-- 
1.7.2.5
