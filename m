From: Eric Wong <normalperson@yhbt.net>
Subject: [RFC] ALSA: usb-audio: reduce "cannot get freq at ep" spew
Date: Tue, 31 Mar 2015 07:36:28 +0000
Message-ID: <20150331073628.GB5912@dcvr.yhbt.net>
References: <20150331073405.GA5912@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150331073405.GA5912@dcvr.yhbt.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Joe Turner <joe@oampo.co.uk>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Eric Wong <normalperson@yhbt.net> wrote:
>   I also had another generic patch prepared before I noticed Joe's
>   quirk addition for the MS Lifecam HD-5000.

This is the generic patch I prepared before I noticed Joe's quirk
addition (applies cleanly to 3.19 and 4.0-rc6):

------------------------------8<---------------------------
Subject: [PATCH] ALSA: usb-audio: reduce "cannot get freq at ep" spew

If a device fails to support reading the sample rate, it will likely
fail again and there is no point in logging the message every time the
sample rate is set.

This reduces dmesg noise when using the Benchmark DAC1 PRE as a USB
sound card.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 sound/usb/clock.c    | 7 +++++--
 sound/usb/usbaudio.h | 3 ++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 03fed66..512fe12 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -307,8 +307,11 @@ static int set_sample_rate_v1(struct snd_usb_audio *chip, int iface,
 				   USB_TYPE_CLASS | USB_RECIP_ENDPOINT | USB_DIR_IN,
 				   UAC_EP_CS_ATTR_SAMPLE_RATE << 8, ep,
 				   data, sizeof(data))) < 0) {
-		dev_err(&dev->dev, "%d:%d: cannot get freq at ep %#x\n",
-			iface, fmt->altsetting, ep);
+		if (!chip->no_get_freq) {
+			dev_err(&dev->dev, "%d:%d: cannot get freq at ep %#x\n",
+				iface, fmt->altsetting, ep);
+			chip->no_get_freq = 1;
+		}
 		return 0; /* some devices don't support reading */
 	}
 
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 91d0380..be65671 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -43,7 +43,8 @@ struct snd_usb_audio {
 	unsigned int in_pm:1;
 	unsigned int autosuspended:1;	
 	unsigned int txfr_quirk:1; /* Subframe boundaries on transfers */
-	
+	unsigned int no_get_freq:1;
+
 	int num_interfaces;
 	int num_suspended_intf;
 
-- 
EW
