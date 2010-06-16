From: Brad Figg <brad.figg@canonical.com>
Subject: Problems building the daily snapshot...
Date: Wed, 16 Jun 2010 15:05:29 -0700
Message-ID: <4C194AA9.205@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 63E4B1038FB
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Jun 2010 00:05:46 +0200 (CEST)
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1OP0jq-0000V6-QU
	for <alsa-devel@alsa-project.org>; Wed, 16 Jun 2010 23:05:44 +0100
Received: from pool-98-108-129-180.ptldor.fios.verizon.net ([98.108.129.180]
	helo=[192.168.1.13]) by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <brad.figg@canonical.com>) id 1OP0jq-0001dn-J4
	for alsa-devel@alsa-project.org; Wed, 16 Jun 2010 23:05:38 +0100
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

I had been building the daily snapshot from:
   http://kernel.org/pub/linux/kernel/people/tiwai/snapshot/

Sometime recently this has stopped working. I am doing:
   ./configure --with-debug=verbose --with-kernel=/lib/modules/2.6.32-23-generic/build
   make

The make fails with:
   make[3]: Leaving directory `/karmic/home/work/alsa/alsa-driver/usb/usx2y'
   make[2]: Leaving directory `/karmic/home/work/alsa/alsa-driver/usb'
   make[2]: Entering directory `/karmic/home/work/alsa/alsa-driver/pcmcia'
   make[3]: Entering directory `/karmic/home/work/alsa/alsa-driver/pcmcia/pdaudiocf'
   make[3]: Leaving directory `/karmic/home/work/alsa/alsa-driver/pcmcia/pdaudiocf'
   make[3]: Entering directory `/karmic/home/work/alsa/alsa-driver/pcmcia/vx'
   make[3]: Leaving directory `/karmic/home/work/alsa/alsa-driver/pcmcia/vx'
   make[2]: Leaving directory `/karmic/home/work/alsa/alsa-driver/pcmcia'
   make[2]: Entering directory `/karmic/home/work/alsa/alsa-driver/misc'
   make[2]: Leaving directory `/karmic/home/work/alsa/alsa-driver/misc'
   make[1]: Leaving directory `/karmic/home/work/alsa/alsa-driver'
   make -C  SUBDIRS=/karmic/home/work/alsa/alsa-driver  CPP="gcc -E" CC="gcc" modules
   make: *** SUBDIRS=/karmic/home/work/alsa/alsa-driver: No such file or directory.  Stop.
   make: *** [compile] Error 2

   (The full build log can be found at: http://kernel.ubuntu.com/~bradf/build.log)

I would have expected this make invocation to have been:
   make SUBDIRS=/karmic/home/work/alsa/alsa-driver  CPP="gcc -E" CC="gcc" -C modules

However, I believe this has worked this way for quite a while so that is probably
not the issue. I'd be interested in looking into this further but I don't understand
how the daily snapshot is created nor where the build infrastructure files (configure, et.)
come from.

Brad
-- 
Brad Figg brad.figg@canonical.com http://www.canonical.com
