From: Torstein Hegge <hegge@resisty.net>
Subject: [PATCH] ALSA: usb: Work around CM6631 sample rate
	change bug
Date: Sat, 2 Mar 2013 14:04:03 +0100
Message-ID: <20130302130403.GD4452@pvv.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from microbel.pvv.ntnu.no (microbel.pvv.ntnu.no [129.241.210.179])
 by alsa0.perex.cz (Postfix) with ESMTP id E5057261636
 for <alsa-devel@alsa-project.org>; Sat,  2 Mar 2013 14:04:06 +0100 (CET)
Received: from horisont.pvv.ntnu.no ([129.241.210.175] ident=Debian-exim)
 by microbel.pvv.ntnu.no with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.72) (envelope-from <torstehe@pvv.ntnu.no>)
 id 1UBm6d-0003JW-Kq
 for alsa-devel@alsa-project.org; Sat, 02 Mar 2013 14:04:05 +0100
Received: from torstehe by horisont.pvv.ntnu.no with local (Exim 4.72)
 (envelope-from <torstehe@pvv.ntnu.no>) id 1UBm6d-0003Qx-CS
 for alsa-devel@alsa-project.org; Sat, 02 Mar 2013 14:04:03 +0100
Content-Disposition: inline
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
List-Id: alsa-devel@alsa-project.org

The C-Media CM6631 USB-to-S/PDIF receiver doesn't respond to changes in
sampling frequency while the interface is active.

Reset the interface after setting the sampling frequency, to ensure that the
sample rate set by snd_usb_init_sample_rate() is used. Otherwise, the device
will try to use the sample rate of the previous file, causing distorted sound
on sample rate changes.

Signed-off-by: Torstein Hegge <hegge@resisty.net>
---
 sound/usb/pcm.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index d82e378..01978a6 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -710,6 +710,16 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
 		subs->need_setup_ep = false;
 	}
 
+	/* Some devices doesn't respond to sample rate changes while the
+	 * interface is active. */
+	switch (subs->stream->chip->usb_id) {
+	case USB_ID(0x0d8c, 0x0304): /* C-Media - Schiit USB Interface */
+	case USB_ID(0x0d8c, 0x0309): /* C-Media CM6631 */
+		usb_set_interface(subs->dev, subs->cur_audiofmt->iface,
+					subs->cur_audiofmt->altset_idx);
+		break;
+	}
+
 	/* some unit conversions in runtime */
 	subs->data_endpoint->maxframesize =
 		bytes_to_frames(runtime, subs->data_endpoint->maxpacksize);
-- 
1.7.10.4
