From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH] ASoC: rockchip: add missing slave_config
	setting for I2S
Date: Sun, 11 Nov 2018 00:18:44 +0900
Message-ID: <20181110151844.21362-1-katsuhiro@katsuster.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www1102.sakura.ne.jp (www1102.sakura.ne.jp [219.94.129.142])
 by alsa0.perex.cz (Postfix) with ESMTP id 72551267B35
 for <alsa-devel@alsa-project.org>; Sat, 10 Nov 2018 16:19:51 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Heiko Stuebner <heiko@sntech.de>, alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org
Cc: Katsuhiro Suzuki <katsuhiro@katsuster.net>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This patch adds missing prepare_sleve_config that is needed for
setup the DMA slave channel for I2S.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 sound/soc/rockchip/rockchip_pcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/rockchip/rockchip_pcm.c b/sound/soc/rockchip/rockchip_pcm.c
index 9e7b5fa4cf59..4ac78d7a4b2d 100644
--- a/sound/soc/rockchip/rockchip_pcm.c
+++ b/sound/soc/rockchip/rockchip_pcm.c
@@ -33,6 +33,7 @@ static const struct snd_pcm_hardware snd_rockchip_hardware = {
 
 static const struct snd_dmaengine_pcm_config rk_dmaengine_pcm_config = {
 	.pcm_hardware = &snd_rockchip_hardware,
+	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
 	.prealloc_buffer_size = 32 * 1024,
 };
 
-- 
2.19.1
