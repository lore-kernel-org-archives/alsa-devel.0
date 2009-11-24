From: Eliot Blennerhassett <linux@audioscience.com>
Subject: USB patch failures alsa-driver git
Date: Tue, 24 Nov 2009 14:29:21 +1300
Message-ID: <4B0B36F1.1010702@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 2ACD5103820
	for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2009 02:29:50 +0100 (CET)
Received: from [192.168.1.82]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0KTL0061EAT3E300@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Tue, 24 Nov 2009 14:29:38 +1300 (NZDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Greetings,

trying to build alsa-driver, I get the following patch failures???
Maybe recent alsa-kernel usb changes have broken the patches in alsa-driver?
(for now, I get around the problem by copying the original files instead
of patching)

uname -a
Linux 2.6.28-16-generic #55-Ubuntu SMP Tue Oct 20 19:48:24 UTC 2009 i686
GNU/Linux


copying file alsa-kernel/usb/usbmidi.c
patching file usbmidi.c
Hunk #2 succeeded at 245 (offset 8 lines).
Hunk #3 FAILED at 269.
Hunk #4 FAILED at 392.
Hunk #5 succeeded at 1699 (offset 97 lines).
Hunk #6 succeeded at 2070 (offset 102 lines).
2 out of 6 hunks FAILED -- saving rejects to file usbmidi.c.rej
make[1]: *** [usbmidi.c] Error 1
make[1]: Leaving directory `/home/eliot/src/alsagit/alsa-driver/usb'
make: *** [modules] Error 2

copying file alsa-kernel/usb/usx2y/usX2Yhwdep.c
patching file usX2Yhwdep.c
Hunk #5 FAILED at 196.
Hunk #6 succeeded at 252 with fuzz 2.
1 out of 7 hunks FAILED -- saving rejects to file usX2Yhwdep.c.rej
make[2]: *** [usX2Yhwdep.c] Error 1
make[2]: Leaving directory `/home/eliot/src/alsagit/alsa-driver/usb/usx2y'
make[1]: *** [prepare] Error 1
make[1]: Leaving directory `/home/eliot/src/alsagit/alsa-driver/usb'
make: *** [modules] Error 2

copying file alsa-kernel/usb/usx2y/usbusx2y.c
patching file usbusx2y.c
Hunk #4 succeeded at 268 with fuzz 1.
Hunk #5 FAILED at 281.
Hunk #7 succeeded at 391 with fuzz 2 (offset -1 lines).
Hunk #8 succeeded at 415 (offset -2 lines).
Hunk #9 succeeded at 441 (offset -1 lines).
Hunk #10 succeeded at 462 (offset -1 lines).
Hunk #11 succeeded at 522 (offset -2 lines).
Hunk #12 succeeded at 542 (offset -2 lines).

copying file alsa-kernel/usb/usx2y/usbusx2yaudio.c
patching file usbusx2yaudio.c
Hunk #3 succeeded at 316 (offset 1 line).
Hunk #4 succeeded at 349 (offset 1 line).
Hunk #5 succeeded at 365 (offset 1 line).
Hunk #6 succeeded at 391 (offset 1 line).
Hunk #7 succeeded at 407 (offset 1 line).
Hunk #8 succeeded at 524 (offset 1 line).
Hunk #9 succeeded at 547 (offset 1 line).
Hunk #10 succeeded at 696 (offset 1 line).
Hunk #11 FAILED at 1059.
0
