From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: hdac_hdmi: fix spelling mistake "montior" -> "monitor"
Date: Fri, 26 Aug 2016 19:17:25 +0100
Message-ID: <20160826181725.769-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_warn message.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/hdac_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 4e181b2..c602c49 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -614,7 +614,7 @@ static int hdac_hdmi_pcm_open(struct snd_pcm_substream *substream,
 			(!pin->eld.eld_valid)) {
 
 		dev_warn(&hdac->hdac.dev,
-			"Failed: montior present? %d ELD valid?: %d for pin: %d\n",
+			"Failed: monitor present? %d ELD valid?: %d for pin: %d\n",
 			pin->eld.monitor_present, pin->eld.eld_valid, pin->nid);
 
 		return 0;
-- 
2.9.3
