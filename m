From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ioctl(arg) - uninitialised byte(s) in alsa lib
Date: Wed, 12 Mar 2008 13:15:43 +0100
Message-ID: <47D7C96F.8010109@ladisch.de>
References: <47D7C358.6050401@xwaves.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id EC44F1038C3
	for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2008 13:14:21 +0100 (CET)
In-Reply-To: <47D7C358.6050401@xwaves.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mathieu Monney <zittix_all@xwaves.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mathieu Monney wrote:
> I'm currently working on a small audio stack on top of alsa and I'm
> getting some "Syscall param ioctl(arg) contains uninitialized byte(s)"
> errors when I run my program using valgrind.
>
> ==14279==    by 0x40DE911: snd_pcm_prepare (in /usr/lib/libasound.so.2.0.0)

The ioctl call is in src/pcm/pcm_hw.c:

	if (ioctl(fd, SNDRV_PCM_IOCTL_PREPARE) < 0) {

Apparently, valgrind doesn't detect the cases where there is no third
argument.


Regards,
Clemens
