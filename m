From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: usb - Avoid unnecessary sample rate
	changes on USB 2.0 clock sources
Date: Thu, 25 Apr 2013 14:32:24 +0200
Message-ID: <1366893144-5884-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 811B026511D
 for <alsa-devel@alsa-project.org>; Thu, 25 Apr 2013 14:32:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

The Scarlett 2i2 seems to take almost 500 ms to set the sample rate,
even if the clock is currently set to that value. This patch speeds
up prepare of the device, by avoiding setting the clock to something
it already is.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/usb/clock.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index b0ec364..3a2ce39 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -356,6 +356,8 @@ static int set_sample_rate_v2(struct snd_usb_audio *chip, int iface,
 		return clock;
 
 	prev_rate = get_sample_rate_v2(chip, iface, fmt->altsetting, clock);
+	if (prev_rate == rate)
+		return 0;
 
 	cs_desc = snd_usb_find_clock_source(chip->ctrl_intf, clock);
 	writeable = uac2_control_is_writeable(cs_desc->bmControls, UAC2_CS_CONTROL_SAM_FREQ - 1);
-- 
1.7.9.5
