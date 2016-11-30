From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH resend] ASoC: Intel: Add missing 10EC5672 ACPI
	ID matching for Cherry Trail
Date: Wed, 30 Nov 2016 14:57:47 +0100
Message-ID: <20161130135747.22485-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 56E8E266912
 for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2016 14:57:52 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Add the missing ACPI ID 10EC5672 for Cherry Trail, which bounds with
cht-bsw-rt5672 driver.  This combination was found on Dell Wyse 3040.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
Resent, as I forgot Cc to alsa-devel ML, sorry!

 sound/soc/intel/atom/sst/sst_acpi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 0a88537ca58a..f4d92bbc5373 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -452,6 +452,8 @@ static struct sst_acpi_mach sst_acpi_bytcr[] = {
 static struct sst_acpi_mach sst_acpi_chv[] = {
 	{"10EC5670", "cht-bsw-rt5672", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
 						&chv_platform_data },
+	{"10EC5672", "cht-bsw-rt5672", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
+						&chv_platform_data },
 	{"10EC5645", "cht-bsw-rt5645", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
 						&chv_platform_data },
 	{"10EC5650", "cht-bsw-rt5645", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
-- 
2.10.2
