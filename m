From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3.5 2/2] ASoC: wm8994: Don't lock CODEC mutex
	to do DAPM sync
Date: Mon, 12 Mar 2012 17:06:47 +0000
Message-ID: <1331572007-32234-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1331572007-32234-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 20B962441F
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 18:06:52 +0100 (CET)
In-Reply-To: <1331572007-32234-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

DAPM now has a DAPM-level lock which it manages itself so we don't need
to take the CODEC mutex to call DAPM any more.  Also remove a redundant
call to snd_soc_dapm_sync(), jack reporting also triggers a DAPM sync.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index ac0cd4b..8bafd43 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3248,16 +3248,11 @@ static irqreturn_t wm1811_jackdet_irq(int irq, void *data)
 
 	/* If required for an external cap force MICBIAS on */
 	if (wm8994->pdata->jd_ext_cap) {
-		mutex_lock(&codec->mutex);
-
 		if (present)
 			snd_soc_dapm_force_enable_pin(&codec->dapm,
 						      "MICBIAS2");
 		else
 			snd_soc_dapm_disable_pin(&codec->dapm, "MICBIAS2");
-
-		snd_soc_dapm_sync(&codec->dapm);
-		mutex_unlock(&codec->mutex);
 	}
 
 	if (present)
-- 
1.7.9.1
