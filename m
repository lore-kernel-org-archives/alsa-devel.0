From: abhijeet.kumar@intel.com
Subject: [PATCH 2/3] ALSA: hda: Make use of core codec
	functions to sync power state
Date: Tue, 23 Jan 2018 23:00:52 +0530
Message-ID: <1516728657-21522-2-git-send-email-abhijeet.kumar@intel.com>
References: <1515670468-9198-1-git-send-email-abhijeet.kumar@intel.com>
 <1516728657-21522-1-git-send-email-abhijeet.kumar@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 6323E2672B0
 for <alsa-devel@alsa-project.org>; Tue, 23 Jan 2018 18:22:29 +0100 (CET)
In-Reply-To: <1516728657-21522-1-git-send-email-abhijeet.kumar@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Abhijeet Kumar <abhijeet.kumar@intel.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Bhumika Goyal <bhumirks@gmail.com>, Wang YanQing <udknight@gmail.com>, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Abhijeet Kumar <abhijeet.kumar@intel.com>

Since sync_power_state is moved to core it's better to use the helper
function to ensure the actual power state reaches target instead of
using the local helper functions already exsisting in hda code.

Signed-off-by: Abhijeet Kumar <abhijeet.kumar@intel.com>
---
 sound/pci/hda/hda_codec.c | 28 +---------------------------
 sound/pci/hda/hda_local.h |  6 +++++-
 2 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index e018ecbf78a8..5bc3a7468e17 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2702,32 +2702,6 @@ void snd_hda_codec_set_power_to_all(struct hda_codec *codec, hda_nid_t fg,
 }
 EXPORT_SYMBOL_GPL(snd_hda_codec_set_power_to_all);
 
-/*
- * wait until the state is reached, returns the current state
- */
-static unsigned int hda_sync_power_state(struct hda_codec *codec,
-					 hda_nid_t fg,
-					 unsigned int power_state)
-{
-	unsigned long end_time = jiffies + msecs_to_jiffies(500);
-	unsigned int state, actual_state;
-
-	for (;;) {
-		state = snd_hda_codec_read(codec, fg, 0,
-					   AC_VERB_GET_POWER_STATE, 0);
-		if (state & AC_PWRST_ERROR)
-			break;
-		actual_state = (state >> 4) & 0x0f;
-		if (actual_state == power_state)
-			break;
-		if (time_after_eq(jiffies, end_time))
-			break;
-		/* wait until the codec reachs to the target state */
-		msleep(1);
-	}
-	return state;
-}
-
 /**
  * snd_hda_codec_eapd_power_filter - A power filter callback for EAPD
  * @codec: the HDA codec
@@ -2790,7 +2764,7 @@ static unsigned int hda_set_power_state(struct hda_codec *codec,
 						   state);
 			snd_hda_codec_set_power_to_all(codec, fg, power_state);
 		}
-		state = hda_sync_power_state(codec, fg, power_state);
+		state = snd_hda_sync_power_state(codec, fg, power_state);
 		if (!(state & AC_PWRST_ERROR))
 			break;
 	}
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index 5b5c324c99b9..321e78baa63c 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -622,7 +622,11 @@ int snd_hda_check_amp_list_power(struct hda_codec *codec,
 {
 	return snd_hdac_check_power_state(&codec->core, nid, target_state);
 }
-
+static inline bool snd_hda_sync_power_state(struct hda_codec *codec,
+			   hda_nid_t nid, unsigned int target_state)
+{
+	return snd_hdac_sync_power_state(&codec->core, nid, target_state);
+}
 unsigned int snd_hda_codec_eapd_power_filter(struct hda_codec *codec,
 					     hda_nid_t nid,
 					     unsigned int power_state);
-- 
1.9.1
