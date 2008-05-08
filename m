From: Adrian Bunk <bunk@kernel.org>
Subject: Re: [patch] snd-pcsp: relax dependancy on CONFIG_INPUT
Date: Fri, 9 May 2008 01:17:24 +0300
Message-ID: <20080508221724.GG22887@cs181133002.pp.htv.fi>
References: <482316B8.5080200@aknet.ru> <s5h4p98yfof.wl%tiwai@suse.de>
	<4823390D.8010000@aknet.ru>
	<20080508173552.GA22887@cs181133002.pp.htv.fi>
	<482345AD.2040909@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.pp.htv.fi (smtp4.pp.htv.fi [213.243.153.38])
	by alsa0.perex.cz (Postfix) with ESMTP id 8EA17247C7
	for <alsa-devel@alsa-project.org>;
	Fri,  9 May 2008 00:18:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <482345AD.2040909@aknet.ru>
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

On Thu, May 08, 2008 at 10:25:49PM +0400, Stas Sergeev wrote:
> Hello.
> 
> Adrian Bunk wrote:
> > Sorry for the silly question, but are there serious usecases where 
> > people in very space limited environments and with CONFIG_INPUT=n
> > want PC-Speaker support?
> Oh, I've just heard youre screaming
> "this all is not worth a new config option!". :)
> 
> Here's another patch instead.
> Without exporting a new option to the
> user this time.
>...
> +config SND_PCSP_INPUT
> +	def_bool y
> +	depends on INPUT
> +	depends on SND_PCSP
>...

The number of users with CONFIG_INPUT=n on a PC might be more or less 
zero (even more considering the fact that you have to set 
CONFIG_EMBEDDED=y for being able to disable INPUT) - your patch adds a 
few #ifdef's that don't have any effect in practice.

And your patches breaks the compilation with CONFIG_SND_PCSP=y, 
CONFIG_INPUT=m if anyone will ever try this combination.

The latter is not unfixable, and I might be very nitpicking here,
but I do simply not see the point why we need this more complicated.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
