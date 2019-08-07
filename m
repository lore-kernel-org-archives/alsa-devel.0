From: Wenwen Wang <wenwen@cs.uga.edu>
Subject: [PATCH v2] ALSA: pcm: fix multiple memory leak bugs
Date: Wed, 7 Aug 2019 03:09:59 -0400
Message-ID: <CAAa=b7dkPm4JqF4_cPwJo_6_aoobr6OyezCb2A9-aAFHNWffeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wenwen Wang <wenwen@cs.uga.edu>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Allison Randal <allison@lohutok.net>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "moderated list:SOUND" <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

In hiface_pcm_init(), 'rt' is firstly allocated through kzalloc(). Later
on, hiface_pcm_init_urb() is invoked to initialize 'rt->out_urbs[i]'. In
hiface_pcm_init_urb(), 'rt->out_urbs[i].buffer' is allocated through
kzalloc().  However, if hiface_pcm_init_urb() fails, both 'rt' and
'rt->out_urbs[i].buffer' are not deallocated, leading to memory leak bugs.
Also, 'rt->out_urbs[i].buffer' is not deallocated if snd_pcm_new() fails.

To fix the above issues, free 'rt' and 'rt->out_urbs[i].buffer'.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 sound/usb/hiface/pcm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/usb/hiface/pcm.c b/sound/usb/hiface/pcm.c
index 14fc1e1..9b132aa 100644
--- a/sound/usb/hiface/pcm.c
+++ b/sound/usb/hiface/pcm.c
@@ -599,12 +599,18 @@ int hiface_pcm_init(struct hiface_chip *chip, u8
extra_freq)
        for (i = 0; i < PCM_N_URBS; i++) {
                ret = hiface_pcm_init_urb(&rt->out_urbs[i], chip, OUT_EP,
                                    hiface_pcm_out_urb_handler);
-               if (ret < 0)
+               if (ret < 0) {
+                       for (; i >= 0; i--)
+                               kfree(rt->out_urbs[i].buffer);
+                       kfree(rt);
                        return ret;
+               }
        }

        ret = snd_pcm_new(chip->card, "USB-SPDIF Audio", 0, 1, 0, &pcm);
        if (ret < 0) {
+               for (i = 0; i < PCM_N_URBS; i++)
+                       kfree(rt->out_urbs[i].buffer);
                kfree(rt);
                dev_err(&chip->dev->dev, "Cannot create pcm instance\n");
                return ret;
-- 
2.7.4
