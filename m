From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Test Patch6 for Conexant HD Audio.
Date: Thu, 26 Oct 2006 14:39:56 -0700
Message-ID: <1161898796.18211.126.camel@razman>
References: <20061026173031.GA899@creeper>
	<1161886425.18211.109.camel@razman> <20061026184505.GA16391@creeper>
	<20061026204423.GA31499@creeper>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-TE8CvvPa2M7bTXqQLdkG"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061026204423.GA31499@creeper>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Nick Fortune <nick@onepointsystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-TE8CvvPa2M7bTXqQLdkG
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I didn't email the alsa-driver patch that fixes that.  It was posted to
bugtrack #2485 earlier, and hasn't changed.  Here it is for
completeness.

Tobin

On Thu, 2006-10-26 at 21:44 +0100, Nick Fortune wrote:
> Bit more progress. First I downloaded a clean alsa-devel tarball to
> make sureit wasn't some gentoo patch casing the problem. The alsa
> tarball gave the same error.
> 
> So I copied alsa-kernel/pci/hda/patch_conexant.c to pci/hda/patch_conexant.o
> which then compiled. I have no idea if this makes sense, except that the 
> compilation worked.
> 
> When I tested it, I got no sound.
> 
> > # lspci -s 0:1b -vn
> > 00:1b.0 0403: 8086:27d8 (rev 02)
> >      Subsystem: 1179:ff31
> >      Flags: bus master, fast devsel, latency 0, IRQ 21
> >      Memory at b0000000 (64-bit, non-prefetchable) [size=16K]
> >      Capabilities: [50] Power Management version 2
> >      Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
> >      Capabilities: [70] Express Unknown type IRQ 0
> >      Capabilities: [100] Virtual Channel
> >      Capabilities: [130] Unknown (5)
> 
> Distro is Gentoo, Machine is a Tosh P100-240. 
> 
> On 19:45 Thu 26 Oct     , Nick Fortune wrote:
> > I get:
> > 
> > > make[5]: *** No rule to make target `/var/tmp/portage/media-sound/alsa-driver-1.0.13/work/alsa-driver-1.0.13/pci/hda/patch_conexant.o', needed by `/var/tmp/portage/media-sound/alsa-driver-1.0.13/work/alsa-driver-1.0.13/pci/hda/snd-hda-intel
> > 
> > I had a quick look at things and couldn't see anything obvious, but
> > I'm not realy familiar with the structure of the alsa project.
> > 
> > Could the file be in the wrong place?
> > 
> > On 11:13 Thu 26 Oct     , Tobin Davis wrote:
> > > I just looked over the patch and found that it was incomplete.  In
> > > reviewing my commandline history, I discovered that test6 didn't get the
> > > alsa-kernel base patch (it only had the patch_conexant.c code), required
> > > for building this code.
> > > 
> > > Here is the real test6 patch.  It should work against both the alsa HG
> > > tip and the alsa-driver-1.0.13.tar.bz2 download.  Earlier versions of
> > > alsa have not been compile tested.
> > > 
> > > Tobin
> > 
> > -- 
> > Don't let THEM immanentize the Eschaton!
> > 
> > -------------------------------------------------------------------------
> > Using Tomcat but need to do more? Need to support web services, security?
> > Get stuff done quickly with pre-integrated technology to make your job easier
> > Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> > http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 
-- 
Tobin Davis <tdavis@dsl-only.net>

--=-TE8CvvPa2M7bTXqQLdkG
Content-Disposition: attachment; filename=conexant-driver-test1.patch
Content-Type: text/x-patch; name=conexant-driver-test1.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- /dev/null	2006-09-13 00:29:45.000000000 -0700
+++ b/pci/hda/patch_conexant.c	2006-10-21 21:30:35.000000000 -0700
@@ -0,0 +1,2 @@
+#define __NO_VERSION__
+#include "../../alsa-kernel/pci/hda/patch_conexant.c"

--=-TE8CvvPa2M7bTXqQLdkG
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-TE8CvvPa2M7bTXqQLdkG
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-TE8CvvPa2M7bTXqQLdkG--
