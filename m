From: Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH] sound: Fix empty menuconfig SND_ARM
Date: Sat, 30 Jul 2016 17:14:13 +0200
Message-ID: <20160730151413.GA25440@eugeniu-X230>
References: <20160730140019.20305-1-rosca.eugeniu@gmail.com>
 <87eg6byzzz.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 172502658DC
 for <alsa-devel@alsa-project.org>; Sat, 30 Jul 2016 17:14:18 +0200 (CEST)
Received: by mail-wm0-f65.google.com with SMTP id i5so19687329wmg.2
 for <alsa-devel@alsa-project.org>; Sat, 30 Jul 2016 08:14:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87eg6byzzz.fsf@belgarion.home>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: broonie@kernel.org, tiwai@suse.com, alsa-devel@alsa-project.org, Eugeniu Rosca <roscaeugeniu@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 30, 2016 at 04:14:24PM +0200, Robert Jarzmik wrote:
> Eugeniu Rosca <roscaeugeniu@gmail.com> writes:
> 
> > commit 3c8f7710c1c4 ("ASoC: fix broken pxa SoC support") has removed
> > the SND_ARM dependency from SND_PXA2XX_LIB and SND_PXA2XX_LIB_AC97,
> > by moving these config entries outside of the "if SND_ARM ... endif"
> > construct.
> >
> > However, by placing these 2 symbols right between the SND_ARM
> > menuconfig definition and the first SND_ARM menu entry, the side
> > effect is that the SND_ARM menu becomes empty and all the config
> > entries caught between "if SND_ARM ... endif" no more belong to
> > menuconfig SND_ARM, but to its parent (menuconfig SND).
> >
> > Fix this.
> NAK.
> 
> The reason is that SND_PXA2XX_LIB is used outside of SND_ARM, see
> sound/soc/pxa/Kconfig, SND_PXA2XX_SOC and co.
> 
> With you commit you're breaking every board relying on SND_PXA2XX_SOC but not
> SND_ARM.
> 
> Cheers.
> 
> --
> Robert

Hi Robert and thanks for the quick reply!

In my understanding, the patch doesn't bring any changes in the
relationship between different config options. It only corrects the
way the config entries are exposed to the user via "make menuconfig"
interface.

Here are two situations that I hope can explain it:

1. Proper (non-empty) menu:

menuconfig A
    prompt "menu-A"

if A
    config B
    prompt "config-B"
endif

config C
    prompt "config-C"

2. Empty menu:

menuconfig A
    prompt "menu-A"

config C
    prompt "config-C"

if A
    config B
    prompt "config-B"
endif

In both cases, the relationship between A, B, C is the same.
However, the options are exposed differently by "make menuconfig".
Assuming B is enabled:

(1):
    menu-A
        config-B
    config-C

(2):
    menu-A
    config-C
    config-B

In case of (1), B is a child of A (expected)
In case of (2), B is a sibling of A (not quite expected)

Let me know if there are still doubts on your side and/or if I can be
of any further help.

Thanks,
Eugeniu.
