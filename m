From: Mark Hills <mark@pogo.org.uk>
Subject: [PATCH 1/4] snd-usb-caiaq: Restore 'Control vinyl'
	input mode on A4DJ
Date: Sat, 29 May 2010 16:53:23 +0100
Message-ID: <1275148406-24596-1-git-send-email-mark@pogo.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wes.ijneb.com (mx.ij.cx [212.13.201.15])
	by alsa0.perex.cz (Postfix) with ESMTP id C6601103809
	for <alsa-devel@alsa-project.org>;
	Sat, 29 May 2010 17:53:27 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This feature was undocumented on early A4DJ units. It is indicated
by lighting both the 'line' and 'phono' lamps at the same time.
Newer units document this and the newer Windows drivers enable this
for all units, so restore the functionality.

This patch simplifies the code and changes the mode mapping to match
the A8DJ, favouring simpler code and consistency over keeping the
existing mapping.

Both 'Control vinyl' and 'Phono' input modes enable the hardware
preamp. The difference is the input impedance.

This reverts commit 9a9527e.

Acked-by: Daniel Mack <daniel@caiaq.de>
Signed-off-by: Mark Hills <mark@pogo.org.uk>
---
 sound/usb/caiaq/control.c |   30 ++----------------------------
 1 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/sound/usb/caiaq/control.c b/sound/usb/caiaq/control.c
index 36ed703..70c3866 100644
--- a/sound/usb/caiaq/control.c
+++ b/sound/usb/caiaq/control.c
@@ -42,21 +42,12 @@ static int control_info(struct snd_kcontrol *kcontrol,
 
 	switch (dev->chip.usb_id) {
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AUDIO8DJ):
-		if (pos == 0) {
-			/* current input mode of A8DJ */
-			uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-			uinfo->value.integer.min = 0;
-			uinfo->value.integer.max = 2;
-			return 0;
-		}
-		break;
-
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AUDIO4DJ):
 		if (pos == 0) {
-			/* current input mode of A4DJ */
+			/* current input mode of A8DJ and A4DJ */
 			uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 			uinfo->value.integer.min = 0;
-			uinfo->value.integer.max = 1;
+			uinfo->value.integer.max = 2;
 			return 0;
 		}
 		break;
@@ -86,14 +77,6 @@ static int control_get(struct snd_kcontrol *kcontrol,
 	struct snd_usb_caiaqdev *dev = caiaqdev(chip->card);
 	int pos = kcontrol->private_value;
 
-	if (dev->chip.usb_id ==
-		USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AUDIO4DJ)) {
-		/* A4DJ has only one control */
-		/* do not expose hardware input mode 0 */
-		ucontrol->value.integer.value[0] = dev->control_state[0] - 1;
-		return 0;
-	}
-
 	if (pos & CNT_INTVAL)
 		ucontrol->value.integer.value[0]
 			= dev->control_state[pos & ~CNT_INTVAL];
@@ -113,15 +96,6 @@ static int control_put(struct snd_kcontrol *kcontrol,
 	unsigned char cmd = EP1_CMD_WRITE_IO;
 
 	switch (dev->chip.usb_id) {
-	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AUDIO4DJ): {
-		/* A4DJ has only one control */
-		/* do not expose hardware input mode 0 */
-		dev->control_state[0] = ucontrol->value.integer.value[0] + 1;
-		snd_usb_caiaq_send_command(dev, EP1_CMD_WRITE_IO,
-				dev->control_state, sizeof(dev->control_state));
-		return 1;
-	}
-
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_TRAKTORKONTROLX1):
 		cmd = EP1_CMD_DIMM_LEDS;
 		break;
-- 
1.7.1
