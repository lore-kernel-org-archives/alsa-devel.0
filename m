From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH RESEND 1/4] ASoC: es8328: Simplify rates
	definition
Date: Wed,  1 Mar 2017 10:11:04 +0100
Message-ID: <20170301091107.10578-2-romain.perier@collabora.com>
References: <20170301091107.10578-1-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by alsa0.perex.cz (Postfix) with ESMTP id B33B4266F16
 for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2017 10:11:25 +0100 (CET)
In-Reply-To: <20170301091107.10578-1-romain.perier@collabora.com>
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

Currently most of the standard rates are supported by this driver.
Instead of defining each supported rate one by one, we use the SND macro
SNDRV_PCM_RATE_8000_48000. Also adds support for 88.2khz as the codec
supports it and the sys clocks are already supported.

Signed-off-by: Romain Perier <romain.perier@collabora.com>
---
 sound/soc/codecs/es8328.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index 3f84fbd..5ad7161 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -70,13 +70,8 @@ static const char * const supply_names[ES8328_SUPPLY_NUM] = {
 };
 
 #define ES8328_RATES (SNDRV_PCM_RATE_96000 | \
-		SNDRV_PCM_RATE_48000 | \
-		SNDRV_PCM_RATE_44100 | \
-		SNDRV_PCM_RATE_32000 | \
-		SNDRV_PCM_RATE_22050 | \
-		SNDRV_PCM_RATE_16000 | \
-		SNDRV_PCM_RATE_11025 | \
-		SNDRV_PCM_RATE_8000)
+		SNDRV_PCM_RATE_88200 | \
+		SNDRV_PCM_RATE_8000_48000)
 #define ES8328_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
 		SNDRV_PCM_FMTBIT_S18_3LE | \
 		SNDRV_PCM_FMTBIT_S20_3LE | \
-- 
2.9.3
