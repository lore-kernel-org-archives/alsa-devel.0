From: Federico Cuello <fedux@fedux.com.ar>
Subject: [PATCH] ALSA: usb: mixer: volume quirk for
	CM102-A+/102S+
Date: Sun,  6 May 2018 13:37:18 +0200
Message-ID: <20180506113718.4007-1-fedux@fedux.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.fedux.com.ar (mail.fedux.com.ar [167.99.131.221])
 by alsa0.perex.cz (Postfix) with ESMTP id A479B266F46
 for <alsa-devel@alsa-project.org>; Sun,  6 May 2018 13:37:22 +0200 (CEST)
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
Cc: Federico Cuello <fedux@fedux.com.ar>
List-Id: alsa-devel@alsa-project.org

Currently it's not possible to set volume lower than 26% (it just mutes).

Also fixes this warning:

  Warning! Unlikely big volume range (=9472), cval->res is probably wrong.
  [13] FU [PCM Playback Volume] ch = 2, val = -9473/-1/1

, and volume works fine for full range.
---
 sound/usb/mixer.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 344d7b069d59..bb5ab7a7dfa5 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -967,6 +967,14 @@ static void volume_control_quirks(struct usb_mixer_elem_info *cval,
 		}
 		break;
 
+	case USB_ID(0x0d8c, 0x0103):
+		if (!strcmp(kctl->id.name, "PCM Playback Volume")) {
+			usb_audio_info(chip,
+				 "set volume quirk for CM102-A+/102S+\n");
+			cval->min = -256;
+		}
+		break;
+
 	case USB_ID(0x0471, 0x0101):
 	case USB_ID(0x0471, 0x0104):
 	case USB_ID(0x0471, 0x0105):
-- 
2.17.0
