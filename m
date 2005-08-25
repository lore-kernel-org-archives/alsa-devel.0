From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: emagic MT4
Date: Thu, 25 Aug 2005 13:56:29 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0508251354300.26149-100000@studcom.urz.uni-halle.de>
References: <bfab11eb050824042734530530@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <bfab11eb050824042734530530@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: samroig@punkass.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Sam Roig wrote:
> Hi, Clemens. Here's the output:
>
> 90 3C 2C
> FF
>    64 7B
> ...

The driver didn't correctly handle the Emagic protocol.

A fix is now in CVS, or use the patch below.


HTH
Clemens

-- 
Index: alsa/alsa-kernel/usb/usbmidi.c
===================================================================
--- alsa.orig/alsa-kernel/usb/usbmidi.c	2005-08-15 20:48:25.000000000 +0200
+++ alsa/alsa-kernel/usb/usbmidi.c	2005-08-24 22:52:12.000000000 +0200
@@ -641,17 +641,20 @@ static void snd_usbmidi_emagic_finish_ou
 static void snd_usbmidi_emagic_input(snd_usb_midi_in_endpoint_t* ep,
 				     uint8_t* buffer, int buffer_length)
 {
-	/* ignore padding bytes at end of buffer */
-	while (buffer_length > 0 && buffer[buffer_length - 1] == 0xff)
-		--buffer_length;
+	int i;
+
+	/* FF indicates end of valid data */
+	for (i = 0; i < buffer_length; ++i)
+		if (buffer[i] == 0xff) {
+			buffer_length = i;
+			break;
+		}

 	/* handle F5 at end of last buffer */
 	if (ep->seen_f5)
 		goto switch_port;

 	while (buffer_length > 0) {
-		int i;
-
 		/* determine size of data until next F5 */
 		for (i = 0; i < buffer_length; ++i)
 			if (buffer[i] == 0xf5)
@@ -718,6 +721,10 @@ static void snd_usbmidi_emagic_output(sn
 				break;
 		}
 	}
+	if (buf_free < ep->max_transfer && buf_free > 0) {
+		*buf = 0xff;
+		--buf_free;
+	}
 	ep->urb->transfer_buffer_length = ep->max_transfer - buf_free;
 }




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
