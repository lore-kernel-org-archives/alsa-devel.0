From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt274: add acpi id
Date: Wed, 30 Aug 2017 12:28:31 +0800
Message-ID: <1504067311-6416-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 39304266C52
 for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2017 06:28:47 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, guneshwor.o.singh@intel.com, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Add ACPI id for Intel platform.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt274.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt274.c b/sound/soc/codecs/rt274.c
index fb683ff..0be69c1 100644
--- a/sound/soc/codecs/rt274.c
+++ b/sound/soc/codecs/rt274.c
@@ -1102,6 +1102,7 @@ MODULE_DEVICE_TABLE(i2c, rt274_i2c_id);
 
 static const struct acpi_device_id rt274_acpi_match[] = {
 	{ "10EC0274", 0 },
+	{ "INT34C2", 0 },
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, rt274_acpi_match);
-- 
2.7.4
