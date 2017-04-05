From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v3 2/2] ASoC: fsl_ssi: Use the tolower()
	function
Date: Wed,  5 Apr 2017 16:44:06 -0300
Message-ID: <1491421446-13799-2-git-send-email-festevam@gmail.com>
References: <1491421446-13799-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f196.google.com (mail-qt0-f196.google.com
 [209.85.216.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C2F3266C1E
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 21:44:59 +0200 (CEST)
Received: by mail-qt0-f196.google.com with SMTP id x35so3004825qtc.1
 for <alsa-devel@alsa-project.org>; Wed, 05 Apr 2017 12:44:59 -0700 (PDT)
In-Reply-To: <1491421446-13799-1-git-send-email-festevam@gmail.com>
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
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Code can be simplified by using the standard tolower() funtion.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v2:
- None

 sound/soc/fsl/fsl_ssi.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 0b74d1c..173cb84 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -35,6 +35,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/clk.h>
+#include <linux/ctype.h>
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
@@ -1315,14 +1316,10 @@ static struct snd_ac97_bus_ops fsl_ssi_ac97_ops = {
  */
 static void make_lowercase(char *s)
 {
-	char *p = s;
-	char c;
-
-	while ((c = *p)) {
-		if ((c >= 'A') && (c <= 'Z'))
-			*p = c + ('a' - 'A');
-		p++;
-	}
+	if (!s)
+		return;
+	for (; *s; s++)
+		*s = tolower(*s);
 }
 
 static int fsl_ssi_imx_probe(struct platform_device *pdev,
-- 
2.7.4
