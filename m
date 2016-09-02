From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v2 08/11] ALSA: hda - macro to get default
	config device of pin widgets
Date: Fri,  2 Sep 2016 16:34:57 +0530
Message-ID: <1472814300-5629-9-git-send-email-subhransu.s.prusty@intel.com>
References: <1472814300-5629-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FD022677A8
 for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2016 13:10:55 +0200 (CEST)
In-Reply-To: <1472814300-5629-1-git-send-email-subhransu.s.prusty@intel.com>
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

In ASoC this easy macro can be used to identify the default
endpoint configuration and create DAPM endpoint widgets.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/hda/local.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/hda/local.h b/sound/hda/local.h
index 9f89e85..41186ab 100644
--- a/sound/hda/local.h
+++ b/sound/hda/local.h
@@ -11,6 +11,9 @@
 #define get_pcaps(codec, nid) \
 	snd_hdac_read_parm(codec, nid, AC_PAR_PIN_CAP)
 
+#define get_defcfg_device(cfg) \
+	((cfg & AC_DEFCFG_DEVICE) >> AC_DEFCFG_DEVICE_SHIFT)
+
 static inline bool is_input_pin(struct hdac_device *codec, hda_nid_t nid)
 {
 	unsigned int pincap = get_pcaps(codec, nid);
-- 
1.9.1
