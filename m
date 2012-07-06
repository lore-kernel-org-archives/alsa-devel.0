From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: dapm: Make sure all dapm contexts are
	updated
Date: Fri,  6 Jul 2012 16:56:16 +0100
Message-ID: <1341590176-20780-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog119.obsmtp.com (na3sys009aog119.obsmtp.com
	[74.125.149.246])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C171104566
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jul 2012 17:56:24 +0200 (CEST)
Received: by wibhr14 with SMTP id hr14so722997wib.9
	for <alsa-devel@alsa-project.org>; Fri, 06 Jul 2012 08:56:19 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Make sure we set the bias level for all DAPM contexts when
changing level.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-dapm.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 912330b..0f078de 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -291,9 +291,9 @@ static int snd_soc_dapm_set_bias_level(struct snd_soc_dapm_context *dapm,
 		if (dapm->codec->driver->set_bias_level)
 			ret = dapm->codec->driver->set_bias_level(dapm->codec,
 								  level);
-		else
-			dapm->bias_level = level;
-	}
+	} else
+		dapm->bias_level = level;
+
 	if (ret != 0)
 		goto out;
 
-- 
1.7.9.5
