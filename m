From: Martin Langer <martin-langer@gmx.de>
Subject: Re: [PATCH]against cvs: us122 support in snd-usb-us428
Date: Mon, 24 Nov 2003 23:14:02 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031124221402.GA7740@tuba.home>
References: <200311241437.52170.annabellesgarden@yahoo.de> <200311242150.32867.ws@seh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200311242150.32867.ws@seh.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Werner Schweer <ws@seh.de>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 24, 2003 at 09:50:32PM +0100, Werner Schweer wrote:
> On Monday 24 November 2003 14:37, Karsten Wiese wrote:
> > Hi,
> >
> > would you please give this a try an your us122s?
> > I integrated Martins stuff into mine. us428 still works here.
> > besides patching you'll need to copy the attached header into
> > alsa-driver/usb/us428.
> > you'll probaply also still need Martin's patched usx2yloader &
> > infrastructure files.
> 
> it works! Tested with US-122: audio recording/play, midi play
> 

Same here. No problems. Everything works fine.
And this fix will show the correct USB ID in /proc/asound/cards in the future.

Thanks!
martin


--- usbus428.c.ORIGINAL	Mon Nov 24 22:51:07 2003
+++ usbus428.c	Mon Nov 24 22:41:17 2003
@@ -255,7 +255,7 @@
 	sprintf(card->shortname, "TASCAM "NAME_ALLCAPS"");
 	sprintf(card->longname, "%s (%x:%x if %d at %03d/%03d)",
 		card->shortname, 
-		snd_usX2Y_usb_id_table[0].idVendor, snd_usX2Y_usb_id_table[0].idProduct,
+		device->descriptor.idVendor, device->descriptor.idProduct,
 		0,//us428(card)->usbmidi.ifnum,
 		usX2Y(card)->chip.dev->bus->busnum, usX2Y(card)->chip.dev->devnum
 		);


-- 
The only nice thing about spam is that it doesn't ring.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
