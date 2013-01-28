From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH 4/6] sound/usb/caiaq/device.c: fix use of
	MODULE_SUPPORTED_DEVICES()
Date: Mon, 28 Jan 2013 23:42:30 +0100
Message-ID: <1359412952-1680-5-git-send-email-ospite@studenti.unina.it>
References: <1359412952-1680-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp208.alice.it (smtp208.alice.it [82.57.200.104])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D6BB265CA5
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2013 23:44:07 +0100 (CET)
In-Reply-To: <1359412952-1680-1-git-send-email-ospite@studenti.unina.it>
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
Cc: Takashi Iwai <tiwai@suse.de>, Michael Trimarchi <michael@amarulasolutions.com>, Antonio Ospite <ao2@amarulasolutions.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Antonio Ospite <ao2@amarulasolutions.com>

It looks like MODULE_SUPPORTED_DEVICES() is not implemented yet, but
still, having the entries in the list consistently separated by commas
and with balanced parenthesis won't hurt.

Signed-off-by: Antonio Ospite <ao2@amarulasolutions.com>
---
 sound/usb/caiaq/device.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
index c828f81..e4d6dbb 100644
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -48,10 +48,10 @@ MODULE_SUPPORTED_DEVICE("{{Native Instruments, RigKontrol2},"
 			 "{Native Instruments, Audio 8 DJ},"
 			 "{Native Instruments, Traktor Audio 2},"
 			 "{Native Instruments, Session I/O},"
-			 "{Native Instruments, GuitarRig mobile}"
-			 "{Native Instruments, Traktor Kontrol X1}"
-			 "{Native Instruments, Traktor Kontrol S4}"
-			 "{Native Instruments, Maschine Controller}");
+			 "{Native Instruments, GuitarRig mobile},"
+			 "{Native Instruments, Traktor Kontrol X1},"
+			 "{Native Instruments, Traktor Kontrol S4},"
+			 "{Native Instruments, Maschine Controller}}");
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX; /* Index 0-max */
 static char* id[SNDRV_CARDS] = SNDRV_DEFAULT_STR; /* Id for this card */
-- 
1.7.10.4
