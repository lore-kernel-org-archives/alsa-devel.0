From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH 3/4] ASoC: es8328: Enabling support for 192k
Date: Fri, 24 Feb 2017 17:01:03 +0100
Message-ID: <20170224160104.29354-4-romain.perier@collabora.com>
References: <20170224160104.29354-1-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by alsa0.perex.cz (Postfix) with ESMTP id C1EF62669EA
 for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2017 17:01:17 +0100 (CET)
In-Reply-To: <20170224160104.29354-1-romain.perier@collabora.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>
Cc: Romain Perier <romain.perier@collabora.com>, linux-rockchip@lists.infradead.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>
List-Id: alsa-devel@alsa-project.org

The master and slave modes don't share the same table for MCLK/LRCLK
ratios. The slaves mode has bigger ratios that allow to use BCLK that
matche sampling frequency of 192khz.

This commit enables this rate only for slave mode, i.e it does not
declare this frequency in sysclk_contraints, resulting to an error in
master mode (not supported CLK).

Signed-off-by: Romain Perier <romain.perier@collabora.com>
---
 sound/soc/codecs/es8328.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index 1363a68..ed7cc42 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -69,7 +69,8 @@ static const char * const supply_names[ES8328_SUPPLY_NUM] = {
 	"HPVDD",
 };
 
-#define ES8328_RATES (SNDRV_PCM_RATE_96000 | \
+#define ES8328_RATES (SNDRV_PCM_RATE_192000 | \
+		SNDRV_PCM_RATE_96000 | \
 		SNDRV_PCM_RATE_88200 | \
 		SNDRV_PCM_RATE_8000_48000)
 #define ES8328_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
-- 
2.9.3
