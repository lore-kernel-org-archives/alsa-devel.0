From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH 1/3] ALSA: usb-audio: correct M-Audio C400
	clock source quirk
Date: Sun, 13 Jan 2013 23:02:02 +0100
Message-ID: <1358114524-5152-2-git-send-email-eldad@fogrefinery.com>
References: <1358114524-5152-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f52.google.com (mail-bk0-f52.google.com
 [209.85.214.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 43624265113
 for <alsa-devel@alsa-project.org>; Sun, 13 Jan 2013 23:02:18 +0100 (CET)
Received: by mail-bk0-f52.google.com with SMTP id w5so1671540bku.11
 for <alsa-devel@alsa-project.org>; Sun, 13 Jan 2013 14:02:18 -0800 (PST)
In-Reply-To: <1358114524-5152-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Taking another look at the C400 descriptors, I see now that there is
a clock selector (0x80) for this device.
Right now, the clock source points to the internal clock (0x81), which
is also valid. When the external clock source (0x82) is selected in the
mixer, and the rates mismatch (if it's free-running it is fixed to
48KHz), xruns will occur.

Set the clock ID to the clock selector unit (0x81), which then
allows the validation code to function correctly.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/quirks-table.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 78e845e..64d25a7 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2289,7 +2289,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.rate_table = (unsigned int[]) {
 							44100, 48000, 88200, 96000
 					},
-					.clock = 0x81,
+					.clock = 0x80,
 				}
 			},
 			/* Capture */
@@ -2315,7 +2315,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.rate_table = (unsigned int[]) {
 						44100, 48000, 88200, 96000
 					},
-					.clock = 0x81,
+					.clock = 0x80,
 				}
 			},
 			/* MIDI */
-- 
1.7.12.4
