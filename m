From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/4] ASoC: imx-es8328: Fix of_node_put() call
	with uninitialized object
Date: Tue,  7 Oct 2014 18:19:53 +0200
Message-ID: <1412698794-25536-4-git-send-email-tiwai@suse.de>
References: <1412698794-25536-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B97E26056D
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 18:20:14 +0200 (CEST)
In-Reply-To: <1412698794-25536-1-git-send-email-tiwai@suse.de>
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

The of_node_put() calls in imx_es8328_probe() may take uninitialized
pointers when reached though the early error path.  This patch adds
the proper NULL initialization for fixing these.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/fsl/imx-es8328.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-es8328.c b/sound/soc/fsl/imx-es8328.c
index 653e66d150c8..d6c55c88a069 100644
--- a/sound/soc/fsl/imx-es8328.c
+++ b/sound/soc/fsl/imx-es8328.c
@@ -78,7 +78,7 @@ static const struct snd_soc_dapm_widget imx_es8328_dapm_widgets[] = {
 static int imx_es8328_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct device_node *ssi_np, *codec_np;
+	struct device_node *ssi_np = NULL, *codec_np = NULL;
 	struct platform_device *ssi_pdev;
 	struct imx_es8328_data *data;
 	u32 int_port, ext_port;
-- 
2.1.2
