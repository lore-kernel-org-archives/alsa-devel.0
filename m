From: James Pearson <james-p@moving-picture.com>
Subject: Re: 1.0.16rc1 release
Date: Tue, 22 Jan 2008 16:23:28 +0000
Message-ID: <47961880.3090309@moving-picture.com>
References: <Pine.LNX.4.61.0801221247570.9698@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moving-picture.com (mpc-26.sohonet.co.uk [193.203.82.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 40A7524B5F
	for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2008 17:23:29 +0100 (CET)
Received: from minion.mpc.local ([172.16.11.112] helo=moving-picture.com)
	by moving-picture.com with esmtp (Exim 4.43) id 1JHLuK-0006zE-OR
	for alsa-devel@alsa-project.org; Tue, 22 Jan 2008 16:23:28 +0000
In-Reply-To: <Pine.LNX.4.61.0801221247570.9698@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> Hello all,
> 
> 	1.0.16rc1 release is available for download on 
> http://www.alsa-project.org . I expect to release 1.0.16rc2 on next 
> Tuesday.

Build problem on RHEL4/CentOS4:

In file included from /tmp/alsa-driver-1.0.16rc1/acore/ioctl32/hwdep32.c:16:
/tmp/alsa-driver-1.0.16rc1/acore/ioctl32/hwdep32_new.c:21:20: driver.h: 
No such file or directory
make[4]: *** [/tmp/alsa-driver-1.0.16rc1/acore/ioctl32/hwdep32.o] Error 1
make[3]: *** [/tmp/alsa-driver-1.0.16rc1/acore/ioctl32] Error 2
make[2]: *** [/tmp/alsa-driver-1.0.16rc1/acore] Error 2
make[1]: *** [_module_/tmp/alsa-driver-1.0.16rc1] Error 2
make[1]: Leaving directory `/usr/src/kernels/2.6.9-67.mpc29-smp-x86_64'
make: *** [compile] Error 2

It looks like alsa-driver-1.0.16rc1/acore/ioctl32/hwdep32_new.c should 
be including "adriver.h" not "driver.h" ??

Also, at MODPOST stage:

*** Warning: "mutex_destroy" 
[/tmp/alsa-driver-1.0.16rc1/pci/oxygen/snd-oxygen-lib.ko] undefined!
*** Warning: "do_posix_clock_monotonic_gettime" 
[/tmp/alsa-driver-1.0.16rc1/acore/snd-timer.ko] undefined!
*** Warning: "do_posix_clock_monotonic_gettime" 
[/tmp/alsa-driver-1.0.16rc1/acore/snd-pcm.ko] undefined!

I'm not sure why its complaining about do_posix_clock_monotonic_gettime, 
as this is there in the 2.6.9 RHEL4 kernel.

James Pearson
