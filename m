From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: [PATCH] ALSA: usb-audio: Fix Creative VF0420 rate
Date: Tue, 14 Jan 2014 14:21:23 +0100
Message-ID: <52D539D3.1000006@ivitera.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8580740673805023995=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
 [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id BE26926170F
 for <alsa-devel@alsa-project.org>; Tue, 14 Jan 2014 14:21:33 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--===============8580740673805023995==
Content-Type: text/x-diff;
 name="0001-ALSA-usb-audio-Fix-Creative-VF0420-rate.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-ALSA-usb-audio-Fix-Creative-VF0420-rate.patch"

>From db1dcaf0f3c2459b02b29c55639a9a6943cffec9 Mon Sep 17 00:00:00 2001
From: Pavel Hofman <pavel.hofman@ivitera.com>
Date: Tue, 14 Jan 2014 13:42:57 +0100
Subject: [PATCH] ALSA: usb-audio: Fix Creative VF0420 rate

Creative Live! Cam Vista IM (VF0420) reports rate of 16kHz while working
at 8kHz. The patch adds its USB ID to the existing quirk.

Signed-off-by: Pavel Hofman <pavel.hofman@ivitera.com>
---
 sound/usb/format.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/usb/format.c b/sound/usb/format.c
index 3525231..d244fd3 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -189,8 +189,10 @@ static int parse_audio_format_rates_v1(struct snd_usb_audio *chip, struct audiof
 			     chip->usb_id == USB_ID(0x0ccd, 0x00b1)) &&
 			    fp->altsetting == 5 && fp->maxpacksize == 392)
 				rate = 96000;
-			/* Creative VF0470 Live Cam reports 16 kHz instead of 8kHz */
-			if (rate == 16000 && chip->usb_id == USB_ID(0x041e, 0x4068))
+			/* Creative VF0420/VF0470 Live Cams report 16 kHz instead of 8kHz */
+			if (rate == 16000 &&
+			    (chip->usb_id == USB_ID(0x041e, 0x4064) ||
+			     chip->usb_id == USB_ID(0x041e, 0x4068)))
 				rate = 8000;
 
 			fp->rate_table[fp->nr_rates] = rate;
-- 
1.7.1


--===============8580740673805023995==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8580740673805023995==--
