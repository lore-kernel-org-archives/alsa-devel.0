From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA, and building the Linux kernel outside its
 source tree...
Date: Fri, 15 Oct 2004 15:15:10 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0410151513540.28430-100000@studcom.urz.uni-halle.de>
References: <s5h7jptgx09.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5h7jptgx09.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> I didn't test the patch for 2.2/2.4 kernels.  It would be appreciated
> if anyone can test it on older kernels.

Works.


Clemens


--- alsa-driver/configure.in.org	Fri Oct 15 14:32:18 2004
+++ alsa-driver/configure.in	Fri Oct 15 14:34:37 2004
@@ -78,10 +78,10 @@
   kerneldir="$DEFAULT_KERNEL_DIR"
 )
 CONFIG_SND_KERNELDIR="$kerneldir"
+AC_MSG_RESULT($kerneldir)

 dnl Check for directory with kernel build tree...
 AC_MSG_CHECKING(for directory with kernel build)
-AC_MSG_RESULT($kerneldir)
 AC_ARG_WITH(build,
   [  --with-build=dir        give the directory with kernel build tree],
   kernelbuild="$withval",
@@ -111,7 +111,7 @@
 HACK_KERNEL_INC=""
 ac_save_CFLAGS="$CFLAGS"
 CFLAGS="$CFLAGS $KERNEL_INC $HACK_KERNEL_INC"
-if test -n "$kernelbuild" - a -f $kernelbuild/include/linux/version.h; then
+if test -n "$kernelbuild" -a -f $kernelbuild/include/linux/version.h; then
   KERNDIR=$kernelbuild
 else
   KERNDIR=$CONFIG_SND_KERNELDIR



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
