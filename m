From: Misael Lopez Cruz <misael.lopez@ti.com>
Subject: [PATCH] ASoC: dapm: Use card_list during DAPM shutdown
Date: Thu, 8 Nov 2012 12:03:12 -0600
Message-ID: <1352397792-2233-1-git-send-email-misael.lopez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 4ECE1261576
 for <alsa-devel@alsa-project.org>; Thu,  8 Nov 2012 19:04:25 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

DAPM shutdown incorrectly uses "list" field of codec struct while
iterating over probed components (codec_dev_list). "list" field
refers to codecs registered in the system, "card_list" field is
used for probed components.

Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-dapm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d0a4be3..6e35bca 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3745,7 +3745,7 @@ void snd_soc_dapm_shutdown(struct snd_soc_card *card)
 {
 	struct snd_soc_codec *codec;
 
-	list_for_each_entry(codec, &card->codec_dev_list, list) {
+	list_for_each_entry(codec, &card->codec_dev_list, card_list) {
 		soc_dapm_shutdown_codec(&codec->dapm);
 		if (codec->dapm.bias_level == SND_SOC_BIAS_STANDBY)
 			snd_soc_dapm_set_bias_level(&codec->dapm,
-- 
1.7.4.1
