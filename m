From: Wenwen Wang <wenwen@cs.uga.edu>
Subject: [PATCH] ALSA: usb-audio: fix a memory leak bug
Date: Tue, 6 Aug 2019 02:13:06 -0400
Message-ID: <CAAa=b7eiG_rpjfL8c-dWjpxSf3XPJxJbcVPrE1W0_1j-9s1QEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wenwen Wang <wenwen@cs.uga.edu>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Fontana <rfontana@redhat.com>, Allison Randal <allison@lohutok.net>, Thomas Gleixner <tglx@linutronix.de>, "moderated list:SOUND" <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

In add_new_ctl(), a mixer element structure is allocated through kzalloc()
and the pointer is saved to 'elem'. Later on, a new alsa control element is
created and added to this structure. In case the add process fails, i.e.,
the return value of snd_usb_mixer_add_control() is less than 0, the
allocated structure is not freed, leading to a memory leak.

To fix the above issue, free 'elem' before returning the error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 sound/usb/mixer_scarlett.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/usb/mixer_scarlett.c b/sound/usb/mixer_scarlett.c
index 83715fd..a6c028a 100644
--- a/sound/usb/mixer_scarlett.c
+++ b/sound/usb/mixer_scarlett.c
@@ -562,8 +562,10 @@ static int add_new_ctl(struct usb_mixer_interface *mixer,
        strlcpy(kctl->id.name, name, sizeof(kctl->id.name));

        err = snd_usb_mixer_add_control(&elem->head, kctl);
-       if (err < 0)
+       if (err < 0) {
+               kfree(elem);
                return err;
+       }

        if (elem_ret)
                *elem_ret = elem;
--
2.7.4
