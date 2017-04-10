From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_ssi: Use the tolower() function" to
	the asoc tree
Date: Mon, 10 Apr 2017 19:42:47 +0100
Message-ID: <E1cxeH1-0003qX-7h@debutante>
References: <1491410411-6053-2-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F2FA266BA4
 for <alsa-devel@alsa-project.org>; Mon, 10 Apr 2017 20:43:00 +0200 (CEST)
In-Reply-To: <1491410411-6053-2-git-send-email-fabio.estevam@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org, broonie@kernel.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_ssi: Use the tolower() function

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From c6682fedee47e3914af366f876728b3f77ba0272 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Wed, 5 Apr 2017 16:44:06 -0300
Subject: [PATCH] ASoC: fsl_ssi: Use the tolower() function

Code can be simplified by using the standard tolower() funtion.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Acked-by: Timur Tabi <timur@tabi.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 184a47360f84..549a598d030e 100644
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
@@ -1320,14 +1321,10 @@ static struct snd_ac97_bus_ops fsl_ssi_ac97_ops = {
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
2.11.0
