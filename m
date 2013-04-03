From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCHv2 03/10] ALSA: usb-audio: neaten EXPORT_SYMBOLS
	placement
Date: Wed,  3 Apr 2013 23:18:51 +0200
Message-ID: <1365023938-1461-4-git-send-email-eldad@fogrefinery.com>
References: <1365023938-1461-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f46.google.com (mail-bk0-f46.google.com
 [209.85.214.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E972260323
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 23:19:15 +0200 (CEST)
Received: by mail-bk0-f46.google.com with SMTP id je9so1129603bkc.19
 for <alsa-devel@alsa-project.org>; Wed, 03 Apr 2013 14:19:15 -0700 (PDT)
In-Reply-To: <1365023938-1461-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>, Torstein Hegge <hegge@resisty.net>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Put EXPORT_SYMBOLS directly under the exported function.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/midi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 1cf943d..60c7aa7 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1455,6 +1455,7 @@ void snd_usbmidi_disconnect(struct list_head* p)
 	}
 	del_timer_sync(&umidi->error_timer);
 }
+EXPORT_SYMBOL(snd_usbmidi_disconnect);
 
 static void snd_usbmidi_rawmidi_free(struct snd_rawmidi *rmidi)
 {
@@ -2090,6 +2091,7 @@ void snd_usbmidi_input_stop(struct list_head* p)
 	}
 	umidi->input_running = 0;
 }
+EXPORT_SYMBOL(snd_usbmidi_input_stop);
 
 static void snd_usbmidi_input_start_ep(struct snd_usb_midi_in_endpoint* ep)
 {
@@ -2119,6 +2121,7 @@ void snd_usbmidi_input_start(struct list_head* p)
 		snd_usbmidi_input_start_ep(umidi->endpoints[i].in);
 	umidi->input_running = 1;
 }
+EXPORT_SYMBOL(snd_usbmidi_input_start);
 
 /*
  * Creates and registers everything needed for a MIDI streaming interface.
@@ -2258,8 +2261,4 @@ int snd_usbmidi_create(struct snd_card *card,
 	list_add_tail(&umidi->list, midi_list);
 	return 0;
 }
-
 EXPORT_SYMBOL(snd_usbmidi_create);
-EXPORT_SYMBOL(snd_usbmidi_input_stop);
-EXPORT_SYMBOL(snd_usbmidi_input_start);
-EXPORT_SYMBOL(snd_usbmidi_disconnect);
-- 
1.8.1.5
