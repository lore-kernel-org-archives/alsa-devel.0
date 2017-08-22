From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/8] ASoC: fsl: Remove superfluous
	snd_soc_jack_free_gpios() call
Date: Tue, 22 Aug 2017 13:59:45 +0200
Message-ID: <20170822115951.6679-3-tiwai@suse.de>
References: <20170822115951.6679-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 75D0C2675DB
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 13:59:54 +0200 (CEST)
In-Reply-To: <20170822115951.6679-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Since jack gpios are managed via devres, we don't have to call
snd_jack_free_gpios() at release any longer.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/fsl/imx-es8328.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/fsl/imx-es8328.c b/sound/soc/fsl/imx-es8328.c
index 20e7400e2611..9953438086e4 100644
--- a/sound/soc/fsl/imx-es8328.c
+++ b/sound/soc/fsl/imx-es8328.c
@@ -203,9 +203,6 @@ static int imx_es8328_remove(struct platform_device *pdev)
 {
 	struct imx_es8328_data *data = platform_get_drvdata(pdev);
 
-	snd_soc_jack_free_gpios(&headset_jack, ARRAY_SIZE(headset_jack_gpios),
-				headset_jack_gpios);
-
 	snd_soc_unregister_card(&data->card);
 
 	return 0;
-- 
2.14.0
