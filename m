From: Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: [PATCH v1 4/4] ASoC: rockchip: i2s: fixup clk div
Date: Fri,  9 Jun 2017 16:52:49 +0800
Message-ID: <1496998369-30556-5-git-send-email-sugar.zhang@rock-chips.com>
References: <1496998369-30556-1-git-send-email-sugar.zhang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.140])
 by alsa0.perex.cz (Postfix) with ESMTP id 0ED692675B6
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 10:57:00 +0200 (CEST)
In-Reply-To: <1496998369-30556-1-git-send-email-sugar.zhang@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: heiko@sntech.de, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Sugar Zhang <sugar.zhang@rock-chips.com>, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

we found mclk maybe not precise as required because of PLL,
but it still can be used and no side effect. for example, if we
require mclk 11289600, but get 11289598, it doesn't matter.
so using DIV_ROUND_CLOSEST to fix it.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>

---

 sound/soc/rockchip/rockchip_i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 2a15a00..b56e00d 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -282,10 +282,10 @@ static int rockchip_i2s_hw_params(struct snd_pcm_substream *substream,
 	if (i2s->is_master_mode) {
 		mclk_rate = clk_get_rate(i2s->mclk);
 		bclk_rate = i2s->bclk_fs * params_rate(params);
-		if (bclk_rate && mclk_rate % bclk_rate)
+		if (!bclk_rate)
 			return -EINVAL;
 
-		div_bclk = mclk_rate / bclk_rate;
+		div_bclk = DIV_ROUND_CLOSEST(mclk_rate, bclk_rate);
 		div_lrck = bclk_rate / params_rate(params);
 		regmap_update_bits(i2s->regmap, I2S_CKR,
 				   I2S_CKR_MDIV_MASK,
-- 
1.9.1
