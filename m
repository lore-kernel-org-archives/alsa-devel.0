From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Start us224control via hotplug. was: Re: Tascam US-224 support
Date: Fri, 20 Feb 2004 00:40:32 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200402200040.33176.annabellesgarden@yahoo.de>
References: <20040216212352.GA566@tuba.home> <20040217214133.GC665@tuba.home> <s5h65e4wdxf.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h65e4wdxf.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, Martin Langer <martin-langer@gmx.de>
Cc: alsa-devel@lists.sourceforge.net, David <david@robot-droid.com>
List-Id: alsa-devel@alsa-project.org

this is a patch against /alsa-tools/usx2yloader/tascam_fpga.in:

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
+	CONTROLLER=@bindir@/us224control
+	;;
 *)
 	;;
 esac
<<<<<<

unfortunately this patch is only half of what it should be:
"us224control" is meant to be created from "ln -s us428control us224control"
how would we integrate this "ln -s us428control us224control" into Makefile.am 
? or should we just cp the symbolic link? but then: can you put the symbolic 
link created by "ln -s us428control us224control" into CVS?

if nobody knows, here is what works out of the box:

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

best regards, Karsten



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
