From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 15/17] AsoC: Intel: Add quirks for MinnowBoard
	MAX
Date: Fri, 12 Aug 2016 16:27:58 -0500
Message-ID: <1471037280-17433-16-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1471037280-17433-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DBBE266E7F
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 23:28:49 +0200 (CEST)
In-Reply-To: <1471037280-17433-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, irina.tirdea@intel.com
List-Id: alsa-devel@alsa-project.org

From: Irina Tirdea <irina.tirdea@intel.com>

I2S MCLK has been routed to LSE connector on the MinnowBoard
starting with HW version 3. Older versions of the board do
not have MCLK wired.

Add dmi quirk to disable MCLK for MinnowBoard MAX (v2).

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 11e11c6..230fc23 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -330,6 +330,15 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 		.driver_data = (unsigned long *)(BYT_RT5640_IN1_MAP |
 						 BYT_RT5640_MCLK_EN),
 	},
+	{
+		.callback = byt_rt5640_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Circuitco"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Minnowboard Max B3 PLATFORM"),
+		},
+		.driver_data = (unsigned long *)(BYT_RT5640_DMIC1_MAP |
+						 BYT_RT5640_DMIC_EN),
+	},
 	{}
 };
 
-- 
2.5.0
