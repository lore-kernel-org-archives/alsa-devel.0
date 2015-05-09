From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] ASoC: fsl: imx-mc13783: Simplify trivial
	if-return sequence
Date: Sat,  9 May 2015 12:45:53 -0300
Message-ID: <1431186353-7331-2-git-send-email-festevam@gmail.com>
References: <1431186353-7331-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f50.google.com (mail-yh0-f50.google.com
 [209.85.213.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 10556260517
 for <alsa-devel@alsa-project.org>; Sat,  9 May 2015 17:46:21 +0200 (CEST)
Received: by yhw29 with SMTP id 29so26610571yhw.1
 for <alsa-devel@alsa-project.org>; Sat, 09 May 2015 08:46:20 -0700 (PDT)
In-Reply-To: <1431186353-7331-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Simplify a trivial if-return sequence.  Possibly combine with a
preceding function call.

The semantic patch that makes this change is available
in scripts/coccinelle/misc/simple_return.cocci.

More information about semantic patching is available at
http://coccinelle.lip6.fr/

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/imx-mc13783.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/fsl/imx-mc13783.c b/sound/soc/fsl/imx-mc13783.c
index 9e6493d..bb04590 100644
--- a/sound/soc/fsl/imx-mc13783.c
+++ b/sound/soc/fsl/imx-mc13783.c
@@ -45,11 +45,7 @@ static int imx_mc13783_hifi_hw_params(struct snd_pcm_substream *substream,
 	if (ret)
 		return ret;
 
-	ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0x3, 0x3, 2, 16);
-	if (ret)
-		return ret;
-
-	return 0;
+	return snd_soc_dai_set_tdm_slot(cpu_dai, 0x3, 0x3, 2, 16);
 }
 
 static struct snd_soc_ops imx_mc13783_hifi_ops = {
-- 
1.9.1
