From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 1/4] ASoC: rt5677: Replace the string
	"micbias1" to "MICBIAS1"
Date: Tue, 10 Jun 2014 14:35:23 +0800
Message-ID: <1402382126-704-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 09EAC265218
 for <alsa-devel@alsa-project.org>; Tue, 10 Jun 2014 08:35:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch replaces the string "micbias1" to "MICBIAS1".

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 833231e..75268a7 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -1685,7 +1685,7 @@ static const struct snd_soc_dapm_widget rt5677_dapm_widgets[] = {
 
 	/* Input Side */
 	/* micbias */
-	SND_SOC_DAPM_SUPPLY("micbias1", RT5677_PWR_ANLG2, RT5677_PWR_MB1_BIT,
+	SND_SOC_DAPM_SUPPLY("MICBIAS1", RT5677_PWR_ANLG2, RT5677_PWR_MB1_BIT,
 		0, rt5677_set_micbias1_event, SND_SOC_DAPM_POST_PMU),
 
 	/* Input Lines */
-- 
1.8.1.1.439.g50a6b54
