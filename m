From: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.16-rc6: known regressions
Date: Tue, 14 Mar 2006 02:06:21 +0100
Message-ID: <20060314010621.GR13973__30871.5364932597$1142298476$gmane$org@stusta.de>
References: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org> <20060313200544.GG13973@stusta.de> <20060313144244.266d96ef.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id CC4061C1
	for <alsa-devel@alsa-project.org>; Tue, 14 Mar 2006 02:06:21 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <20060313144244.266d96ef.akpm@osdl.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Parag Warudkar <kernel-stuff@comcast.net>, Miguel Blanco <mblancom@gmail.com>, Mauro Tassinari <mtassinari@cmanet.it>, perex@suse.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 13, 2006 at 02:42:44PM -0800, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > This email lists some known regressions in 2.6.16-rc6 compared to 2.6.15.
> >
> 
> We've also left a trail of wrecked machines behind us from earlier kernels.
>...
> Post-2.6.15:
>   From: Parag Warudkar <kernel-stuff@comcast.net>
>   Subject: Re: ALSA HDA Intel stoped to work in 2.6.16-*

Is this the interrupt problem from the "ALSA can't cherry-pick" 
category?

>...
> XFS-related oopses:
>   http://bugzilla.kernel.org/show_bug.cgi?id=6180

This was in my list.

>...
> Post-2.6.14:
>   From: "Miguel Blanco" <mblancom@gmail.com>
>   Subject: problem mounting a jffs2 filesystem
> 
>   (We might have fixed this?)

This was fixed with commit e96fb230cc97760e448327c0de612cfba94ca7bf.

>...
> Post-2.6.16-rc1:
>   From: "Mauro Tassinari" <mtassinari@cmanet.it>
>   Subject: Re: 2.6.16-rc3: more regressions
> 
>   (Radeon makes Xorg hang)
>...

This was fixed with commit 75c0141ca2fdae7c332d8f17412fbe0939dd005f.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
