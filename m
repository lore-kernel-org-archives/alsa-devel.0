From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: stop probe if HDaudio
	capabilities don't exist" to the asoc tree
Date: Thu, 13 Dec 2018 18:11:06 +0000 (GMT)
Message-ID: <20181213181106.AB6AE11254D1@debutante.sirena.org.uk>
References: <20181207235008.22988-4-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 32715267CAD
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 19:11:09 +0100 (CET)
In-Reply-To: <20181207235008.22988-4-pierre-louis.bossart@linux.intel.com>
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

   ASoC: Intel: Skylake: stop probe if HDaudio capabilities don't exist

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

>From fa11ab5688f744bc868356f3f14c3bb9f283a780 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 7 Dec 2018 17:50:05 -0600
Subject: [PATCH] ASoC: Intel: Skylake: stop probe if HDaudio capabilities
 don't exist

Check immediately if required HDaudio capabilities can't be found (no
PPCAP or no streams exposed in GCAP), and move all DMA inits after the
error tests.

PPCAP and GCAP are not reliable indicators of DSP presence, but if
they don't exist then the driver will not work.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 41a084b3d48f..72e366bbba33 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -946,6 +946,12 @@ static int skl_first_init(struct hdac_bus *bus)
 
 	snd_hdac_bus_parse_capabilities(bus);
 
+	/* check if PPCAP exists */
+	if (!bus->ppcap) {
+		dev_err(bus->dev, "bus ppcap not set, HDaudio or DSP not present?\n");
+		return -ENODEV;
+	}
+
 	if (skl_acquire_irq(bus, 0) < 0)
 		return -EBUSY;
 
@@ -955,23 +961,25 @@ static int skl_first_init(struct hdac_bus *bus)
 	gcap = snd_hdac_chip_readw(bus, GCAP);
 	dev_dbg(bus->dev, "chipset global capabilities = 0x%x\n", gcap);
 
-	/* allow 64bit DMA address if supported by H/W */
-	if (!dma_set_mask(bus->dev, DMA_BIT_MASK(64))) {
-		dma_set_coherent_mask(bus->dev, DMA_BIT_MASK(64));
-	} else {
-		dma_set_mask(bus->dev, DMA_BIT_MASK(32));
-		dma_set_coherent_mask(bus->dev, DMA_BIT_MASK(32));
-	}
-
 	/* read number of streams from GCAP register */
 	cp_streams = (gcap >> 8) & 0x0f;
 	pb_streams = (gcap >> 12) & 0x0f;
 
-	if (!pb_streams && !cp_streams)
+	if (!pb_streams && !cp_streams) {
+		dev_err(bus->dev, "no streams found in GCAP definitions?\n");
 		return -EIO;
+	}
 
 	bus->num_streams = cp_streams + pb_streams;
 
+	/* allow 64bit DMA address if supported by H/W */
+	if (!dma_set_mask(bus->dev, DMA_BIT_MASK(64))) {
+		dma_set_coherent_mask(bus->dev, DMA_BIT_MASK(64));
+	} else {
+		dma_set_mask(bus->dev, DMA_BIT_MASK(32));
+		dma_set_coherent_mask(bus->dev, DMA_BIT_MASK(32));
+	}
+
 	/* initialize streams */
 	snd_hdac_ext_stream_init_all
 		(bus, 0, cp_streams, SNDRV_PCM_STREAM_CAPTURE);
-- 
2.19.0.rc2
