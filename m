From: "guan yim" <guanyim@hotmail.com>
Subject: RE: 1.0.4rc1 release
Date: Mon, 29 Mar 2004 10:04:29 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Sea2-F518GyUbvH4KQ700018c71@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from hotmail.com (sea2-f51.sea2.hotmail.com [207.68.165.51])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA07803
	for <alsa-devel@alsa-project.org>; Mon, 29 Mar 2004 10:16:46 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,


alsa-driver:

if simply just do ./configure then make, here is what I get:

In file included from mpu401.c:4:
../../alsa-kernel/drivers/mpu401/mpu401.c:31:27: acpi/acpi_bus.h: No such 
file or directory
make[3]: *** [fastdep] Error 1
make[3]: Leaving directory 
`/root/alsa104rc1/alsa-driver-1.0.4rc1/drivers/mpu401'
make[2]: *** [_sfdep_mpu401] Error 2
make[2]: Leaving directory `/root/alsa104rc1/alsa-driver-1.0.4rc1/drivers'
make[1]: *** [dep] Error 1
make[1]: Leaving directory `/root/alsa104rc1/alsa-driver-1.0.4rc1'
make: *** [include/sndversions.h] Error 2


But if I were to use something like ./configure --with-cards=emu10k1 then 
make, no problem.


alsa-lib: ./configure;make;make install, no problem.
alsa-utils: ./configure;make;make install, no problem.
other packages not tested.

System configuration: Redhat 7.3 distro, original GCC (2.96), kernel 2.4.20

Thanks.

_________________________________________________________________
Help STOP SPAM with the new MSN 8 and get 2 months FREE*  
http://join.msn.com/?page=features/junkmail



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
