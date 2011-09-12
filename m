From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 2/4] ALSA: snd-usb: re-order the Makefile
Date: Mon, 12 Sep 2011 18:54:11 +0200
Message-ID: <1315846453-5036-3-git-send-email-zonque@gmail.com>
References: <1315846453-5036-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (unknown [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id 78FD3244CE
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Sep 2011 18:53:55 +0200 (CEST)
In-Reply-To: <1315846453-5036-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Sort its entries in alphabetical order.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>
---
 sound/usb/Makefile |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/usb/Makefile b/sound/usb/Makefile
index cf9ed66..083501e 100644
--- a/sound/usb/Makefile
+++ b/sound/usb/Makefile
@@ -3,16 +3,16 @@
 #
 
 snd-usb-audio-objs := 	card.o \
+			clock.o \
+			endpoint.o \
+			format.o \
+			helper.o \
 			mixer.o \
 			mixer_quirks.o \
+			pcm.o \
 			proc.o \
 			quirks.o \
-			format.o \
-			endpoint.o \
-			urb.o \
-			pcm.o \
-			helper.o \
-			clock.o
+			urb.o
 
 snd-usbmidi-lib-objs := midi.o
 
-- 
1.7.5.4
