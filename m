From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/6] ALSA: usb-audio: Add keep_iface flag
Date: Wed,  2 May 2018 16:11:13 +0200
Message-ID: <20180502141116.31966-4-tiwai@suse.de>
References: <20180502141116.31966-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F91F266F4E
 for <alsa-devel@alsa-project.org>; Wed,  2 May 2018 16:11:20 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 7D046AF06
 for <alsa-devel@alsa-project.org>; Wed,  2 May 2018 14:11:19 +0000 (UTC)
In-Reply-To: <20180502141116.31966-1-tiwai@suse.de>
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

Introduce a new flag to struct snd_usb_audio for allowing the device
to skip usb_set_interface() calls at changing or closing the stream.
As of this patch, the flag is nowhere set, so it's just a place
holder.  The dynamic switching will be added in the following patch.

A background information for this change:

Dell WD15 dock with Realtek chip gives a very long pause at each time
the driver changes the altset, which eventually happens at every PCM
stream open/close and parameter change.  As the long pause happens in
each usb_set_interface() call, there is nothing we can do as long as
it's called.  The workaround is to reduce calling it as much as
possible, and this flag indicates that behavior.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/pcm.c      | 17 ++++++++++-------
 sound/usb/usbaudio.h |  3 +++
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index ae7d8a0a0a0a..dc2dfec9effd 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -509,12 +509,14 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 
 	/* close the old interface */
 	if (subs->interface >= 0 && subs->interface != fmt->iface) {
-		err = usb_set_interface(subs->dev, subs->interface, 0);
-		if (err < 0) {
-			dev_err(&dev->dev,
-				"%d:%d: return to setting 0 failed (%d)\n",
-				fmt->iface, fmt->altsetting, err);
-			return -EIO;
+		if (!subs->stream->chip->keep_iface) {
+			err = usb_set_interface(subs->dev, subs->interface, 0);
+			if (err < 0) {
+				dev_err(&dev->dev,
+					"%d:%d: return to setting 0 failed (%d)\n",
+					fmt->iface, fmt->altsetting, err);
+				return -EIO;
+			}
 		}
 		subs->interface = -1;
 		subs->altset_idx = 0;
@@ -1253,7 +1255,8 @@ static int snd_usb_pcm_close(struct snd_pcm_substream *substream, int direction)
 
 	stop_endpoints(subs, true);
 
-	if (subs->interface >= 0 &&
+	if (!as->chip->keep_iface &&
+	    subs->interface >= 0 &&
 	    !snd_usb_lock_shutdown(subs->stream->chip)) {
 		usb_set_interface(subs->dev, subs->interface, 0);
 		subs->interface = -1;
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 4d5c89a7ba2b..32f4a5425536 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -59,6 +59,9 @@ struct snd_usb_audio {
 
 	int setup;			/* from the 'device_setup' module param */
 	bool autoclock;			/* from the 'autoclock' module param */
+	bool keep_iface;		/* keep interface/altset after closing
+					 * or parameter change
+					 */
 
 	struct usb_host_interface *ctrl_intf;	/* the audio control interface */
 };
-- 
2.16.3
