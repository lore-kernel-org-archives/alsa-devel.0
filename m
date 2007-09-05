From: James Pearson <james-p@moving-picture.com>
Subject: Re: Problems with 32 bit apps on 64 bit OS using dmix
 and snd-ioctl32
Date: Wed, 05 Sep 2007 15:38:33 +0100
Message-ID: <46DEBF69.6070307@moving-picture.com>
References: <46DE8EB0.90208@moving-picture.com> <s5hd4wx8ec0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moving-picture.com (mpc-26.sohonet.co.uk [193.203.82.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 0157A243AD
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Sep 2007 16:38:33 +0200 (CEST)
In-Reply-To: <s5hd4wx8ec0.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
>>So, what is the danger of using these 'disabled' ioctls?
>>
>>I can't find any reference to 'TCOC* definitions' - what are these ???
> 
> 
> A typo of TIOC* or TC*.  They are defined in asm-*/ioctls.h.
> 
> These are used for syscalls like fcntl().  Thus, it's indeed dangerous
> to define these.
> 
> Can't you build the new alsa-driver with old kernel?  Then, together
> with the new alsa-lib, the problem should go away.

I can't build either alsa-driver 1.0.14 or 1.0.15rc1 - they bomb out with:

   CC [M]  /tmp/alsa-driver-1.0.15rc1/misc/ac97_bus.o
In file included from /tmp/alsa-driver-1.0.15rc1/misc/ac97_bus.c:1:
/tmp/alsa-driver-1.0.15rc1/misc/../alsa-kernel/ac97_bus.c:30: error: 
syntax error before "pm_message_t"
/tmp/alsa-driver-1.0.15rc1/misc/../alsa-kernel/ac97_bus.c:31: warning: 
function declaration isn't a prototype
/tmp/alsa-driver-1.0.15rc1/misc/../alsa-kernel/ac97_bus.c: In function 
`ac97_bus_suspend':
/tmp/alsa-driver-1.0.15rc1/misc/../alsa-kernel/ac97_bus.c:34: error: 
`dev' undeclared (first use in this function)
/tmp/alsa-driver-1.0.15rc1/misc/../alsa-kernel/ac97_bus.c:34: error: 
(Each undeclared identifier is reported only once
/tmp/alsa-driver-1.0.15rc1/misc/../alsa-kernel/ac97_bus.c:34: error: for 
each function it appears in.)
/tmp/alsa-driver-1.0.15rc1/misc/../alsa-kernel/ac97_bus.c:35: error: 
`state' undeclared (first use in this function)
/tmp/alsa-driver-1.0.15rc1/misc/../alsa-kernel/ac97_bus.c: In function 
`ac97_bus_resume':
/tmp/alsa-driver-1.0.15rc1/misc/../alsa-kernel/ac97_bus.c:45: error: too 
few arguments to function
make[4]: *** [/tmp/alsa-driver-1.0.15rc1/misc/ac97_bus.o] Error 1

However, even if I could build 1.0.14/15rc1, I'm not sure if they would 
help - as I think the important output from the configure script 
(alsa-driver 1.0.13 and above) is:

checking for new unlocked/compat_ioctl... no

and in include/config.h:

/* #undef CONFIG_SND_HAVE_NEW_IOCTL */

So, as far as I can tell, means that I have to use the snd-ioctl32 
module, which has the problems I originally described.

Is this correct?

Thanks

James Pearson
