From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ALSA: pcm: Mark expected switch fall-through
Date: Wed, 1 Aug 2018 10:58:25 -0500
Message-ID: <20180801155825.GA4876@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1357375 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/core/oss/pcm_plugin.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/core/oss/pcm_plugin.c b/sound/core/oss/pcm_plugin.c
index 85bab92..0391cb1a 100644
--- a/sound/core/oss/pcm_plugin.c
+++ b/sound/core/oss/pcm_plugin.c
@@ -353,6 +353,7 @@ snd_pcm_format_t snd_pcm_plug_slave_format(snd_pcm_format_t format,
 				if (snd_mask_test(format_mask, (__force int)format1))
 					return format1;
 			}
+			/* fall through */
 		default:
 			return (__force snd_pcm_format_t)-EINVAL;
 		}
-- 
2.7.4
