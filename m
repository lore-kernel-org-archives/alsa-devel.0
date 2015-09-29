From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 2/2] ASoC: sun4i-codec: Remove redundant
	SND_PCM_RATE_KNOT
Date: Tue, 29 Sep 2015 21:43:18 +0200
Message-ID: <1443555798-16001-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1443555798-16001-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (down.free-electrons.com
 [37.187.137.238])
 by alsa0.perex.cz (Postfix) with ESMTP id 542BE260666
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 07:04:06 +0200 (CEST)
In-Reply-To: <1443555798-16001-1-git-send-email-maxime.ripard@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Emilio Lopez <emilio@elopez.com.ar>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

The SND_PCM_RATE_KNOT covers all the rate settings, even though some that
we don't support, while we also list all the rate we support. Simply remove
it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 sound/soc/sunxi/sun4i-codec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 28834129bea3..e5d195fe491e 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -389,8 +389,7 @@ static struct snd_soc_dai_driver sun4i_codec_dai = {
 		.rate_max	= 192000,
 		.rates		= SNDRV_PCM_RATE_8000_48000 |
 				  SNDRV_PCM_RATE_96000 |
-				  SNDRV_PCM_RATE_192000 |
-				  SNDRV_PCM_RATE_KNOT,
+				  SNDRV_PCM_RATE_192000,
 		.formats	= SNDRV_PCM_FMTBIT_S16_LE |
 				  SNDRV_PCM_FMTBIT_S32_LE,
 		.sig_bits	= 24,
-- 
2.5.3
