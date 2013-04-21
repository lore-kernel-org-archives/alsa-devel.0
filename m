From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH,
	for-next] ALSA: usb-audio: use FMTBITs in parse_audio_format_i
Date: Mon, 22 Apr 2013 01:44:04 +0200
Message-ID: <1366587844-1252-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f42.google.com (mail-bk0-f42.google.com
 [209.85.214.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B92C260314
 for <alsa-devel@alsa-project.org>; Mon, 22 Apr 2013 01:44:16 +0200 (CEST)
Received: by mail-bk0-f42.google.com with SMTP id jc3so2357146bkc.29
 for <alsa-devel@alsa-project.org>; Sun, 21 Apr 2013 16:44:16 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, Daniel Mack <zonque@gmail.com>, Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Replace the usage of SNDRV_PCM_FORMAT_* macros with the equivalent
SNDRV_PCM_FMTBIT_* macros, and the result be can assigned directly
to the formats field.
Modify the variable name to reflect the change.

The following sparse messages are silenced:

sound/usb/format.c:377:44: warning: incorrect type in assignment (different base types)
sound/usb/format.c:377:44:    expected int [signed] pcm_format
sound/usb/format.c:377:44:    got restricted snd_pcm_format_t [usertype] <noident>
sound/usb/format.c:379:44: warning: incorrect type in assignment (different base types)
sound/usb/format.c:379:44:    expected int [signed] pcm_format
sound/usb/format.c:379:44:    got restricted snd_pcm_format_t [usertype] <noident>
sound/usb/format.c:382:36: warning: incorrect type in assignment (different base types)
sound/usb/format.c:382:36:    expected int [signed] pcm_format
sound/usb/format.c:382:36:    got restricted snd_pcm_format_t [usertype] <noident>

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/format.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/usb/format.c b/sound/usb/format.c
index 020ede0..e025e28 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -365,7 +365,7 @@ static int parse_audio_format_i(struct snd_usb_audio *chip,
 {
 	struct usb_interface_descriptor *altsd = get_iface_desc(iface);
 	int protocol = altsd->bInterfaceProtocol;
-	int pcm_format, ret;
+	int pcm_formats, ret;
 
 	if (fmt->bFormatType == UAC_FORMAT_TYPE_III) {
 		/* FIXME: the format type is really IECxxx
@@ -377,14 +377,14 @@ static int parse_audio_format_i(struct snd_usb_audio *chip,
 		case USB_ID(0x0763, 0x2003): /* M-Audio Audiophile USB */
 			if (chip->setup == 0x00 && 
 			    fp->altsetting == 6)
-				pcm_format = SNDRV_PCM_FORMAT_S16_BE;
+				pcm_formats = SNDRV_PCM_FMTBIT_S16_BE;
 			else
-				pcm_format = SNDRV_PCM_FORMAT_S16_LE;
+				pcm_formats = SNDRV_PCM_FMTBIT_S16_LE;
 			break;
 		default:
-			pcm_format = SNDRV_PCM_FORMAT_S16_LE;
+			pcm_formats = SNDRV_PCM_FMTBIT_S16_LE;
 		}
-		fp->formats = 1uLL << pcm_format;
+		fp->formats = pcm_formats;
 	} else {
 		fp->formats = parse_audio_format_i_type(chip, fp, format,
 							fmt, protocol);
-- 
1.8.1.5
