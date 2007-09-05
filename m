From: James Pearson <james-p@moving-picture.com>
Subject: Problems with 32 bit apps on 64 bit OS using dmix and
	snd-ioctl32
Date: Wed, 05 Sep 2007 12:10:40 +0100
Message-ID: <46DE8EB0.90208@moving-picture.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moving-picture.com (mpc-26.sohonet.co.uk [193.203.82.251])
	by alsa0.perex.cz (Postfix) with ESMTP id CE1BB103879
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Sep 2007 13:10:40 +0200 (CEST)
Received: from minion.mpc.local ([172.16.11.112] helo=moving-picture.com)
	by moving-picture.com with esmtp (Exim 4.43) id 1ISsmO-0007Z8-9v
	for alsa-devel@alsa-project.org; Wed, 05 Sep 2007 12:10:40 +0100
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

I've already sent this to the alsa-user list, but may be this a better 
place to ask:

I have a problem using 32 bit (i386) playback applications on a 64 bit
(x86_64) CentOS4/RHEL4 based kernel (based on kernel 2.6.9).

I've installed alsa-driver, alsa-lib and alsa-utils 1.0.13 (newer
versions of alsa-driver don't build with this kernel)

If I try to run a 32 bit copy of aplay on a 64 bit machine that doesn't
support hardware mixing (e.g. HDA NVidia) - i.e. uses dmix by default, I
get:

aplay: pcm_write:1268: write error: Invalid argument

and /var/log/messages reports:

Sep  4 16:45:37 wstemp-b kernel: ioctl32(aplay:28133): Unknown cmd fd(3)
cmd(40045402){00} arg(ffffae88) on /dev/snd/timer
Sep  4 16:45:37 wstemp-b kernel: ioctl32(aplay:28133): Unknown cmd fd(5)
cmd(c008551a){00} arg(080678a0) on /dev/snd/controlC0
Sep  4 16:45:37 wstemp-b kernel: ioctl32(aplay:28133): Unknown cmd fd(5)
cmd(c008551b){00} arg(080678a0) on /dev/snd/controlC0
Sep  4 16:45:37 wstemp-b kernel: ioctl32(aplay:28133): Unknown cmd fd(3)
cmd(000054a0){00} arg(00000320) on /dev/snd/timer

I've done some searching to find a solution - and found out that in more
recent kernels, snd-ioctl32 has been obsoleted - and if I do use a more
modern kernel, then using a 32 bit version of aplay works OK on a newer
64 bit kernel.

However, for other (not sound related) reasons, I need to run the
RHEL4/CentOS4 2.6.9 kernel ...

I had a look at the alsa-driver code, and acore/ioctl32/timer32_new.c
contains:

#if 0
         /* ** FIXME **
          * The following four entries are disabled because they conflict
          * with the TCOC* definitions.
          * Unfortunately, the current ioctl32 wrapper uses a single
          * hash table for all devices.  Once when the wrapper is fixed
          * with the table based on devices, they'll be back again.
          */
         MAP_COMPAT(SNDRV_TIMER_IOCTL_START),
         MAP_COMPAT(SNDRV_TIMER_IOCTL_STOP),
         MAP_COMPAT(SNDRV_TIMER_IOCTL_CONTINUE),
         MAP_COMPAT(SNDRV_TIMER_IOCTL_PAUSE),
#endif

If I change the '#if 0' to '#if 1', recompile and reload with this new
snd-ioctl32 module, then the 32 bit aplay works without an error ...
although /var/log/messages still reports:

Sep  4 17:05:26 wstemp-b kernel: ioctl32(aplay:28926): Unknown cmd fd(3)
cmd(40045402){00} arg(ffffadb8) on /dev/snd/timer
Sep  4 17:05:26 wstemp-b kernel: ioctl32(aplay:28926): Unknown cmd fd(5)
cmd(c008551a){00} arg(080678a0) on /dev/snd/controlC0
Sep  4 17:05:26 wstemp-b kernel: ioctl32(aplay:28926): Unknown cmd fd(5)
cmd(c008551b){00} arg(080678a0) on /dev/snd/controlC0

... but at least I get sound out!

So, what is the danger of using these 'disabled' ioctls?

I can't find any reference to 'TCOC* definitions' - what are these ???

Thanks

James Pearson
