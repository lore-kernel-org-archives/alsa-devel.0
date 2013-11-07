From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] [ALSA] sb16 - info leak in snd_sb_csp_ioctl()
Date: Thu, 7 Nov 2013 12:09:47 +0300
Message-ID: <20131107090947.GS26669@mwanda>
References: <20131107080954.GS21844@elgon.mountain>
 <s5hli10vbqv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hli10vbqv.wl%tiwai@suse.de>
Sender: kernel-janitors-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 07, 2013 at 09:48:08AM +0100, Takashi Iwai wrote:
> At Thu, 7 Nov 2013 11:09:54 +0300,
> Dan Carpenter wrote:
> > 
> > There is a 2 byte hole after "info.func_nr" so we could leak unitialized
> > stack information to userspace.
> > 
> > Fixes: 1da177e4c3f4 ('Linux-2.6.12-rc2')
> 
> Does this help at all?  It means that the bug has been there even
> before moving to git.  I think it's better to be removed for avoid
> confusion.

I think if you are back porting it then you know it goes back all the
way.  That seems useful.

The Fixes tag is still new so it's not totally clear what the rules are.
I don't have strong feelings about this either way.

regards,
dan carpenter

