From: Jussi Laako <jussi@sonarnerd.net>
Subject: [PATCH] ALSA: usb-audio: Add native DSD support for
	Esoteric D-05X
Date: Thu,  7 Dec 2017 12:58:33 +0200
Message-ID: <1512644313-22870-1-git-send-email-jussi@sonarnerd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [194.142.149.154])
 by alsa0.perex.cz (Postfix) with ESMTP id C3A06267A89
 for <alsa-devel@alsa-project.org>; Thu,  7 Dec 2017 11:58:52 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: Jussi Laako <jussi@sonarnerd.net>, nob77413@gmail.com
List-Id: alsa-devel@alsa-project.org

Adds VID:PID of Esoteric D-05X to the TEAC device id's.
Renames the is_teac_50X_dac() function to is_teac_dsd_dac() to cover
broader device family from the same corporation sharing the same USB
audio implementation.

Signed-off-by: Jussi Laako <jussi@sonarnerd.net>
---
 sound/usb/quirks.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 77eecaa..a66ef57 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1166,10 +1166,11 @@ static bool is_marantz_denon_dac(unsigned int id)
 /* TEAC UD-501/UD-503/NT-503 USB DACs need a vendor cmd to switch
  * between PCM/DOP and native DSD mode
  */
-static bool is_teac_50X_dac(unsigned int id)
+static bool is_teac_dsd_dac(unsigned int id)
 {
 	switch (id) {
 	case USB_ID(0x0644, 0x8043): /* TEAC UD-501/UD-503/NT-503 */
+	case USB_ID(0x0644, 0x8044): /* Esoteric D-05X */
 		return true;
 	}
 	return false;
@@ -1202,7 +1203,7 @@ int snd_usb_select_mode_quirk(struct snd_usb_substream *subs,
 			break;
 		}
 		mdelay(20);
-	} else if (is_teac_50X_dac(subs->stream->chip->usb_id)) {
+	} else if (is_teac_dsd_dac(subs->stream->chip->usb_id)) {
 		/* Vendor mode switch cmd is required. */
 		switch (fmt->altsetting) {
 		case 3: /* DSD mode (DSD_U32) requested */
@@ -1392,7 +1393,7 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 	}
 
 	/* TEAC devices with USB DAC functionality */
-	if (is_teac_50X_dac(chip->usb_id)) {
+	if (is_teac_dsd_dac(chip->usb_id)) {
 		if (fp->altsetting == 3)
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 	}
-- 
2.7.4
