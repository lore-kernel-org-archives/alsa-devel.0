From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] ASoC: sound/soc/sof/: fix kconfig dependency warning
Date: Mon, 6 May 2019 12:01:40 -0700
Message-ID: <418abbd5-f01c-19ef-c9f2-7de5662f10a2@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, moderated for non-subscribers <alsa-devel@alsa-project.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kconfig warning for unmet dependency for IOSF_MBI when
PCI is not set/enabled.  Fixes this warning:

WARNING: unmet direct dependencies detected for IOSF_MBI
  Depends on [n]: PCI [=n]
  Selected by [y]:
  - SND_SOC_SOF_ACPI [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_SOF_TOPLEVEL [=y] && (ACPI [=y] || COMPILE_TEST [=n]) && X86 [=y]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/sof/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20190506.orig/sound/soc/sof/Kconfig
+++ linux-next-20190506/sound/soc/sof/Kconfig
@@ -28,7 +28,7 @@ config SND_SOC_SOF_ACPI
 	select SND_SOC_ACPI if ACPI
 	select SND_SOC_SOF_OPTIONS
 	select SND_SOC_SOF_INTEL_ACPI if SND_SOC_SOF_INTEL_TOPLEVEL
-	select IOSF_MBI if X86
+	select IOSF_MBI if X86 && PCI
 	help
 	  This adds support for ACPI enumeration. This option is required
 	  to enable Intel Haswell/Broadwell/Baytrail/Cherrytrail devices
