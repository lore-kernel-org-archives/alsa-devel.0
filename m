From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH] ASoC: nau8825: correct typo in biquad filter
	coefficients
Date: Fri, 3 Jun 2016 12:02:16 +0800
Message-ID: <1464926536-2685-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C847D26520A
 for <alsa-devel@alsa-project.org>; Fri,  3 Jun 2016 06:01:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

There is typo in the name of biquad filter coefficients control.
The patch is to fix the typo.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8825.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index dbb91aa..43cb677 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -386,7 +386,7 @@ static const struct snd_kcontrol_new nau8825_controls[] = {
 	SOC_ENUM("DAC Oversampling Rate", nau8825_dac_oversampl_enum),
 	/* programmable biquad filter */
 	SOC_ENUM("BIQ Path Select", nau8825_biq_path_enum),
-	SND_SOC_BYTES_EXT("BIQ Coefficeints", 20,
+	SND_SOC_BYTES_EXT("BIQ Coefficients", 20,
 		  nau8825_biq_coeff_get, nau8825_biq_coeff_put),
 };
 
-- 
2.6.4
