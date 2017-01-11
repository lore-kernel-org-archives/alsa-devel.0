From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 7/7] ALSA: usb: Constify snd_rawmidi_ops
Date: Wed, 11 Jan 2017 20:02:42 +0100
Message-ID: <20170111190242.12585-8-tiwai@suse.de>
References: <20170111190242.12585-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 843F026753D
 for <alsa-devel@alsa-project.org>; Wed, 11 Jan 2017 20:02:45 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id F0B9EACD3
 for <alsa-devel@alsa-project.org>; Wed, 11 Jan 2017 19:02:43 +0000 (UTC)
In-Reply-To: <20170111190242.12585-1-tiwai@suse.de>
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

Now snd_rawmidi_ops is maintained as a const pointer in snd_rawmidi,
we can constify the definitions.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/6fire/midi.c      | 4 ++--
 sound/usb/bcd2000/bcd2000.c | 4 ++--
 sound/usb/caiaq/midi.c      | 4 ++--
 sound/usb/line6/midi.c      | 4 ++--
 sound/usb/midi.c            | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/usb/6fire/midi.c b/sound/usb/6fire/midi.c
index 3d410969553e..aa5adbb6eb5d 100644
--- a/sound/usb/6fire/midi.c
+++ b/sound/usb/6fire/midi.c
@@ -139,14 +139,14 @@ static void usb6fire_midi_in_trigger(
 	spin_unlock_irqrestore(&rt->in_lock, flags);
 }
 
-static struct snd_rawmidi_ops out_ops = {
+static const struct snd_rawmidi_ops out_ops = {
 	.open = usb6fire_midi_out_open,
 	.close = usb6fire_midi_out_close,
 	.trigger = usb6fire_midi_out_trigger,
 	.drain = usb6fire_midi_out_drain
 };
 
-static struct snd_rawmidi_ops in_ops = {
+static const struct snd_rawmidi_ops in_ops = {
 	.open = usb6fire_midi_in_open,
 	.close = usb6fire_midi_in_close,
 	.trigger = usb6fire_midi_in_trigger
diff --git a/sound/usb/bcd2000/bcd2000.c b/sound/usb/bcd2000/bcd2000.c
index d060dddcc52d..2ff9d578753a 100644
--- a/sound/usb/bcd2000/bcd2000.c
+++ b/sound/usb/bcd2000/bcd2000.c
@@ -252,13 +252,13 @@ static void bcd2000_input_complete(struct urb *urb)
 			__func__, ret);
 }
 
-static struct snd_rawmidi_ops bcd2000_midi_output = {
+static const struct snd_rawmidi_ops bcd2000_midi_output = {
 	.open =    bcd2000_midi_output_open,
 	.close =   bcd2000_midi_output_close,
 	.trigger = bcd2000_midi_output_trigger,
 };
 
-static struct snd_rawmidi_ops bcd2000_midi_input = {
+static const struct snd_rawmidi_ops bcd2000_midi_input = {
 	.open =    bcd2000_midi_input_open,
 	.close =   bcd2000_midi_input_close,
 	.trigger = bcd2000_midi_input_trigger,
diff --git a/sound/usb/caiaq/midi.c b/sound/usb/caiaq/midi.c
index 2d7588461b33..f8e5b1b57c4f 100644
--- a/sound/usb/caiaq/midi.c
+++ b/sound/usb/caiaq/midi.c
@@ -102,14 +102,14 @@ static void snd_usb_caiaq_midi_output_trigger(struct snd_rawmidi_substream *subs
 }
 
 
-static struct snd_rawmidi_ops snd_usb_caiaq_midi_output =
+static const struct snd_rawmidi_ops snd_usb_caiaq_midi_output =
 {
 	.open =		snd_usb_caiaq_midi_output_open,
 	.close =	snd_usb_caiaq_midi_output_close,
 	.trigger =      snd_usb_caiaq_midi_output_trigger,
 };
 
-static struct snd_rawmidi_ops snd_usb_caiaq_midi_input =
+static const struct snd_rawmidi_ops snd_usb_caiaq_midi_input =
 {
 	.open =		snd_usb_caiaq_midi_input_open,
 	.close =	snd_usb_caiaq_midi_input_close,
diff --git a/sound/usb/line6/midi.c b/sound/usb/line6/midi.c
index d0fb2f205bd9..1d3a23b02d68 100644
--- a/sound/usb/line6/midi.c
+++ b/sound/usb/line6/midi.c
@@ -200,14 +200,14 @@ static void line6_midi_input_trigger(struct snd_rawmidi_substream *substream,
 		line6->line6midi->substream_receive = NULL;
 }
 
-static struct snd_rawmidi_ops line6_midi_output_ops = {
+static const struct snd_rawmidi_ops line6_midi_output_ops = {
 	.open = line6_midi_output_open,
 	.close = line6_midi_output_close,
 	.trigger = line6_midi_output_trigger,
 	.drain = line6_midi_output_drain,
 };
 
-static struct snd_rawmidi_ops line6_midi_input_ops = {
+static const struct snd_rawmidi_ops line6_midi_input_ops = {
 	.open = line6_midi_input_open,
 	.close = line6_midi_input_close,
 	.trigger = line6_midi_input_trigger,
diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 7ba92921bf28..6e763bc8d7db 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1234,14 +1234,14 @@ static void snd_usbmidi_input_trigger(struct snd_rawmidi_substream *substream,
 		clear_bit(substream->number, &umidi->input_triggered);
 }
 
-static struct snd_rawmidi_ops snd_usbmidi_output_ops = {
+static const struct snd_rawmidi_ops snd_usbmidi_output_ops = {
 	.open = snd_usbmidi_output_open,
 	.close = snd_usbmidi_output_close,
 	.trigger = snd_usbmidi_output_trigger,
 	.drain = snd_usbmidi_output_drain,
 };
 
-static struct snd_rawmidi_ops snd_usbmidi_input_ops = {
+static const struct snd_rawmidi_ops snd_usbmidi_input_ops = {
 	.open = snd_usbmidi_input_open,
 	.close = snd_usbmidi_input_close,
 	.trigger = snd_usbmidi_input_trigger
-- 
2.11.0
