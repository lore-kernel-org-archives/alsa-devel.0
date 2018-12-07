From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 3/6] ASoC: Intel: Skylake: stop probe if
	HDaudio capabilities don't exist
Date: Fri,  7 Dec 2018 17:50:05 -0600
Message-ID: <20181207235008.22988-4-pierre-louis.bossart@linux.intel.com>
References: <20181207235008.22988-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id DC180267D2F
 for <alsa-devel@alsa-project.org>; Sat,  8 Dec 2018 00:51:04 +0100 (CET)
In-Reply-To: <20181207235008.22988-1-pierre-louis.bossart@linux.intel.com>
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
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Filip Kaczmarski <filip.kaczmarski@intel.com>, tiwai@suse.de, Chris Chiu <chiu@endlessm.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Daniel Drake <drake@endlessm.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Michal Wasko <michal.wasko@intel.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>
List-Id: alsa-devel@alsa-project.org

Check immediately if required HDaudio capabilities can't be found (no
PPCAP or no streams exposed in GCAP), and move all DMA inits after the
error tests.

PPCAP and GCAP are not reliable indicators of DSP presence, but if
they don't exist then the driver will not work.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
2.17.1
