From: raj raja <yuvaraj.addu@gmail.com>
Subject: Re: alsa-driver cross compile problem - upgrading ALSA
Date: Mon, 2 Jul 2012 09:36:51 +0530
Message-ID: <CADgpFcpmf2LQzXYnfvUgZttAw0Ko71CdaTpAMJ+d3HpT0omTJA@mail.gmail.com>
References: <20120629153248.29780@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id D572C2455C
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Jul 2012 06:06:51 +0200 (CEST)
Received: by wgbds1 with SMTP id ds1so2488850wgb.2
	for <alsa-devel@alsa-project.org>; Sun, 01 Jul 2012 21:06:51 -0700 (PDT)
In-Reply-To: <20120629153248.29780@gmx.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Max Klein <mein_name@ist-einmalig.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Better you compile with kernel


Thanks

Yuvi R

On Fri, Jun 29, 2012 at 9:02 PM, Max Klein <mein_name@ist-einmalig.de>wrote:

> I am running 2.6.27 kernel on arm board with ALSA driver version 1.0.17
> (cat /proc/asound/version) and I would like to update ALSA driver version
> to current 1.0.25.
>
> I am trying to build alsa-drivers with "./configure
> --with-cross=arm-none-linux-gnueabi- --enable-dynamic-minors
> --with-debug=full --with-isapnp=no --with-oss=no
> --with-kernel=/data/src/kernel/linux-davinci
> --with-build=/data/src/kernel/linux-davinci --with-sequencer=no"
>
> Afterwards I compile it via "make ARCH=arm" but this fails we the
> following error:
>
> In file included from
> /data/VRM/davinci33/alsa-1.0.25/alsa-driver-1.0.25/acore/hrtimer.c:1:
> /data/VRM/davinci33/alsa-1.0.25/alsa-driver-1.0.25/include/adriver.h:753:
> error: static declaration of 'jiffies_to_msecs' follows non-static
> declaration
> include/linux/jiffies.h:286: error: previous declaration of
> 'jiffies_to_msecs' was here
> /data/VRM/davinci33/alsa-1.0.25/alsa-driver-1.0.25/include/adriver.h:772:
> error: static declaration of 'msecs_to_jiffies' follows non-static
> declaration
> include/linux/jiffies.h:288: error: previous declaration of
> 'msecs_to_jiffies' was here
>
>
> Can someone please help me how to get ALSA upgraded on my platform?
> Obviously I am either doing something wrong when configuring or I am on the
> absolutely wrong way?
>
> I am looking forward for any advice, thanks in advance!
> --
> NEU: FreePhone 3-fach-Flat mit kostenlosem Smartphone!
> Jetzt informieren: http://mobile.1und1.de/?ac=OM.PW.PW003K20328T7073a
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
