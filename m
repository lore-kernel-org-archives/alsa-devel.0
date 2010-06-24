From: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Subject: [PATCH 2/2] ASoC: uda134x: fix bias level setup on
	initialization
Date: Thu, 24 Jun 2010 17:38:51 +0400
Message-ID: <1277386731-31160-2-git-send-email-vzapolskiy@gmail.com>
References: <1277386731-31160-1-git-send-email-vzapolskiy@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6077E10381D
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jun 2010 15:39:23 +0200 (CEST)
Received: by mail-bw0-f51.google.com with SMTP id 11so141592bwz.38
	for <alsa-devel@alsa-project.org>; Thu, 24 Jun 2010 06:39:23 -0700 (PDT)
In-Reply-To: <1277386731-31160-1-git-send-email-vzapolskiy@gmail.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Vladimir Zapolskiy <vzapolskiy@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On initialization ADC/DAC are enabled only for UDA1341, that's why
bias_level shall be set to off explicitly, otherwise dapm is
misinformed about bias_level on startup.

Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
---
 sound/soc/codecs/uda134x.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index 5c7b054..ed13515 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -547,10 +547,6 @@ static int uda134x_soc_probe(struct platform_device *pdev)
 	codec->read = uda134x_read_reg_cache;
 	codec->write = uda134x_write;
 
-	if (!pd->is_powered_on_standby) {
-		codec->set_bias_level = uda134x_set_bias_level;
-	}
-
 	INIT_LIST_HEAD(&codec->dapm_widgets);
 	INIT_LIST_HEAD(&codec->dapm_paths);
 
@@ -561,6 +557,14 @@ static int uda134x_soc_probe(struct platform_device *pdev)
 
 	uda134x_reset(codec);
 
+	if (pd->is_powered_on_standby) {
+		codec->set_bias_level = NULL;
+		uda134x_set_bias_level(codec, SND_SOC_BIAS_ON);
+	} else {
+		codec->set_bias_level = uda134x_set_bias_level;
+		uda134x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	}
+
 	/* register pcms */
 	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
 	if (ret < 0) {
-- 
1.7.0.4
