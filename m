From: Adrian Bunk <bunk@kernel.org>
Subject: Re: [patch] snd-pcsp: relax dependancy on CONFIG_INPUT
Date: Fri, 9 May 2008 01:48:26 +0300
Message-ID: <20080508224826.GI22887@cs181133002.pp.htv.fi>
References: <482316B8.5080200@aknet.ru> <s5h4p98yfof.wl%tiwai@suse.de>
	<4823390D.8010000@aknet.ru>
	<20080508173552.GA22887@cs181133002.pp.htv.fi>
	<482345AD.2040909@aknet.ru>
	<20080508221724.GG22887@cs181133002.pp.htv.fi>
	<482380F6.3070309@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6.pp.htv.fi (smtp6.pp.htv.fi [213.243.153.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 04206247B8
	for <alsa-devel@alsa-project.org>;
	Fri,  9 May 2008 00:49:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <482380F6.3070309@aknet.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stas Sergeev <stsp@aknet.ru>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, May 09, 2008 at 02:38:46AM +0400, Stas Sergeev wrote:
> Hello.
> 
> Adrian Bunk wrote:
> > And your patches breaks the compilation with CONFIG_SND_PCSP=y, 
> > CONFIG_INPUT=m if anyone will ever try this combination.
> OK, that's nasty indeed...
> Then I guess it is not a big deal
> to leave that dependancy as-is until
> the real need in changing it appear.
> 
> Btw, is there really no way at all
> to tell kconfig something like
> depends on INPUT if SND_PCSP_INPUT
> or similar?

There are different ways how you could express this in kconfig
depending on what exactly would be intended.

But the stuff we already have in kconfig has enough problematic 
cornercases, and making anything more complicated IMHO requires
a justification that there's a real need for it.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
