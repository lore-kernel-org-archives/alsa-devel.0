From: Andreas Mohr <andi@lisas.de>
Subject: Re: [PATCH] sound azt3328: add custom AC97
 semi-emulation, to be able to use standard ALSA AC97 layer
Date: Thu, 17 Feb 2011 19:27:30 +0100
Message-ID: <20110217182730.GB20893@rhlx01.hs-esslingen.de>
References: <20110216231547.GA1638@rhlx01.hs-esslingen.de>
	<s5hvd0iwojc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	by alsa0.perex.cz (Postfix) with ESMTP id DE83C103833
	for <alsa-devel@alsa-project.org>; Thu, 17 Feb 2011 19:27:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hvd0iwojc.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Andreas Mohr <andi@lisas.de>
List-Id: alsa-devel@alsa-project.org

Hi,

On Thu, Feb 17, 2011 at 06:37:11PM +0100, Takashi Iwai wrote:
> At Thu, 17 Feb 2011 00:15:47 +0100,
> Andreas Mohr wrote:
> > @@ -189,6 +195,19 @@
> >  #include <sound/mpu401.h>
> >  #include <sound/opl3.h>
> >  #include <sound/initval.h>
> > +/*
> > + * For now, use AC97 layer in case CONFIG_SND_AC97_CODEC is available.
> > + * If our AC97 emulation turns out to work nicely,
> > + * then make it unconditional and remove old custom AC97 crap
> > + * (and Kconfig-select SND_AC97_CODEC).
> 
> In theory, this causes a problem when you build azt driver into kernel
> and build ac97 as a module.

Ah, darn, right!

> I'd suggest just to select AC97 always, and give some switch (either
> static or dynamic) for AC97 control method.

Will do, thanks!

(I'm preferring compile-time switch)

Andreas Mohr
