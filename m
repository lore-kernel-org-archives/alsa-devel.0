From: Guido Aulisi <guido.aulisi@gmail.com>
Subject: ALSA: snd-usb-usx2y: remove bogus frame checks
Date: Mon, 07 Oct 2013 23:29:50 +0200
Message-ID: <1381181390.2193.11.camel@yoda.heavyware>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f54.google.com (mail-ee0-f54.google.com [74.125.83.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 72BFC265193
 for <alsa-devel@alsa-project.org>; Mon,  7 Oct 2013 23:29:53 +0200 (CEST)
Received: by mail-ee0-f54.google.com with SMTP id e53so3530612eek.41
 for <alsa-devel@alsa-project.org>; Mon, 07 Oct 2013 14:29:53 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, nicholas.bailey@glasgow.ac.uk
List-Id: alsa-devel@alsa-project.org

Hi,
I did some more testing on my US122:

I used my patch (see below) and it worked (with default nrpack=4), but I
got "should not be here with counts=42" errors, then after some time the
kernel crashed, but I couldn't copy the trace.

Then I set nrpack=1 and I got no "should not be here..." and it was more
stable, no crash. I only checked playback, not recording, nor MIDI, with
aplay I played some songs for about one hour...

I hope this can be useful. But I think there are other bugs in this
driver.

Ciao
Guido Aulisi

The patch is:

diff --git a/sound/usb/usx2y/usbusx2yaudio.c b/sound/usb/usx2y/usbusx2yaudio.c
index 63fb521..cd16fcc 100644
--- a/sound/usb/usx2y/usbusx2yaudio.c
+++ b/sound/usb/usx2y/usbusx2yaudio.c
@@ -328,7 +328,7 @@ static void i_usX2Y_urb_complete(struct urb *urb)
                usX2Y_error_urb_status(usX2Y, subs, urb);
                return;
        }
-       if (likely((urb->start_frame & 0xFFFF) == (usX2Y->wait_iso_frame & 0xFFFF)))
+       if (likely((urb->start_frame & 0x03FF) == (usX2Y->wait_iso_frame & 0x03FF)))
                subs->completed_urb = urb;
        else {
                usX2Y_error_sequence(usX2Y, subs, urb);
