From: Mark Hills <mark@pogo.org.uk>
Subject: [PATCH 1/5] snd-usb-caiaq: Send the correct command
	when setting controls
Date: Wed,  4 Feb 2009 22:34:30 +0000
Message-ID: <1233786874-16373-1-git-send-email-mark@pogo.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metheny.ijneb.com (mailout.ijneb.com [212.13.201.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 687F124406
	for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2009 23:34:35 +0100 (CET)
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

Fixes a bug where an incorrect command was sent which had no effect on the
device.

Signed-off-by: Mark Hills <mark@pogo.org.uk>
Acked-by: Daniel Mack <daniel@caiaq.de>
---
 usb/caiaq/caiaq-control.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/usb/caiaq/caiaq-control.c b/usb/caiaq/caiaq-control.c
index 6ac5489..1f9531d 100644
--- a/usb/caiaq/caiaq-control.c
+++ b/usb/caiaq/caiaq-control.c
@@ -94,7 +94,7 @@ static int control_put(struct snd_kcontrol *kcontrol,
 	if (pos & CNT_INTVAL) {
 		dev->control_state[pos & ~CNT_INTVAL]
 			= ucontrol->value.integer.value[0];
-		snd_usb_caiaq_send_command(dev, EP1_CMD_DIMM_LEDS,
+		snd_usb_caiaq_send_command(dev, EP1_CMD_WRITE_IO,
 				dev->control_state, sizeof(dev->control_state));
 	} else {
 		if (ucontrol->value.integer.value[0])
-- 
1.6.1.2
