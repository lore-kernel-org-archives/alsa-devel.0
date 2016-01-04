From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 1/8] ASoC: Intel: fix ACPI probe regression
	with Atom DPCM driver
Date: Mon,  4 Jan 2016 17:20:23 -0600
Message-ID: <1451949630-3475-2-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1451949630-3475-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F18B2605B1
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2016 00:21:00 +0100 (CET)
In-Reply-To: <1451949630-3475-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The commit 95f098014815b330838b1173d3d7bcea3b481242
"ASoC: Intel: Move apci find machine routines"

introduced a regression in ACPI probe of the DPCM driver.
Fix by conditionally compiling sst-acpi when the DPCM driver
is not selected

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/common/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/intel/common/Makefile b/sound/soc/intel/common/Makefile
index 3b9332e..668fdee 100644
--- a/sound/soc/intel/common/Makefile
+++ b/sound/soc/intel/common/Makefile
@@ -1,5 +1,10 @@
 snd-soc-sst-dsp-objs := sst-dsp.o
+ifneq ($(CONFIG_SND_SST_IPC_ACPI),)
+snd-soc-sst-acpi-objs := sst-match-acpi.o
+else
 snd-soc-sst-acpi-objs := sst-acpi.o sst-match-acpi.o
+endif
+
 snd-soc-sst-ipc-objs := sst-ipc.o
 
 snd-soc-sst-dsp-$(CONFIG_DW_DMAC_CORE) += sst-firmware.o
-- 
1.9.1
