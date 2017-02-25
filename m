From: Mihai-Valentin DUMITRU <mihai.dumitru2201@gmail.com>
Subject: [PATCH] ASoC: rockchip: i2s: Remove unnecessary 'out of memory'
 message
Date: Sat, 25 Feb 2017 12:18:34 +0200
Message-ID: <20170225101834.28232-1-mihai.dumitru2201@stud.acs.upb.ro>
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
To: perex@perex.cz, tiwai@suse.com, heiko@sntech.de
Cc: alsa-devel@alsa-project.org, Mihai-Valentin DUMITRU <mihai.dumitru2201@gmail.com>, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, broonie@kernel.org, Mihai-Valentin DUMITRU <mihai.dumitru2201@stud.acs.upb.ro>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This was reported by checkpatch.pl

Signed-off-by: Mihai-Valentin DUMITRU <mihai.dumitru2201@gmail.com>
---
 sound/soc/rockchip/rockchip_i2s.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 974915cb4c4f..d02a1045fc0b 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -551,10 +551,8 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 	int val;
 
 	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
-	if (!i2s) {
-		dev_err(&pdev->dev, "Can't allocate rk_i2s_dev\n");
+	if (!i2s)
 		return -ENOMEM;
-	}
 
 	i2s->dev = &pdev->dev;
 
-- 
2.11.1
