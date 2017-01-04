From: Alexandrov Stansilav <neko@nya.ai>
Subject: [PATCH v2 2/2] ASoC: Intel: Atom: Add support for
	rt5640 sound card found on HP Pavilion x2 10-p000 tablet.
Date: Wed,  4 Jan 2017 15:22:13 +0300
Message-ID: <e129703fe81de8fdba680a4a6e27d1e414af2579.1483531270.git.neko@nya.ai>
References: <cover.1483531270.git.neko@nya.ai>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from thorium.nya.ai (nya.ai [109.195.179.38])
 by alsa0.perex.cz (Postfix) with ESMTP id D8A2F2674E8
 for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2017 13:22:17 +0100 (CET)
In-Reply-To: <cover.1483531270.git.neko@nya.ai>
In-Reply-To: <cover.1483531270.git.neko@nya.ai>
References: <cover.1483531270.git.neko@nya.ai>
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
Cc: vinod.koul@intel.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Alexandrov Stansilav <neko@nya.ai>
---
 sound/soc/intel/atom/sst/sst_acpi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index f4d92bb..896ced2 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -463,6 +463,8 @@ static struct sst_acpi_mach sst_acpi_chv[] = {
 	/* some CHT-T platforms rely on RT5640, use Baytrail machine driver */
 	{"10EC5640", "bytcr_rt5640", "intel/fw_sst_22a8.bin", "bytcr_rt5640", cht_quirk,
 						&chv_platform_data },
+	{"10EC3276", "bytcr_rt5640", "intel/fw_sst_22a8.bin", "bytcr_rt5640", NULL,
+						&chv_platform_data },
 
 	{},
 };
-- 
2.10.2
