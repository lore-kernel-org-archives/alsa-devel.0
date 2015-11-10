From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v4 1/6] ALSA: hdac: structure definition for
	ext_dma_params
Date: Tue, 10 Nov 2015 18:42:05 +0530
Message-ID: <1447161130-24889-2-git-send-email-vinod.koul@intel.com>
References: <1447161130-24889-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id CFD182650CC
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2015 14:08:50 +0100 (CET)
In-Reply-To: <1447161130-24889-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

This extends the structure definition of ext_device and adds
definition for dma_params which will be used when hdmi codec.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Acked-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hdaudio_ext.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index a4cadd9c297a..425af0674557 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -186,9 +186,15 @@ struct hdac_ext_device {
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
1.9.1
