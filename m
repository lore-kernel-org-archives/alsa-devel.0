From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: Start us224control via hotplug. was: Re: Tascam US-224 support
Date: Mon, 23 Feb 2004 16:49:01 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200402231649.01896.annabellesgarden@yahoo.de>
References: <20040216212352.GA566@tuba.home> <200402200040.33176.annabellesgarden@yahoo.de> <s5hfzd6uisc.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hfzd6uisc.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Martin Langer <martin-langer@gmx.de>, alsa-devel@lists.sourceforge.net, David <david@robot-droid.com>
List-Id: alsa-devel@alsa-project.org

Am Freitag, 20. Februar 2004 11:50 schrieb Takashi Iwai:
> At Fri, 20 Feb 2004 00:40:32 +0100,
>
> Karsten Wiese wrote:
> > this is a patch against /alsa-tools/usx2yloader/tascam_fpga.in:
> >
> >
> > Index: tascam_fpga.in
> > ===================================================================
> > RCS file: /cvsroot/alsa/alsa-tools/usx2yloader/tascam_fpga.in,v
> > retrieving revision 1.4
> > diff -u -r1.4 tascam_fpga.in
> > --- tascam_fpga.in	19 Jan 2004 18:49:21 -0000	1.4
> > +++ tascam_fpga.in	19 Feb 2004 22:16:04 -0000
> > @@ -23,6 +23,9 @@
> >  1604/8001/*)
> >  	CONTROLLER=@bindir@/us428control
> >  	;;
> > +1604/8005/*)
> > +	CONTROLLER=@bindir@/us224control
> > +	;;
> >  *)
> >  	;;
> >  esac
> > <<<<<<
> >
> > unfortunately this patch is only half of what it should be:
> > "us224control" is meant to be created from "ln -s us428control
> > us224control"
>
> is it necessary for performance except for the sane naming?
> for example, in the case of aplay/arecord, both of them are the same
> binary but perform differently according to the executed name.
> if it's not the case, i'd like to keep the same name.
sane naming only so far.

>
> > how would we integrate this "ln -s us428control us224control" into
> > Makefile.am ? or should we just cp the symbolic link? but then: can you
> > put the symbolic link created by "ln -s us428control us224control" into
> > CVS?
> >
> > if nobody knows, here is what works out of the box:
> >
> >
> > Index: tascam_fpga.in
> > ===================================================================
> > RCS file: /cvsroot/alsa/alsa-tools/usx2yloader/tascam_fpga.in,v
> > retrieving revision 1.4
> > diff -u -r1.4 tascam_fpga.in
> > --- tascam_fpga.in	19 Jan 2004 18:49:21 -0000	1.4
> > +++ tascam_fpga.in	19 Feb 2004 22:16:04 -0000
> > @@ -23,6 +23,9 @@
> >  1604/8001/*)
> >  	CONTROLLER=@bindir@/us428control
> >  	;;
> > +1604/8005/*)
> > +	CONTROLLER=@bindir@/us428control
> > +	;;
> >  *)
> >  	;;
> >  esac
>
> that's fine.

please commit the 'fine' version:

>>>>>>
Index: tascam_fpga.in
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/usx2yloader/tascam_fpga.in,v
retrieving revision 1.4
diff -u -r1.4 tascam_fpga.in
--- tascam_fpga.in	19 Jan 2004 18:49:21 -0000	1.4
+++ tascam_fpga.in	19 Feb 2004 22:16:04 -0000
@@ -23,6 +23,9 @@
 1604/8001/*)
 	CONTROLLER=@bindir@/us428control
 	;;
+1604/8005/*)
+	CONTROLLER=@bindir@/us428control
+	;;
 *)
 	;;
 esac
<<<<<<

thanks,
Karsten


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
