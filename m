From: Vladimir Dergachev <volodya@mindspring.com>
Subject: Re: 1.0.2 release
Date: Tue, 27 Jan 2004 17:50:20 -0500 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401271746440.23461@node2.localnet.net>
References: <Pine.LNX.4.58.0401271049310.3133@pnote.perex-int.cz>
Reply-To: Vladimir Dergachev <volodya@mindspring.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from barry.mail.mindspring.net (barry.mail.mindspring.net [207.69.200.25])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id BAA24390
	for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2004 01:25:52 +0100
In-Reply-To: <Pine.LNX.4.58.0401271049310.3133@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


 I am having problem compiling it against 2.6.2-rc1 linux kernel.

Basically, after configure, make only patches some files and does not
compile any modules so that make install produces:

make[1]: Entering directory `/home/volodya/alsa-driver-1.0.2/acore'
mkdir -p /lib/modules/2.6.2-rc1/kernel/sound/acore
cp snd-page-alloc.ko snd-pcm.ko snd-rtctimer.ko snd-timer.ko snd.ko
/lib/modules/2.6.2-rc1/kernel/sound/acore
cp: cannot stat `snd-page-alloc.ko': No such file or directory
cp: cannot stat `snd-pcm.ko': No such file or directory
cp: cannot stat `snd-rtctimer.ko': No such file or directory
cp: cannot stat `snd-timer.ko': No such file or directory
cp: cannot stat `snd.ko': No such file or directory
make[1]: *** [modules_install] Error 1
make[1]: Leaving directory `/home/volodya/alsa-driver-1.0.2/acore'
make: *** [install-modules] Error 1

I just alsa-driver-1.0.0-rc2 and it works fine.

                     best

                         Vladimir Dergachev
PS The configure command used was
./configure --with-sequencer=yes --with-oss=yes --with-cards=intel8x0m



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
