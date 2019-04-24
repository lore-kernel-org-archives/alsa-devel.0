From: Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] ASoC: Intel: bytcht_es8316: fix cast warning
Date: Wed, 24 Apr 2019 13:41:14 +0200
Message-ID: <20190424114114.27073-1-anders.roxell@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>
List-Id: alsa-devel@alsa-project.org

When building bytcht_es8316 the following warning shows up:

../sound/soc/intel/boards/bytcht_es8316.c: In function ‘snd_byt_cht_es8316_mc_probe’:
../sound/soc/intel/boards/bytcht_es8316.c:508:11: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
   quirk = (int)dmi_id->driver_data;
           ^

Rework to use uintptr_t instead of int.

Fixes: a8d218f4fe81 ("ASoC: Intel: bytcht_es8316: Add quirk for the Teclast X98+ II")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 sound/soc/intel/boards/bytcht_es8316.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 38975827e276..68136ba1519e 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -505,7 +505,7 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 	/* Check for BYTCR or other platform and setup quirks */
 	dmi_id = dmi_first_match(byt_cht_es8316_quirk_table);
 	if (dmi_id) {
-		quirk = (int)dmi_id->driver_data;
+		quirk = (uintptr_t)dmi_id->driver_data;
 	} else if (x86_match_cpu(baytrail_cpu_ids) &&
 	    mach->mach_params.acpi_ipc_irq_index == 0) {
 		/* On BYTCR default to SSP0, internal-mic-in2-map, mono-spk */
-- 
2.20.1
