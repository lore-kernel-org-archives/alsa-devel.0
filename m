From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: Re: [PATCH] ad1848-lib Makefile cleanup
Date: Thu, 9 Aug 2007 20:03:22 +0200
Message-ID: <20070809200322.b13ff9f4.krzysztof.h1@wp.pl>
References: <20070809190643.6e5a16be.krzysztof.h1@wp.pl>
	<s5hps1wwrmf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.wp.pl (mx1.wp.pl [212.77.101.5])
	by alsa0.perex.cz (Postfix) with ESMTP id CD82B24395
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Aug 2007 19:59:09 +0200 (CEST)
In-Reply-To: <s5hps1wwrmf.wl%tiwai@suse.de>
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
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 09 Aug 2007 19:21:44 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Thu, 9 Aug 2007 19:06:43 +0200,
> Krzysztof Helt wrote:
> > 

> >  obj-$(CONFIG_SND_AD1848) += snd-ad1848.o snd-ad1848-lib.o
> 
> This line should contain only snd-ad1848.o.
> 
ok.

> > -obj-$(CONFIG_SND_OPTI92X_AD1848) += snd-ad1848-lib.o
> > +obj-$(CONFIG_SND_AD1848_LIB) += snd-ad1848-lib.o
> >  
> >  obj-m := $(sort $(obj-m))
> 
> Oh, this sort is also superfluous.
> 
> There need similar cleanups in other isa/* directories.
> Care to create a patch including them?
> 

Should this be one patch for all isa libs or each one in the separate patch?

Regards,
Krzysztof
