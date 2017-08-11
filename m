From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ASoC: Baytrail SST MAX98090: Delete an error
 message for a failed memory allocation in byt_max98090_probe()
Date: Fri, 11 Aug 2017 12:46:54 +0200
Message-ID: <95614c7b-9856-94f8-4550-a87048cfe283@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 4927C26648D
 for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2017 12:47:01 +0200 (CEST)
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 11 Aug 2017 12:42:40 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/intel/boards/byt-max98090.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/byt-max98090.c b/sound/soc/intel/boards/byt-max98090.c
index 047be7fa0ce9..fa68bb32adef 100644
--- a/sound/soc/intel/boards/byt-max98090.c
+++ b/sound/soc/intel/boards/byt-max98090.c
@@ -152,10 +152,8 @@ static int byt_max98090_probe(struct platform_device *pdev)
 	int ret_val;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_ATOMIC);
-	if (!priv) {
-		dev_err(&pdev->dev, "allocation failed\n");
+	if (!priv)
 		return -ENOMEM;
-	}
 
 	ret_val = devm_acpi_dev_add_driver_gpios(dev->parent, acpi_byt_max98090_gpios);
 	if (ret_val)
-- 
2.14.0
