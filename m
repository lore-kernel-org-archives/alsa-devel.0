From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Harden DSP detection
	with PCI class/subclass info" to the asoc tree
Date: Thu, 13 Dec 2018 18:11:08 +0000 (GMT)
Message-ID: <20181213181108.9187911254D1@debutante.sirena.org.uk>
References: <20181207235008.22988-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EA4A9267CB8
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 19:11:11 +0100 (CET)
In-Reply-To: <20181207235008.22988-3-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Filip Kaczmarski <filip.kaczmarski@intel.com>, tiwai@suse.de, Chris Chiu <chiu@endlessm.com>, Cezary Rojewski <cezary.rojewski@intel.com>, Daniel Drake <drake@endlessm.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Michal Wasko <michal.wasko@intel.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Harden DSP detection with PCI class/subclass info

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From c746de8dbc7b0ae9df491f7a99a6dab34203b51b Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 7 Dec 2018 17:50:04 -0600
Subject: [PATCH] ASoC: Intel: Skylake: Harden DSP detection with PCI
 class/subclass info

The existing PPCAP and GCAP fields cannot be used reliably to
determine if the DSP is enabled by the BIOS. Instead rely on the
class/subclass information to find out if this driver can run or
not. The values in the code don't seem to be documented in publicly
available documents but are part of recommendations made to BIOS
writers and have been verified to be accurate on a number of
platforms.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index df36b8fe6d5e..41a084b3d48f 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -916,6 +916,21 @@ static int skl_first_init(struct hdac_bus *bus)
 	unsigned short gcap;
 	int cp_streams, pb_streams, start_idx;
 
+	/*
+	 * detect DSP by checking class/subclass/prog-id information
+	 * class=04 subclass 03 prog-if 00: no DSP, legacy driver needs to be used
+	 * class=04 subclass 01 prog-if 00: DSP is present (and may be required e.g. for DMIC or SSP support)
+	 * class=04 subclass 03 prog-if 80: either of DSP or legacy mode can be used
+	 */
+	if (pci->class == 0x040300) {
+		dev_err(bus->dev, "The DSP is not enabled on this platform, aborting probe\n");
+		return -ENODEV;
+	} else if (pci->class != 0x040100 && pci->class != 0x040380) {
+		dev_err(bus->dev, "Unknown PCI class/subclass/prog-if information (0x%06x) found, aborting probe\n", pci->class);
+		return -ENODEV;
+	}
+	dev_info(bus->dev, "DSP detected with PCI class/subclass/prog-if info 0x%06x\n", pci->class);
+
 	err = pci_request_regions(pci, "Skylake HD audio");
 	if (err < 0)
 		return err;
-- 
2.19.0.rc2
