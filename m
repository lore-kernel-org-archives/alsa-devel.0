From: "Michael T. Sullivan" <M.T.Sullivan@rcn.com>
Subject: [PATCH] alsa-driver-1.0.1/configure.in
Date: Fri, 09 Jan 2004 09:30:05 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FFEC8FD.4060800@rcn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Running configure on Red Hat 9 yields the error:

./configure: line 3856: test: too many arguments

The configure continues, but the resulting build fails to load module
kernel/sound/snd.o due to an undefined symbol. The fix is trivial:

--- alsa-driver-1.0.1/configure.in.orig	2004-01-08 08:15:55.000000000 -0600
+++ alsa-driver-1.0.1/configure.in	2004-01-09 03:54:29.000000000 -0600
@@ -407,7 +407,7 @@
  CHECK_KERNEL_HEADER(linux/workqueue.h)
  if test ! -f include/linux/workqueue.h; then
    if test "x$kversion.$kpatchlevel" = "x2.4" -a \
-     test "x$RED_HAT_LINUX_KERNEL" = "xy"; then
+          "x$RED_HAT_LINUX_KERNEL" = "xy"; then
      echo "It looks like you're using a RedHat 9 kernel."
      echo "Disabling their incomplete workqueue.h modification."
      mkdir -p include/linux



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
