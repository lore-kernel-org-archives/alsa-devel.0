From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/7] ALSA: isa: Constify snd_rawmidi_ops
Date: Wed, 11 Jan 2017 20:02:39 +0100
Message-ID: <20170111190242.12585-5-tiwai@suse.de>
References: <20170111190242.12585-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5936D26753C
 for <alsa-devel@alsa-project.org>; Wed, 11 Jan 2017 20:02:44 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id DF90AAC27
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
 include/sound/snd_wavefront.h        | 4 ++--
 sound/isa/gus/gus_uart.c             | 4 ++--
 sound/isa/msnd/msnd_midi.c           | 2 +-
 sound/isa/sb/sb8_midi.c              | 4 ++--
 sound/isa/wavefront/wavefront_midi.c | 4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/sound/snd_wavefront.h b/include/sound/snd_wavefront.h
index 35e94b3d1ec7..cd0bab1ef6f1 100644
--- a/include/sound/snd_wavefront.h
+++ b/include/sound/snd_wavefront.h
@@ -37,8 +37,8 @@ struct _snd_wavefront_midi {
 #define	MPU_ACK		0xFE
 #define	UART_MODE_ON	0x3F
 
-extern struct snd_rawmidi_ops snd_wavefront_midi_output;
-extern struct snd_rawmidi_ops snd_wavefront_midi_input;
+extern const struct snd_rawmidi_ops snd_wavefront_midi_output;
+extern const struct snd_rawmidi_ops snd_wavefront_midi_input;
 
 extern void   snd_wavefront_midi_enable_virtual (snd_wavefront_card_t *);
 extern void   snd_wavefront_midi_disable_virtual (snd_wavefront_card_t *);
diff --git a/sound/isa/gus/gus_uart.c b/sound/isa/gus/gus_uart.c
index 3992912743f5..ac5f5687d1a3 100644
--- a/sound/isa/gus/gus_uart.c
+++ b/sound/isa/gus/gus_uart.c
@@ -227,14 +227,14 @@ static void snd_gf1_uart_output_trigger(struct snd_rawmidi_substream *substream,
 	spin_unlock_irqrestore(&gus->uart_cmd_lock, flags);
 }
 
-static struct snd_rawmidi_ops snd_gf1_uart_output =
+static const struct snd_rawmidi_ops snd_gf1_uart_output =
 {
 	.open =		snd_gf1_uart_output_open,
 	.close =	snd_gf1_uart_output_close,
 	.trigger =	snd_gf1_uart_output_trigger,
 };
 
-static struct snd_rawmidi_ops snd_gf1_uart_input =
+static const struct snd_rawmidi_ops snd_gf1_uart_input =
 {
 	.open =		snd_gf1_uart_input_open,
 	.close =	snd_gf1_uart_input_close,
diff --git a/sound/isa/msnd/msnd_midi.c b/sound/isa/msnd/msnd_midi.c
index ffc67fd80c23..912b5a9ccbab 100644
--- a/sound/isa/msnd/msnd_midi.c
+++ b/sound/isa/msnd/msnd_midi.c
@@ -142,7 +142,7 @@ void snd_msndmidi_input_read(void *mpuv)
 }
 EXPORT_SYMBOL(snd_msndmidi_input_read);
 
-static struct snd_rawmidi_ops snd_msndmidi_input = {
+static const struct snd_rawmidi_ops snd_msndmidi_input = {
 	.open =		snd_msndmidi_input_open,
 	.close =	snd_msndmidi_input_close,
 	.trigger =	snd_msndmidi_input_trigger,
diff --git a/sound/isa/sb/sb8_midi.c b/sound/isa/sb/sb8_midi.c
index d551c50e549f..bd672abb4854 100644
--- a/sound/isa/sb/sb8_midi.c
+++ b/sound/isa/sb/sb8_midi.c
@@ -247,14 +247,14 @@ static void snd_sb8dsp_midi_output_trigger(struct snd_rawmidi_substream *substre
 		snd_sb8dsp_midi_output_write(substream);
 }
 
-static struct snd_rawmidi_ops snd_sb8dsp_midi_output =
+static const struct snd_rawmidi_ops snd_sb8dsp_midi_output =
 {
 	.open =		snd_sb8dsp_midi_output_open,
 	.close =	snd_sb8dsp_midi_output_close,
 	.trigger =	snd_sb8dsp_midi_output_trigger,
 };
 
-static struct snd_rawmidi_ops snd_sb8dsp_midi_input =
+static const struct snd_rawmidi_ops snd_sb8dsp_midi_input =
 {
 	.open =		snd_sb8dsp_midi_input_open,
 	.close =	snd_sb8dsp_midi_input_close,
diff --git a/sound/isa/wavefront/wavefront_midi.c b/sound/isa/wavefront/wavefront_midi.c
index 8a80fc6a616b..2aa05f3aaa38 100644
--- a/sound/isa/wavefront/wavefront_midi.c
+++ b/sound/isa/wavefront/wavefront_midi.c
@@ -559,14 +559,14 @@ snd_wavefront_midi_start (snd_wavefront_card_t *card)
 	return 0;
 }
 
-struct snd_rawmidi_ops snd_wavefront_midi_output =
+const struct snd_rawmidi_ops snd_wavefront_midi_output =
 {
 	.open =		snd_wavefront_midi_output_open,
 	.close =	snd_wavefront_midi_output_close,
 	.trigger =	snd_wavefront_midi_output_trigger,
 };
 
-struct snd_rawmidi_ops snd_wavefront_midi_input =
+const struct snd_rawmidi_ops snd_wavefront_midi_input =
 {
 	.open =		snd_wavefront_midi_input_open,
 	.close =	snd_wavefront_midi_input_close,
-- 
2.11.0
