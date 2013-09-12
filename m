From: Daniel Mack <zonque@gmail.com>
Subject: Re: Hello
Date: Thu, 12 Sep 2013 19:33:05 +0200
Message-ID: <5231FAD1.5070608@gmail.com>
References: <20130911231224.2d52a2e3@mach1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 89BFD2654D0
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2013 19:33:07 +0200 (CEST)
Received: by mail-bk0-f51.google.com with SMTP id mx10so49341bkb.10
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2013 10:33:07 -0700 (PDT)
In-Reply-To: <20130911231224.2d52a2e3@mach1>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Jordan <jordan.mymail@gmail.com>
Cc: alsa-devel@alsa-project.org, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
List-Id: alsa-devel@alsa-project.org

On 12.09.2013 05:12, Michael Jordan wrote:
> If I am trying to ask some questions about the alsa system, do I need
> to copy somebody directly to get a response? I have posted about 4
> questions on the group in the last few months, and I have not even
> gotten a slap on the hand.
> 
> The reason I am contacting you is you have mentioned working on the
> TLV320AIC3X which is the chip used on the OMAPL138 board that we have.
> I am attempting to write a driver for a PCM3168A which we have already
> constructed a board for, and plugs into the 100 pin audio expander
> connecter. I have the basic draft of a driver, but everything in the
> code seems to be fairly strongly coded for the DA850 boards to use the
> TLV320AIC. I can prevent it loading, and my module will load, but
> things are not "connecting" internally. I assumed that I would need to
> make some changes in the arch/arm/mach-davinci/board-da850-evm.c.

In general, you shouldn't have any audio specific code in
arch/arm/mach-davinci/*.

> However what I am running into is chasing me up a trail that eventually
> has me modifying mach-types.h and creating a whole new board
> configuration. I said ok, so I copied board-da850-evm.c to
> board-da850-evm-mod.c which made it necessary for me to begin modifying
> some Kconfig's, etc., and I still cannot get the kernel to compile with
> the new kernel driver.
> 
> I just need to know, am I heading down the wrong path with this? I have
> a pcm3168a.c and pcm3168a.h which have a basic structure for the new
> codec, 

For reviews, please post patches against the current mainline linux git
tree to this list.

> but I cannot figure out how to get the system to actually use it
> because it basically appears that the TLV320AIC3X is "hard-wired" into
> the system.

Consider the following basics:

- board files in arch/arm/ should only contain basic machine-specific
hardware setup (including i2c/spi device matching)
- in ALSA, things are structured in machine, platform and codec parts,
which are separated from each other in order to make them system and
platform generic. Make sure to read Documentation/sound/alsa/soc/* for this.

Also note that traditional board files are going away. If you want your
platform to be future-proof, start using device-tree files to describe
your board. As a starting point, have a look at
arch/arm/boot/dts/da850-evm.dts in the current mainline kernel git.

With the upcoming simple-card DT support, you might even be able to
avoid writing an ASoC maschine driver altogether.


Daniel
