From: James Pearson <james-p@moving-picture.com>
Subject: Re: alsa-driver-1.0.15rc2 build issues on RHEL4/CentOS4
Date: Wed, 26 Sep 2007 12:50:58 +0100
Message-ID: <46FA47A2.3020205@moving-picture.com>
References: <46EA5F30.7000404@moving-picture.com>	<s5hwsutkq6o.wl%tiwai@suse.de>
	<46F9353C.1040105@moving-picture.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090805060104020207080405"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moving-picture.com (mpc-26.sohonet.co.uk [193.203.82.251])
	by alsa0.perex.cz (Postfix) with ESMTP id AD8002442C
	for <alsa-devel@alsa-project.org>;
	Wed, 26 Sep 2007 13:50:58 +0200 (CEST)
In-Reply-To: <46F9353C.1040105@moving-picture.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090805060104020207080405
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

James Pearson wrote:

> 
> I've just discovered that I can't load snd-ioctl32 from 1.0.15rc2 on 
> RHEL4/CentOS4 - dmesg reports:
> 
> snd_ioctl32: Unknown symbol snd_ctl_elem_read
> snd_ioctl32: Unknown symbol snd_ctl_elem_write
> 
> snd-ioctl32 with 1.0.15rc1 loads fine ...

The problem is still there with 1.0.15rc3 - however, I've found the 
cause of the issue:

EXPORT_SYMBOL(snd_ctl_elem_read) and EXPORT_SYMBOL(snd_ctl_elem_write) 
have been removed from alsa-kernel/core/control.c - see:

<http://hg.alsa-project.org/alsa-kernel/rev/efd5ab99655e>

I guess this is OK for more recent kernels, but still needed for 
RHEL4/CentOS4 2.6.9 kernels

I can work round the problem by putting these back into acore/control.c

I've attached a patch which patches acore/control.patch

James Pearson

--------------090805060104020207080405
Content-Type: text/plain;
 name="alsa-1.0.15rc3-control_patch.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-1.0.15rc3-control_patch.patch"

--- ./acore/control.patch.dist	2007-09-21 09:41:25.000000000 +0100
+++ ./acore/control.patch	2007-09-26 12:07:14.809107031 +0100
@@ -1,5 +1,5 @@
---- ../alsa-kernel/core/control.c	2007-05-17 08:15:24.000000000 +0200
-+++ control.c	2007-05-24 21:25:20.000000000 +0200
+--- ../alsa-kernel/core/control.c	2007-09-21 09:41:26.000000000 +0100
++++ control.c	2007-09-26 12:06:00.936446240 +0100
 @@ -1,3 +1,4 @@
 +#define __NO_VERSION__
  /*
@@ -13,7 +13,25 @@
  #include <linux/slab.h>
  #include <linux/vmalloc.h>
  #include <linux/time.h>
-@@ -1387,25 +1389,44 @@
+@@ -716,6 +718,8 @@ int snd_ctl_elem_read(struct snd_card *c
+ 	return result;
+ }
+ 
++EXPORT_SYMBOL(snd_ctl_elem_read);
++
+ static int snd_ctl_elem_read_user(struct snd_card *card,
+ 				  struct snd_ctl_elem_value __user *_control)
+ {
+@@ -779,6 +783,8 @@ int snd_ctl_elem_write(struct snd_card *
+ 	return result;
+ }
+ 
++EXPORT_SYMBOL(snd_ctl_elem_write);
++
+ static int snd_ctl_elem_write_user(struct snd_ctl_file *file,
+ 				   struct snd_ctl_elem_value __user *_control)
+ {
+@@ -1383,25 +1389,44 @@ static int snd_ctl_fasync(int fd, struct
  /*
   * ioctl32 compat
   */

--------------090805060104020207080405
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------090805060104020207080405--
