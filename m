From: Eliot Blennerhassett <linux@blennerhassett.gen.nz>
Subject: Re: build failures in asihpi (was: ALSA 1.0.12rc1
	release)
Date: Mon, 10 Jul 2006 13:31:33 +1200
Message-ID: <200607101331.34321.linux@blennerhassett.gen.nz>
References: <Pine.LNX.4.61.0606231231370.10283@tm8103-a.perex-int.cz>
	<20060702123404.GI5158@neu.nirvana>
	<200607101021.35954.linux@blennerhassett.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200607101021.35954.linux@blennerhassett.gen.nz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: ATrpms development list <atrpms-devel@ATrpms.net>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 10 Jul 2006 10:21, Eliot Blennerhassett wrote:
> I'm not sure what the problem with asihpi is, but the short term answer is
> to fix the Kconfig or other part of build system to force it not to be
> built for X86_64.

Seems that the alsa-driver configure script does not set CONFIG_X86_64=y

Bug and patch submitted 
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2267

Summary: correct config for x86_64
Drivers that depended on (! x86_64) were not being disabled

Signed off by: Eliot Blennerhassett <eblennerhassett@audioscience.com>

diff -r e381a75adf4c configure.in
--- a/configure.in      Thu Jul 06 15:13:52 2006 +0200
+++ b/configure.in      Mon Jul 10 13:15:33 2006 +1200
@@ -1093,6 +1093,7 @@ EOF
     c_opts="-mno-red-zone -mcmodel=kernel -fno-reorder-blocks 
-fno-strength-reduce -finline-limit=2000"
     CONFIG_SND_BIT32_EMUL=m
     CONFIG_X86=y
+    CONFIG_X86_64=y
     test "$CONFIG_ISA" = "probe" && CONFIG_ISA=
     ;;
   sa1100)


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
