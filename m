From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH] snd-maestro3: Enable docking support for Dell
	Latitude C810
Date: Sun,  1 Nov 2015 14:32:03 +0100
Message-ID: <1446384723-29765-1-git-send-email-linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gsystem.sk (ns.gsystem.sk [62.176.172.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DEFC260435
 for <alsa-devel@alsa-project.org>; Sun,  1 Nov 2015 14:32:15 +0100 (CET)
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

Enable I2S docking for Dell Latitude C810.
This allows the audio output on C/Port II to work (and probably also
the audio inputs on C/Dock II).

The volume can't be adjusted - none of the mixer controls currently
supported affects the I2S output (they belong to the STAC9721/23 AC'97
codec responsible for the laptop internal connectors & speakers).

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
---
 sound/pci/maestro3.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/sound/pci/maestro3.c b/sound/pci/maestro3.c
index 72e89ce..965d5c6 100644
--- a/sound/pci/maestro3.c
+++ b/sound/pci/maestro3.c
@@ -1932,12 +1932,19 @@ snd_m3_ac97_write(struct snd_ac97 *ac97, unsigned short reg, unsigned short val)
 }
 
 
-static void snd_m3_remote_codec_config(int io, int isremote)
+static void snd_m3_remote_codec_config(struct snd_m3 *chip, int isremote)
 {
+	int io = chip->iobase;
+	u16 tmp;
+
 	isremote = isremote ? 1 : 0;
 
-	outw((inw(io + RING_BUS_CTRL_B) & ~SECOND_CODEC_ID_MASK) | isremote,
-	     io + RING_BUS_CTRL_B);
+	tmp = inw(io + RING_BUS_CTRL_B) & ~SECOND_CODEC_ID_MASK;
+	/* enable dock on Dell Latitude C810 */
+	if (chip->pci->subsystem_vendor == 0x1028 &&
+	    chip->pci->subsystem_device == 0x00e5)
+		tmp |= M3I_DOCK_ENABLE;
+	outw(tmp | isremote, io + RING_BUS_CTRL_B);
 	outw((inw(io + SDO_OUT_DEST_CTRL) & ~COMMAND_ADDR_OUT) | isremote,
 	     io + SDO_OUT_DEST_CTRL);
 	outw((inw(io + SDO_IN_DEST_CTRL) & ~STATUS_ADDR_IN) | isremote,
@@ -1989,7 +1996,7 @@ static void snd_m3_ac97_reset(struct snd_m3 *chip)
 		if (!chip->irda_workaround)
 			dir |= 0x10; /* assuming pci bus master? */
 
-		snd_m3_remote_codec_config(io, 0);
+		snd_m3_remote_codec_config(chip, 0);
 
 		outw(IO_SRAM_ENABLE, io + RING_BUS_CTRL_A);
 		udelay(20);
-- 
Ondrej Zary
