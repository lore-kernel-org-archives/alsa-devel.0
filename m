From: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Subject: [PATCH 1/2] ASoC: TWL6040: Fix playback with 19.2 Mhz
	MCLK
Date: Thu, 20 May 2010 17:53:07 -0500
Message-ID: <1274395988-19801-2-git-send-email-jorge.candelaria@ti.com>
References: <1274395988-19801-1-git-send-email-jorge.candelaria@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 1DF1B103816
	for <alsa-devel@alsa-project.org>;
	Fri, 21 May 2010 01:05:27 +0200 (CEST)
In-Reply-To: <1274395988-19801-1-git-send-email-jorge.candelaria@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Margarita Olaya Cabrera <magi.olaya@ti.com>, Jorge Eduardo Candelaria <jorge.candelaria@ti.com>, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

When using MCLK is configured for 19.2 Mhz, clock slicer should be
enabled and HPPLL should be bypassed in clock path.

Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
---
 sound/soc/codecs/twl6040.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index af36346..85dd4fb 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -928,7 +928,7 @@ static int twl6040_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		case 19200000:
 			/* mclk input, pll disabled */
 			hppllctl |= TWL6040_MCLK_19200KHZ |
-				    TWL6040_HPLLSQRBP |
+				    TWL6040_HPLLSQRENA |
 				    TWL6040_HPLLBP;
 			break;
 		case 26000000:
-- 
1.6.3.3
