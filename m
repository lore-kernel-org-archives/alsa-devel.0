From: Pavel Roskin <proski@gnu.org>
Subject: Re: Breakage in alsa-driver/include/adriver.h on CVS
Date: Thu, 3 Oct 2002 11:25:55 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0210031122360.25863-100000@marabou.research.att.com>
References: <Pine.LNX.4.33.0210030920080.521-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0210030920080.521-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi, Jaroslav!

> Fixed. Thanks for this report.

One more thing.  This change is needed to compile alsa-drivers with Linux
2.4.20-pre8.  Function usb_audio_probe() itself has "struct usb_device",
but its declaration uses "usb_device" as the first argument.

Now alsa-drivers compiles for me again.

==============================
--- alsa-kernel/usb/usbaudio.c
+++ alsa-kernel/usb/usbaudio.c
@@ -1313,7 +1313,7 @@ static int usb_audio_probe(struct usb_in
 			   const struct usb_device_id *id);
 static void usb_audio_disconnect(struct usb_interface *intf);
 #else
-static void * usb_audio_probe(usb_device *dev, unsigned int ifnum,
+static void * usb_audio_probe(struct usb_device *dev, unsigned int ifnum,
 			      const struct usb_device_id *id);
 static void usb_audio_disconnect(struct usb_device *dev, void *ptr);
 #endif
==============================

-- 
Regards,
Pavel Roskin



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
