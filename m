From: Michael Jordan <jordan.mymail@gmail.com>
Subject: Hello
Date: Wed, 11 Sep 2013 23:12:24 -0400
Message-ID: <20130911231224.2d52a2e3@mach1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f41.google.com (mail-yh0-f41.google.com
 [209.85.213.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 440AE261B06
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2013 05:12:28 +0200 (CEST)
Received: by mail-yh0-f41.google.com with SMTP id f73so4049566yha.0
 for <alsa-devel@alsa-project.org>; Wed, 11 Sep 2013 20:12:27 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Gururaja,

If I am trying to ask some questions about the alsa system, do I need
to copy somebody directly to get a response? I have posted about 4
questions on the group in the last few months, and I have not even
gotten a slap on the hand.

The reason I am contacting you is you have mentioned working on the
TLV320AIC3X which is the chip used on the OMAPL138 board that we have.
I am attempting to write a driver for a PCM3168A which we have already
constructed a board for, and plugs into the 100 pin audio expander
connecter. I have the basic draft of a driver, but everything in the
code seems to be fairly strongly coded for the DA850 boards to use the
TLV320AIC. I can prevent it loading, and my module will load, but
things are not "connecting" internally. I assumed that I would need to
make some changes in the arch/arm/mach-davinci/board-da850-evm.c.

However what I am running into is chasing me up a trail that eventually
has me modifying mach-types.h and creating a whole new board
configuration. I said ok, so I copied board-da850-evm.c to
board-da850-evm-mod.c which made it necessary for me to begin modifying
some Kconfig's, etc., and I still cannot get the kernel to compile with
the new kernel driver.

I just need to know, am I heading down the wrong path with this? I have
a pcm3168a.c and pcm3168a.h which have a basic structure for the new
codec, but I cannot figure out how to get the system to actually use it
because it basically appears that the TLV320AIC3X is "hard-wired" into
the system.

Help please,

Michael
