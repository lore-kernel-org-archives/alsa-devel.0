From: Georgi Georgiev <chutz@gg3.net>
Subject: snd-ioctl32 is failing on x86_64 (no crashes, just errors)
Date: Thu, 6 Jan 2005 22:06:50 +0900
Message-ID: <20050106130649.GA253131@lion.gg3.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from tiger.gg3.net (142.13.111.219.st.bbexcite.jp [219.111.13.142])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id AC460255
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2005 14:06:53 +0100 (MET)
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Running a 32-bit version of any application fails with:

amixer: Mixer hw:0 load error: Invalid argument

for example. I have snd-ioctl32 loaded properly (lsmod shows it).

Kernel is vanilla 2.6.10 and I just tried it with version 1.0.8rc2 of
alsa-driver. Also, alsa-lib and alsa-utils version 1.0.8rc2 are
installed in my 64-bit environment, and also in the 32-bit chroot env
where I am trying to run amixer from. The distro is Gentoo, and I also
have their alsa-headers-1.0.8_rc2 installed in the 32-bit chroot.

-- 
\/   Georgi Georgiev   \/  Professor: Doomsday device? Ah, now the     \/
/\    chutz@gg3.net    /\ ball's in Farnsworth's court. I suppose I    /\
\/  +81(90)6266-1163   \/ could part with one and still be feared.     \/


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
