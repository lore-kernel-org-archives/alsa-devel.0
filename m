From: "Vittorio G (VittGam)" <linuxbugs@vittgam.net>
Subject: [PATCH] ALSA: usb-audio: Add quirk for MS LifeCam HD-3000
Date: Fri, 22 May 2015 21:15:19 +0200
Message-ID: <fffbee5b1d6a62456b10a9ca132298fb@vittgam.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org
Cc: stable@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Microsoft LifeCam HD-3000 (045e:0779) needs a similar quirk for
suppressing the unsupported sample rate inquiry.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=98481
Cc: <stable@vger.kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Vittorio Gambaletta <linuxbugs@vittgam.net>
---

The dmesg is showing this every time the ALSA audio is opened
by the application:

[3759907.370000] 2:3:1: cannot get freq at ep 0x82

And in fact I had to initialize ALSA and v4l2 in a specific order
in my application in order for them to both work.

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 46facfc..2917534 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1118,6 +1118,7 @@ bool snd_usb_get_sample_rate_quirk(struct snd_usb_audio *chip)
  	case USB_ID(0x045E, 0x075D): /* MS Lifecam Cinema  */
  	case USB_ID(0x045E, 0x076D): /* MS Lifecam HD-5000 */
  	case USB_ID(0x045E, 0x0772): /* MS Lifecam Studio */
+	case USB_ID(0x045E, 0x0779): /* MS Lifecam HD-3000 */
  	case USB_ID(0x04D8, 0xFEEA): /* Benchmark DAC1 Pre */
  		return true;
  	}
