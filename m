From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 5/6] ASoC: axi-{spdif,
	i2s}: Remove SND_DMAENGINE_PCM_FLAG_NO_RESIDUE flag
Date: Mon,  6 Jan 2014 11:46:01 +0100
Message-ID: <1389005162-5223-6-git-send-email-lars@metafoo.de>
References: <1389005162-5223-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-079.synserver.de (smtp-out-023.synserver.de
 [212.40.185.23])
 by alsa0.perex.cz (Postfix) with ESMTP id 47FBF2617B5
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2014 11:45:51 +0100 (CET)
In-Reply-To: <1389005162-5223-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: dmaengine@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The pl330 driver properly reports that it does not have residue reporting
support, which means the PCM dmaengine driver is able to figure this out on its
own. So there is no need to set the flag manually. Removing the flag has the
advantage that once the pl330 driver gains support for residue reporting it will
automatically be used by the generic dmaengine PCM driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
New in v2
---
 sound/soc/adi/axi-i2s.c   | 3 +--
 sound/soc/adi/axi-spdif.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/adi/axi-i2s.c b/sound/soc/adi/axi-i2s.c
index 7f91a86..6058c1f 100644
--- a/sound/soc/adi/axi-i2s.c
+++ b/sound/soc/adi/axi-i2s.c
@@ -236,8 +236,7 @@ static int axi_i2s_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clk_disable;
 
-	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL,
-			SND_DMAENGINE_PCM_FLAG_NO_RESIDUE);
+	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
 	if (ret)
 		goto err_clk_disable;
 
diff --git a/sound/soc/adi/axi-spdif.c b/sound/soc/adi/axi-spdif.c
index 8db7a99..198e3a4 100644
--- a/sound/soc/adi/axi-spdif.c
+++ b/sound/soc/adi/axi-spdif.c
@@ -229,8 +229,7 @@ static int axi_spdif_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clk_disable;
 
-	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL,
-			SND_DMAENGINE_PCM_FLAG_NO_RESIDUE);
+	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
 	if (ret)
 		goto err_clk_disable;
 
-- 
1.8.0
