From: Mark Hills <mark@xwax.org>
Subject: [PATCH 2/2] snd-usb-audio: Trust fields given in the
	quirk
Date: Sat, 16 Mar 2013 13:22:58 +0000
Message-ID: <1363440178-24925-2-git-send-email-mark@xwax.org>
References: <1363440178-24925-1-git-send-email-mark@xwax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wes.ijneb.com (mx.ij.cx [212.13.201.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E44E26510B
 for <alsa-devel@alsa-project.org>; Sat, 16 Mar 2013 14:23:02 +0100 (CET)
In-Reply-To: <1363440178-24925-1-git-send-email-mark@xwax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Chris J Arges <christopherarges@gmail.com>, Damien Zammit <damien@zamaudio.com>
List-Id: alsa-devel@alsa-project.org

The maxpacksize field is given in some quirks, but it gets ignored (in
favour of wMaxPacketSize from the first endpoint.) This patch favours
the one in the quirk.

Digidesign Mbox and Mbox 2 are the only affected quirks and the devices
are assumed to be working without this patch. So for safety against the
values in the quirk being incorrect, remove them.

The datainterval is also ignored but there are not currently any quirks
which choose to override this.

Cc: Damien Zammit <damien@zamaudio.com>
Cc: Chris J Arges <christopherarges@gmail.com>
---
 sound/usb/quirks-table.h | 3 ---
 sound/usb/quirks.c       | 6 ++++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 1c8db85..3614e9b 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2965,7 +2965,6 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
 					.endpoint = 0x02,
 					.ep_attr = 0x01,
-					.maxpacksize = 0x130,
 					.rates = SNDRV_PCM_RATE_44100 |
 						 SNDRV_PCM_RATE_48000,
 					.rate_min = 44100,
@@ -3013,7 +3012,6 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.attributes = 0x00,
 					.endpoint = 0x03,
 					.ep_attr = USB_ENDPOINT_SYNC_ASYNC,
-					.maxpacksize = 0x128,
 					.rates = SNDRV_PCM_RATE_48000,
 					.rate_min = 48000,
 					.rate_max = 48000,
@@ -3039,7 +3037,6 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
 					.endpoint = 0x85,
 					.ep_attr = USB_ENDPOINT_SYNC_SYNC,
-					.maxpacksize = 0x128,
 					.rates = SNDRV_PCM_RATE_48000,
 					.rate_min = 48000,
 					.rate_max = 48000,
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index b0f7140..0745eea 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -165,8 +165,10 @@ static int create_fixed_stream_quirk(struct snd_usb_audio *chip,
 		return -EINVAL;
 	}
 	alts = &iface->altsetting[fp->altset_idx];
-	fp->datainterval = snd_usb_parse_datainterval(chip, alts);
-	fp->maxpacksize = le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize);
+	if (fp->datainterval == 0)
+		fp->datainterval = snd_usb_parse_datainterval(chip, alts);
+	if (fp->maxpacksize == 0)
+		fp->maxpacksize = le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize);
 	usb_set_interface(chip->dev, fp->iface, 0);
 	snd_usb_init_pitch(chip, fp->iface, alts, fp);
 	snd_usb_init_sample_rate(chip, fp->iface, alts, fp, fp->rate_max);
-- 
1.7.12.1
