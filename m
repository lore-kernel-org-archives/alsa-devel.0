From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] sound/isa/: possible cleanups
Date: Fri, 13 May 2005 16:37:20 +0200
Message-ID: <20050513143720.GH16549@stusta.de>
References: <20050513140053.GF16549@stusta.de> <s5hd5rvryaw.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 5B7C92F8
	for <alsa-devel@alsa-project.org>; Fri, 13 May 2005 16:37:22 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <s5hd5rvryaw.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, perex@suse.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, May 13, 2005 at 04:32:55PM +0200, Takashi Iwai wrote:
>...
> The unused stuff in sound/isa/gus/* are for (everlasting :) future
> development, e.g. WaveTable synth support.  So I don't think it's a
> good idea to remove completely them.
>...

Would a patch to #if 0 them away be OK?

> Takashi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
