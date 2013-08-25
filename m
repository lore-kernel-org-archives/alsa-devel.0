From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH v3 10/11] ALSA: usb-audio: remove altset_idx
	from snd_usb_substream
Date: Sun, 25 Aug 2013 17:45:54 +0200
Message-ID: <1377445555-5923-5-git-send-email-eldad@fogrefinery.com>
References: <1377445399-5678-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f52.google.com (mail-bk0-f52.google.com
 [209.85.214.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F616261983
 for <alsa-devel@alsa-project.org>; Sun, 25 Aug 2013 17:46:18 +0200 (CEST)
Received: by mail-bk0-f52.google.com with SMTP id e11so781726bkh.25
 for <alsa-devel@alsa-project.org>; Sun, 25 Aug 2013 08:46:17 -0700 (PDT)
In-Reply-To: <1377445399-5678-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

We only need to check the current altsetting in one place, so there's no
benefit from tracking it.
This patch replaces that one check with get_cur_altset_idx() added in
a previous patch and in the proc substream dump routine.

Thanks to Clemens Ladisch for pointing out the difference between
altset_idx and altsetting - the check is changed accordingly to match
against fmt->altsetting.

Note that the proc dump now returns the altsetting number and not the
array index.

This allows removing altset_idx from snd_usb_substream.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>

---
v2: corrected check.
---
 sound/usb/card.h | 1 -
 sound/usb/pcm.c  | 8 ++------
 sound/usb/pcm.h  | 2 ++
 sound/usb/proc.c | 4 +++-
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/usb/card.h b/sound/usb/card.h
index 4061ee1..0fd3f8b 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -117,7 +117,6 @@ struct snd_usb_substream {
 	unsigned int channels_max;	/* max channels in the all audiofmts */
 	unsigned int cur_rate;		/* current rate (for hw_params callback) */
 	unsigned int period_bytes;	/* current period bytes (for hw_params callback) */
-	unsigned int altset_idx;     /* USB data format: index of alternate setting */
 	unsigned int txfr_quirk:1;	/* allow sub-frame alignment */
 	unsigned int fmt_type;		/* USB audio format type (1-3) */
 	unsigned int pkt_offset_adj;	/* Bytes to drop from beginning of packets (for non-compliant devices) */
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index d58fbcf..5018b30 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -216,7 +216,7 @@ int snd_usb_init_pitch(struct snd_usb_audio *chip, int iface,
 	}
 }
 
-static int get_cur_altsetting(struct usb_device *dev, int ifnum)
+int get_cur_altsetting(struct usb_device *dev, int ifnum)
 {
 	struct usb_interface *iface;
 	struct usb_interface_descriptor *altsd;
@@ -538,12 +538,11 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 				dev->devnum, fmt->iface, fmt->altsetting, err);
 			return -EIO;
 		}
-		subs->altset_idx = 0;
 	}
 
 	/* set interface */
 	if (subs->interface != fmt->iface ||
-	    subs->altset_idx != fmt->altset_idx) {
+	    get_cur_altsetting(subs->dev, subs->interface) != fmt->altsetting) {
 		err = snd_usb_set_interface(subs, fmt->iface, fmt->altsetting);
 		if (err < 0) {
 			snd_printk(KERN_ERR "%d:%d:%d: usb_set_interface failed (%d)\n",
@@ -552,7 +551,6 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 		}
 		snd_printdd(KERN_INFO "setting usb interface %d:%d\n",
 				fmt->iface, fmt->altsetting);
-		subs->altset_idx = fmt->altset_idx;
 
 		snd_usb_set_interface_quirk(dev);
 	}
@@ -784,7 +782,6 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 
 	subs->interface = fmt->iface;
-	subs->altset_idx = fmt->altset_idx;
 	subs->need_setup_ep = true;
 
 	return 0;
@@ -1268,7 +1265,6 @@ static int snd_usb_pcm_open(struct snd_pcm_substream *substream, int direction)
 	struct snd_usb_substream *subs = &as->substream[direction];
 
 	subs->interface = -1;
-	subs->altset_idx = 0;
 	runtime->hw = snd_usb_hardware;
 	runtime->private_data = subs;
 	subs->pcm_substream = substream;
diff --git a/sound/usb/pcm.h b/sound/usb/pcm.h
index df7a003..0c9cb8c 100644
--- a/sound/usb/pcm.h
+++ b/sound/usb/pcm.h
@@ -10,5 +10,7 @@ int snd_usb_init_pitch(struct snd_usb_audio *chip, int iface,
 		       struct usb_host_interface *alts,
 		       struct audioformat *fmt);
 
+int get_cur_altsetting(struct usb_device *dev, int ifnum);
+
 
 #endif /* __USBAUDIO_PCM_H */
diff --git a/sound/usb/proc.c b/sound/usb/proc.c
index 5f761ab..ab6aafe 100644
--- a/sound/usb/proc.c
+++ b/sound/usb/proc.c
@@ -27,6 +27,7 @@
 #include "card.h"
 #include "endpoint.h"
 #include "proc.h"
+#include "pcm.h"
 
 /* convert our full speed USB rate into sampling rate in Hz */
 static inline unsigned get_full_speed_hz(unsigned int usb_rate)
@@ -140,7 +141,8 @@ static void proc_dump_substream_status(struct snd_usb_substream *subs, struct sn
 	if (subs->running) {
 		snd_iprintf(buffer, "  Status: Running\n");
 		snd_iprintf(buffer, "    Interface = %d\n", subs->interface);
-		snd_iprintf(buffer, "    Altset = %d\n", subs->altset_idx);
+		snd_iprintf(buffer, "    Altset = %d\n",
+			    get_cur_altsetting(subs->dev, subs->interface));
 		proc_dump_ep_status(subs, subs->data_endpoint, subs->sync_endpoint, buffer);
 	} else {
 		snd_iprintf(buffer, "  Status: Stop\n");
-- 
1.8.1.5
