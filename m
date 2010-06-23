From: Alexey Fisher <bug-track@fisher-privat.net>
Subject: [PATCH] Add volume resolution quirk for some logitech
	webcams
Date: Wed, 23 Jun 2010 11:34:47 +0200
Message-ID: <1277285687-10897-1-git-send-email-bug-track@fisher-privat.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 01489243E2
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jun 2010 11:35:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Cc: Alexey Fisher <bug-track@fisher-privat.net>
List-Id: alsa-devel@alsa-project.org

Some programs like Skype trying to set capture volume automatically.
Normally it will tray carefully, step by step lover or higher the volume.
In real word it work not really well, because devises and vendors lie
about real audio settings. For example most Logitech webcams
have 6400 or 3500 steps for capture volume. They do not tell that
actual resolution is 384. So we have only 7 or 18 real steps.
In this patch I set real resolution only for tested devices.

Signed-off-by: Alexey Fisher <bug-track@fisher-privat.net>
---
 sound/usb/mixer.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 6939d0f..fd9f377 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1107,6 +1107,18 @@ static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
 		}
 		break;
 
+	case USB_ID(0x046d, 0x0809):
+	case USB_ID(0x046d, 0x0991):
+	/* most audio usb divise lighe about volume resolution.
+	 * most of them have res = 384. Proboly there is some magick behind
+	 * this number. */
+		if (!strcmp(kctl->id.name, "Mic Capture Volume")) {
+			snd_printk(KERN_INFO
+				"set volume quirk: cval->res = 384\n");
+			cval->res = 384;
+		}
+		break;
+
 	}
 
 	snd_printdd(KERN_INFO "[%d] FU [%s] ch = %d, val = %d/%d/%d\n",
-- 
1.7.0.4
