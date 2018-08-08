From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ALSA: usb-audio: Mark expected switch fall-through
Date: Wed, 8 Aug 2018 17:23:44 -0500
Message-ID: <20180808222344.GA3140@embeddedor.com>
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

Addresses-Coverity-ID: 1357413 ("Missing break in switch")
Addresses-Coverity-ID: 114917 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/usb/mixer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 73e811f..c63c84b 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -856,12 +856,14 @@ static int check_input_term(struct mixer_build *state, int id,
 					term->type = UAC3_PROCESSING_UNIT << 16; /* virtual type */
 				else /* UAC_VERSION_2 */
 					term->type = UAC3_EFFECT_UNIT << 16; /* virtual type */
+				/* fall through */
 			case UAC1_EXTENSION_UNIT:
 			/* UAC2_PROCESSING_UNIT_V2 */
 				if (protocol == UAC_VERSION_1 && !term->type)
 					term->type = UAC3_EXTENSION_UNIT << 16; /* virtual type */
 				else if (protocol == UAC_VERSION_2 && !term->type)
 					term->type = UAC3_PROCESSING_UNIT << 16; /* virtual type */
+				/* fall through */
 			case UAC2_EXTENSION_UNIT_V2: {
 				struct uac_processing_unit_descriptor *d = p1;
 
-- 
2.7.4
