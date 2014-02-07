From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] ASoC: rt5640: Add ACPI ID for Intel Baytrail
Date: Fri,  7 Feb 2014 09:35:16 +0200
Message-ID: <1391758516-17772-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 29FCB2652C4
 for <alsa-devel@alsa-project.org>; Fri,  7 Feb 2014 08:35:47 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Bard Liao <bardliao@realtek.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Realtek RT5640 uses ACPI ID "10EC5640" for Intel Baytrail platforms.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5640.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index a3fb41179636..886924934aa5 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2093,6 +2093,7 @@ MODULE_DEVICE_TABLE(i2c, rt5640_i2c_id);
 #ifdef CONFIG_ACPI
 static struct acpi_device_id rt5640_acpi_match[] = {
 	{ "INT33CA", 0 },
+	{ "10EC5640", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, rt5640_acpi_match);
-- 
1.8.5.3
