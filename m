From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: Intel: Make sure we only build SST
	drivers on X86
Date: Wed, 19 Feb 2014 14:06:24 +0000
Message-ID: <1392818784-6248-2-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1392818784-6248-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B57026531C
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 15:07:12 +0100 (CET)
In-Reply-To: <1392818784-6248-1-git-send-email-liam.r.girdwood@linux.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Disable build on non X86 architectures. This fixes the following build
errors on PPC :-

sound/soc/intel/sst-dsp.c: In function 'sst_dsp_outbox_write':
sound/soc/intel/sst-dsp.c:218:2: error: implicit declaration of function 'memcpy_toio' [-Werror=implicit-function-declaration]
  memcpy_toio(sst->mailbox.out_base, message, bytes);
  ^
sound/soc/intel/sst-dsp.c: In function 'sst_dsp_outbox_read':
sound/soc/intel/sst-dsp.c:231:2: error: implicit declaration of function 'memcpy_fromio' [-Werror=implicit-function-declaration]
  memcpy_fromio(message, sst->mailbox.out_base, bytes);
  ^

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index c962432..e61bd89 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -15,6 +15,7 @@ config SND_SST_MFLD_PLATFORM
 config SND_SOC_INTEL_SST
 	tristate "ASoC support for Intel(R) Smart Sound Technology"
 	select SND_SOC_INTEL_SST_ACPI if ACPI
+	depends on X86
 	help
           This adds support for Intel(R) Smart Sound Technology (SST).
           Say Y if you have such a device
-- 
1.8.3.2
