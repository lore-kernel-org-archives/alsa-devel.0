From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 2/2] ASoC: fsl_ssi: Use the tolower()
	function
Date: Wed,  5 Apr 2017 16:02:26 -0300
Message-ID: <1491418946-10585-2-git-send-email-festevam@gmail.com>
References: <1491418946-10585-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f193.google.com (mail-qk0-f193.google.com
 [209.85.220.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E403C266C13
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 21:02:42 +0200 (CEST)
Received: by mail-qk0-f193.google.com with SMTP id p22so2938634qka.0
 for <alsa-devel@alsa-project.org>; Wed, 05 Apr 2017 12:02:42 -0700 (PDT)
In-Reply-To: <1491418946-10585-1-git-send-email-festevam@gmail.com>
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
Changes since v1:
- None

 sound/soc/fsl/fsl_ssi.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index e0639e17..baf26fc 100644
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
@@ -1323,14 +1324,10 @@ static struct snd_ac97_bus_ops fsl_ssi_ac97_ops = {
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
