From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Subject: [PATCH 4/4] ALSA: hda: check if stream is stopped in
	snd_hdac_stream_clear
Date: Tue, 15 May 2018 12:10:56 +0530
Message-ID: <1526366456-20470-5-git-send-email-sriramx.periyasamy@intel.com>
References: <1526366456-20470-1-git-send-email-sriramx.periyasamy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 11E38266F69
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 08:51:25 +0200 (CEST)
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

Check if the DMA Channel is already stopped. There is no need
to stop it again if stopped.

Signed-off-by: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>
Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
---
 sound/hda/hdac_stream.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index aa8a2884289f..c1810eb7212b 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -89,6 +89,11 @@ void snd_hdac_stream_clear(struct hdac_stream *azx_dev)
 	int timeout = 300;
 	unsigned char val;
 
+	/* check if the DMA is already stopped */
+	val = snd_hdac_stream_readb(azx_dev, SD_CTL) & SD_CTL_DMA_START;
+	if (!val)
+		return;
+
 	snd_hdac_stream_updateb(azx_dev, SD_CTL,
 				SD_CTL_DMA_START | SD_INT_MASK, 0);
 
-- 
2.7.4
