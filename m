From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [RFC 09/11] ALSA: hda - macro to get default config
	device of pin widgets
Date: Mon, 27 Jun 2016 09:18:02 +0530
Message-ID: <1466999284-14782-10-git-send-email-subhransu.s.prusty@intel.com>
References: <1466999284-14782-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 7502926524F
 for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2016 05:51:53 +0200 (CEST)
In-Reply-To: <1466999284-14782-1-git-send-email-subhransu.s.prusty@intel.com>
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
 sound/hda/local.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/hda/local.h b/sound/hda/local.h
index a51f5f6..cceeac2 100644
--- a/sound/hda/local.h
+++ b/sound/hda/local.h
@@ -11,6 +11,9 @@
 #define get_pcaps(codec, nid) \
 	snd_hdac_read_parm(codec, nid, AC_PAR_PIN_CAP)
 
+#define get_defcfg_device(cfg) \
+	((cfg & AC_DEFCFG_DEVICE) >> AC_DEFCFG_DEVICE_SHIFT)
+
 static inline int is_input_pin(struct hdac_device *codec, hda_nid_t nid)
 {
 	unsigned int pincap = get_pcaps(codec, nid);
-- 
1.9.1
