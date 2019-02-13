From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 19/20] ASoC: Intel: Kconfig: expose common
	option between SST and SOF drivers
Date: Wed, 13 Feb 2019 16:08:46 -0600
Message-ID: <20190213220847.10567-20-pierre-louis.bossart@linux.intel.com>
References: <20190213220847.10567-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190213220847.10567-1-pierre-louis.bossart@linux.intel.com>
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, andriy.shevchenko@intel.com, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Both drivers rely on the same module, expose it for both configurations

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/Kconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index bd9fd2035c55..fc1396adde71 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -196,13 +196,18 @@ config SND_SOC_INTEL_SKYLAKE_COMMON
 
 endif ## SND_SOC_INTEL_SKYLAKE_FAMILY
 
+endif ## SND_SOC_INTEL_SST_TOPLEVEL
+
+if SND_SOC_INTEL_SST_TOPLEVEL || SND_SOC_SOF_INTEL_TOPLEVEL
+
 config SND_SOC_ACPI_INTEL_MATCH
 	tristate
 	select SND_SOC_ACPI if ACPI
 	# this option controls the compilation of ACPI matching tables and
 	# helpers and is not meant to be selected by the user.
 
-endif ## SND_SOC_INTEL_SST_TOPLEVEL
+endif ## SND_SOC_INTEL_SST_TOPLEVEL || SND_SOC_SOF_INTEL_TOPLEVEL
+
 
 # ASoC codec drivers
 source "sound/soc/intel/boards/Kconfig"
-- 
2.17.1
