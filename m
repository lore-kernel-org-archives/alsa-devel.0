From: Martin Langer <martin-langer@gmx.de>
Subject: Re: Type in configure in alsa-driver
Date: Mon, 17 Mar 2003 14:08:02 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030317130801.GC530@tuba.home>
References: <3E75BC52.787B0B87@srr.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3E75BC52.787B0B87@srr.ro>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andrei Boros <andrei@srr.ro>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 17, 2003 at 02:15:14PM +0200, Andrei Boros wrote:
> 
> checking for kenrel linux/spinlock.h... yes
>              ^^^^^^

--- alsa-driver/configure.in.ORIGINAL	Mon Mar 17 14:01:44 2003
+++ alsa-driver/configure.in	Mon Mar 17 14:02:17 2003
@@ -151,7 +151,7 @@
 AC_MSG_RESULT($kaversion)
 
 AC_DEFUN(CHECK_KERNEL_HEADER, [
-  AC_MSG_CHECKING(for kenrel $1)
+  AC_MSG_CHECKING(for kernel $1)
   if test -f "$CONFIG_SND_KERNELDIR/include/$1"; then
     AC_MSG_RESULT("yes")
     if test -f include/$1; then



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
