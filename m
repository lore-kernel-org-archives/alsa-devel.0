From: "Paulo Cavalcanti" <promac@gmail.com>
Subject: Re: alsa 1.0.18 does not work for Intel onboard cards
Date: Sun, 14 Dec 2008 09:29:03 -0200
Message-ID: <68720af30812140329w1dc0d166j2ddc07da866d875b@mail.gmail.com>
References: <68720af30812130723k785e5b4di12b4a3e72c633e2b@mail.gmail.com>
	<68720af30812130752t6a396948jec7062a7a1aa9092@mail.gmail.com>
	<s5htz9715oi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f16.google.com (mail-gx0-f16.google.com
	[209.85.217.16])
	by alsa0.perex.cz (Postfix) with ESMTP id 86E241037EC
	for <alsa-devel@alsa-project.org>; Sun, 14 Dec 2008 12:29:04 +0100 (CET)
Received: by gxk9 with SMTP id 9so2302462gxk.8
	for <alsa-devel@alsa-project.org>; Sun, 14 Dec 2008 03:29:03 -0800 (PST)
In-Reply-To: <s5htz9715oi.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 14, 2008 at 7:12 AM, Takashi Iwai <tiwai@suse.de> wrote:

> At Sat, 13 Dec 2008 13:52:24 -0200,
> Paulo Cavalcanti wrote:
> >
> > On Sat, Dec 13, 2008 at 1:23 PM, Paulo Cavalcanti <promac@gmail.com>
> wrote:
> >
> > > Hi,
> > >
> > > alsa driver 1.0.18 has been a nightmare for me.
> > >
> > > I had a perfectly working sound for my Intel D975XBX2 when using
> > > alsa driver 1.017. Going to 1.0.18 just muted my front sound.
> > > Well, maybe not everybody needs a front sound output, but I just
> > > stick with the 1.01.17 driver.
> > >
> > >
> > Then, I tried an Intel DG45ID mobo, which does not have
> > any sound at all, with the later alsa driver 1.0.18a (detected as a
> Generic
> > DG45).
> >
> > Going back to alsa driver 1.0.17, from the stock Fedora 10 kernel
> > (my card is then detected as an IDT 92HD73E1X5),
> > I have an analogic sound working, but Master, Headphones, and PCM
> > channels have to be above 90%, for anyone being able to hear anything.
> > Therefore, the volume is compressed in the upper 10% of the scale.
> >
> > Furthermore, I have no mic, and no input working (I would like to feed
> the
> > output
> > of my capture card to the input source of the sound card) .
> > It seems to me that the input (blue jack)  is configured as output,
> > in the 1.0.17 alsa driver.
> >
> > I do not know what else I can try, maybe some alsa snapshot,
> > to fix some of these issues.
>
> Try the snapshot on
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-snapshot.tar.gz
>
>
>
Thanks, Takashi

but it did not change anything for the Intel DG45ID.
This is a Genuine Intel mother board.

The sound card is detected as "Generic 8086 Intel G45 Develk",
but I do not hear anything, even with all mixer channel at the maximum
volumes.

This is a  Fedora 10, with the latest alsa packages, and
everything seems OK, the applications work, but I do no hear anything.

With the alsa driver from the latest Fedora kernel

Linux version 2.6.27.7-134.fc10.x86_64

the card is detected as IDT 92HD73E1X5 and,

although I have to put all the mixer channels at the maximum, the sound
output works fine, even mid emulation.

During the snapshot compilation, I got dozens of this warning:

----------------------------------------------------------------------------------
/home/roma/redhat/BUILD/alsa-driver/include/config1.h:65:1: warning:
"CONFIG_SND_AC97_POWER_SAVE_DEFAULT" redefined
In file included from <command-line>:0:
./include/linux/autoconf.h:260:1: warning: this is the location of the
previous definition
  CC [M]  /home/roma/redhat/BUILD/alsa-driver/misc/ac97_bus.o
In file included from
/home/roma/redhat/BUILD/alsa-driver/include/config.h:6,
                 from
/home/roma/redhat/BUILD/alsa-driver/include/adriver.h:25,
                 from /home/roma/redhat/BUILD/alsa-driver/misc/ac97_bus.c:1:
-----------------------------------------------------------------------------------


This is the output of alsa-info, with the stock driver (1.0.17):

http://www.alsa-project.org/db/?f=36ac819b3ef4391335caf7c5be3a97bd3a300b93



-- 
Paulo Roma Cavalcanti
LCG - UFRJ
