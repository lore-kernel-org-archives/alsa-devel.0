From: Adrian Bunk <bunk@kernel.org>
Subject: Re: [patch] snd-pcsp: relax dependancy on CONFIG_INPUT
Date: Thu, 8 May 2008 20:35:52 +0300
Message-ID: <20080508173552.GA22887@cs181133002.pp.htv.fi>
References: <482316B8.5080200@aknet.ru> <s5h4p98yfof.wl%tiwai@suse.de>
	<4823390D.8010000@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6.pp.htv.fi (smtp6.pp.htv.fi [213.243.153.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 63FB924791
	for <alsa-devel@alsa-project.org>;
	Thu,  8 May 2008 19:37:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4823390D.8010000@aknet.ru>
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

On Thu, May 08, 2008 at 09:31:57PM +0400, Stas Sergeev wrote:
> Hello.
> 
> The attached patch makes an input
> driver part of snd-pcsp optional.
> 
> Would it be possible to apply that?
>...

Sorry for the silly question, but are there serious usecases where 
people in very space limited environments and with CONFIG_INPUT=n
want PC-Speaker support?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
