From: lars.bjorndal@broadpark.no (Lars =?iso-8859-1?Q?Bj=F8rndal?=)
Subject: Compilation error
Date: Fri, 25 Jun 2010 08:15:04 +0200
Message-ID: <m3aaqjab9z.fsf@fox.lamasti.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailfilter.handytech.no (mail.handytech.no [195.159.152.100])
	by alsa0.perex.cz (Postfix) with ESMTP id D3317103817
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 08:15:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailfilter.handytech.no (Postfix) with ESMTP id 37E1730347
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 08:15:15 +0200 (CEST)
Received: from mailfilter.handytech.no ([127.0.0.1])
	by localhost (mailfilter.handytech.no [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id t8id5hFP4VCw for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 08:15:07 +0200 (CEST)
Received: from fox.lamasti.net (lamasti.net [217.13.25.216])
	by mailfilter.handytech.no (Postfix) with ESMTP id 86F4F30083
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 08:15:07 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by fox.lamasti.net (Postfix) with ESMTP id A892E803F
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 08:15:06 +0200 (CEST)
Received: from fox.lamasti.net ([127.0.0.1])
	by localhost (fox.lamasti.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1XKXUVMwGtlm for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 08:15:04 +0200 (CEST)
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


I get the following output while trying to compile the alsa driver on my
Fedora 12 system. It worked well with the previous kernel version.

# ./alsa-compile.sh --install
File environment.base is cached.
> cd /tmp/alsa-compile-script
File environment.compile is cached.
alsa-driver tree alsa-driver-1.0.23.31.g2379a.273.g5b97d is present.
Reusing it.
Use './alsa-compile.sh --clean=alsa-driver' command to refetch and rebuild.
Sources unpacked to alsa-driver-1.0.23.31.g2379a.273.g5b97d
> cd alsa-driver-1.0.23.31.g2379a.273.g5b97d
Running make:
make dep
make[1]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.23.31.g2379a.273.g5b97d'
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.23.31.g2379a.273.g5b97d/include'
make -C sound prepare
make[3]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.23.31.g2379a.273.g5b97d/include/sound'
make prepare2
make[4]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.23.31.g2379a.273.g5b97d/include/sound'
make[4]: Nothing to be done for `prepare2'.
make[4]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.23.31.g2379a.273.g5b97d/include/sound'
make[3]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.23.31.g2379a.273.g5b97d/include/sound'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.23.31.g2379a.273.g5b97d/include'
...
make[2]: Entering directory `/tmp/alsa-compile-script/alsa-driver-1.0.23.31.g2379a.273.g5b97d/misc'
make[2]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.23.31.g2379a.273.g5b97d/misc'
make[1]: Leaving directory `/tmp/alsa-compile-script/alsa-driver-1.0.23.31.g2379a.273.g5b97d'
make -C /lib/modules/2.6.32.14-127.fc12.i686.PAE/build SUBDIRS=/tmp/alsa-compile-script/alsa-driver-1.0.23.31.g2379a.273.g5b97d  CPP="gcc -E" CC="gcc" modules
make[1]: Entering directory `/usr/src/kernels/2.6.32.14-127.fc12.i686.PAE'
  CC [M]  /tmp/alsa-compile-script/alsa-driver-1.0.23.31.g2379a.273.g5b97d/usb/misc/ua101.o
In file included from /tmp/alsa-compile-script/alsa-driver-1.0.23.31.g2379a.273.g5b97d/usb/misc/ua101.c:2:
/tmp/alsa-compile-script/alsa-driver-1.0.23.31.g2379a.273.g5b97d/usb/misc/../../alsa-kernel/usb/misc/ua101.c: In function 'alloc_stream_buffers':
/tmp/alsa-compile-script/alsa-driver-1.0.23.31.g2379a.273.g5b97d/usb/misc/../../alsa-kernel/usb/misc/ua101.c:1071: error: implicit declaration of function 'usb_alloc_coherent'
/tmp/alsa-compile-script/alsa-driver-1.0.23.31.g2379a.273.g5b97d/usb/misc/../../alsa-kernel/usb/misc/ua101.c:1072: warning: assignment makes pointer from integer without a cast
/tmp/alsa-compile-script/alsa-driver-1.0.23.31.g2379a.273.g5b97d/usb/misc/../../alsa-kernel/usb/misc/ua101.c: In function 'free_stream_buffers':
/tmp/alsa-compile-script/alsa-driver-1.0.23.31.g2379a.273.g5b97d/usb/misc/../../alsa-kernel/usb/misc/ua101.c:1092: error: implicit declaration of function 'usb_free_coherent'
/tmp/alsa-compile-script/alsa-driver-1.0.23.31.g2379a.273.g5b97d/usb/misc/../../alsa-kernel/usb/misc/ua101.c: In function 'ua101_card_free':
/tmp/alsa-compile-script/alsa-driver-1.0.23.31.g2379a.273.g5b97d/usb/misc/../../alsa-kernel/usb/misc/ua101.c:1172: warning: unused variable 'ua'
make[4]: *** [/tmp/alsa-compile-script/alsa-driver-1.0.23.31.g2379a.273.g5b97d/usb/misc/ua101.o] Error 1
make[3]: *** [/tmp/alsa-compile-script/alsa-driver-1.0.23.31.g2379a.273.g5b97d/usb/misc] Error 2
make[2]: *** [/tmp/alsa-compile-script/alsa-driver-1.0.23.31.g2379a.273.g5b97d/usb] Error 2
make[1]: *** [_module_/tmp/alsa-compile-script/alsa-driver-1.0.23.31.g2379a.273.g5b97d] Error 2
make[1]: Leaving directory `/usr/src/kernels/2.6.32.14-127.fc12.i686.PAE'
make: *** [compile] Error 2
Working directory /tmp/alsa-compile-script/alsa-driver-1.0.23.31.g2379a.273.g5b97d.
Compilation of alsa-driver failed.
Report this problem to the <alsa-devel@alsa-project.org> mailing list.

Lars
