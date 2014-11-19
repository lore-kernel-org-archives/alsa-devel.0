From: Jianqun Xu <jay.xu@rock-chips.com>
Subject: [PATCH v2 2/2] ASoC: rockchip: i2s: add support for
	grabbing output clock to codec
Date: Wed, 19 Nov 2014 16:09:27 +0800
Message-ID: <1416384567-29476-1-git-send-email-jay.xu@rock-chips.com>
References: <1416366468-4744-1-git-send-email-jay.xu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 876A1265455
 for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2014 09:09:34 +0100 (CET)
In-Reply-To: <1416366468-4744-1-git-send-email-jay.xu@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: heiko@sntech.de, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, huangtao@rock-chips.com
Cc: Sonny Rao <sonnyrao@chromium.org>, Jianqun Xu <jay.xu@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

Patch is from Sonny Rao <sonnyrao@chromium.org>

We need to claim the clock which is driving the codec so that when we enable
clock gating, we continue to clock the codec when needed.  I make this an
optional clock since there might be some applications where we don't need it
but can still use the I2S block.

Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
---
changes since v1:
- modify commit message

 sound/soc/rockchip/rockchip_i2s.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index c74ba37..2820ade 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -28,6 +28,7 @@ struct rk_i2s_dev {
 
 	struct clk *hclk;
 	struct clk *mclk;
+	struct clk *oclk;
 
 	struct snd_dmaengine_dai_dma_data capture_dma_data;
 	struct snd_dmaengine_dai_dma_data playback_dma_data;
@@ -439,6 +440,14 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 		return PTR_ERR(i2s->mclk);
 	}
 
+	i2s->oclk = devm_clk_get(&pdev->dev, "i2s_clk_out");
+	if (IS_ERR(i2s->oclk)) {
+		dev_dbg(&pdev->dev, "Didn't find output clock\n");
+		i2s->oclk = NULL;
+	}
+	if (i2s->oclk)
+		ret = clk_prepare_enable(i2s->oclk);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(regs))
@@ -505,6 +514,8 @@ static int rockchip_i2s_remove(struct platform_device *pdev)
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		i2s_runtime_suspend(&pdev->dev);
 
+	if (i2s->oclk)
+		clk_disable_unprepare(i2s->oclk);
 	clk_disable_unprepare(i2s->mclk);
 	clk_disable_unprepare(i2s->hclk);
 	snd_dmaengine_pcm_unregister(&pdev->dev);
-- 
1.9.1
