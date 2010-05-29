From: Mark Hills <mark@pogo.org.uk>
Subject: [PATCH 2/4] snd-usb-caiaq: Simplify single case to an
	'if'
Date: Sat, 29 May 2010 16:53:24 +0100
Message-ID: <1275148406-24596-2-git-send-email-mark@pogo.org.uk>
References: <1275148406-24596-1-git-send-email-mark@pogo.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wes.ijneb.com (mx.ij.cx [212.13.201.15])
	by alsa0.perex.cz (Postfix) with ESMTP id A3A4E2441C
	for <alsa-devel@alsa-project.org>;
	Sat, 29 May 2010 17:53:27 +0200 (CEST)
In-Reply-To: <1275148406-24596-1-git-send-email-mark@pogo.org.uk>
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

After removing code, only one case remains. So use an 'if' instead.

Acked-by: Daniel Mack <daniel@caiaq.de>
Signed-off-by: Mark Hills <mark@pogo.org.uk>
---
 sound/usb/caiaq/control.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/usb/caiaq/control.c b/sound/usb/caiaq/control.c
index 70c3866..91c804c 100644
--- a/sound/usb/caiaq/control.c
+++ b/sound/usb/caiaq/control.c
@@ -95,11 +95,9 @@ static int control_put(struct snd_kcontrol *kcontrol,
 	int pos = kcontrol->private_value;
 	unsigned char cmd = EP1_CMD_WRITE_IO;
 
-	switch (dev->chip.usb_id) {
-	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_TRAKTORKONTROLX1):
+	if (dev->chip.usb_id ==
+		USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_TRAKTORKONTROLX1))
 		cmd = EP1_CMD_DIMM_LEDS;
-		break;
-	}
 
 	if (pos & CNT_INTVAL) {
 		dev->control_state[pos & ~CNT_INTVAL]
-- 
1.7.1
