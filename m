From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 16/17] ASoC: bytcr_rt5640: Add quirk for
	Teclast X98 Air 3G tablet
Date: Fri, 12 Aug 2016 16:27:59 -0500
Message-ID: <1471037280-17433-17-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1471037280-17433-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A920265919
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 23:28:50 +0200 (CEST)
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

Add DMI-based quirk, routing from SSP0 to AIF1 is not very
usual

Suggested-by: Antonio Ospite <ao2@ao2.it>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 230fc23..032abfe 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -339,6 +339,16 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 		.driver_data = (unsigned long *)(BYT_RT5640_DMIC1_MAP |
 						 BYT_RT5640_DMIC_EN),
 	},
+	{
+		.callback = byt_rt5640_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "TECLAST"),
+			DMI_MATCH(DMI_BOARD_NAME, "tPAD"),
+		},
+		.driver_data = (unsigned long *)(BYT_RT5640_IN3_MAP |
+						BYT_RT5640_MCLK_EN |
+						BYT_RT5640_SSP0_AIF1),
+	},
 	{}
 };
 
-- 
2.5.0
