From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Subject: [PATCH 3/4] ALSA: hda: Log HDA Hardware related errors
Date: Tue, 15 May 2018 12:10:55 +0530
Message-ID: <1526366456-20470-4-git-send-email-sriramx.periyasamy@intel.com>
References: <1526366456-20470-1-git-send-email-sriramx.periyasamy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BF4F266F46
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 08:51:23 +0200 (CEST)
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

Detect the timeout while modifying HDA DMA related Registers
for stream reset and print them to console for user information

Signed-off-by: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>
Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
---
 sound/hda/hdac_stream.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index 33c8ced528f6..aa8a2884289f 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -144,6 +144,10 @@ void snd_hdac_stream_reset(struct hdac_stream *azx_dev)
 		if (val)
 			break;
 	} while (--timeout);
+
+	if (!timeout)
+		dev_err(azx_dev->bus->dev, "timeout on stream reset entry\n");
+
 	val &= ~SD_CTL_STREAM_RESET;
 	snd_hdac_stream_writeb(azx_dev, SD_CTL, val);
 	udelay(3);
@@ -157,6 +161,9 @@ void snd_hdac_stream_reset(struct hdac_stream *azx_dev)
 			break;
 	} while (--timeout);
 
+	if (!timeout)
+		dev_err(azx_dev->bus->dev, "timeout on stream reset exit\n");
+
 	/* reset first position - may not be synced with hw at this time */
 	if (azx_dev->posbuf)
 		*azx_dev->posbuf = 0;
-- 
2.7.4
