From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl: imx-pcm-fiq: Remove unused
	'runtime' variable
Date: Fri,  8 Nov 2013 00:55:00 -0200
Message-ID: <1383879300-19947-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qe0-f43.google.com (mail-qe0-f43.google.com
 [209.85.128.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BD53261735
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2013 03:55:09 +0100 (CET)
Received: by mail-qe0-f43.google.com with SMTP id nc12so1391067qeb.2
 for <alsa-devel@alsa-project.org>; Thu, 07 Nov 2013 18:55:08 -0800 (PST)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, oskar@scara.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Commit 68f9672b (ASoC: fsl: imx-pcm-fiq: remove bogus period delta calculation)
introduced the following build warning:

sound/soc/fsl/imx-pcm-fiq.c:53:26: warning: unused variable 'runtime' [-Wunused-variable]

Remove the unused 'runtime' variable.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/imx-pcm-fiq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index 73cb07d..41740e4 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -50,7 +50,6 @@ static enum hrtimer_restart snd_hrtimer_callback(struct hrtimer *hrt)
 	struct imx_pcm_runtime_data *iprtd =
 		container_of(hrt, struct imx_pcm_runtime_data, hrt);
 	struct snd_pcm_substream *substream = iprtd->substream;
-	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct pt_regs regs;
 
 	if (!atomic_read(&iprtd->running))
-- 
1.8.1.2
