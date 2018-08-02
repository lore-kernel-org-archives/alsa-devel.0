From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 3/4] ALSA: opti9xx: mark expected switch fall-throughs
Date: Thu, 2 Aug 2018 15:41:55 -0500
Message-ID: <3355bbbbecd3a8041635d5d125aa9111c17beed9.1533242152.git.gustavo@embeddedor.com>
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

Addresses-Coverity-ID: 402016 ("Missing break in switch")
Addresses-Coverity-ID: 1056542 ("Missing break in switch")
Addresses-Coverity-ID: 1339579 ("Missing break in switch")
Addresses-Coverity-ID: 1369526 ("Missing break in switch")
Addresses-Coverity-ID: 1369529 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/isa/opti9xx/miro.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/isa/opti9xx/miro.c b/sound/isa/opti9xx/miro.c
index 8894c7c..c6136c6 100644
--- a/sound/isa/opti9xx/miro.c
+++ b/sound/isa/opti9xx/miro.c
@@ -176,10 +176,13 @@ static int aci_busy_wait(struct snd_miro_aci *aci)
 			switch (timeout-ACI_MINTIME) {
 			case 0 ... 9:
 				out /= 10;
+				/* fall through */
 			case 10 ... 19:
 				out /= 10;
+				/* fall through */
 			case 20 ... 30:
 				out /= 10;
+				/* fall through */
 			default:
 				set_current_state(TASK_UNINTERRUPTIBLE);
 				schedule_timeout(out);
@@ -834,6 +837,7 @@ static unsigned char snd_miro_read(struct snd_miro *chip,
 			retval = inb(chip->mc_base + 9);
 			break;
 		}
+		/* fall through */
 
 	case OPTi9XX_HW_82C929:
 		retval = inb(chip->mc_base + reg);
@@ -863,6 +867,7 @@ static void snd_miro_write(struct snd_miro *chip, unsigned char reg,
 			outb(value, chip->mc_base + 9);
 			break;
 		}
+		/* fall through */
 
 	case OPTi9XX_HW_82C929:
 		outb(value, chip->mc_base + reg);
-- 
2.7.4
