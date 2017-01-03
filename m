From: Alexandrov Stanislav <neko@nya.ai>
Subject: [PATCH] ASoC: intel: rt5640: add support for sound
 card found on HP Pavilion x2 10-p000
Date: Wed, 04 Jan 2017 00:56:39 +0300
Message-ID: <7368c4ab543ff6a4783984e72a0ab04e@nya.ai>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from thorium.nya.ai (thorium.nya.ai [109.195.179.38])
 by alsa0.perex.cz (Postfix) with ESMTP id 8870226743E
 for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2017 22:56:42 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alsa Devel <alsa-devel@alsa-project.org>
Cc: Vinod Koul <vinod.koul@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Add support for rt5640 sound card found on HP Pavilion x2 10-p000 
tablet.

original bugreport: https://bugzilla.kernel.org/show_bug.cgi?id=187621

Signed-off-by: Alexandrov Stanislav <neko@nya.ai>
---
  sound/soc/codecs/rt5640.c           | 1 +
  sound/soc/intel/atom/sst/sst_acpi.c | 2 ++
  2 files changed, 3 insertions(+)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index e29a6de..c5234b9 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2315,6 +2315,7 @@ static const struct acpi_device_id 
rt5640_acpi_match[] = {
  	{ "INT33CA", 0 },
  	{ "10EC5640", 0 },
  	{ "10EC5642", 0 },
+	{ "10EC3276", 0 },
  	{ "INTCCFFD", 0 },
  	{ },
  };
diff --git a/sound/soc/intel/atom/sst/sst_acpi.c 
b/sound/soc/intel/atom/sst/sst_acpi.c
index f4d92bb..896ced2 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -463,6 +463,8 @@ static struct sst_acpi_mach sst_acpi_chv[] = {
  	/* some CHT-T platforms rely on RT5640, use Baytrail machine driver */
  	{"10EC5640", "bytcr_rt5640", "intel/fw_sst_22a8.bin", "bytcr_rt5640", 
cht_quirk,
  						&chv_platform_data },
+	{"10EC3276", "bytcr_rt5640", "intel/fw_sst_22a8.bin", "bytcr_rt5640", 
NULL,
+						&chv_platform_data },

  	{},
  };
-- 
2.10.2
