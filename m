From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 7/7] ASoC: Disable MICBIAS and SYSCLK when
	stopping WM8962 accessory detection
Date: Tue,  1 Nov 2011 18:40:42 +0000
Message-ID: <1320172842-15790-7-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1320172842-15790-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CD0AC103884
	for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2011 19:40:46 +0100 (CET)
In-Reply-To: <1320172842-15790-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

They aren't needed any more. If machines need them for other purposes then
further changes will be required.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index ffd55ac..231871a 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3689,6 +3689,9 @@ int wm8962_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack)
 	if (jack) {
 		snd_soc_dapm_force_enable_pin(&codec->dapm, "SYSCLK");
 		snd_soc_dapm_force_enable_pin(&codec->dapm, "MICBIAS");
+	} else {
+		snd_soc_dapm_disable_pin(&codec->dapm, "SYSCLK");
+		snd_soc_dapm_disable_pin(&codec->dapm, "MICBIAS");
 	}
 
 	return 0;
-- 
1.7.7.1
