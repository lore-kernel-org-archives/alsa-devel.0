From: "Risto Suominen" <risto.suominen@gmail.com>
Subject: snd-powermac
Date: Sat, 29 Mar 2008 17:05:53 +0200
Message-ID: <46e1c7760803290805i9f56637uce18036db7a6756d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.247])
	by alsa0.perex.cz (Postfix) with ESMTP id 6949924487
	for <alsa-devel@alsa-project.org>; Sat, 29 Mar 2008 16:05:56 +0100 (CET)
Received: by hs-out-0708.google.com with SMTP id x43so1037149hsb.0
	for <alsa-devel@alsa-project.org>; Sat, 29 Mar 2008 08:05:55 -0700 (PDT)
Content-Disposition: inline
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

I'm about to send the following to alsa-user mailing list:

I've been trying to fix ALSA support for older PowerMacs. Anyone
experiencing problems - like missing or inoperative or wrongly
directed controls in alsamixer - could you, please, test my patch and
write the results into this list or directly to me?

If you are still with me, check first with lsmod that you are using
snd-powermac:
$ lsmod | grep ^snd.powermac
snd_powermac           56576  0
$

Then you will need to install make, C-compiler and kernel headers
corresponding to your running kernel, f.ex (Ubuntu Dapper 6.06.1):
$ sudo aptitude install make gcc linux-headers-2.6.15-26-powerpc

and fetch the ALSA driver source code and my patch:
$ wget ftp://ftp.alsa-project.org/pub/driver/alsa-driver-1.0.16.tar.bz2
$ wget http://ristosu.wippiespace.com/pub/alsa-driver-1.0.16-p4.diff

Unpack the source and apply the patch:
$ tar xjf alsa-driver-1.0.16.tar.bz2
$ cd alsa-driver-1.0.16
$ patch -p0 < ../alsa-driver-1.0.16-p4.diff

Finally configure:
$ ./configure --disable-verbose-printk
--with-kernel=/usr/src/linux-headers-2.6.15-26-powerpc
--with-build=/usr/src/linux-headers-2.6.15-26-powerpc
--with-moddir=/lib/modules/2.6.15-26-powerpc/updates/sound
--with-isapnp=no --with-oss=yes --with-pcm-oss-plugins=yes
--with-cards=powermac

make and install:
$ make
$ sudo make install-modules

To load the new modules without rebooting:
$ sudo modprobe -r snd-powermac
$ sudo modprobe -r snd-pcm-oss
$ sudo modprobe snd-powermac

Risto
