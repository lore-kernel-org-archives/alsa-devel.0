From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: [PATCH] ASoC: rockchip: Select DMA_PL330 by RK3399 audio
Date: Sun, 14 Apr 2019 14:02:12 -0700
Message-ID: <20190414210212.2144-1-alyssa@rosenzweig.io>
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
To: linux-rockchip@lists.infradead.org
Cc: alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Alyssa Rosenzweig <alyssa@rosenzweig.io>
List-Id: alsa-devel@alsa-project.org

Without the appropriate DMA controller selected, the RK3399 audio
drivers compile but fail immediately. Accordingly, selecting the RK3399
audio without the corresponding PL330 controller is an invalid
configuration. Prevent errors (otherwise forcing the driver to unload at
runtime)  by an appropriate `select` directive in the Kconfig.

Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
---
 sound/soc/rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
index 957046ac6c8c..fa3cab461a60 100644
--- a/sound/soc/rockchip/Kconfig
+++ b/sound/soc/rockchip/Kconfig
@@ -73,6 +73,7 @@ config SND_SOC_RK3399_GRU_SOUND
 	select SND_SOC_RT5514_SPI
 	select SND_SOC_HDMI_CODEC
 	select SND_SOC_DMIC
+	select PL330_DMA
 	help
 	  Say Y or M here if you want to add support multiple codecs for SoC
 	  audio on Rockchip RK3399 GRU boards.
-- 
2.20.1
