From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 2/4] ALSA: opti92x: mark expected switch fall-throughs
Date: Thu, 2 Aug 2018 15:41:21 -0500
Message-ID: <a1aff0d9df70429d2b414435764f2092263ffee9.1533242152.git.gustavo@embeddedor.com>
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

Addresses-Coverity-ID: 1165394 ("Missing break in switch")
Addresses-Coverity-ID: 1167851 ("Missing break in switch")
Addresses-Coverity-ID: 402015 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/isa/opti9xx/opti92x-ad1848.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index 505cd81..ac0ab6e 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -261,6 +261,7 @@ static unsigned char snd_opti9xx_read(struct snd_opti9xx *chip,
 			retval = inb(chip->mc_base + 9);
 			break;
 		}
+		/* Fall through */
 
 	case OPTi9XX_HW_82C928:
 	case OPTi9XX_HW_82C929:
@@ -303,6 +304,7 @@ static void snd_opti9xx_write(struct snd_opti9xx *chip, unsigned char reg,
 			outb(value, chip->mc_base + 9);
 			break;
 		}
+		/* Fall through */
 
 	case OPTi9XX_HW_82C928:
 	case OPTi9XX_HW_82C929:
@@ -350,6 +352,7 @@ static int snd_opti9xx_configure(struct snd_opti9xx *chip,
 		snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(4), 0xf0, 0xfc);
 		/* enable wave audio */
 		snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(6), 0x02, 0x02);
+		/* Fall through */
 
 	case OPTi9XX_HW_82C925:
 		/* enable WSS mode */
-- 
2.7.4
