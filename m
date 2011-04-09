From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH] ASoC: sn95031: decorate function with
	__devexit_p()
Date: Sat, 09 Apr 2011 23:03:58 +0800
Message-ID: <20110409150358.3278.78790.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id A1D161037FC
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Apr 2011 17:03:31 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>, Lu Guanqun <guanqun.lu@intel.com>
Cc: Koul Vinod <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lrg@slimlogic.co.uk>, Harsha Priya <priya.harsha@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

According to the comments in include/linux/init.h:

"Pointers to __devexit functions must use __devexit_p(function_name), the
wrapper will insert either the function_name or NULL, depending on the config
options."

Fix this issue in codecs sn95031.

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 sound/soc/codecs/sn95031.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
index 569555f..f70977d 100644
--- a/sound/soc/codecs/sn95031.c
+++ b/sound/soc/codecs/sn95031.c
@@ -918,7 +918,7 @@ static struct platform_driver sn95031_codec_driver = {
 		.owner		= THIS_MODULE,
 	},
 	.probe		= sn95031_device_probe,
-	.remove		= sn95031_device_remove,
+	.remove		= __devexit_p(sn95031_device_remove),
 };
 
 static int __init sn95031_init(void)
