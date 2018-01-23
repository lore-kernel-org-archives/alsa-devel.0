From: abhijeet.kumar@intel.com
Subject: [PATCH 3/3] ASoC: hdac_hdmi : Ensuring proper setting of output widget power state
Date: Tue, 23 Jan 2018 23:00:53 +0530
Message-ID: <1516728657-21522-3-git-send-email-abhijeet.kumar@intel.com>
References: <1515670468-9198-1-git-send-email-abhijeet.kumar@intel.com>
 <1516728657-21522-1-git-send-email-abhijeet.kumar@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516728657-21522-1-git-send-email-abhijeet.kumar@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Abhijeet Kumar <abhijeet.kumar@intel.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Wang YanQing <udknight@gmail.com>, Bhumika Goyal <bhumirks@gmail.com>, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Abhijeet Kumar <abhijeet.kumar@intel.com>

In usecases like hot plug-unplug DP panel or modeset during a playback,
sometimes we observe no audio after codec resets. During no audio
condition, we have noticed that the power state of the pin or the
connector is D3. Optimizing the way we set the power mitigates the
issue. With this changes the verb is sent to set the power state and
waits until actual state reaches target state. Thus ensuring power state
is set.

Signed-off-by: Abhijeet Kumar <abhijeet.kumar@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index f3b4f4dfae6a..4dc9b9b71db9 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -716,10 +716,20 @@ static struct hdac_hdmi_pcm *hdac_hdmi_get_pcm(struct hdac_ext_device *edev,
 static void hdac_hdmi_set_power_state(struct hdac_ext_device *edev,
 			     hda_nid_t nid, unsigned int pwr_state)
 {
+	int count;
+	unsigned int state;
 	if (get_wcaps(&edev->hdac, nid) & AC_WCAP_POWER) {
-		if (!snd_hdac_check_power_state(&edev->hdac, nid, pwr_state))
-			snd_hdac_codec_write(&edev->hdac, nid, 0,
-				AC_VERB_SET_POWER_STATE, pwr_state);
+		if (!snd_hdac_check_power_state(&edev->hdac, nid, pwr_state)) {
+			for (count = 0; count < 10; count++) {
+				snd_hdac_codec_read(&edev->hdac, nid, 0,
+						AC_VERB_SET_POWER_STATE,
+						pwr_state);
+				state = snd_hdac_sync_power_state(&edev->hdac,
+						 nid, pwr_state);
+				if (!(state & AC_PWRST_ERROR))
+					break;
+			}
+		}
 	}
 }
 
-- 
1.9.1
