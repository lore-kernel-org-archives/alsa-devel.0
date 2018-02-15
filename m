From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi : Ensuring proper setting of output widget power state" to the asoc tree
Date: Thu, 15 Feb 2018 15:34:24 +0000
Message-ID: <E1emLYG-0007Ln-Qd@debutante>
References: <1518683739-4448-1-git-send-email-abhijeet.kumar@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1518683739-4448-1-git-send-email-abhijeet.kumar@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>, Puneeth Prabhu <puneethx.prabhu@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, abhijeet.kumar@intel.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi : Ensuring proper setting of output widget power state

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 753597fbb7031ff147d4f2862426699e4ad8efca Mon Sep 17 00:00:00 2001
From: Abhijeet Kumar <abhijeet.kumar@intel.com>
Date: Thu, 15 Feb 2018 14:05:38 +0530
Subject: [PATCH] ASoC: hdac_hdmi : Ensuring proper setting of output widget
 power state

In usecases like hot plug-unplug DP panel or modeset during a playback,
sometimes we observe no audio after codec resets. During no audio
condition, we have noticed that the power state of the pin or the
connector is D3. Optimizing the way we set the power mitigates the
issue. With this changes the verb is sent to set the power state and
waits until actual state reaches target state. Thus ensuring power
state is set.

Signed-off-by: Abhijeet Kumar <abhijeet.kumar@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 0758927d1e06..60bea9d69fc0 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -718,10 +718,22 @@ static struct hdac_hdmi_pcm *hdac_hdmi_get_pcm(struct hdac_ext_device *edev,
 static void hdac_hdmi_set_power_state(struct hdac_ext_device *edev,
 			     hda_nid_t nid, unsigned int pwr_state)
 {
+	int count;
+	unsigned int state;
+
 	if (get_wcaps(&edev->hdev, nid) & AC_WCAP_POWER) {
-		if (!snd_hdac_check_power_state(&edev->hdev, nid, pwr_state))
-			snd_hdac_codec_write(&edev->hdev, nid, 0,
-				AC_VERB_SET_POWER_STATE, pwr_state);
+		if (!snd_hdac_check_power_state(&edev->hdac, nid, pwr_state)) {
+			for (count = 0; count < 10; count++) {
+				snd_hdac_codec_read(&edev->hdac, nid, 0,
+						AC_VERB_SET_POWER_STATE,
+						pwr_state);
+				state = snd_hdac_sync_power_state(&edev->hdac,
+						nid, pwr_state);
+				if (!(state & AC_PWRST_ERROR))
+					break;
+			}
+		}
+
 	}
 }
 
-- 
2.16.1
