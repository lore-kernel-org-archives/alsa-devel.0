From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 4/4] ALSA: es18xx: mark expected switch fall-through
Date: Thu, 2 Aug 2018 15:42:39 -0500
Message-ID: <0f829f2fdd59c8e59b1ec08b8742fadf419a30f0.1533242152.git.gustavo@embeddedor.com>
References: <cover.1533242152.git.gustavo@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1533242152.git.gustavo@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 115075 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/isa/es18xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/isa/es18xx.c b/sound/isa/es18xx.c
index 2a6960c..0d103d6 100644
--- a/sound/isa/es18xx.c
+++ b/sound/isa/es18xx.c
@@ -1024,6 +1024,7 @@ static int snd_es18xx_put_mux(struct snd_kcontrol *kcontrol, struct snd_ctl_elem
 			val = 3;
 		} else
 			retVal = snd_es18xx_mixer_bits(chip, 0x7a, 0x08, 0x00) != 0x00;
+		/* fall through */
  /* 4 source chips */
 	case 0x1868:
 	case 0x1878:
-- 
2.7.4
