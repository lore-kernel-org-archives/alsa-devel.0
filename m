From: Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v6 08/11] ASoC: Intel: atom: Make PCI
	dependency explicit
Date: Sat,  5 Jan 2019 10:06:03 +0000
Message-ID: <20190105100606.6673-9-okaya@kernel.org>
References: <20190105100606.6673-1-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C0E52678D4
 for <alsa-devel@alsa-project.org>; Sat,  5 Jan 2019 11:06:22 +0100 (CET)
In-Reply-To: <20190105100606.6673-1-okaya@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-next@vger.kernel.org
Cc: "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>, Sinan Kaya <okaya@kernel.org>, Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
satisfied implicitly through dependencies on CONFIG_ACPI have to be
specified directly. This code relies on IOSF_MBI and IOSF_MBI depends
on PCI. For this reason, add a direct dependency on CONFIG_PCI to the
IOSF_MBI driver.

Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 sound/soc/intel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 99a62ba409df..bd9fd2035c55 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -91,7 +91,7 @@ config SND_SST_ATOM_HIFI2_PLATFORM_PCI
 config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
 	tristate "ACPI HiFi2 (Baytrail, Cherrytrail) Platforms"
 	default ACPI
-	depends on X86 && ACPI
+	depends on X86 && ACPI && PCI
 	select SND_SST_IPC_ACPI
 	select SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SOC_ACPI_INTEL_MATCH
-- 
2.19.0
