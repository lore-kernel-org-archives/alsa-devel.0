From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] ASoC: Intel: Update Baytrail ADSP firmware name
Date: Wed,  6 Aug 2014 09:48:14 +0300
Message-ID: <1407307694-30730-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B902B26507D
 for <alsa-devel@alsa-project.org>; Wed,  6 Aug 2014 08:48:22 +0200 (CEST)
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
Cc: Mengdong Lin <mengdong.lin@intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Update the initial Baytrail ADSP firmware file name with the one that is now
in linux-firmware.git. Please see linux-firmware.git commit 7551a3a78453
("fw_sst_0f28: Add firmware for Intel Baytrail SST DSP").

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/sst-acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/sst-acpi.c b/sound/soc/intel/sst-acpi.c
index 42edc6f4fc4a..03d0a166b635 100644
--- a/sound/soc/intel/sst-acpi.c
+++ b/sound/soc/intel/sst-acpi.c
@@ -246,8 +246,8 @@ static struct sst_acpi_desc sst_acpi_broadwell_desc = {
 };
 
 static struct sst_acpi_mach baytrail_machines[] = {
-	{ "10EC5640", "byt-rt5640", "intel/fw_sst_0f28.bin-i2s_master" },
-	{ "193C9890", "byt-max98090", "intel/fw_sst_0f28.bin-i2s_master" },
+	{ "10EC5640", "byt-rt5640", "intel/fw_sst_0f28.bin-48kHz_i2s_master" },
+	{ "193C9890", "byt-max98090", "intel/fw_sst_0f28.bin-48kHz_i2s_master" },
 	{}
 };
 
-- 
2.0.1
