From: Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH v2] ASoC: sgtl5000: add avc enable control
Date: Tue, 30 May 2017 14:00:16 +0200
Message-ID: <1496145616-9307-1-git-send-email-richard.leitner@skidata.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, dev@g0hl1n.net, Richard Leitner <richard.leitner@skidata.com>
List-Id: alsa-devel@alsa-project.org

This control enables the automatic volume control (AVC) of SGTL5000
using its DAP_AVC_CTRL register.

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
CHANGES v2:
	- added trailing "Switch" as covered in ControlNames.txt
---
 sound/soc/codecs/sgtl5000.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 5a2702e..0477f2e 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -434,6 +434,8 @@ static const struct snd_kcontrol_new sgtl5000_snd_controls[] = {
 			0x1f, 1,
 			lineout_volume),
 	SOC_SINGLE("Lineout Playback Switch", SGTL5000_CHIP_ANA_CTRL, 8, 1, 1),
+
+	SOC_SINGLE("AVC Enable Switch", SGTL5000_DAP_AVC_CTRL, 0, 1, 0),
 };
 
 /* mute the codec used by alsa core */
-- 
2.1.4
