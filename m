From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [RFC 03/11] ALSA: hda - Add macro to test pin widget's
	input capability
Date: Mon, 27 Jun 2016 09:17:56 +0530
Message-ID: <1466999284-14782-4-git-send-email-subhransu.s.prusty@intel.com>
References: <1466999284-14782-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id A546D265162
 for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2016 05:51:38 +0200 (CEST)
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
 sound/hda/local.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/hda/local.h b/sound/hda/local.h
index 0d5bb15..a51f5f6 100644
--- a/sound/hda/local.h
+++ b/sound/hda/local.h
@@ -8,6 +8,16 @@
 #define get_wcaps(codec, nid) \
 	snd_hdac_read_parm(codec, nid, AC_PAR_AUDIO_WIDGET_CAP)
 
+#define get_pcaps(codec, nid) \
+	snd_hdac_read_parm(codec, nid, AC_PAR_PIN_CAP)
+
+static inline int is_input_pin(struct hdac_device *codec, hda_nid_t nid)
+{
+	unsigned int pincap = get_pcaps(codec, nid);
+
+	return (pincap & AC_PINCAP_IN) != 0;
+}
+
 /* get the widget type from widget capability bits */
 static inline int get_wcaps_type(unsigned int wcaps)
 {
-- 
1.9.1
