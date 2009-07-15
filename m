From: Subrata Modak <subrata@linux.vnet.ibm.com>
Subject: [PATCH 06/06] Fix compilation warning for sound/drivers/serial/u16550.c
Date: Wed, 15 Jul 2009 07:51:28 +0530
Message-ID: <20090715022125.4481.17259.sendpatchset@subratamodak.linux.ibm.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751768AbZGOCVs@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Isaku Yamahata <yamahata@private.email.ne.jp>, Jaroslav Kysela <perex@perex.cz>, George Hansper <ghansper@apana.org.au>
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>, David Howells <dhowells@redhat.com>, Subrata Modak <subrata@linux.vnet.ibm.com>, Balbir Singh <balbir@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Following fix is inspired by David Howells fix few days back:
http://lkml.org/lkml/2009/7/9/109,

Signed-off-by: Subrata Modak<subrata@linux.vnet.ibm.com>,
---

--- a/sound/drivers/serial-u16550.c	2009-05-20 10:48:23.000000000 +0530
+++ b/sound/drivers/serial-u16550.c	2009-07-15 06:46:48.000000000 +0530
@@ -902,7 +902,7 @@ static int __devinit snd_uart16550_rmidi
 static int __devinit snd_serial_probe(struct platform_device *devptr)
 {
 	struct snd_card *card;
-	struct snd_uart16550 *uart;
+	struct snd_uart16550 *uninitialized_var(uart);
 	int err;
 	int dev = devptr->id;
 

---
Regards--
Subrata
