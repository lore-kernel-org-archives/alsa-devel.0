From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 13/15] module_param: make bool parameters really bool (sound)
Date: Mon, 19 Dec 2011 12:25:40 +1030
Message-ID: <8762hdpboj.fsf@rustcorp.com.au>
References: <87boraserb.fsf@rustcorp.com.au> <s5hiplim2tt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hiplim2tt.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 15 Dec 2011 13:33:50 +0100, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 15 Dec 2011 13:49:36 +1030,
> Rusty Russell wrote:
> > 
> > module_param(bool) used to counter-intuitively take an int.  In
> > fddd5201 (mid-2009) we allowed bool or int/unsigned int using a messy
> > trick.
> > 
> > It's time to remove the int/unsigned int option.  For this version
> > it'll simply give a warning, but it'll break next kernel version.
> > 
> > Cc: Jaroslav Kysela <perex@perex.cz>
> > Cc: Takashi Iwai <tiwai@suse.de>
> > Cc: alsa-devel@alsa-project.org
> > Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> 
> Acked-by: Takashi Iwai <tiwai@suse.de>
> 
> (Maybe it'd be good to change with true and false instead of 1 and 0,
>  too.  But it's subtle things and we don't have to mix up in a single
>  patch.)
> 
> Rusty, would you like to merge from your tree, or shall I merge
> through sound tree?

Please take it :)

I'll take the bint one, since that's got other dependencies, but this
one is pure cleanup.

Thanks!
Rusty.
