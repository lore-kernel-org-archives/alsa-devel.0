From: Mark Hills <mark@pogo.org.uk>
Subject: [PATCH 3/5] snd-usb-caiaq: Do not expose hardware
	input mode 0 of A4DJ
Date: Wed,  4 Feb 2009 22:34:32 +0000
Message-ID: <1233786874-16373-3-git-send-email-mark@pogo.org.uk>
References: <1233786874-16373-1-git-send-email-mark@pogo.org.uk>
	<1233786874-16373-2-git-send-email-mark@pogo.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metheny.ijneb.com (mailout.ijneb.com [212.13.201.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 6531D24402
	for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2009 23:34:35 +0100 (CET)
In-Reply-To: <1233786874-16373-2-git-send-email-mark@pogo.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

In the context of the Audio 4 DJ (when compared to Audio 8 DJ), hardware
input mode 0 is not used. Expose modes 1 (line) and 2 (phono) to the user
as modes 0 and 1 respectively.

Signed-off-by: Mark Hills <mark@pogo.org.uk>
Acked-by: Daniel Mack <daniel@caiaq.de>
---
 usb/caiaq/caiaq-control.c |   32 +++++++++++++++++++++++++++++---
 1 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/usb/caiaq/caiaq-control.c b/usb/caiaq/caiaq-control.c
index 1f9531d..136ef34 100644
--- a/usb/caiaq/caiaq-control.c
+++ b/usb/caiaq/caiaq-control.c
@@ -44,16 +44,24 @@ static int control_info(struct snd_kcontrol *kcontrol,
 	uinfo->count = 1;
 	pos &= ~CNT_INTVAL;
 
-	if (((id == USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AUDIO8DJ)) ||
-	     (id == USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AUDIO4DJ)))
+	if (id == USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AUDIO8DJ)
 		&& (pos == 0)) {
-		/* current input mode of A8DJ and A4DJ */
+		/* current input mode of A8DJ */
 		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 		uinfo->value.integer.min = 0;
 		uinfo->value.integer.max = 2;
 		return 0;
 	}
 
+	if (id == USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AUDIO4DJ)
+		&& (pos == 0)) {
+		/* current input mode of A4DJ */
+		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+		uinfo->value.integer.min = 0;
+		uinfo->value.integer.max = 1;
+		return 0;
+	}
+
 	if (is_intval) {
 		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 		uinfo->value.integer.min = 0;
@@ -74,6 +82,14 @@ static int control_get(struct snd_kcontrol *kcontrol,
 	struct snd_usb_caiaqdev *dev = caiaqdev(chip->card);
 	int pos = kcontrol->private_value;
 
+	if (dev->chip.usb_id ==
+		USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AUDIO4DJ)) {
+		/* A4DJ has only one control */
+		/* do not expose hardware input mode 0 */
+		ucontrol->value.integer.value[0] = dev->control_state[0] - 1;
+		return 0;
+	}
+
 	if (pos & CNT_INTVAL)
 		ucontrol->value.integer.value[0]
 			= dev->control_state[pos & ~CNT_INTVAL];
@@ -91,6 +107,16 @@ static int control_put(struct snd_kcontrol *kcontrol,
 	struct snd_usb_caiaqdev *dev = caiaqdev(chip->card);
 	int pos = kcontrol->private_value;
 
+	if (dev->chip.usb_id ==
+		USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AUDIO4DJ)) {
+		/* A4DJ has only one control */
+		/* do not expose hardware input mode 0 */
+		dev->control_state[0] = ucontrol->value.integer.value[0] + 1;
+		snd_usb_caiaq_send_command(dev, EP1_CMD_WRITE_IO,
+				dev->control_state, sizeof(dev->control_state));
+		return 1;
+	}
+
 	if (pos & CNT_INTVAL) {
 		dev->control_state[pos & ~CNT_INTVAL]
 			= ucontrol->value.integer.value[0];
-- 
1.6.1.2
