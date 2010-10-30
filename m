From: Joe Perches <joe@perches.com>
Subject: [PATCH 39/39] sound/soc/codecs/wm_hubs.c: Update WARN uses
Date: Sat, 30 Oct 2010 14:08:56 -0700
Message-ID: <777b4b32cf9bcd1fcb78d7d5c26e8c9a0c17aa3e.1288471898.git.joe@perches.com>
References: <cover.1288471897.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1288471897.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <trivial@kernel.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Ian Lartey <ian@opensource.wolfsonmicro.com>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add missing newlines.

Signed-off-by: Joe Perches <joe@perches.com>
---
 sound/soc/codecs/wm_hubs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index 2cb8153..19ca782 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -123,7 +123,7 @@ static void calibrate_dc_servo(struct snd_soc_codec *codec)
 			reg_r = reg & WM8993_DCS_DAC_WR_VAL_0_MASK;
 			break;
 		default:
-			WARN(1, "Unknown DCS readback method");
+			WARN(1, "Unknown DCS readback method\n");
 			break;
 		}
 
-- 
1.7.3.1.g432b3.dirty
