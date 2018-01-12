From: abhijeet.kumar@intel.com
Subject: [PATCH v2] ASoC: hdac_hdmi: Ensuring proper setting of
	output widget power state
Date: Fri, 12 Jan 2018 13:57:58 +0530
Message-ID: <1515745679-6989-1-git-send-email-abhijeet.kumar@intel.com>
References: <1515670468-9198-1-git-send-email-abhijeet.kumar@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 137D7266F50
 for <alsa-devel@alsa-project.org>; Fri, 12 Jan 2018 09:19:40 +0100 (CET)
In-Reply-To: <1515670468-9198-1-git-send-email-abhijeet.kumar@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Sandeep Tayal <sandeepx.tayal@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: abhijeet.kumar@intel.com
List-Id: alsa-devel@alsa-project.org

From: Abhijeet Kumar <abhijeet.kumar@intel.com>

In usecases like hot plug-unplug DP panel or modeset during a playback,
sometimes we observe no audio after codec resets.

During no audio condition, we have noticed that the power state of the
pin or the connector is D3. Optimzing the way we set the power could
mitigate the issue. With this changes the verb is sent to set the power
state and response is received. Thus ensuring power state is set.

Signed-off-by: Abhijeet Kumar <abhijeet.kumar@intel.com>
---
Changes in v2:
- update commit message

 sound/soc/codecs/hdac_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index f3b4f4dfae6a..e24caecf0a4f 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -718,7 +718,7 @@ static void hdac_hdmi_set_power_state(struct hdac_ext_device *edev,
 {
 	if (get_wcaps(&edev->hdac, nid) & AC_WCAP_POWER) {
 		if (!snd_hdac_check_power_state(&edev->hdac, nid, pwr_state))
-			snd_hdac_codec_write(&edev->hdac, nid, 0,
+			snd_hdac_codec_read(&edev->hdac, nid, 0,
 				AC_VERB_SET_POWER_STATE, pwr_state);
 	}
 }
-- 
1.9.1
