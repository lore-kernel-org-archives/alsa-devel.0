From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Request for test (1.0.18 final)
Date: Tue, 28 Oct 2008 09:06:58 +0100
Message-ID: <4906C822.7070807@ladisch.de>
References: <Pine.LNX.4.61.0810271449320.12044@tm8103.perex-int.cz>
	<4905F6EB.8080507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id CE2A41037F7
	for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2008 09:07:01 +0100 (CET)
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 4176E186405
	for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2008 04:07:00 -0400 (EDT)
Received: from [10.1.2.10] (srv004.schk01.int.dmc-one.com [85.232.8.141])
	by mail.messagingengine.com (Postfix) with ESMTPSA id AFEB7304B1
	for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2008 04:06:59 -0400 (EDT)
In-Reply-To: <4905F6EB.8080507@gmail.com>
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
> Please, report compilation trouble with the current ALSA code.

make[4]: *** No rule to make target `/home/c/alsa/alsa-driver/i2c/other/tea575x-tuner.o', needed by `/home/c/alsa/alsa-driver/i2c/other/snd-tea575x-tuner.o'.  Stop.
make[3]: *** [/home/c/alsa/alsa-driver/i2c/other] Error 2
make[2]: *** [/home/c/alsa/alsa-driver/i2c] Error 2
make[1]: *** [_module_/home/c/alsa/alsa-driver] Error 2
make[1]: Leaving directory `/root/linux-2.6'
make: *** [compile] Error 2

In my kernel, CONFIG_VIDEO_DEV is set but CONFIG_VIDEO_V4L1 isn't,
and the snd-tea575x-tuner module depends on the latter.

I don't fully understand the purpose of the hack in the makefile, but
this patch works for me:

--- alsa.orig/alsa-driver/i2c/other/Makefile	2008-10-27 20:54:38.000000000 +0100
+++ alsa/alsa-driver/i2c/other/Makefile	2008-10-27 20:55:01.000000000 +0100
@@ -9,7 +9,7 @@

 # Toplevel Module Dependency
 # hack for tea575x support
-ifeq (y,$(CONFIG_VIDEO_DEV))
+ifeq (y,$(CONFIG_SND_FM801_TEA575X_BOOL))
 obj-$(CONFIG_SND_FM801) += snd-tea575x-tuner.o
 ifeq (m,$(CONFIG_SND_FM801))
 export-objs += tea575x-tuner.o
