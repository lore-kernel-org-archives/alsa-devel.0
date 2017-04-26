From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 2/2] ASoC: codec: wm8960: Relax bit clock
	computation when using PLL
Date: Wed, 26 Apr 2017 16:09:52 +0300
Message-ID: <1493212192-7930-3-git-send-email-daniel.baluta@nxp.com>
References: <1493212192-7930-1-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on0064.outbound.protection.outlook.com [104.47.33.64])
 by alsa0.perex.cz (Postfix) with ESMTP id C7C552673CD
 for <alsa-devel@alsa-project.org>; Wed, 26 Apr 2017 15:10:10 +0200 (CEST)
In-Reply-To: <1493212192-7930-1-git-send-email-daniel.baluta@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, tiwai@suse.com, ckeepax@opensource.wolfsonmicro.com, arnd@arndb.de, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Daniel Baluta <daniel.baluta@nxp.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Bitclk is derived from sysclk using bclk_divs.
Sysclk can be derived in two ways:
	(1) directly from MLCK
	(2) MCLK via PLL

Commit 3c01b9ee2ab9d0d ("ASoC: codec: wm8960: Relax bit clock
computation")
relaxed bitclk computation when sysclk is directly derived from MCLK.

Lets do the same thing when sysclk is derived via PLL.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
Changes since v2:
	* rebase after changes in first patch in the series

 sound/soc/codecs/wm8960.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index d899623..9ed4557 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -679,6 +679,10 @@ int wm8960_configure_sysclk(struct wm8960_priv *wm8960, int mclk,
  *		- freq_out    = sysclk * sysclk_divs
  *		- 10 * sysclk = bclk * bclk_divs
  *
+ * 	If we cannot find an exact match for (sysclk, lrclk, bclk)
+ * 	triplet, we relax the bclk such that bclk is chosen as the
+ * 	closest available frequency greater than expected bclk.
+ *
  * @codec: codec structure
  * @freq_in: input frequency used to derive freq out via PLL
  * @sysclk_idx: sysclk_divs index for found sysclk
@@ -696,12 +700,14 @@ int wm8960_configure_pll(struct snd_soc_codec *codec, int freq_in,
 {
 	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
 	int sysclk, bclk, lrclk, freq_out;
-	int diff;
+	int diff, closest, best_freq_out;
 	int i, j, k;
 
 	bclk = wm8960->bclk;
 	lrclk = wm8960->lrclk;
+	closest = freq_in;
 
+	best_freq_out = -EINVAL;
 	*sysclk_idx = *dac_idx = *bclk_idx = -1;
 
 	for (i = 0; i < ARRAY_SIZE(sysclk_divs); ++i) {
@@ -722,10 +728,18 @@ int wm8960_configure_pll(struct snd_soc_codec *codec, int freq_in,
 					*bclk_idx = k;
 					return freq_out;
 				}
+				if (diff > 0 && closest > diff) {
+					*sysclk_idx = i;
+					*dac_idx = j;
+					*bclk_idx = k;
+					closest = diff;
+					best_freq_out = freq_out;
+				}
 			}
 		}
 	}
-	return -EINVAL;
+
+	return best_freq_out;
 }
 static int wm8960_configure_clocking(struct snd_soc_codec *codec)
 {
-- 
2.7.4
