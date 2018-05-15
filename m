From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Subject: [PATCH 2/4] ALSA: hda: Make sure DMA is started by
	reading back the RUN bit
Date: Tue, 15 May 2018 12:10:54 +0530
Message-ID: <1526366456-20470-3-git-send-email-sriramx.periyasamy@intel.com>
References: <1526366456-20470-1-git-send-email-sriramx.periyasamy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 28629266F69
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 08:51:20 +0200 (CEST)
In-Reply-To: <1526366456-20470-1-git-send-email-sriramx.periyasamy@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>

As per HW recommendation, after setting the RUN bit,
software must read a 1 from the RUN bit, before modifying
related control registers/re-starting the DMA engine.

Signed-off-by: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>
Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
---
 sound/hda/hdac_stream.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index 2000ea6f48fa..33c8ced528f6 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -48,6 +48,8 @@ EXPORT_SYMBOL_GPL(snd_hdac_stream_init);
 void snd_hdac_stream_start(struct hdac_stream *azx_dev, bool fresh_start)
 {
 	struct hdac_bus *bus = azx_dev->bus;
+	int timeout = 300;
+	unsigned char val;
 
 	trace_snd_hdac_stream_start(bus, azx_dev);
 
@@ -60,6 +62,20 @@ void snd_hdac_stream_start(struct hdac_stream *azx_dev, bool fresh_start)
 	/* set DMA start and interrupt mask */
 	snd_hdac_stream_updateb(azx_dev, SD_CTL,
 				0, SD_CTL_DMA_START | SD_INT_MASK);
+
+	do {
+		udelay(3);
+		val = snd_hdac_stream_readb(azx_dev, SD_CTL) & SD_CTL_DMA_START;
+		if (val)
+			break;
+	} while (--timeout);
+
+	if (!timeout) {
+		azx_dev->running = false;
+		dev_err(azx_dev->bus->dev, "unable to start the stream\n");
+		return;
+	}
+
 	azx_dev->running = true;
 }
 EXPORT_SYMBOL_GPL(snd_hdac_stream_start);
-- 
2.7.4
