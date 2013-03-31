From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH 03/10] ALSA: usb-audio: neaten EXPORT_SYMBOLS
	placement
Date: Sun, 31 Mar 2013 17:52:25 +0200
Message-ID: <1364745152-1762-4-git-send-email-eldad@fogrefinery.com>
References: <1364745152-1762-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f43.google.com (mail-bk0-f43.google.com
 [209.85.214.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 54F5E26172B
 for <alsa-devel@alsa-project.org>; Sun, 31 Mar 2013 17:53:05 +0200 (CEST)
Received: by mail-bk0-f43.google.com with SMTP id jm2so679500bkc.30
 for <alsa-devel@alsa-project.org>; Sun, 31 Mar 2013 08:53:05 -0700 (PDT)
In-Reply-To: <1364745152-1762-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>
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
