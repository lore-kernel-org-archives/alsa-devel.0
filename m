From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/4] ALSA: hdac: structure definition for
	ext_dma_params
Date: Mon,  5 Oct 2015 15:09:50 +0100
Message-ID: <1444054191-17030-4-git-send-email-vinod.koul@intel.com>
References: <1444054191-17030-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id CE84026062F
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 16:10:30 +0200 (CEST)
In-Reply-To: <1444054191-17030-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

This extends the structure definition of hdac_ext_device and adds definition for
dma_params which will be used with HDA codec.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hdaudio_ext.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index 94210dcdb6ea..719edff2a77b 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -179,9 +179,15 @@ struct hdac_ext_device {
 	/* codec ops */
 	struct hdac_ext_codec_ops ops;
 
+	struct snd_card *card;
+	void *scodec;
 	void *private_data;
 };
 
+struct hdac_ext_dma_params {
+	u32 format;
+	u8 stream_tag;
+};
 #define to_ehdac_device(dev) (container_of((dev), \
 				 struct hdac_ext_device, hdac))
 /*
-- 
2.4.3
