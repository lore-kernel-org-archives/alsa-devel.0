From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Subject: [PATCH 1/4] ALSA: hda: Make sure DMA is stopped by
	reading back the RUN bit
Date: Tue, 15 May 2018 12:10:53 +0530
Message-ID: <1526366456-20470-2-git-send-email-sriramx.periyasamy@intel.com>
References: <1526366456-20470-1-git-send-email-sriramx.periyasamy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 96907266F4E
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 08:51:19 +0200 (CEST)
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

As per HW recommendation, after clearing the RUN bit,
software must read a 0 from the RUN bit, before modifying
related control registers or re-starting the DMA engine.

Signed-off-by: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>
Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
---
 sound/hda/hdac_stream.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index e1472c7ab6c1..2000ea6f48fa 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -70,8 +70,23 @@ EXPORT_SYMBOL_GPL(snd_hdac_stream_start);
  */
 void snd_hdac_stream_clear(struct hdac_stream *azx_dev)
 {
+	int timeout = 300;
+	unsigned char val;
+
 	snd_hdac_stream_updateb(azx_dev, SD_CTL,
 				SD_CTL_DMA_START | SD_INT_MASK, 0);
+
+	do {
+		udelay(3);
+		val = snd_hdac_stream_readb(azx_dev, SD_CTL) &
+				SD_CTL_DMA_START;
+		if (!val)
+			break;
+	} while (--timeout);
+
+	if (!timeout)
+		dev_err(azx_dev->bus->dev, "unable to stop the stream\n");
+
 	snd_hdac_stream_writeb(azx_dev, SD_STS, SD_INT_MASK); /* to be sure */
 	azx_dev->running = false;
 }
-- 
2.7.4
