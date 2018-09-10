From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH] ASoC: rockchip: add missing INTERLEAVED PCM
	attribute
Date: Tue, 11 Sep 2018 01:39:32 +0900
Message-ID: <20180910163932.13722-1-katsuhiro@katsuster.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www1102.sakura.ne.jp (www1102.sakura.ne.jp [219.94.129.142])
 by alsa0.perex.cz (Postfix) with ESMTP id EF03C2676EB
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2018 18:40:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>, alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org
Cc: Katsuhiro Suzuki <katsuhiro@katsuster.net>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This patch adds SNDRV_PCM_INFO_INTERLEAVED into PCM hardware info.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 sound/soc/rockchip/rockchip_pcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_pcm.c b/sound/soc/rockchip/rockchip_pcm.c
index f77538319221..9e7b5fa4cf59 100644
--- a/sound/soc/rockchip/rockchip_pcm.c
+++ b/sound/soc/rockchip/rockchip_pcm.c
@@ -21,7 +21,8 @@ static const struct snd_pcm_hardware snd_rockchip_hardware = {
 	.info			= SNDRV_PCM_INFO_MMAP |
 				  SNDRV_PCM_INFO_MMAP_VALID |
 				  SNDRV_PCM_INFO_PAUSE |
-				  SNDRV_PCM_INFO_RESUME,
+				  SNDRV_PCM_INFO_RESUME |
+				  SNDRV_PCM_INFO_INTERLEAVED,
 	.period_bytes_min	= 32,
 	.period_bytes_max	= 8192,
 	.periods_min		= 1,
-- 
2.18.0
