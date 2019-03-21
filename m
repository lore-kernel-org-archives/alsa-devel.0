From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 20/20] ASoC: Intel: select relevant machine
	drivers for SOF
Date: Thu, 21 Mar 2019 11:10:55 -0500
Message-ID: <20190321161055.26582-21-pierre-louis.bossart@linux.intel.com>
References: <20190321161055.26582-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190321161055.26582-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Daniel Baluta <daniel.baluta@gmail.com>, Alan Cox <alan@linux.intel.com>, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, andriy.shevchenko@linux.intel.com, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SOF can only support specific machine drivers, handle dependencies

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/Kconfig | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 12d6b73e9531..bf6d7a11f94a 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -1,6 +1,6 @@
 menuconfig SND_SOC_INTEL_MACH
 	bool "Intel Machine drivers"
-	depends on SND_SOC_INTEL_SST_TOPLEVEL
+	depends on SND_SOC_INTEL_SST_TOPLEVEL || SND_SOC_SOF_INTEL_TOPLEVEL
 	help
          Intel ASoC Machine Drivers. If you have a Intel machine that
          has an audio controller with a DSP and I2S or DMIC port, then
@@ -24,6 +24,10 @@ config SND_SOC_INTEL_HASWELL_MACH
 	  Say Y or m if you have such a device.
 	  If unsure select "N".
 
+endif ## SND_SOC_INTEL_HASWELL
+
+if SND_SOC_INTEL_HASWELL || SND_SOC_SOF_BROADWELL
+
 config SND_SOC_INTEL_BDW_RT5677_MACH
 	tristate "Broadwell with RT5677 codec"
 	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM && GPIOLIB
@@ -43,7 +47,7 @@ config SND_SOC_INTEL_BROADWELL_MACH
 	  Ultrabook platforms.
 	  Say Y or m if you have such a device. This is a recommended option.
 	  If unsure select "N".
-endif ## SND_SOC_INTEL_HASWELL
+endif ## SND_SOC_INTEL_HASWELL || SND_SOC_SOF_BROADWELL
 
 if SND_SOC_INTEL_BAYTRAIL
 
@@ -68,7 +72,7 @@ config SND_SOC_INTEL_BYT_RT5640_MACH
 
 endif ## SND_SOC_INTEL_BAYTRAIL
 
-if SND_SST_ATOM_HIFI2_PLATFORM
+if SND_SST_ATOM_HIFI2_PLATFORM || SND_SOC_SOF_BAYTRAIL
 
 config SND_SOC_INTEL_BYTCR_RT5640_MACH
 	tristate "Baytrail and Baytrail-CR with RT5640 codec"
@@ -158,6 +162,10 @@ config SND_SOC_INTEL_BYT_CHT_ES8316_MACH
 	  Say Y or m if you have such a device. This is a recommended option.
 	  If unsure select "N".
 
+endif ## SND_SST_ATOM_HIFI2_PLATFORM || SND_SOC_SOF_BAYTRAIL
+
+if SND_SST_ATOM_HIFI2_PLATFORM
+
 config SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH
 	tristate "Baytrail & Cherrytrail platform with no codec (MinnowBoard MAX, Up)"
 	depends on X86_INTEL_LPSS && I2C && ACPI
@@ -314,7 +322,7 @@ config SND_SOC_INTEL_KBL_RT5660_MACH
 
 endif ## SND_SOC_INTEL_KBL
 
-if SND_SOC_INTEL_GLK
+if SND_SOC_INTEL_GLK || (SND_SOC_SOF_GEMINILAKE  && SND_SOC_SOF_HDA_LINK)
 
 config SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH
 	tristate "GLK with RT5682 and MAX98357A in I2S Mode"
@@ -330,9 +338,9 @@ config SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH
 	   Say Y if you have such a device.
 	   If unsure select "N".
 
-endif ## SND_SOC_INTEL_GLK
+endif ## SND_SOC_INTEL_GLK || (SND_SOC_SOF_GEMINILAKE  && SND_SOC_SOF_HDA_LINK)
 
-if SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC
+if SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC || SND_SOC_SOF_HDA_AUDIO_CODEC
 
 config SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH
 	tristate "SKL/KBL/BXT/APL with HDA Codecs"
@@ -344,6 +352,6 @@ config SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH
           Say Y or m if you have such a device. This is a recommended option.
 	  If unsure select "N".
 
-endif ## SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC
+endif ## SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC || SND_SOC_SOF_HDA_AUDIO_CODEC
 
 endif ## SND_SOC_INTEL_MACH
-- 
2.17.1
