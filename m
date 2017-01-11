From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/7] ALSA: drivers: Constify snd_rawmidi_ops
Date: Wed, 11 Jan 2017 20:02:38 +0100
Message-ID: <20170111190242.12585-4-tiwai@suse.de>
References: <20170111190242.12585-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5838826753B
 for <alsa-devel@alsa-project.org>; Wed, 11 Jan 2017 20:02:44 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D9429AC23
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
 sound/drivers/mpu401/mpu401_uart.c | 4 ++--
 sound/drivers/mtpav.c              | 4 ++--
 sound/drivers/mts64.c              | 4 ++--
 sound/drivers/portman2x4.c         | 4 ++--
 sound/drivers/serial-u16550.c      | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/drivers/mpu401/mpu401_uart.c b/sound/drivers/mpu401/mpu401_uart.c
index 776596b5ee05..3a7c317ae012 100644
--- a/sound/drivers/mpu401/mpu401_uart.c
+++ b/sound/drivers/mpu401/mpu401_uart.c
@@ -481,14 +481,14 @@ snd_mpu401_uart_output_trigger(struct snd_rawmidi_substream *substream, int up)
 
  */
 
-static struct snd_rawmidi_ops snd_mpu401_uart_output =
+static const struct snd_rawmidi_ops snd_mpu401_uart_output =
 {
 	.open =		snd_mpu401_uart_output_open,
 	.close =	snd_mpu401_uart_output_close,
 	.trigger =	snd_mpu401_uart_output_trigger,
 };
 
-static struct snd_rawmidi_ops snd_mpu401_uart_input =
+static const struct snd_rawmidi_ops snd_mpu401_uart_input =
 {
 	.open =		snd_mpu401_uart_input_open,
 	.close =	snd_mpu401_uart_input_close,
diff --git a/sound/drivers/mtpav.c b/sound/drivers/mtpav.c
index 30e8a1d5bc87..00b31f92c504 100644
--- a/sound/drivers/mtpav.c
+++ b/sound/drivers/mtpav.c
@@ -600,13 +600,13 @@ static int snd_mtpav_get_ISA(struct mtpav *mcard)
 /*
  */
 
-static struct snd_rawmidi_ops snd_mtpav_output = {
+static const struct snd_rawmidi_ops snd_mtpav_output = {
 	.open =		snd_mtpav_output_open,
 	.close =	snd_mtpav_output_close,
 	.trigger =	snd_mtpav_output_trigger,
 };
 
-static struct snd_rawmidi_ops snd_mtpav_input = {
+static const struct snd_rawmidi_ops snd_mtpav_input = {
 	.open =		snd_mtpav_input_open,
 	.close =	snd_mtpav_input_close,
 	.trigger =	snd_mtpav_input_trigger,
diff --git a/sound/drivers/mts64.c b/sound/drivers/mts64.c
index fd4d18df84d3..f32e81342247 100644
--- a/sound/drivers/mts64.c
+++ b/sound/drivers/mts64.c
@@ -749,13 +749,13 @@ static void snd_mts64_rawmidi_input_trigger(struct snd_rawmidi_substream *substr
 	spin_unlock_irqrestore(&mts->lock, flags);
 }
 
-static struct snd_rawmidi_ops snd_mts64_rawmidi_output_ops = {
+static const struct snd_rawmidi_ops snd_mts64_rawmidi_output_ops = {
 	.open    = snd_mts64_rawmidi_open,
 	.close   = snd_mts64_rawmidi_close,
 	.trigger = snd_mts64_rawmidi_output_trigger
 };
 
-static struct snd_rawmidi_ops snd_mts64_rawmidi_input_ops = {
+static const struct snd_rawmidi_ops snd_mts64_rawmidi_input_ops = {
 	.open    = snd_mts64_rawmidi_open,
 	.close   = snd_mts64_rawmidi_close,
 	.trigger = snd_mts64_rawmidi_input_trigger
diff --git a/sound/drivers/portman2x4.c b/sound/drivers/portman2x4.c
index 189e3e7028af..ec8a94325ef6 100644
--- a/sound/drivers/portman2x4.c
+++ b/sound/drivers/portman2x4.c
@@ -546,13 +546,13 @@ static void snd_portman_midi_output_trigger(struct snd_rawmidi_substream *substr
 	spin_unlock_irqrestore(&pm->reg_lock, flags);
 }
 
-static struct snd_rawmidi_ops snd_portman_midi_output = {
+static const struct snd_rawmidi_ops snd_portman_midi_output = {
 	.open =		snd_portman_midi_open,
 	.close =	snd_portman_midi_close,
 	.trigger =	snd_portman_midi_output_trigger,
 };
 
-static struct snd_rawmidi_ops snd_portman_midi_input = {
+static const struct snd_rawmidi_ops snd_portman_midi_input = {
 	.open =		snd_portman_midi_open,
 	.close =	snd_portman_midi_close,
 	.trigger =	snd_portman_midi_input_trigger,
diff --git a/sound/drivers/serial-u16550.c b/sound/drivers/serial-u16550.c
index 1927b89e1d1f..60d51ac4ccfe 100644
--- a/sound/drivers/serial-u16550.c
+++ b/sound/drivers/serial-u16550.c
@@ -752,14 +752,14 @@ static void snd_uart16550_output_trigger(struct snd_rawmidi_substream *substream
 		snd_uart16550_output_write(substream);
 }
 
-static struct snd_rawmidi_ops snd_uart16550_output =
+static const struct snd_rawmidi_ops snd_uart16550_output =
 {
 	.open =		snd_uart16550_output_open,
 	.close =	snd_uart16550_output_close,
 	.trigger =	snd_uart16550_output_trigger,
 };
 
-static struct snd_rawmidi_ops snd_uart16550_input =
+static const struct snd_rawmidi_ops snd_uart16550_input =
 {
 	.open =		snd_uart16550_input_open,
 	.close =	snd_uart16550_input_close,
-- 
2.11.0
