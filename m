From: Carlo Caione <carlo@caione.org>
Subject: [PATCH] ASoC: rt5651: Convert rt5651 micbias1 to a
	supply widget
Date: Wed, 18 Oct 2017 18:06:31 +0100
Message-ID: <20171018170631.9189-1-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id C90A7266EE0
 for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2017 19:07:19 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id i124so11124523wmf.3
 for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2017 10:07:19 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux@endlessm.com, bardliao@realtek.com, oder_chiou@realtek.com, lgirdwood@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com
Cc: Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

From: Carlo Caione <carlo@endlessm.com>

MICBIAS widget type has been deprecated. Convert it to a SUPPLY widget.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 sound/soc/codecs/rt5651.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index da60b28ba3df..28f7210cec91 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -883,8 +883,8 @@ static const struct snd_soc_dapm_widget rt5651_dapm_widgets[] = {
 	/* micbias */
 	SND_SOC_DAPM_SUPPLY("LDO", RT5651_PWR_ANLG1,
 			RT5651_PWR_LDO_BIT, 0, NULL, 0),
-	SND_SOC_DAPM_MICBIAS("micbias1", RT5651_PWR_ANLG2,
-			RT5651_PWR_MB1_BIT, 0),
+	SND_SOC_DAPM_SUPPLY("micbias1", RT5651_PWR_ANLG2,
+			RT5651_PWR_MB1_BIT, 0, NULL, 0),
 	/* Input Lines */
 	SND_SOC_DAPM_INPUT("MIC1"),
 	SND_SOC_DAPM_INPUT("MIC2"),
-- 
2.14.2
