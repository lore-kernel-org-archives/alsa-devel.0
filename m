From: Jesper Juhl <jj@chaosbits.net>
Subject: Re: [PATCH] Sound: AudioScience HPI: Don't leak firmware if mem
 alloc fails
Date: Fri, 29 Jul 2011 11:07:04 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1107291106300.22532@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1107282145230.20477@swampdragon.chaosbits.net> <s5hpqkt6425.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hpqkt6425.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Joe Perches <joe@perches.com>, Eliot Blennerhassett <eblennerhassett@audioscience.com>, Jaroslav Kysela <perex@perex.cz>, support@audioscience.com
List-Id: alsa-devel@alsa-project.org

On Fri, 29 Jul 2011, Takashi Iwai wrote:

> At Thu, 28 Jul 2011 21:48:27 +0200 (CEST),
> Jesper Juhl wrote:
> > 
> > We leak the memory allocated to 'firmware' when we fail to
> > release_firmware() after a kmalloc() failure in hpi_dsp_code_open().
> > This patch should take care of the leak.
> > 
> > Signed-off-by: Jesper Juhl <jj@chaosbits.net>
> > ---
> >  sound/pci/asihpi/hpidspcd.c |    4 +++-
> >  1 files changed, 3 insertions(+), 1 deletions(-)
> > 
> > 	Build tested only.
> > 
> > diff --git a/sound/pci/asihpi/hpidspcd.c b/sound/pci/asihpi/hpidspcd.c
> > index 3a7afa3..8d261ef 100644
> > --- a/sound/pci/asihpi/hpidspcd.c
> > +++ b/sound/pci/asihpi/hpidspcd.c
> > @@ -85,8 +85,10 @@ short hpi_dsp_code_open(u32 adapter, void *os_data, struct dsp_code *dsp_code,
> >  
> >  	HPI_DEBUG_LOG(DEBUG, "dsp code %s opened\n", fw_name);
> >  	dsp_code->pvt = kmalloc(sizeof(*dsp_code->pvt), GFP_KERNEL);
> > -	if (!dsp_code->pvt)
> > +	if (!dsp_code->pvt) {
> > +		release_firmware(firmware);
> >  		return HPI_ERROR_MEMORY_ALLOC;
> > +	}
> 
> IMO, it's better to use the same error handling like others, i.e.
> "goto error2".  But you want to pass a different error code, so we'd
> need to introduce an error code variable there...
> 
Thank you for the feedback. I'll cook up a better patch tonight.

-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
