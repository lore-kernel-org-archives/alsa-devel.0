From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ALSA: snd-usb-usx2y: fix start frame mask
Date: Wed,  2 Oct 2013 15:39:57 +0200
Message-ID: <1380721197-4889-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C470265139
 for <alsa-devel@alsa-project.org>; Wed,  2 Oct 2013 15:40:21 +0200 (CEST)
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
Cc: tiwai@suse.de, guido.aulisi@gmail.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

This patch is based on a change proposed by Guido Aulisi in a
discussion on LAU which can be followed here:

  http://linuxaudio.org/mailarchive/lau/2013/5/20/200177

Cc: fzu@wemgehoertderstaat.de
Original-code-by: Guido Aulisi <guido.aulisi@gmail.com>
Tested-by: Dr Nicholas J Bailey <nicholas.bailey@glasgow.ac.uk>
Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/usb/usx2y/usbusx2yaudio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/usx2y/usbusx2yaudio.c b/sound/usb/usx2y/usbusx2yaudio.c
index 63fb521..cd16fcc 100644
--- a/sound/usb/usx2y/usbusx2yaudio.c
+++ b/sound/usb/usx2y/usbusx2yaudio.c
@@ -328,7 +328,7 @@ static void i_usX2Y_urb_complete(struct urb *urb)
 		usX2Y_error_urb_status(usX2Y, subs, urb);
 		return;
 	}
-	if (likely((urb->start_frame & 0xFFFF) == (usX2Y->wait_iso_frame & 0xFFFF)))
+	if (likely((urb->start_frame & 0x03FF) == (usX2Y->wait_iso_frame & 0x03FF)))
 		subs->completed_urb = urb;
 	else {
 		usX2Y_error_sequence(usX2Y, subs, urb);
-- 
1.8.3.1
