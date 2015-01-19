From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 16/17] ALSA: line6: Make
	line6_send_raw_message() static
Date: Mon, 19 Jan 2015 16:54:50 +0100
Message-ID: <1421682891-11594-17-git-send-email-tiwai@suse.de>
References: <1421682891-11594-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B64E261489
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 16:55:03 +0100 (CET)
In-Reply-To: <1421682891-11594-1-git-send-email-tiwai@suse.de>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Chris Rorvick <chris@rorvick.com>
List-Id: alsa-devel@alsa-project.org

It's used only locally.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/driver.c | 4 ++--
 sound/usb/line6/driver.h | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 1193d16396a0..a2f72cc2bf96 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -88,8 +88,8 @@ static void line6_stop_listen(struct usb_line6 *line6)
 /*
 	Send raw message in pieces of wMaxPacketSize bytes.
 */
-int line6_send_raw_message(struct usb_line6 *line6, const char *buffer,
-			   int size)
+static int line6_send_raw_message(struct usb_line6 *line6, const char *buffer,
+				  int size)
 {
 	int i, done = 0;
 
diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index f484aa09840b..8fd65f2e1f06 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -169,8 +169,6 @@ extern int line6_read_data(struct usb_line6 *line6, int address, void *data,
 extern int line6_read_serial_number(struct usb_line6 *line6,
 				    int *serial_number);
 extern int line6_send_program(struct usb_line6 *line6, u8 value);
-extern int line6_send_raw_message(struct usb_line6 *line6, const char *buffer,
-				  int size);
 extern int line6_send_raw_message_async(struct usb_line6 *line6,
 					const char *buffer, int size);
 extern int line6_send_sysex_message(struct usb_line6 *line6,
-- 
2.2.1
