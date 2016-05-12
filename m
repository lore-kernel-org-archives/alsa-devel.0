From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/2] ASoC: rt298: fix null deref on acpi driver
	data
Date: Thu, 12 May 2016 09:38:49 +0530
Message-ID: <1463026130-18651-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 41895264FF9
 for <alsa-devel@alsa-project.org>; Thu, 12 May 2016 06:02:58 +0200 (CEST)
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
Cc: patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Bard Liao <bardliao@realtek.com>, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
List-Id: alsa-devel@alsa-project.org

ACPI driver data can be NULL so we need to check that before
dereference the driver data.

Signed-off-by: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/rt298.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index 68cf8d5a174f..45dc5fa24961 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -1179,7 +1179,7 @@ static int rt298_i2c_probe(struct i2c_client *i2c,
 
 	/* enable jack combo mode on supported devices */
 	acpiid = acpi_match_device(dev->driver->acpi_match_table, dev);
-	if (acpiid) {
+	if (acpiid && acpiid->driver_data) {
 		rt298->pdata = *(struct rt298_platform_data *)
 				acpiid->driver_data;
 	}
-- 
1.9.1
