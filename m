From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: Intel: Fix build
Date: Thu, 15 Feb 2018 17:20:33 +0000
Message-ID: <20180215172033.8534-1-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 97A4D267CBF
 for <alsa-devel@alsa-project.org>; Thu, 15 Feb 2018 18:20:52 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: abhijeet.kumar@intel.com, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

One of the recently introduced commits hadn't been build tested, fix
that.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 60bea9d69fc0..84f7a7a36e4b 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -722,12 +722,12 @@ static void hdac_hdmi_set_power_state(struct hdac_ext_device *edev,
 	unsigned int state;
 
 	if (get_wcaps(&edev->hdev, nid) & AC_WCAP_POWER) {
-		if (!snd_hdac_check_power_state(&edev->hdac, nid, pwr_state)) {
+		if (!snd_hdac_check_power_state(&edev->hdev, nid, pwr_state)) {
 			for (count = 0; count < 10; count++) {
-				snd_hdac_codec_read(&edev->hdac, nid, 0,
+				snd_hdac_codec_read(&edev->hdev, nid, 0,
 						AC_VERB_SET_POWER_STATE,
 						pwr_state);
-				state = snd_hdac_sync_power_state(&edev->hdac,
+				state = snd_hdac_sync_power_state(&edev->hdev,
 						nid, pwr_state);
 				if (!(state & AC_PWRST_ERROR))
 					break;
-- 
2.16.1
