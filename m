From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/3] ASoC: rt5645: Add ACPI ID 10EC5640
Date: Fri,  8 Jul 2016 15:39:50 +0530
Message-ID: <1467972591-29175-3-git-send-email-vinod.koul@intel.com>
References: <1467972591-29175-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B4DB265957
 for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2016 12:03:09 +0200 (CEST)
In-Reply-To: <1467972591-29175-1-git-send-email-vinod.koul@intel.com>
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
Cc: Stephen Just <stephenjust@gmail.com>, patches.audio@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, apterix@gmail.com, broonie@kernel.org, Sachin Mokashi <sachinx.mokashi@intel.com>, Vinod Koul <vinod.koul@intel.com>, bugzilla@hadess.net
List-Id: alsa-devel@alsa-project.org

Some CHT platforms use RT5645 codec which has entry 10EC5640 so add it.
Also add DMI quirk for jack detection.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=98001
Signed-off-by: Sachin Mokashi <sachinx.mokashi@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
[Jack detection]
Suggested-by: Stephen Just <stephenjust@gmail.com>
---
 sound/soc/codecs/rt5645.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 3c6594da6c9c..761ca88c4cdd 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3531,6 +3531,7 @@ MODULE_DEVICE_TABLE(i2c, rt5645_i2c_id);
 static const struct acpi_device_id rt5645_acpi_match[] = {
 	{ "10EC5645", 0 },
 	{ "10EC5650", 0 },
+	{ "10EC5640", 0 },
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, rt5645_acpi_match);
@@ -3561,6 +3562,12 @@ static const struct dmi_system_id dmi_platform_intel_braswell[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Setzer"),
 		},
 	},
+	{
+		.ident = "Microsoft Surface 3",
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Surface 3"),
+		},
+	},
 	{ }
 };
 
-- 
1.9.1
