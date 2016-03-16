From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/3] ALSA: usb-audio: Minor code cleanup in
	create_fixed_stream_quirk()
Date: Wed, 16 Mar 2016 12:50:15 +0100
Message-ID: <1458129016-27188-3-git-send-email-tiwai@suse.de>
References: <1458129016-27188-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D16E265E3F
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2016 12:50:19 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 08CB6ACDF
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2016 11:50:17 +0000 (UTC)
In-Reply-To: <1458129016-27188-1-git-send-email-tiwai@suse.de>
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

Just a minor code cleanup: unify the error paths.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/quirks.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 529c35cceaa6..a889d433cbdf 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -167,23 +167,18 @@ static int create_fixed_stream_quirk(struct snd_usb_audio *chip,
 	stream = (fp->endpoint & USB_DIR_IN)
 		? SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
 	err = snd_usb_add_audio_stream(chip, stream, fp);
-	if (err < 0) {
-		kfree(fp);
-		kfree(rate_table);
-		return err;
-	}
+	if (err < 0)
+		goto error;
 	if (fp->iface != get_iface_desc(&iface->altsetting[0])->bInterfaceNumber ||
 	    fp->altset_idx >= iface->num_altsetting) {
-		kfree(fp);
-		kfree(rate_table);
-		return -EINVAL;
+		err = -EINVAL;
+		goto error;
 	}
 	alts = &iface->altsetting[fp->altset_idx];
 	altsd = get_iface_desc(alts);
 	if (altsd->bNumEndpoints < 1) {
-		kfree(fp);
-		kfree(rate_table);
-		return -EINVAL;
+		err = -EINVAL;
+		goto error;
 	}
 
 	fp->protocol = altsd->bInterfaceProtocol;
@@ -196,6 +191,11 @@ static int create_fixed_stream_quirk(struct snd_usb_audio *chip,
 	snd_usb_init_pitch(chip, fp->iface, alts, fp);
 	snd_usb_init_sample_rate(chip, fp->iface, alts, fp, fp->rate_max);
 	return 0;
+
+ error:
+	kfree(fp);
+	kfree(rate_table);
+	return err;
 }
 
 static int create_auto_pcm_quirk(struct snd_usb_audio *chip,
-- 
2.7.3
