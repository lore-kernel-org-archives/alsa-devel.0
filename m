From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] ALSA: drivers: Convert timers to use timer_setup()
Date: Tue, 24 Oct 2017 08:34:29 -0700
Message-ID: <20171024153429.GA112861@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bhumika Goyal <bhumirks@gmail.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Markus Elfring <elfring@users.sourceforge.net>, David Howells <dhowells@redhat.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: Bhumika Goyal <bhumirks@gmail.com>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Markus Elfring <elfring@users.sourceforge.net>
Cc: David Howells <dhowells@redhat.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 sound/drivers/aloop.c              | 7 +++----
 sound/drivers/dummy.c              | 7 +++----
 sound/drivers/mpu401/mpu401_uart.c | 7 +++----
 sound/drivers/mtpav.c              | 7 +++----
 sound/drivers/opl3/opl3_midi.c     | 4 ++--
 sound/drivers/opl3/opl3_seq.c      | 2 +-
 sound/drivers/opl3/opl3_voice.h    | 2 +-
 sound/drivers/serial-u16550.c      | 7 +++----
 8 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 135adb17703c..afac886ffa28 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -529,9 +529,9 @@ static unsigned int loopback_pos_update(struct loopback_cable *cable)
 	return running;
 }
 
-static void loopback_timer_function(unsigned long data)
+static void loopback_timer_function(struct timer_list *t)
 {
-	struct loopback_pcm *dpcm = (struct loopback_pcm *)data;
+	struct loopback_pcm *dpcm = from_timer(dpcm, t, timer);
 	unsigned long flags;
 
 	spin_lock_irqsave(&dpcm->cable->lock, flags);
@@ -675,8 +675,7 @@ static int loopback_open(struct snd_pcm_substream *substream)
 	}
 	dpcm->loopback = loopback;
 	dpcm->substream = substream;
-	setup_timer(&dpcm->timer, loopback_timer_function,
-		    (unsigned long)dpcm);
+	timer_setup(&dpcm->timer, loopback_timer_function, 0);
 
 	cable = loopback->cables[substream->number][dev];
 	if (!cable) {
diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index c0939a0164a6..7b2b1f766b00 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -306,9 +306,9 @@ static int dummy_systimer_prepare(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static void dummy_systimer_callback(unsigned long data)
+static void dummy_systimer_callback(struct timer_list *t)
 {
-	struct dummy_systimer_pcm *dpcm = (struct dummy_systimer_pcm *)data;
+	struct dummy_systimer_pcm *dpcm = from_timer(dpcm, t, timer);
 	unsigned long flags;
 	int elapsed = 0;
 	
@@ -343,8 +343,7 @@ static int dummy_systimer_create(struct snd_pcm_substream *substream)
 	if (!dpcm)
 		return -ENOMEM;
 	substream->runtime->private_data = dpcm;
-	setup_timer(&dpcm->timer, dummy_systimer_callback,
-			(unsigned long) dpcm);
+	timer_setup(&dpcm->timer, dummy_systimer_callback, 0);
 	spin_lock_init(&dpcm->lock);
 	dpcm->substream = substream;
 	return 0;
diff --git a/sound/drivers/mpu401/mpu401_uart.c b/sound/drivers/mpu401/mpu401_uart.c
index b997222274bd..3e745f47dd2f 100644
--- a/sound/drivers/mpu401/mpu401_uart.c
+++ b/sound/drivers/mpu401/mpu401_uart.c
@@ -169,9 +169,9 @@ EXPORT_SYMBOL(snd_mpu401_uart_interrupt_tx);
  * timer callback
  * reprogram the timer and call the interrupt job
  */
-static void snd_mpu401_uart_timer(unsigned long data)
+static void snd_mpu401_uart_timer(struct timer_list *t)
 {
-	struct snd_mpu401 *mpu = (struct snd_mpu401 *)data;
+	struct snd_mpu401 *mpu = from_timer(mpu, t, timer);
 	unsigned long flags;
 
 	spin_lock_irqsave(&mpu->timer_lock, flags);
@@ -191,8 +191,7 @@ static void snd_mpu401_uart_add_timer (struct snd_mpu401 *mpu, int input)
 
 	spin_lock_irqsave (&mpu->timer_lock, flags);
 	if (mpu->timer_invoked == 0) {
-		setup_timer(&mpu->timer, snd_mpu401_uart_timer,
-			    (unsigned long)mpu);
+		timer_setup(&mpu->timer, snd_mpu401_uart_timer, 0);
 		mod_timer(&mpu->timer, 1 + jiffies);
 	} 
 	mpu->timer_invoked |= input ? MPU401_MODE_INPUT_TIMER :
diff --git a/sound/drivers/mtpav.c b/sound/drivers/mtpav.c
index 0f6392001e30..547662e02fcc 100644
--- a/sound/drivers/mtpav.c
+++ b/sound/drivers/mtpav.c
@@ -406,10 +406,10 @@ static void snd_mtpav_input_trigger(struct snd_rawmidi_substream *substream, int
  * timer interrupt for outputs
  */
 
-static void snd_mtpav_output_timer(unsigned long data)
+static void snd_mtpav_output_timer(struct timer_list *t)
 {
 	unsigned long flags;
-	struct mtpav *chip = (struct mtpav *)data;
+	struct mtpav *chip = from_timer(chip, t, timer);
 	int p;
 
 	spin_lock_irqsave(&chip->spinlock, flags);
@@ -707,8 +707,7 @@ static int snd_mtpav_probe(struct platform_device *dev)
 	mtp_card->share_irq = 0;
 	mtp_card->inmidistate = 0;
 	mtp_card->outmidihwport = 0xffffffff;
-	setup_timer(&mtp_card->timer, snd_mtpav_output_timer,
-		    (unsigned long) mtp_card);
+	timer_setup(&mtp_card->timer, snd_mtpav_output_timer, 0);
 
 	card->private_free = snd_mtpav_free;
 
diff --git a/sound/drivers/opl3/opl3_midi.c b/sound/drivers/opl3/opl3_midi.c
index 13c0a7e1bc2b..bb3f3a5a6951 100644
--- a/sound/drivers/opl3/opl3_midi.c
+++ b/sound/drivers/opl3/opl3_midi.c
@@ -238,10 +238,10 @@ static int opl3_get_voice(struct snd_opl3 *opl3, int instr_4op,
 /*
  * System timer interrupt function
  */
-void snd_opl3_timer_func(unsigned long data)
+void snd_opl3_timer_func(struct timer_list *t)
 {
 
-	struct snd_opl3 *opl3 = (struct snd_opl3 *)data;
+	struct snd_opl3 *opl3 = from_timer(opl3, t, tlist);
 	unsigned long flags;
 	int again = 0;
 	int i;
diff --git a/sound/drivers/opl3/opl3_seq.c b/sound/drivers/opl3/opl3_seq.c
index d3e91be8b23a..5f881c4cdf1f 100644
--- a/sound/drivers/opl3/opl3_seq.c
+++ b/sound/drivers/opl3/opl3_seq.c
@@ -248,7 +248,7 @@ static int snd_opl3_seq_probe(struct device *_dev)
 	}
 
 	/* setup system timer */
-	setup_timer(&opl3->tlist, snd_opl3_timer_func, (unsigned long) opl3);
+	timer_setup(&opl3->tlist, snd_opl3_timer_func, 0);
 	spin_lock_init(&opl3->sys_timer_lock);
 	opl3->sys_timer_status = 0;
 
diff --git a/sound/drivers/opl3/opl3_voice.h b/sound/drivers/opl3/opl3_voice.h
index eaef435e0528..a2445163008e 100644
--- a/sound/drivers/opl3/opl3_voice.h
+++ b/sound/drivers/opl3/opl3_voice.h
@@ -37,7 +37,7 @@ void snd_opl3_nrpn(void *p, struct snd_midi_channel *chan, struct snd_midi_chann
 void snd_opl3_sysex(void *p, unsigned char *buf, int len, int parsed, struct snd_midi_channel_set *chset);
 
 void snd_opl3_calc_volume(unsigned char *reg, int vel, struct snd_midi_channel *chan);
-void snd_opl3_timer_func(unsigned long data);
+void snd_opl3_timer_func(struct timer_list *t);
 
 /* Prototypes for opl3_drums.c */
 void snd_opl3_load_drums(struct snd_opl3 *opl3);
diff --git a/sound/drivers/serial-u16550.c b/sound/drivers/serial-u16550.c
index 88e66ea0306d..0a67b8b9f176 100644
--- a/sound/drivers/serial-u16550.c
+++ b/sound/drivers/serial-u16550.c
@@ -309,12 +309,12 @@ static irqreturn_t snd_uart16550_interrupt(int irq, void *dev_id)
 }
 
 /* When the polling mode, this function calls snd_uart16550_io_loop. */
-static void snd_uart16550_buffer_timer(unsigned long data)
+static void snd_uart16550_buffer_timer(struct timer_list *t)
 {
 	unsigned long flags;
 	struct snd_uart16550 *uart;
 
-	uart = (struct snd_uart16550 *)data;
+	uart = from_timer(uart, t, buffer_timer);
 	spin_lock_irqsave(&uart->open_lock, flags);
 	snd_uart16550_del_timer(uart);
 	snd_uart16550_io_loop(uart);
@@ -828,8 +828,7 @@ static int snd_uart16550_create(struct snd_card *card,
 	uart->prev_in = 0;
 	uart->rstatus = 0;
 	memset(uart->prev_status, 0x80, sizeof(unsigned char) * SNDRV_SERIAL_MAX_OUTS);
-	setup_timer(&uart->buffer_timer, snd_uart16550_buffer_timer,
-		    (unsigned long)uart);
+	timer_setup(&uart->buffer_timer, snd_uart16550_buffer_timer, 0);
 	uart->timer_running = 0;
 
 	/* Register device */
-- 
2.7.4


-- 
Kees Cook
Pixel Security
