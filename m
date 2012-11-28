From: Eldad Zack <eldad@fogrefinery.com>
Subject: [FT C400, PATCH RFC,
	v4 02/10] usb-audio: correct sync ep init
Date: Wed, 28 Nov 2012 23:55:33 +0100
Message-ID: <1354143341-1623-3-git-send-email-eldad@fogrefinery.com>
References: <1354143341-1623-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F859264F08
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 23:55:52 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id ik5so5643893bkc.38
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 14:55:52 -0800 (PST)
In-Reply-To: <1354143341-1623-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Daniel Mack <zonque@gmail.com>, Felix Homann <linuxaudio@showlabor.de>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
Cc: Grant Diffey <gdiffey@gmail.com>, George Willian Condomitti <georgecondomitti@gmail.com>, Chris Cavey <chris-alsa@rauros.net>, Eldad Zack <eldad@fogrefinery.com>, Jeffrey Barish <jeff_barish@earthlink.net>
List-Id: alsa-devel@alsa-project.org

Commit 947d299686aa9cc8aecf749d54e8475c6e498956
"ALSA: snd-usb: properly initialize the sync endpoint" introduced a
regression for devices that has a sync endpoint with a channel
number different than the data endpoint channel.
Due to a different channel and period bytes count, attempting to
initialize the sync endpoint will fail. With xhci it yields:

cannot submit urb 0, error -90: internal error

With this patch, if a sync endpoint has multiple audioformats, an
audioformat with a matching number of channels is preferred. Otherwise,
an audioformat will be picked randomly (i.e., first audioformat with a
non-zero channel count) and the period bytes count is adjusted
accordingly.

Cc: Jeffrey Barish <jeff_barish@earthlink.net>
Cc: Daniel Mack <zonque@gmail.com>
Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/pcm.c |   79 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 72 insertions(+), 7 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index ff8cbbf..2158943 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -438,6 +438,76 @@ add_sync_ep:
 }
 
 /*
+ * Configure the sync ep using the rate and pcm format of the data ep.
+ */
+static int configure_sync_endpoint(struct snd_usb_substream *subs)
+{
+	int ret;
+	struct list_head *p;
+	struct audioformat *sync_fp;
+	int sync_channels = 0;
+	int sync_period_bytes = subs->period_bytes;
+	int direction = subs->direction ^ 1;
+	struct snd_usb_substream *sync_subs =
+		&subs->stream->substream[direction];
+
+	if (sync_subs->ep_num != subs->sync_endpoint->ep_num) {
+		snd_printk(KERN_ERR "%s: cannot find the sync ep (direction %d, found %x, wanted %x).\n",
+			__func__, direction,
+				subs->stream->substream[direction].ep_num,
+				subs->sync_endpoint->ep_num);
+		return -EINVAL;
+	}
+
+	/*
+	 * Try to find a format with a number of channels matching
+	 * the data substream. If no such format was found, pick one
+	 * with non zero channel number at random.
+	 */
+	list_for_each(p, &sync_subs->fmt_list) {
+		struct audioformat *fp;
+		fp = list_entry(p, struct audioformat, list);
+
+		if (sync_channels == 0) {
+			sync_fp = fp;
+			sync_channels = fp->channels;
+		} else {
+			if (fp->channels == subs->channels) {
+				sync_channels = fp->channels;
+				sync_fp = fp;
+			}
+		}
+	}
+
+	if (sync_channels < 1) {
+		snd_printk(KERN_ERR "%s: no valid audioformat for sync ep %x found\n",
+			__func__, sync_subs->ep_num);
+		return -EINVAL;
+	}
+
+	/*
+	 * Recalculated the period bytes if channel number differ between
+	 * data and sync ep.
+	 */
+	if (sync_channels != subs->channels) {
+		sync_period_bytes = (subs->period_bytes / subs->channels) *
+			sync_channels;
+		snd_printdd(KERN_INFO "%s: sync ep period bytes recalc %d -> %d\n",
+			__func__, subs->period_bytes, sync_period_bytes);
+	}
+
+	ret = snd_usb_endpoint_set_params(subs->sync_endpoint,
+					  subs->pcm_format,
+					  sync_channels,
+					  sync_period_bytes,
+					  subs->cur_rate,
+					  sync_fp,
+					  NULL);
+
+	return ret;
+}
+
+/*
  * configure endpoint params
  *
  * called  during initial setup and upon resume
@@ -459,13 +529,8 @@ static int configure_endpoint(struct snd_usb_substream *subs)
 		return ret;
 
 	if (subs->sync_endpoint)
-		ret = snd_usb_endpoint_set_params(subs->sync_endpoint,
-						  subs->pcm_format,
-						  subs->channels,
-						  subs->period_bytes,
-						  subs->cur_rate,
-						  subs->cur_audiofmt,
-						  NULL);
+		ret = configure_sync_endpoint(subs);
+
 	return ret;
 }
 
-- 
1.7.8.6
