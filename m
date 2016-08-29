From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 05/12] ALSA: hdac: Move 'to_hda_ext_device'
	helper to core
Date: Mon, 29 Aug 2016 11:53:19 +0530
Message-ID: <1472451806-10605-6-git-send-email-subhransu.s.prusty@intel.com>
References: <1472451806-10605-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id CE4B9266E18
 for <alsa-devel@alsa-project.org>; Mon, 29 Aug 2016 18:23:42 +0200 (CEST)
In-Reply-To: <1472451806-10605-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/hda/ext/hdac_codec.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/hda/ext/hdac_codec.h b/sound/hda/ext/hdac_codec.h
index 7f47a7e..9159139 100644
--- a/sound/hda/ext/hdac_codec.h
+++ b/sound/hda/ext/hdac_codec.h
@@ -46,6 +46,13 @@ struct hdac_codec_widget {
 	void *params;	/* Widget specific parameters */
 };
 
+static inline struct hdac_ext_device *to_hda_ext_device(struct device *dev)
+{
+	struct hdac_device *hdac = dev_to_hdac_dev(dev);
+
+	return to_ehdac_device(hdac);
+}
+
 int snd_hdac_parse_widgets(struct hdac_device *hdac);
 int snd_hdac_codec_init(struct hdac_device *hdac);
 void snd_hdac_codec_cleanup(struct hdac_device *hdac);
-- 
1.9.1
