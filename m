From: Adam Goode <agoode@google.com>
Subject: [PATCH - usb-audio 1/1] ALSA: usb-audio: Allow
 changing from a bad sample rate
Date: Tue, 10 Jul 2018 16:27:43 -0400
Message-ID: <20180710202743.69639-1-agoode@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f202.google.com (mail-qt0-f202.google.com
 [209.85.216.202])
 by alsa0.perex.cz (Postfix) with ESMTP id 23EC9267700
 for <alsa-devel@alsa-project.org>; Tue, 10 Jul 2018 22:27:51 +0200 (CEST)
Received: by mail-qt0-f202.google.com with SMTP id b8-v6so22232567qto.16
 for <alsa-devel@alsa-project.org>; Tue, 10 Jul 2018 13:27:51 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adam Goode <agoode@google.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

If the audio device is externally clocked and set to a rate that does
not match the external clock, the clock will never be valid and we cannot
set the rate successfully. To fix this, allow a rate change even if
the clock is initially invalid, and validate again after the rate is
changed.

This fixes problems with MOTU UltraLite AVB hardware over USB.

Signed-off-by: Adam Goode <agoode@google.com>

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index c79749613fa6..9e9019464f91 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -513,14 +513,26 @@ static int set_sample_rate_v2v3(struct snd_usb_audio *chip, int iface,
 	bool writeable;
 	u32 bmControls;
 
+	/* First, try to find a valid clock. This may trigger
+	 * automatic clock selection if the current clock is not
+	 * valid. */
 	clock = snd_usb_clock_find_source(chip, fmt->protocol,
 					  fmt->clock, true);
-	if (clock < 0)
-		return clock;
+	if (clock < 0) {
+		/* We did not find a valid clock, but that might be
+		 * because the current sample rate does not match an
+		 * external clock source. Try again without validation
+		 * and we will do another validation after setting the
+		 * rate. */
+		clock = snd_usb_clock_find_source(chip, fmt->protocol,
+						  fmt->clock, false);
+		if (clock < 0)
+			return clock;
+	}
 
 	prev_rate = get_sample_rate_v2v3(chip, iface, fmt->altsetting, clock);
 	if (prev_rate == rate)
-		return 0;
+		return uac_clock_source_is_valid(chip, fmt->protocol, clock) ? 0 : -ENXIO;
 
 	if (fmt->protocol == UAC_VERSION_3) {
 		struct uac3_clock_source_descriptor *cs_desc;
@@ -577,7 +589,8 @@ static int set_sample_rate_v2v3(struct snd_usb_audio *chip, int iface,
 		snd_usb_set_interface_quirk(dev);
 	}
 
-	return 0;
+	/* validate clock after rate change */
+	return uac_clock_source_is_valid(chip, fmt->protocol, clock) ? 0 : -ENXIO;
 }
 
 int snd_usb_init_sample_rate(struct snd_usb_audio *chip, int iface,
-- 
2.18.0.203.gfac676dfb9-goog
