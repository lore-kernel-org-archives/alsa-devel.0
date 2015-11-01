From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH] snd-maestro3: Fix Allegro mute until master
	volume/mute is touched
Date: Sun,  1 Nov 2015 20:53:14 +0100
Message-ID: <1446407594-2382-1-git-send-email-linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gsystem.sk (ns.gsystem.sk [62.176.172.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BBB9260513
 for <alsa-devel@alsa-project.org>; Sun,  1 Nov 2015 20:53:26 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.com>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

ESS Allegro (marked ES1989S), [125d:1988] (rev 10) is mute after
loading snd-maestro3 and running alsactl restore. Touching master
volume or mute makes it work.

Looks like a bug in the AC'97 codec integrated into the chip.

Write AC97_MASTER register twice to work-around the problem.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
---
 sound/pci/maestro3.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/pci/maestro3.c b/sound/pci/maestro3.c
index 965d5c6..17ae926 100644
--- a/sound/pci/maestro3.c
+++ b/sound/pci/maestro3.c
@@ -1929,6 +1929,16 @@ snd_m3_ac97_write(struct snd_ac97 *ac97, unsigned short reg, unsigned short val)
 		return;
 	snd_m3_outw(chip, val, CODEC_DATA);
 	snd_m3_outb(chip, reg & 0x7f, CODEC_COMMAND);
+	/*
+	 * Workaround for buggy ES1988 integrated AC'97 codec. It remains silent
+	 * until the MASTER volume or mute is touched (alsactl restore does not
+	 * work).
+	 */
+	if (ac97->id == 0x45838308 && reg == AC97_MASTER) {
+		snd_m3_ac97_wait(chip);
+		snd_m3_outw(chip, val, CODEC_DATA);
+		snd_m3_outb(chip, reg & 0x7f, CODEC_COMMAND);
+	}
 }
 
 
-- 
Ondrej Zary
