From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] ASoC: Intel: Disable SND_SOC_INTEL_BAYTRAIL
	when SND_SST_ATOM_HIFI2_PLATFORM is enabled
Date: Fri, 13 Apr 2018 14:45:37 +0200
Message-ID: <20180413124537.6765-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DD22266BBC
 for <alsa-devel@alsa-project.org>; Fri, 13 Apr 2018 14:45:41 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The sound/soc/intel/common/sst-acpi.c code only tries to load the
"baytrail-pcm-audio" driver (and supporting board drivers) when
SND_SST_ATOM_HIFI2_PLATFORM is not enabled, since otherwise these
are handled by snd-soc-sst-atom-hifi2-platform.ko.

Since these thus will never be used when SND_SST_ATOM_HIFI2_PLATFORM is
enabled, building these drivers when it is enabled is useless.

Add a Kconfig dependency to reflect this, so that SND_SOC_INTEL_BAYTRAIL
cannot be enabled when SND_SST_ATOM_HIFI2_PLATFORM is also enabled.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index ceb105cbd461..640f9bc9bd46 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -61,7 +61,7 @@ config SND_SOC_INTEL_HASWELL
 
 config SND_SOC_INTEL_BAYTRAIL
 	tristate "Baytrail (legacy) Platforms"
-	depends on DMADEVICES && ACPI
+	depends on DMADEVICES && ACPI && SND_SST_ATOM_HIFI2_PLATFORM=n
 	select SND_SOC_INTEL_SST
 	select SND_SOC_INTEL_SST_ACPI
 	select SND_SOC_INTEL_SST_FIRMWARE
-- 
2.17.0
