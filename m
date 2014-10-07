From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/4] ASoC: imx-es8328: Fix missing return code
	in imx_es8328_probe()
Date: Tue,  7 Oct 2014 18:19:54 +0200
Message-ID: <1412698794-25536-5-git-send-email-tiwai@suse.de>
References: <1412698794-25536-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 96BD326056A
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

An error code was forgotten to be passed in the error path of
imx_es8328_probe().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/fsl/imx-es8328.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/imx-es8328.c b/sound/soc/fsl/imx-es8328.c
index d6c55c88a069..f8cf10e16ce9 100644
--- a/sound/soc/fsl/imx-es8328.c
+++ b/sound/soc/fsl/imx-es8328.c
@@ -104,6 +104,7 @@ static int imx_es8328_probe(struct platform_device *pdev)
 	if (ext_port > MUX_PORT_MAX || ext_port == 0) {
 		dev_err(dev, "mux-ext-port: hardware only has %d mux ports\n",
 			MUX_PORT_MAX);
+		ret = -EINVAL;
 		goto fail;
 	}
 
-- 
2.1.2
