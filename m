From: Sentinel <sentinel@optonline.net>
Subject: spdif/iec958 outputs at VT1708S not recognized
Date: Tue, 26 May 2009 10:24:59 -0400
Message-ID: <000401c9de0d$c06d27d0$41477770$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta2.srv.hcvlny.cv.net (mta2.srv.hcvlny.cv.net [167.206.4.197])
	by alsa0.perex.cz (Postfix) with ESMTP id 028861038C7
	for <alsa-devel@alsa-project.org>;
	Tue, 26 May 2009 16:25:13 +0200 (CEST)
Received: from HPGame2 (ool-4571dd92.dyn.optonline.net [69.113.221.146])
	by mta2.srv.hcvlny.cv.net
	(Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
	with ESMTP id <0KK900CR29DLB9J0@mta2.srv.hcvlny.cv.net> for
	alsa-devel@alsa-project.org; Tue, 26 May 2009 10:25:00 -0400 (EDT)
Content-language: en-us
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
List-Id: alsa-devel@alsa-project.org

I tried using the snapshot because I was having the same problem as Peter
was.  No spdif out on my vt1708s.  Unfortunately for me my build didn't go
quite as well, for some reason I had 2 undefined which make the snd.ko fail
to load.  Is there something that I'm missing?  I am running slamd64 distro
current, with the latest kernel along with the alsa kernel patch
"2.6.29.4-rt15".   Please help.

 

  Building modules, stage 2.

  MODPOST 131 modules

WARNING: "register_sound_special_device" [/usr/src/alsa-driver/acore/snd.ko]
undefined!

WARNING: "unregister_sound_special" [/usr/src/alsa-driver/acore/snd.ko]
undefined!

make[1]: Leaving directory `/usr/src/linux-2.6.29.4'

utils/link-modules /usr/src/alsa-driver
