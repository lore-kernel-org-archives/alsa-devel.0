From: Clemens Ladisch <clemens@ladisch.de>
Subject: CONFIG_SND_RTC and CONFIG_SND_RTCTIMER and CONFIG_RTC, oh my!
Date: Tue, 14 May 2002 10:49:22 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CE0CF92.F5CFFB38@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mlucom8.urz.Uni-Halle.DE [141.48.10.118] (may be forged))
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA22362
	for <alsa-devel@alsa-project.org>; Tue, 14 May 2002 10:49:33 +0200
Received: from mserv1.urz.uni-halle.de ([141.48.3.145] helo=mserv1)
	  by mailgate.uni-halle.de with esmtp (EXIM Version 3.35)
	  for <alsa-devel@alsa-project.org>
	  id 177Xzr-00070Z-00; Tue, 14 May 2002 10:49:27 +0200
Received: from conversion-daemon.mail.uni-halle.de by mail.uni-halle.de
 (iPlanet Messaging Server 5.2 (built Feb 21 2002))
 id <0GW300E01EMWXA@mail.uni-halle.de> for alsa-devel@alsa-project.org; Tue,
 14 May 2002 10:49:27 +0200 (MEST)
Received: from studcom.urz.uni-halle.de
 (studcom.urz.Uni-Halle.DE [141.48.3.19]) by mail.uni-halle.de
 (iPlanet Messaging Server 5.2 (built Feb 21 2002))
 with ESMTP id <0GW300DBGF6FG2@mail.uni-halle.de> for
 alsa-devel@alsa-project.org; Tue, 14 May 2002 10:49:27 +0200 (MEST)
Received: from ladisch.de (ifiu23.informatik.Uni-Halle.DE [141.48.14.23])
	by studcom.urz.uni-halle.de (8.9.3 (PHNE_22672)/8.9.3)
 with ESMTP id KAA06962	for <alsa-devel@alsa-project.org>; Tue,
 14 May 2002 10:49:22 +0200 (METDST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I tried to use the RTC callback timer with my 2.4.12 kernel.
Patching the kernel went fine, but then ALSA wouldn't compile the
snd-rtctimer.o module, although configure said:
| checking for RTC callback support in kernel ... "yes"

A glance at alsa-kernel/core/Makefile shows that both CONFIG_RTC and
CONFIG_SND_RTCTIMER need to be defined:

	ifeq ($(subst m,y,$(CONFIG_RTC)),y)
	  obj-$(CONFIG_SND_RTCTIMER) += snd-timer.o
	  obj-$(CONFIG_SND_RTCTIMER) += snd-rtctimer.o
	endif

... but neither appears in alsa-driver/Makefile.conf, apparently
because configure thinks it should define CONFIG_SND_RTC instead:

alsa-driver/configure.in:
	...
	rtcsup="0"
	...
	  AC_MSG_RESULT("yes");rtcsup="m",
	  AC_MSG_RESULT("no");rtcsup="n",
	  AC_MSG_RESULT("unknown");rtcsup="n"
	...
	CONFIG_SND_RTC=$rtcsup
	AC_SUBST(CONFIG_SND_RTC)
	if test "$CONFIG_SND_RTC" = "1"; then
	  AC_DEFINE(CONFIG_SND_RTC)
	fi

Additionally, it's unclear whether the value of CONFIG_SND_RTC should
be 0/1 or n/m.


Sorry, no patch because I'm lacking the autoconf knowledge for this.
(I got it to compile (and run) by hacking the makefile, but I won't
submit _this_ change. :-)


Clemens

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
