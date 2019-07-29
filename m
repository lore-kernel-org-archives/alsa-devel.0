From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] sound: dmasound_atari: Mark expected switch fall-through
Date: Mon, 29 Jul 2019 09:33:20 -0500
Message-ID: <20190729143320.GA8212@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <keescook@chromium.org>
List-Id: alsa-devel@alsa-project.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warning:

sound/oss/dmasound/dmasound_atari.c: warning: this statement may fall
through [-Wimplicit-fallthrough=]:  => 1449:24

Notice that, in this particular case, the code comment is
modified in accordance with what GCC is expecting to find.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/oss/dmasound/dmasound_atari.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/oss/dmasound/dmasound_atari.c b/sound/oss/dmasound/dmasound_atari.c
index 83653683fd68..b5845e904ba1 100644
--- a/sound/oss/dmasound/dmasound_atari.c
+++ b/sound/oss/dmasound/dmasound_atari.c
@@ -1449,7 +1449,7 @@ static int FalconMixerIoctl(u_int cmd, u_long arg)
 		tt_dmasnd.input_gain =
 			RECLEVEL_VOXWARE_TO_GAIN(data & 0xff) << 4 |
 			RECLEVEL_VOXWARE_TO_GAIN(data >> 8 & 0xff);
-		/* fall thru, return set value */
+		/* fall through - return set value */
 	    case SOUND_MIXER_READ_MIC:
 		return IOCTL_OUT(arg,
 			RECLEVEL_GAIN_TO_VOXWARE(tt_dmasnd.input_gain >> 4 & 0xf) |
-- 
2.22.0
