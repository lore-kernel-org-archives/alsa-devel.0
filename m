From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: skl: always select SND_SOC_HDAC_HDA
Date: Fri,  2 Nov 2018 12:24:08 +0100
Message-ID: <20181102112456.780127-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by alsa0.perex.cz (Postfix) with ESMTP id D2C60267950
 for <alsa-devel@alsa-project.org>; Fri,  2 Nov 2018 12:25:13 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vkoul@kernel.org>, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Naveen Manohar <naveen.m@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The skylake sound support is written to work both with or without
CONFIG_SND_SOC_HDAC_HDA, and uses an #ifdef to decide whether it should
link against that. However, this fails with SND_SOC_ALL_CODECS=m or
SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH=m when the Skylake support itself
is built-in, with this link error:

sound/soc/intel/skylake/skl.o: In function `skl_probe':
skl.c:(.text+0x56c): undefined reference to `snd_soc_hdac_hda_get_ops'

Using an explicit 'select' here simplifies the logic and prevents
it from happening, at the cost of always including the compile
time dependency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/intel/Kconfig       | 1 +
 sound/soc/intel/skylake/skl.c | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 0caa1f4eb94d..c21ce7624af1 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -109,6 +109,7 @@ config SND_SOC_INTEL_SKYLAKE
 	depends on PCI && ACPI
 	select SND_HDA_EXT_CORE
 	select SND_HDA_DSP_LOADER
+	select SND_SOC_HDAC_HDA
 	select SND_SOC_TOPOLOGY
 	select SND_SOC_INTEL_SST
 	select SND_SOC_ACPI_INTEL_MATCH
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 29225623b4b4..1069ee265ce5 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -870,9 +870,7 @@ static int skl_create(struct pci_dev *pci,
 	hbus = skl_to_hbus(skl);
 	bus = skl_to_bus(skl);
 
-#if IS_ENABLED(CONFIG_SND_SOC_HDAC_HDA)
 	ext_ops = snd_soc_hdac_hda_get_ops();
-#endif
 	snd_hdac_ext_bus_init(bus, &pci->dev, &bus_core_ops, io_ops, ext_ops);
 	bus->use_posbuf = 1;
 	skl->pci = pci;
-- 
2.18.0
