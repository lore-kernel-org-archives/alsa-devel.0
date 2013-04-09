From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ALSA: snd-usb: Playback Design: use
	usb_set_inferface quirk from more locations
Date: Wed, 10 Apr 2013 00:56:03 +0800
Message-ID: <1365526563-19149-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EE0C265E50
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2013 18:56:12 +0200 (CEST)
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
Cc: tiwai@suse.de, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

It turns out the devices from Playback Design need the delay quirk
after usb_set_interface from clocks.c as well. Make it a proper
quirks function and factor out the code to quirks.c.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/usb/clock.c  |    3 +++
 sound/usb/pcm.c    |    7 +------
 sound/usb/quirks.c |   10 ++++++++++
 sound/usb/quirks.h |    1 +
 4 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index ae35e7d..b0ec364 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -32,6 +32,7 @@
 #include "card.h"
 #include "helper.h"
 #include "clock.h"
+#include "quirks.h"
 
 static struct uac_clock_source_descriptor *
 	snd_usb_find_clock_source(struct usb_host_interface *ctrl_iface,
@@ -392,7 +393,9 @@ static int set_sample_rate_v2(struct snd_usb_audio *chip, int iface,
 	 * interface is active. */
 	if (rate != prev_rate) {
 		usb_set_interface(dev, iface, 0);
+		snd_usb_set_interface_quirk(dev);
 		usb_set_interface(dev, iface, fmt->altsetting);
+		snd_usb_set_interface_quirk(dev);
 	}
 
 	return 0;
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 754cb5b..815a37d 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -349,12 +349,7 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 		subs->interface = fmt->iface;
 		subs->altset_idx = fmt->altset_idx;
 
-		/*
-		 * "Playback Design" products need a 50ms delay after setting the
-		 * USB interface.
-		 */
-		if (le16_to_cpu(dev->descriptor.idVendor) == 0x23ba)
-			mdelay(50);
+		snd_usb_set_interface_quirk(dev);
 	}
 
 	subs->data_endpoint = snd_usb_add_endpoint(subs->stream->chip,
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 7882a82..551ae1a 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -892,6 +892,16 @@ void snd_usb_endpoint_start_quirk(struct snd_usb_endpoint *ep)
 		ep->skip_packets = 16;
 }
 
+void snd_usb_set_interface_quirk(struct usb_device *dev)
+{
+	/*
+	 * "Playback Design" products need a 50ms delay after setting the
+	 * USB interface.
+	 */
+	if (le16_to_cpu(dev->descriptor.idVendor) == 0x23ba)
+		mdelay(50);
+}
+
 void snd_usb_ctl_msg_quirk(struct usb_device *dev, unsigned int pipe,
 			   __u8 request, __u8 requesttype, __u16 value,
 			   __u16 index, void *data, __u16 size)
diff --git a/sound/usb/quirks.h b/sound/usb/quirks.h
index f10d00e..665e972 100644
--- a/sound/usb/quirks.h
+++ b/sound/usb/quirks.h
@@ -26,6 +26,7 @@ int snd_usb_is_big_endian_format(struct snd_usb_audio *chip,
 
 void snd_usb_endpoint_start_quirk(struct snd_usb_endpoint *ep);
 
+void snd_usb_set_interface_quirk(struct usb_device *dev);
 void snd_usb_ctl_msg_quirk(struct usb_device *dev, unsigned int pipe,
 			   __u8 request, __u8 requesttype, __u16 value,
 			   __u16 index, void *data, __u16 size);
-- 
1.7.10.4
