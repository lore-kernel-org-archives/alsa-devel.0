From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/18] ALSA: serial-u16550: Use setup_timer()
	and mod_timer()
Date: Mon, 19 Jan 2015 12:11:19 +0100
Message-ID: <1421665891-14475-7-git-send-email-tiwai@suse.de>
References: <1421665891-14475-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 360712606C8
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 12:11:37 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E9EDBAD8B
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 11:11:35 +0000 (UTC)
In-Reply-To: <1421665891-14475-1-git-send-email-tiwai@suse.de>
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

No functional change, refactoring with the standard helpers.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/serial-u16550.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/drivers/serial-u16550.c b/sound/drivers/serial-u16550.c
index 13a34e3c6382..8c1dc73e14e4 100644
--- a/sound/drivers/serial-u16550.c
+++ b/sound/drivers/serial-u16550.c
@@ -174,9 +174,8 @@ static inline void snd_uart16550_add_timer(struct snd_uart16550 *uart)
 {
 	if (!uart->timer_running) {
 		/* timer 38600bps * 10bit * 16byte */
-		uart->buffer_timer.expires = jiffies + (HZ+255)/256;
+		mod_timer(&uart->buffer_timer, jiffies + (HZ + 255) / 256);
 		uart->timer_running = 1;
-		add_timer(&uart->buffer_timer);
 	}
 }
 
@@ -830,9 +829,8 @@ static int snd_uart16550_create(struct snd_card *card,
 	uart->prev_in = 0;
 	uart->rstatus = 0;
 	memset(uart->prev_status, 0x80, sizeof(unsigned char) * SNDRV_SERIAL_MAX_OUTS);
-	init_timer(&uart->buffer_timer);
-	uart->buffer_timer.function = snd_uart16550_buffer_timer;
-	uart->buffer_timer.data = (unsigned long)uart;
+	setup_timer(&uart->buffer_timer, snd_uart16550_buffer_timer,
+		    (unsigned long)uart);
 	uart->timer_running = 0;
 
 	/* Register device */
-- 
2.2.1
