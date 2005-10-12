From: Thomas Hood <jdthood@yahoo.co.uk>
Subject: 1.0.10rc2 alsa-driver build errors under gcc 4.0.2
Date: Wed, 12 Oct 2005 15:11:26 +0200
Message-ID: <434D0B7E.705@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailservice.tudelft.nl (mailservice.tudelft.nl [130.161.131.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 31295178
	for <alsa-devel@alsa-project.org>; Wed, 12 Oct 2005 15:11:26 +0200 (MEST)
Received: from localhost (localhost [127.0.0.1])
	by rav.antivirus (Postfix) with ESMTP id 9C620800D0
	for <alsa-devel@alsa-project.org>; Wed, 12 Oct 2005 15:11:24 +0200 (CEST)
Received: from aglu.demon.nl (x104.decis.nl [130.161.177.104])
	by mx4.tudelft.nl (Postfix) with ESMTP id 0063A8003A
	for <alsa-devel@alsa-project.org>; Wed, 12 Oct 2005 15:11:23 +0200 (CEST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by aglu.demon.nl (Postfix) with ESMTP id 24A143FE96
	for <alsa-devel@alsa-project.org>; Wed, 12 Oct 2005 15:11:27 +0200 (CEST)
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

FYI

$ grep -C5 rror alsa-driver_1.0.9+1.0.10rc2-1~1_i386.build
make[2]: Entering directory `/home/jdthood/src/pkg-alsa/pkg-alsa/trunk/build-area/alsa-driver-1.0.9+1.0.10rc2/debian/alsa-source/usr/src/modules/alsa-driver/acore'
Makefile:6: /home/jdthood/src/pkg-alsa/pkg-alsa/trunk/build-area/alsa-driver-1.0.9+1.0.10rc2/debian/alsa-source/usr/src/modules/alsa-driver/Makefile.conf: No such file or directory
/home/jdthood/src/pkg-alsa/pkg-alsa/trunk/build-area/alsa-driver-1.0.9+1.0.10rc2/debian/alsa-source/usr/src/modules/alsa-driver/Rules.make:75: /Rules.make1: No such file or directory
make[2]: *** No rule to make target `/Rules.make1'.  Stop.
make[2]: Leaving directory `/home/jdthood/src/pkg-alsa/pkg-alsa/trunk/build-area/alsa-driver-1.0.9+1.0.10rc2/debian/alsa-source/usr/src/modules/alsa-driver/acore'
make[1]: *** [clean] Error 1
make[1]: Leaving directory `/home/jdthood/src/pkg-alsa/pkg-alsa/trunk/build-area/alsa-driver-1.0.9+1.0.10rc2/debian/alsa-source/usr/src/modules/alsa-driver'
make: [build-source] Error 2 (ignored)
chown -R root:src debian/alsa-source/usr/src
# alsa-source/debian/*
install -m755 debian/alsa-source.rules debian/alsa-source/usr/src/modules/alsa-driver/debian/rules
install -m644 debian/alsa-source.control debian/alsa-source/usr/src/modules/alsa-driver/debian/control
install -m644 debian/copyright debian/alsa-source/usr/src/modules/alsa-driver/debian/copyright



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
