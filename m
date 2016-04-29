From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: usb-audio: Limit retrying sample rate
	reads
Date: Fri, 29 Apr 2016 11:54:37 +0200
Message-ID: <1461923677-26662-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 60B6626518B
 for <alsa-devel@alsa-project.org>; Fri, 29 Apr 2016 11:54:38 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 20688AD6E
 for <alsa-devel@alsa-project.org>; Fri, 29 Apr 2016 09:54:38 +0000 (UTC)
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

There are many USB audio devices with buggy firmware that don't react
with the sample rate reading properly.  This often results in the
flood of error messages and slowing down the operation.

The sample rate read back is basically only for confirming the sample
rate setup, and it's not critically important.  As a compromise, in
this patch, we stop the sample rate read back once when the device
gives errors more than tolerance (twice, as of now).  This should
improve most of error cases while we still can catch the firmware
bugginess.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/clock.c    | 4 ++++
 sound/usb/usbaudio.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 7ccbcaf6a147..26dd5f20f149 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -309,6 +309,9 @@ static int set_sample_rate_v1(struct snd_usb_audio *chip, int iface,
 	 * support reading */
 	if (snd_usb_get_sample_rate_quirk(chip))
 		return 0;
+	/* the firmware is likely buggy, don't repeat to fail too many times */
+	if (chip->sample_rate_read_error > 2)
+		return 0;
 
 	if ((err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC_GET_CUR,
 				   USB_TYPE_CLASS | USB_RECIP_ENDPOINT | USB_DIR_IN,
@@ -316,6 +319,7 @@ static int set_sample_rate_v1(struct snd_usb_audio *chip, int iface,
 				   data, sizeof(data))) < 0) {
 		dev_err(&dev->dev, "%d:%d: cannot get freq at ep %#x\n",
 			iface, fmt->altsetting, ep);
+		chip->sample_rate_read_error++;
 		return 0; /* some devices don't support reading */
 	}
 
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index a161c7c1b126..89b6853030de 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -50,6 +50,7 @@ struct snd_usb_audio {
 	
 	int num_interfaces;
 	int num_suspended_intf;
+	int sample_rate_read_error;
 
 	struct list_head pcm_list;	/* list of pcm streams */
 	struct list_head ep_list;	/* list of audio-related endpoints */
-- 
2.8.1
