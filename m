From: Roman Sommer <roman.sommer@fau.de>
Subject: [PATCH 3/3] sound/line6: add newline after declarations
Date: Mon, 18 Jun 2018 12:29:39 +0200
Message-ID: <1529317779-15908-4-git-send-email-roman.sommer@fau.de>
References: <1529317779-15908-1-git-send-email-roman.sommer@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1529317779-15908-1-git-send-email-roman.sommer@fau.de>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Roman Sommer <roman.sommer@fau.de>, linux-kernel@i4.cs.fau.de, Daniel Graefe <daniel.graefe@fau.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, =?UTF-8?q?Hans=20P=2E=20M=C3=B6ller=20Ebner?= <hmoller@uc.cl>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?q?Fabi=C3=A1n=20Inostroza?= <soulsonceonfire@gmail.com>, Bhumika Goyal <bhumirks@gmail.com>, Philippe Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

CC: Jaroslav Kysela <perex@perex.cz>
CC: Takashi Iwai <tiwai@suse.com>
CC: Takashi Sakamoto <o-takashi@sakamocchi.jp>
CC: "Hans P. Möller Ebner" <hmoller@uc.cl>
CC: Kees Cook <keescook@chromium.org>
CC: Kate Stewart <kstewart@linuxfoundation.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: "Fabián Inostroza" <soulsonceonfire@gmail.com>
CC: Bhumika Goyal <bhumirks@gmail.com>
CC: Philippe Ombredanne <pombredanne@nexb.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: alsa-devel@alsa-project.org
CC: linux-kernel@vger.kernel.org

This patch adds newlines after variable declarations in sound/usb/line6.

Signed-off-by: Roman Sommer <roman.sommer@fau.de>
Signed-off-by: Daniel Graefe <daniel.graefe@fau.de>
---
 sound/usb/line6/driver.h   | 1 +
 sound/usb/line6/playback.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index 1dfb6de..4dff70c 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -174,6 +174,7 @@ struct usb_line6 {
 		struct mutex read_lock;
 		wait_queue_head_t wait_queue;
 		unsigned int active:1;
+
 		STRUCT_KFIFO_REC_2(LINE6_BUFSIZE_LISTEN * LINE6_RAW_MESSAGES_MAXCOUNT)
 			fifo;
 	} messages;
diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index 674502c..1e16a5c 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -39,6 +39,7 @@ static void change_volume(struct urb *urb_out, int volume[],
 		for (; p < buf_end; ++p) {
 			short pv = le16_to_cpu(*p);
 			int val = (pv * volume[chn & 1]) >> 8;
+
 			pv = clamp(val, -0x8000, 0x7fff);
 			*p = cpu_to_le16(pv);
 			++chn;
@@ -126,6 +127,7 @@ static void add_monitor_signal(struct urb *urb_out, unsigned char *signal,
 			short pov = le16_to_cpu(*po);
 			short piv = le16_to_cpu(*pi);
 			int val = pov + ((piv * volume) >> 8);
+
 			pov = clamp(val, -0x8000, 0x7fff);
 			*po = cpu_to_le16(pov);
 		}
-- 
2.7.4
