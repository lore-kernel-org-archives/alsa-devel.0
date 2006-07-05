From: Lee Revell <rlrevell@joe-job.com>
Subject: macro `AM_PATH_ALSA' not found in library
Date: Wed, 05 Jul 2006 15:24:19 -0400
Message-ID: <1152127459.15837.127.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I have a script that builds alsa-lib and alsa-utils for an embedded
platform.

It works perfectly on all my Ubuntu machines.  But when I try it on an
FC4 box, alsa-lib builds correctly, but alsa-utils fails like so:

config.status: executing depfiles commands
cd . && /bin/sh /home/lee/perforce/Alchemy/ppc/linux/rootfs/filesystem/packages/alsa-utils-1.0.11/missing --run aclocal-1.9 -I m4
aclocal:configure.in:30: warning: macro `AM_PATH_ALSA' not found in library
 cd . && /bin/sh /home/lee/perforce/Alchemy/ppc/linux/rootfs/filesystem/packages/alsa-utils-1.0.11/missing --run automake-1.9 --foreign
cd . && /bin/sh /home/lee/perforce/Alchemy/ppc/linux/rootfs/filesystem/packages/alsa-utils-1.0.11/missing --run autoconf
configure.in:30: error: possibly undefined macro: AM_PATH_ALSA
      If this token and others are legitimate, please use m4_pattern_allow.
      See the Autoconf documentation.
make: *** [configure] Error 1

What is AM_PATH_ALSA?  How can I make it work?

Lee


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
