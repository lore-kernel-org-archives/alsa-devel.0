From: Michael Slade <mslade@knobbits.org>
Subject: [PATCH] Support for Yamaha MOXF
Date: Thu, 09 Jan 2014 16:09:10 +1100
Message-ID: <52CE2EF6.7010902@knobbits.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030904080801070806080500"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from killface.knobbits.org (killface.knobbits.org [67.18.208.22])
 by alsa0.perex.cz (Postfix) with ESMTP id D724E2651E7
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 06:09:14 +0100 (CET)
Received: from [10.77.83.4] (82.92.233.220.static.exetel.com.au
 [220.233.92.82])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by killface.knobbits.org (Postfix) with ESMTPSA id 58AC93C243
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 16:09:12 +1100 (EST)
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
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030904080801070806080500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

My apologies if I'm doing this wrong.

I have managed to get a Yamaha MOXF8 working with the attached patch.  
Presumably also works with a MOXF6.

The new Yamaha MOXF6/8 are successors to the MOX6/8.  Apart from things 
like new voices, a flash expansion port, and a different colour at the 
ends, they are pretty much identical in operation.

The MOXF has a USB ID of 0499:150f.  So I needed to add a new 
quirks-table.h stanza for it, by copy-pasting the MOX one and changing 
he ID.

I haven't tested it to death or anything,  but I am having no trouble 
recording and playing audio and midi.

Let me know if this patch is acceptable or of there is more that is 
needed from me.

Note, this patch is against Ubuntu Raring's 3.8.0 kernel, but it's a 
trivial patch.

Mick.


--------------030904080801070806080500
Content-Type: text/x-patch;
 name="alsa-yamaha-moxf.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="alsa-yamaha-moxf.patch"

--- linux-3.8.0.orig/sound/usb/quirks-table.h
+++ linux-3.8.0/sound/usb/quirks-table.h
@@ -353,6 +359,32 @@
 		}
 	}
 },
+{
+	USB_DEVICE(0x0499, 0x150f),
+	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+		/* .vendor_name = "Yamaha", */
+		/* .product_name = "MOXF6/MOXF8", */
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = (const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 1,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE
+			},
+			{
+				.ifnum = 2,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE
+			},
+			{
+				.ifnum = 3,
+				.type = QUIRK_MIDI_YAMAHA
+			},
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},
 YAMAHA_DEVICE(0x2000, "DGP-7"),
 YAMAHA_DEVICE(0x2001, "DGP-5"),
 YAMAHA_DEVICE(0x2002, NULL),

--------------030904080801070806080500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030904080801070806080500--
