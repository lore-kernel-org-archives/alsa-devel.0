From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 11/11] ASoC: 88pm860x: Use SND_SOC_DAPM_PGA_E()
	instead of open-coding it
Date: Wed, 19 Jun 2013 19:34:03 +0200
Message-ID: <1371663243-10032-11-git-send-email-lars@metafoo.de>
References: <1371663243-10032-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-226.synserver.de (smtp-out-227.synserver.de
 [212.40.185.227])
 by alsa0.perex.cz (Postfix) with ESMTP id 75F44262607
 for <alsa-devel@alsa-project.org>; Wed, 19 Jun 2013 19:34:01 +0200 (CEST)
In-Reply-To: <1371663243-10032-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/88pm860x-codec.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index 1382f3f..8af0434 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -120,10 +120,8 @@
  * before DAC & PGA in DAPM power-off sequence.
  */
 #define PM860X_DAPM_OUTPUT(wname, wevent)	\
-{	.id = snd_soc_dapm_pga, .name = wname, .reg = SND_SOC_NOPM, \
-	.shift = 0, .invert = 0, .kcontrol_news = NULL, \
-	.num_kcontrols = 0, .event = wevent, \
-	.event_flags = SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD, }
+	SND_SOC_DAPM_PGA_E(wname, SND_SOC_NOPM, 0, 0, NULL, 0, wevent, \
+			    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD)
 
 struct pm860x_det {
 	struct snd_soc_jack	*hp_jack;
-- 
1.8.0
