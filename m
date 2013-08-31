From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 08/14] ASoC: kirkwood: prefer external clock over internal
 clock
Date: Sat, 31 Aug 2013 13:42:36 +0100
Message-ID: <E1VFkVg-0003Ip-G7@rmk-PC.arm.linux.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130831123458.GF6617@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jean-Francois Moine <moinejf@free.fr>, Jason Cooper <jason@lakedaemon.net>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/kirkwood/kirkwood-i2s.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 84dd9b0..8e10369 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -104,20 +104,20 @@ static void kirkwood_set_rate(struct snd_soc_dai *dai,
 {
 	uint32_t clks_ctrl;
 
-	if (rate == 44100 || rate == 48000 || rate == 96000) {
-		/* use internal dco for supported rates */
-		dev_dbg(dai->dev, "%s: dco set rate = %lu\n",
-			__func__, rate);
-		kirkwood_set_dco(priv->io, rate);
-
-		clks_ctrl = KIRKWOOD_MCLK_SOURCE_DCO;
-	} else if (!IS_ERR(priv->extclk)) {
+	if (!IS_ERR(priv->extclk)) {
 		/* use optional external clk for other rates */
 		dev_dbg(dai->dev, "%s: extclk set rate = %lu -> %lu\n",
 			__func__, rate, 256 * rate);
 		clk_set_rate(priv->extclk, 256 * rate);
 
 		clks_ctrl = KIRKWOOD_MCLK_SOURCE_EXTCLK;
+	} else if (rate == 44100 || rate == 48000 || rate == 96000) {
+		/* use internal dco for supported rates */
+		dev_dbg(dai->dev, "%s: dco set rate = %lu\n",
+			__func__, rate);
+		kirkwood_set_dco(priv->io, rate);
+
+		clks_ctrl = KIRKWOOD_MCLK_SOURCE_DCO;
 	}
 	writel(clks_ctrl, priv->io + KIRKWOOD_CLOCKS_CTRL);
 }
-- 
1.7.4.4
