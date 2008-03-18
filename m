From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: [PATCH] usbmidi.c: Call usb_autopm functions from
	rawmidi open/close callbacks
Date: Tue, 18 Mar 2008 15:05:46 +0100
Message-ID: <200803181505.46464.fzu@wemgehoertderstaat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 3622424477
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 15:05:53 +0100 (CET)
Received: by fk-out-0910.google.com with SMTP id f40so8395917fka.0
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 07:05:52 -0700 (PDT)
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


Lets "usb auto suspend" work for devices that set their
usb_driver::supports_autosuspend to 1.
Has no effect for other devices.

Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>
---
 sound/usb/usbmidi.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/usb/usbmidi.c b/sound/usb/usbmidi.c
index 6c616c7..842486f 100644
--- a/sound/usb/usbmidi.c
+++ b/sound/usb/usbmidi.c
@@ -860,11 +860,14 @@ static int snd_usbmidi_output_open(struct snd_rawmidi_substream *substream)
 	}
 	substream->runtime->private_data = port;
 	port->state = STATE_UNKNOWN;
+	usb_autopm_get_interface(umidi->iface);
 	return 0;
 }
 
 static int snd_usbmidi_output_close(struct snd_rawmidi_substream *substream)
 {
+	struct snd_usb_midi* umidi = substream->rmidi->private_data;
+	usb_autopm_put_interface(umidi->iface);
 	return 0;
 }
 
-- 
1.5.3.3


-------------------------------------------------------
