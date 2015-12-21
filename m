From: Geliang Tang <geliangtang@163.com>
Subject: [PATCH] ALSA: usb-audio: use list_for_each_entry_continue_reverse
Date: Mon, 21 Dec 2015 23:55:39 +0800
Message-ID: <fea57694a17b8001b53896f657ffccf5128ee4c3.1450713219.git.geliangtang@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Ricard Wanderlof <ricard.wanderlof@axis.com>, =?UTF-8?q?Johan=20Rast=C3=A9n?= <johan@oljud.se>
Cc: Geliang Tang <geliangtang@163.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

For better readability, use list_for_each_entry_continue_reverse()
in have_dup_chmap().

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 sound/usb/stream.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 8ee14f2..c4dc577 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -125,11 +125,9 @@ static int usb_chmap_ctl_info(struct snd_kcontrol *kcontrol,
 static bool have_dup_chmap(struct snd_usb_substream *subs,
 			   struct audioformat *fp)
 {
-	struct list_head *p;
+	struct audioformat *prev = fp;
 
-	for (p = fp->list.prev; p != &subs->fmt_list; p = p->prev) {
-		struct audioformat *prev;
-		prev = list_entry(p, struct audioformat, list);
+	list_for_each_entry_continue_reverse(prev, &subs->fmt_list, list) {
 		if (prev->chmap &&
 		    !memcmp(prev->chmap, fp->chmap, sizeof(*fp->chmap)))
 			return true;
-- 
2.5.0
