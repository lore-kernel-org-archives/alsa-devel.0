From: Jaroslav Kysela <perex@suse.cz>
Subject: RE: 1.0.4rc1 release
Date: Mon, 29 Mar 2004 11:43:13 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403291141430.1856@pnote.perex-int.cz>
References: <Sea2-F518GyUbvH4KQ700018c71@hotmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA09495
	for <alsa-devel@alsa-project.org>; Mon, 29 Mar 2004 11:42:39 +0200
In-Reply-To: <Sea2-F518GyUbvH4KQ700018c71@hotmail.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: guan yim <guanyim@hotmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 29 Mar 2004, guan yim wrote:

> alsa-driver:
> 
> if simply just do ./configure then make, here is what I get:
> 
> In file included from mpu401.c:4:
> ../../alsa-kernel/drivers/mpu401/mpu401.c:31:27: acpi/acpi_bus.h: No such 
> file or directory
> make[3]: *** [fastdep] Error 1
> make[3]: Leaving directory 
> `/root/alsa104rc1/alsa-driver-1.0.4rc1/drivers/mpu401'
> make[2]: *** [_sfdep_mpu401] Error 2
> make[2]: Leaving directory `/root/alsa104rc1/alsa-driver-1.0.4rc1/drivers'
> make[1]: *** [dep] Error 1
> make[1]: Leaving directory `/root/alsa104rc1/alsa-driver-1.0.4rc1'
> make: *** [include/sndversions.h] Error 2

Is somewhere defined acpi_walk_resources() function in your kernel tree?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
