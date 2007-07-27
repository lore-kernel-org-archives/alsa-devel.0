From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: [PATCH] snd_usb_caiaq_input_free() fix
Date: Fri, 27 Jul 2007 12:12:24 +0200
Message-ID: <200707271212.24219.fzu@wemgehoertderstaat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout0.freenet.de (mout0.freenet.de [195.4.92.90])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F28B103800
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Jul 2007 12:12:16 +0200 (CEST)
Received: from [195.4.92.13] (helo=mx3.freenet.de)
	by mout0.freenet.de with esmtpa (Exim 4.68-dev)
	(envelope-from <fzu@wemgehoertderstaat.de>) id 1IEMnw-00070Y-Je
	for alsa-devel@alsa-project.org; Fri, 27 Jul 2007 12:12:16 +0200
Received: from p5b10a662.dip0.t-ipconnect.de ([91.16.166.98]:32834
	helo=[10.130.108.11])
	by mx3.freenet.de with esmtpa (ID fzu@wemgehoertderstaat.de) (port 25)
	(Exim 4.68 #1) id 1IEMnv-0003WG-Io
	for alsa-devel@alsa-project.org; Fri, 27 Jul 2007 12:12:15 +0200
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
To: alsa-devel@alsa-project.org
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
