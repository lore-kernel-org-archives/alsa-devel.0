From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: Intel: Build Medfield compressed ops
Date: Thu,  8 May 2014 23:30:37 +0100
Message-ID: <1399588237-21024-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C164E261A1D
 for <alsa-devel@alsa-project.org>; Fri,  9 May 2014 00:30:51 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Since commit 4b68b4e1c564 (ASoC: Intel: split the pcm and compress to
different files) the compressed ops haven't been built causing link
failures on allyesconfig and making the driver unbuildable.  Add the
object to the Makefile to fix that.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/intel/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
index 5d3fb6f35a19..0db4e2f336dc 100644
--- a/sound/soc/intel/Makefile
+++ b/sound/soc/intel/Makefile
@@ -2,7 +2,7 @@
 snd-soc-sst-dsp-objs := sst-dsp.o sst-firmware.o
 snd-soc-sst-acpi-objs := sst-acpi.o
 
-snd-soc-sst-mfld-platform-objs := sst-mfld-platform-pcm.o
+snd-soc-sst-mfld-platform-objs := sst-mfld-platform-pcm.o sst-mfld-platform-compress.o
 snd-soc-mfld-machine-objs := mfld_machine.o
 
 obj-$(CONFIG_SND_SST_MFLD_PLATFORM) += snd-soc-sst-mfld-platform.o
-- 
2.0.0.rc2
