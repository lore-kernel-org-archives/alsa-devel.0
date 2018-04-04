From: Naveen Manohar <naveen.m@intel.com>
Subject: [PATCH 5/5] ASoC: Intel: Add Geminilake Dialog+Maxim
	machine driver entry
Date: Wed,  4 Apr 2018 10:16:59 +0530
Message-ID: <1522817219-3750-6-git-send-email-naveen.m@intel.com>
References: <1522817219-3750-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 282E226762F
 for <alsa-devel@alsa-project.org>; Wed,  4 Apr 2018 06:47:49 +0200 (CEST)
In-Reply-To: <1522817219-3750-1-git-send-email-naveen.m@intel.com>
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
Cc: vinod.koul@intel.com, harshapriya.n@intel.com, naveen.m@intel.com, broonie@kernel.org, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

This patch adds da7219_max98357a machine driver entry into
machine table

Signed-off-by: Naveen Manohar <naveen.m@intel.com>
---
 sound/soc/intel/skylake/skl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index d50c2ee..96eeb1d 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -1155,6 +1155,13 @@ static struct snd_soc_acpi_mach sst_glk_devdata[] = {
 		.drv_name = "glk_alc298s_i2s",
 		.fw_filename = "intel/dsp_fw_glk.bin",
 	},
+	{
+		.id = "DLGS7219",
+		.drv_name = "glk_da7219_max98357a",
+		.fw_filename = "intel/dsp_fw_glk.bin",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &bxt_codecs,
+	},
 	{}
 };
 
-- 
2.7.4
