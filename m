From: abhijeet.kumar@intel.com
Subject: [PATCH 1/3] ALSA: hda: Copying sync power state helper to core
Date: Tue, 23 Jan 2018 23:00:51 +0530
Message-ID: <1516728657-21522-1-git-send-email-abhijeet.kumar@intel.com>
References: <1515670468-9198-1-git-send-email-abhijeet.kumar@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515670468-9198-1-git-send-email-abhijeet.kumar@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Abhijeet Kumar <abhijeet.kumar@intel.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Bhumika Goyal <bhumirks@gmail.com>, Wang YanQing <udknight@gmail.com>, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Abhijeet Kumar <abhijeet.kumar@intel.com>

The current sync_power_state is local to hda code, moving it
core so that other users apart from hda legacy can use it.
The helper function ensures the actual state reaches the target state.

Signed-off-by: Abhijeet Kumar <abhijeet.kumar@intel.com>
---
 include/sound/hdaudio.h |  2 ++
 sound/hda/hdac_device.c | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 68169e3749de..4c93ff5301bd 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -146,6 +146,8 @@ int snd_hdac_codec_write(struct hdac_device *hdac, hda_nid_t nid,
 			int flags, unsigned int verb, unsigned int parm);
 bool snd_hdac_check_power_state(struct hdac_device *hdac,
 		hda_nid_t nid, unsigned int target_state);
+unsigned int snd_hdac_sync_power_state(struct hdac_device *hdac,
+		      hda_nid_t nid, unsigned int target_state);
 /**
  * snd_hdac_read_parm - read a codec parameter
  * @codec: the codec object
diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index 06f845e293cb..7ba100bb1c3f 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -3,6 +3,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -1064,3 +1065,37 @@ bool snd_hdac_check_power_state(struct hdac_device *hdac,
 	return (state == target_state);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_check_power_state);
+/**
+ * snd_hdac_sync_power_state - wait until actual power state matches
+ * with the target state
+ *
+ * @hdac: the HDAC device
+ * @nid: NID to send the command
+ * @target_state: target state to check for
+ *
+ * Return power state or PS_ERROR if codec rejects GET verb.
+ */
+unsigned int snd_hdac_sync_power_state(struct hdac_device *codec,
+			hda_nid_t nid, unsigned int power_state)
+{
+	unsigned long end_time = jiffies + msecs_to_jiffies(500);
+	unsigned int state, actual_state, count;
+
+	for (count = 0; count < 500; count++) {
+		state = snd_hdac_codec_read(codec, nid, 0,
+				AC_VERB_GET_POWER_STATE, 0);
+		if (state & AC_PWRST_ERROR) {
+			msleep(20);
+			break;
+		}
+		actual_state = (state >> 4) & 0x0f;
+		if (actual_state == power_state)
+			break;
+		if (time_after_eq(jiffies, end_time))
+			break;
+		/* wait until the codec reachs to the target state */
+		msleep(1);
+	}
+	return state;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_sync_power_state);
-- 
1.9.1
