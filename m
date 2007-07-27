From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: [PATCH] snd_usb_caiaq_input_free() fix
Date: Fri, 27 Jul 2007 12:06:50 +0200
Message-ID: <200707271206.51137.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout1.freenet.de (mout1.freenet.de [195.4.92.91])
	by alsa0.perex.cz (Postfix) with ESMTP id 047E41037EF
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Jul 2007 12:06:39 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org


input_free_device()'s comment says:
input_free_device() should only be used if input_register_device() was
not called yet or if it failed. Once device was registered
use input_unregister_device() and memory will be freed once last
refrence to the device is dropped.

Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>
---


diff -pur rt9/sound/usb/caiaq/caiaq-input.c rt9-kw/sound/usb/caiaq/caiaq-input.c
--- rt9/sound/usb/caiaq/caiaq-input.c	2007-07-10 20:56:30.000000000 +0200
+++ rt9-kw/sound/usb/caiaq/caiaq-input.c	2007-07-27 11:45:52.000000000 +0200
@@ -238,7 +238,6 @@ void snd_usb_caiaq_input_free(struct snd
 		return;
 
 	input_unregister_device(dev->input_dev);
-	input_free_device(dev->input_dev);
 	dev->input_dev = NULL;
 }
