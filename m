From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: usb quattro permission denied as normal user
Date: Sun, 25 May 2003 15:09:43 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3ED05E27.3030804@boosthardware.com>
References: <Law9-F68BE5op1NGGbf0004b443@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id IAA10003
	for <alsa-devel@alsa-project.org>; Sun, 25 May 2003 08:36:27 +0200
Received: from www2.webhosting.cx (www2.webhosting.cx [207.44.198.86])
	by gate.perex.cz (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id IAA18094
	for <alsa-devel@alsa-project.org>; Sun, 25 May 2003 08:25:04 +0200
Received: from boosthardware.com ([61.73.14.240])
	(authenticated (0 bits))
	by www2.webhosting.cx (8.11.6/8.11.6) with ESMTP id h4P6Omi04000
	for <alsa-devel@alsa-project.org>; Sun, 25 May 2003 08:24:50 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

After installing latest cvs and running chmod a+rw /dev/dsp* /dev/mixer 
I get this error while normal user which doesn't occur as root.

aplay -f cd -d 10 -D quattro1 test.wav
aplay: main:480: audio open error: Permission denied

Could this be related to the recent changes to the snddevices script 
procedure?


-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

Being on stage with the band in front of crowds shouting, "Get off! No!
We want normal music!", I think that was more like acting than anything
I've ever done.

Goldie, 8 Nov, 2002
The Scotsman




-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
