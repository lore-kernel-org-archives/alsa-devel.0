From: Wenwen Wang <wenwen@cs.uga.edu>
Subject: [PATCH] ALSA: pcm: fix a memory leak bug
Date: Wed, 7 Aug 2019 02:15:17 -0400
Message-ID: <CAAa=b7ffFNc4zuQfXEwsS363=kX_ZOx0+jhg4WM3JQ-d7n-LMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wenwen Wang <wenwen@cs.uga.edu>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Allison Randal <allison@lohutok.net>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "moderated list:SOUND" <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

In hiface_pcm_init(), 'rt' is firstly allocated through kzalloc(). Later
on, hiface_pcm_init_urb() is invoked to initialize 'rt->out_urbs[i]'.
However, if the initialization fails, 'rt' is not deallocated, leading to a
memory leak bug.

To fix the above issue, free 'rt' before returning the error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 sound/usb/hiface/pcm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/usb/hiface/pcm.c b/sound/usb/hiface/pcm.c
index 14fc1e1..5dbcd0d 100644
--- a/sound/usb/hiface/pcm.c
+++ b/sound/usb/hiface/pcm.c
@@ -599,8 +599,10 @@ int hiface_pcm_init(struct hiface_chip *chip, u8
extra_freq)
        for (i = 0; i < PCM_N_URBS; i++) {
                ret = hiface_pcm_init_urb(&rt->out_urbs[i], chip, OUT_EP,
                                    hiface_pcm_out_urb_handler);
-               if (ret < 0)
+               if (ret < 0) {
+                       kfree(rt);
                        return ret;
+               }
        }

        ret = snd_pcm_new(chip->card, "USB-SPDIF Audio", 0, 1, 0, &pcm);
-- 
2.7.4
