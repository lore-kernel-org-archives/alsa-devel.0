From: Martin Langer <martin-langer@gmx.de>
Subject: Re: 1.0.4rc from cvs-head: snd-usb-usx2y still needs snd-hwdep....
Date: Thu, 1 Apr 2004 20:34:14 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040401183414.GA576@tuba.home>
References: <200403310119.34195.annabellesgarden@yahoo.de> <Pine.LNX.4.58.0403310910110.1950@pnote.perex-int.cz> <20040331185719.GA9281@tuba.home> <200404011012.10249.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200404011012.10249.annabellesgarden@yahoo.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: alsa-devel@lists.sourceforge.net, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 01, 2004 at 10:12:10AM +0200, Karsten Wiese wrote:
> Am Mittwoch 31 März 2004 20:57 schrieb Martin Langer:
> Yes! rm every file in alsa-driver, re-update from cvs and ./cvscompile.
> There might be a simpler solution though...

Indeed. That solves it :) Thanks.

> >
> > depmod: *** Unresolved symbols in
> > /lib/modules/2.4.25-rc1/kernel/sound/usb/snd-usb-audio.o
> > depmod:         snd_rawmidi_transmit_peek
> > depmod:         snd_rawmidi_transmit_ack
> > depmod:         snd_rawmidi_transmit_empty
> > depmod:         snd_rawmidi_receive
> > depmod:         snd_rawmidi_new
> > depmod:         snd_rawmidi_set_ops
> didn't see this.
> 

It's still there, but this patch will fix it:

Index: alsa-driver/usb/Kconfig
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/Kconfig,v
retrieving revision 1.2
diff -u -r1.2 Kconfig
--- alsa-driver/usb/Kconfig	31 Mar 2004 06:57:28 -0000	1.2
+++ alsa-driver/usb/Kconfig	1 Apr 2004 18:14:09 -0000
@@ -4,11 +4,12 @@
 	depends on SND!=n && USB!=n
 
 config SND_USB_USX2Y
-	tristate "US-428 USB driver"
+	tristate "US-X2Y USB driver"
 	depends on SND && USB
 	select SND_HWDEP
+	select SND_RAWMIDI
 	select SND_PCM
 	help
-	  Say 'Y' or 'M' to include support for US-428 USB devices.
+	  Say 'Y' or 'M' to include support for Tascam US-X2Y USB devices.
 
 endmenu



BTW: I assume that alsa-driver/usb/usx2y/Kconfig can be removed.
alsa-driver/usb/Kconfig seems to be the correct file instead?


martin


-- 
                                     Living on earth may be expensive,
                   but it includes an annual free trip around the sun. 


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
