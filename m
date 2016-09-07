From: Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: [PATCH v3] ASoC: rockchip: spdif: restore register during
 runtime_suspend/resume cycle
Date: Wed,  7 Sep 2016 14:30:21 +0800
Message-ID: <1473229821-54139-1-git-send-email-sugar.zhang@rock-chips.com>
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
To: dianders@chromium.org, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Sugar Zhang <sugar.zhang@rock-chips.com>, linux-rockchip@lists.infradead.org, Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

when step into runtime_suspend, spdif pd will be disabled and loss state.
so need to restore register when runtime_resume.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>

---

Changes in v3:
- remove unneeded initialization

Changes in v2:
- remove system suspend/resume and restore register
  in runtime_suspend/resume per Doug Anderson's suggestion

 sound/soc/rockchip/rockchip_spdif.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_spdif.c b/sound/soc/rockchip/rockchip_spdif.c
index 4ca2657..fa8101d 100644
--- a/sound/soc/rockchip/rockchip_spdif.c
+++ b/sound/soc/rockchip/rockchip_spdif.c
@@ -65,6 +65,7 @@ static int __maybe_unused rk_spdif_runtime_suspend(struct device *dev)
 {
 	struct rk_spdif_dev *spdif = dev_get_drvdata(dev);
 
+	regcache_cache_only(spdif->regmap, true);
 	clk_disable_unprepare(spdif->mclk);
 	clk_disable_unprepare(spdif->hclk);
 
@@ -88,7 +89,16 @@ static int __maybe_unused rk_spdif_runtime_resume(struct device *dev)
 		return ret;
 	}
 
-	return 0;
+	regcache_cache_only(spdif->regmap, false);
+	regcache_mark_dirty(spdif->regmap);
+
+	ret = regcache_sync(spdif->regmap);
+	if (ret) {
+		clk_disable_unprepare(spdif->mclk);
+		clk_disable_unprepare(spdif->hclk);
+	}
+
+	return ret;
 }
 
 static int rk_spdif_hw_params(struct snd_pcm_substream *substream,
-- 
1.9.1
