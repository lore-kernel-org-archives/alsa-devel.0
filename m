From: Jaroslav Kysela <perex@suse.cz>
Subject: 2.5 kbuild: use of '-z muldefs' for LD?
Date: Mon, 9 Jun 2003 13:56:59 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306091342400.1323-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (UNKNOWN@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA05566
	for <alsa-devel@alsa-project.org>; Mon, 9 Jun 2003 13:57:11 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: LKML <linux-kernel@vger.kernel.org>
Cc: ALSA development <alsa-devel@alsa-project.org>, kbuild-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello all,

	I am trying to figure the best solution for our problem. We reuse
one object file for more targets. Example:

------
snd-ice1712-objs := ice1712.o delta.o hoontech.o ews.o ak4xxx.o
snd-ice1724-objs := ice1724.o amp.o revo.o aureon.o ak4xxx.o

# Toplevel Module Dependency
obj-$(CONFIG_SND_ICE1712) += snd-ice1712.o
obj-$(CONFIG_SND_ICE1724) += snd-ice1724.o
------

The ak4xxx.o module is shared and has defined a few public functions.
Unfortunately, the default build-in.o rule fails when targets are 
requested to be included into the solid kernel because the public 
functions are duplicated in snd-ice1712.o and snd-ice17124.o.

I can instruct the ld compiler to ignore the multiple definitions using 
'-z muldefs':

EXTRA_LDFLAGS = -z muldefs

But it seems like a hack for me.
Does anybody have another idea to solve my problem?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
