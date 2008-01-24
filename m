From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Error when compiling from HG on Ubuntu 7.10
Date: Thu, 24 Jan 2008 23:13:08 +0100
Message-ID: <47990D74.2030606@insite.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.bobrnet.net (bobrnet.cust.inethome.cz [88.146.180.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 9571324371
	for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2008 23:13:14 +0100 (CET)
Received: from [192.168.105.213] (ap-dustin.bobrnet.cz [10.109.8.38])
	by mailserver.bobrnet.net (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id
	m0OMHiWe017085
	for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2008 23:17:44 +0100
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

Hello,

While trying to compile the latest alsa-kernel + alsa-drivers from HG =

using ./hgcompile, I am hitting the following error:

   CC [M]  /home/pavel/projects/alsa/alsa-driver/i2c/other/tea575x-tuner.o
In file included from =

/home/pavel/projects/alsa/alsa-driver/i2c/other/tea575x-tuner.c:23:
/home/pavel/projects/alsa/alsa-driver/include/sound/driver.h:1:2: =

warning: #warning "This file is deprecated"
/home/pavel/projects/alsa/alsa-driver/i2c/other/tea575x-tuner.c:60: =

error: redefinition of =91video_get_drvdata=92
include/media/v4l2-dev.h:383: error: previous definition of =

=91video_get_drvdata=92 was here
/home/pavel/projects/alsa/alsa-driver/i2c/other/tea575x-tuner.c:65: =

error: redefinition of =91video_set_drvdata=92
include/media/v4l2-dev.h:388: error: previous definition of =

=91video_set_drvdata=92 was here
/home/pavel/projects/alsa/alsa-driver/i2c/other/tea575x-tuner.c:101:5: =

warning: "LINUX_VERSION_CODE" is not defined
/home/pavel/projects/alsa/alsa-driver/i2c/other/tea575x-tuner.c:101:26: =

warning: "KERNEL_VERSION" is not defined
/home/pavel/projects/alsa/alsa-driver/i2c/other/tea575x-tuner.c:101:40: =

error: missing binary operator before token "("
/home/pavel/projects/alsa/alsa-driver/i2c/other/tea575x-tuner.c:112:5: =

warning: "LINUX_VERSION_CODE" is not defined
/home/pavel/projects/alsa/alsa-driver/i2c/other/tea575x-tuner.c:112:27: =

warning: "KERNEL_VERSION" is not defined
/home/pavel/projects/alsa/alsa-driver/i2c/other/tea575x-tuner.c:112:41: =

error: missing binary operator before token "("
/home/pavel/projects/alsa/alsa-driver/i2c/other/tea575x-tuner.c:120:5: =

warning: "LINUX_VERSION_CODE" is not defined
/home/pavel/projects/alsa/alsa-driver/i2c/other/tea575x-tuner.c:120:27: =

warning: "KERNEL_VERSION" is not defined
/home/pavel/projects/alsa/alsa-driver/i2c/other/tea575x-tuner.c:120:41: =

error: missing binary operator before token "("
/home/pavel/projects/alsa/alsa-driver/i2c/other/tea575x-tuner.c:124:5: =

warning: "LINUX_VERSION_CODE" is not defined
/home/pavel/projects/alsa/alsa-driver/i2c/other/tea575x-tuner.c:124:27: =

warning: "KERNEL_VERSION" is not defined
/home/pavel/projects/alsa/alsa-driver/i2c/other/tea575x-tuner.c:124:41: =

error: missing binary operator before token "("
/home/pavel/projects/alsa/alsa-driver/i2c/other/tea575x-tuner.c:204:5: =

warning: "LINUX_VERSION_CODE" is not defined
/home/pavel/projects/alsa/alsa-driver/i2c/other/tea575x-tuner.c:204:27: =

warning: "KERNEL_VERSION" is not defined
/home/pavel/projects/alsa/alsa-driver/i2c/other/tea575x-tuner.c:204:41: =

error: missing binary operator before token "("
/home/pavel/projects/alsa/alsa-driver/i2c/other/tea575x-tuner.c:227:5: =

warning: "LINUX_VERSION_CODE" is not defined
/home/pavel/projects/alsa/alsa-driver/i2c/other/tea575x-tuner.c:227:26: =

warning: "KERNEL_VERSION" is not defined
/home/pavel/projects/alsa/alsa-driver/i2c/other/tea575x-tuner.c:227:40: =

error: missing binary operator before token "("
/home/pavel/projects/alsa/alsa-driver/i2c/other/tea575x-tuner.c:230:5: =

warning: "LINUX_VERSION_CODE" is not defined
/home/pavel/projects/alsa/alsa-driver/i2c/other/tea575x-tuner.c:230:27: =

warning: "KERNEL_VERSION" is not defined
/home/pavel/projects/alsa/alsa-driver/i2c/other/tea575x-tuner.c:230:41: =

error: missing binary operator before token "("
/home/pavel/projects/alsa/alsa-driver/i2c/other/tea575x-tuner.c:234:5: =

warning: "LINUX_VERSION_CODE" is not defined
/home/pavel/projects/alsa/alsa-driver/i2c/other/tea575x-tuner.c:234:26: =

warning: "KERNEL_VERSION" is not defined
/home/pavel/projects/alsa/alsa-driver/i2c/other/tea575x-tuner.c:234:40: =

error: missing binary operator before token "("
/home/pavel/projects/alsa/alsa-driver/i2c/other/tea575x-tuner.c: In =

function =91snd_tea575x_init=92:
/home/pavel/projects/alsa/alsa-driver/i2c/other/tea575x-tuner.c:243: =

warning: assignment from incompatible pointer type
make[4]: *** =

[/home/pavel/projects/alsa/alsa-driver/i2c/other/tea575x-tuner.o] Error 1

The system runs on 2.6.22-14-rt kernel, corresponding package with =

headers installed correctly. Perhaps I am doing something wrong.

Thanks a lot for any help.

Regards,

Pavel Hofman.
