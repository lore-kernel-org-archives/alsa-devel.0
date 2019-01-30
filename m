From: lsh <lshua312@163.com>
Subject: [PATCH] ASoC: rockchip: fix small typo
Date: Wed, 30 Jan 2019 22:33:35 +0800
Message-ID: <1548858815-20161-1-git-send-email-lshua312@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, heiko@sntech.de, linux-kernel@vger.kernel.org, lsh <lshua312@163.com>, tiwai@suse.com, perex@perex.cz, linux-rockchip@lists.infradead.org, broonie@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

codec_dai -> cpu_dai

Signed-off-by: lsh <lshua312@163.com>
---
 sound/soc/rockchip/rockchip_rt5645.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_rt5645.c b/sound/soc/rockchip/rockchip_rt5645.c
index 881c324..f88adf0 100644
--- a/sound/soc/rockchip/rockchip_rt5645.c
+++ b/sound/soc/rockchip/rockchip_rt5645.c
@@ -95,14 +95,16 @@ static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
 	ret = snd_soc_dai_set_sysclk(cpu_dai, 0, mclk,
 				     SND_SOC_CLOCK_OUT);
 	if (ret < 0) {
-		dev_err(codec_dai->dev, "Can't set codec clock %d\n", ret);
+		dev_err(cpu_dai->dev,
+			"Can't set clock for cpu_dai %d\n", ret);
 		return ret;
 	}
 
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
 				     SND_SOC_CLOCK_IN);
 	if (ret < 0) {
-		dev_err(codec_dai->dev, "Can't set codec clock %d\n", ret);
+		dev_err(codec_dai->dev,
+			"Can't set clock for codec_dai %d\n", ret);
 		return ret;
 	}
 
-- 
1.9.1
