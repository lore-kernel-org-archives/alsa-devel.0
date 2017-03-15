From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v2 14/14] ASoC: sunxi: simplify optional reset
	handling
Date: Wed, 15 Mar 2017 12:31:57 +0100
Message-ID: <20170315113157.13218-1-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.4.pengutronix.de (metis.ext.4.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 39141266861
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 12:31:58 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

As of commit bb475230b8e5 ("reset: make optional functions really
optional"), the reset framework API calls use NULL pointers to describe
optional, non-present reset controls.

This allows to return errors from devm_reset_control_get_optional and to
call reset_control_deassert unconditionally.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Mark Brown <broonie@kernel.org>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 sound/soc/sunxi/sun4i-spdif.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index eaefd07a5ed08..cdf8a6d86010c 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -521,13 +521,12 @@ static int sun4i_spdif_probe(struct platform_device *pdev)
 
 	if (quirks->has_reset) {
 		host->rst = devm_reset_control_get_optional(&pdev->dev, NULL);
-		if (IS_ERR(host->rst) && PTR_ERR(host->rst) == -EPROBE_DEFER) {
-			ret = -EPROBE_DEFER;
+		if (IS_ERR(host->rst)) {
+			ret = PTR_ERR(host->rst);
 			dev_err(&pdev->dev, "Failed to get reset: %d\n", ret);
 			return ret;
 		}
-		if (!IS_ERR(host->rst))
-			reset_control_deassert(host->rst);
+		reset_control_deassert(host->rst);
 	}
 
 	ret = devm_snd_soc_register_component(&pdev->dev,
-- 
2.11.0
