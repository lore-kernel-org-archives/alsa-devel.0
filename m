From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: HDSP driver update
Date: 08 Apr 2003 11:15:25 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1049793324.1344.57.camel@satellite.undata.org>
References: <E192VvZ-0000Px-00@dardilly>
	 <1049720707.1447.3.camel@satellite.undata.org>
	 <s5hvfxqqpnz.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-6uA2jqRtGIFbwjQhSCt5"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hvfxqqpnz.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Paul Davis <paul@linuxaudiosystems.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-6uA2jqRtGIFbwjQhSCt5
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> i committed the new driver and hdsploader to cvs tree right now.
> i had to fix the compilation error in hdsp.c because of the last
> change of control interface (inside the kernel).
> 
Thanks

> the two issues still pending:
> 
> 1. hdspconf is still not merged yet to cvs, because it's written in
>    C++ and fltk.  i'm not sure whether we should put it into the same
>    tree.  IMO, it's ok - we already have envy24control with gtk.
> 
>    so, if no one has objection, i'll try to put to alsa-tools, too.
> 
Just FYI the upcoming hdspmixer you wanted to include too is also
C++/fltk.

> 
> 2. the change of control interface above would make the access to a
>    matrix mixer over the standard control API much easier without
>    using the non-official indirect accessing.
> 
>    could you try to port the driver to use that feature?
> 
> 
Of course.

The attached patch fixes a problem with hwdep interface creation in the
case a firmware is detected at boot time.

Thomas


--=-6uA2jqRtGIFbwjQhSCt5
Content-Disposition: attachment; filename=hdsp_hwdep_create.patch
Content-Type: text/plain; name=hdsp_hwdep_create.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- hdsp.c.old	2003-04-07 17:32:36.000000000 +0200
+++ hdsp.c	2003-04-08 11:05:22.000000000 +0200
@@ -4116,6 +4116,10 @@
 			hdsp->io_type = Digiface;
 		}
 		
+		if ((err = snd_hdsp_create_hwdep(card, hdsp)) < 0) {
+			return err;
+		}
+		
 		snd_hdsp_initialize_channels(hdsp);
 		
 		snd_hdsp_initialize_midi_flush(hdsp);

--=-6uA2jqRtGIFbwjQhSCt5--



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
