From: Wenwen Wang <wenwen@cs.uga.edu>
Subject: [PATCH] ALSA: usb-audio: fix a memory leak bug
Date: Tue, 6 Aug 2019 03:00:27 -0400
Message-ID: <CAAa=b7f=SG6QR248JD9_VP89B=D2p3pdYcSAzRLchbJTpdXt_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wenwen Wang <wenwen@cs.uga.edu>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shuah Khan <shuah@kernel.org>, Richard Fontana <rfontana@redhat.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, Thomas Gleixner <tglx@linutronix.de>, "moderated list:SOUND" <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

In snd_usb_get_audioformat_uac3(), a structure for channel maps 'chmap' is
allocated through kzalloc() before the execution goto 'found_clock'.
However, this structure is not deallocated if the memory allocation for
'pd' fails, leading to a memory leak bug.

To fix the above issue, free 'fp->chmap' before returning NULL.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 sound/usb/stream.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 7ee9d17..e852c7f 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -1043,6 +1043,7 @@ snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,

                pd = kzalloc(sizeof(*pd), GFP_KERNEL);
                if (!pd) {
+                       kfree(fp->chmap);
                        kfree(fp->rate_table);
                        kfree(fp);
                        return NULL;
--
2.7.4
