From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 1/2] ASoC: Intel: Atom: update Thinkpad 10 quirk
Date: Mon, 17 Apr 2017 10:04:07 -0500
Message-ID: <20170417150408.20935-2-pierre-louis.bossart@linux.intel.com>
References: <20170417150408.20935-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id E9008266C2E
 for <alsa-devel@alsa-project.org>; Mon, 17 Apr 2017 17:04:27 +0200 (CEST)
In-Reply-To: <20170417150408.20935-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

There are multiple skews of the same Lenovo audio hardware
based on the Realtek RT5670 codec.

Manufacturer: LENOVO
        Product Name: 20C1CTO1WW
        Version: ThinkPad 10

Manufacturer: LENOVO
	Product Name: 20C3001VHH
	Version: ThinkPad 10

Manufacturer: LENOVO
	Product Name: 20C10024GE
	Version: ThinkPad Tablet B

Manufacturer: LENOVO
	Product Name: 20359
	Version: Lenovo Miix 2 10

For all these devices, the same quirk is used to force
the machine driver to be based on RT5670 instead of RT5640
as indicated by the BIOS.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=96691
Tested-by: Nicole Faerber <nicole.faerber@dpin.de>
Tested-by: Viacheslav Ostroukh <v.dev@ostroukh.me>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/atom/sst/sst_acpi.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 18fe46e..dd250b8 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -420,7 +420,21 @@ static const struct dmi_system_id byt_table[] = {
 		.callback = byt_thinkpad10_quirk_cb,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "20C3001VHH"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad 10"),
+		},
+	},
+	{
+		.callback = byt_thinkpad10_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad Tablet B"),
+		},
+	},
+	{
+		.callback = byt_thinkpad10_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Miix 2 10"),
 		},
 	},
 	{ }
-- 
2.9.3
