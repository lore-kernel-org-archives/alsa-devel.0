From: Tim <terminator356@users.sourceforge.net>
Subject: Re: multi pcm and mmap problem
Date: Mon, 26 Nov 2007 17:46:59 -0500
Message-ID: <200711261746.59712.terminator356@users.sourceforge.net>
References: <200711210158.42108.terminator356@users.sourceforge.net>
	<200711251751.05205.terminator356@users.sourceforge.net>
	<s5h4pf9s33w.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp102.rog.mail.re2.yahoo.com (smtp102.rog.mail.re2.yahoo.com
	[206.190.36.80]) by alsa0.perex.cz (Postfix) with SMTP id 98F93248C3
	for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2007 23:32:37 +0100 (CET)
In-Reply-To: <s5h4pf9s33w.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Monday 26 November 2007 05:38:59 am you wrote:
> > It seems to me, looking at the 'IEC958 CS8427 Error Status' results
> > below, that envy24control should perhaps be using it, instead of
> >  'Word Clock Status', as a 'locked' indicator.
> Actually 'Word Clock Status' is determined from this register value.
> So far it checks whether its zero or not.  But this seesm too strict.
> We'll need to check only the UNLOCK bit (bit 4) for sync status.
>
> How about the patch below (to alsa-kernel)?
>
> diff -r 5e8cab953031 pci/ice1712/delta.c
> --- a/pci/ice1712/delta.c	Mon Nov 26 09:00:56 2007 +0100
> +++ b/pci/ice1712/delta.c	Mon Nov 26 11:56:18 2007 +0100
> @@ -405,7 +405,7 @@ static int snd_ice1712_delta1010lt_wordc
>  	if (snd_i2c_sendbytes(ice->cs8427, &reg, 1) != 1)
>  		snd_printk(KERN_ERR "unable to send register 0x%x byte to CS8427\n",
> reg); snd_i2c_readbytes(ice->cs8427, &reg, 1);
> -	ucontrol->value.integer.value[0] = (reg ? 1 : 0);
> +	ucontrol->value.integer.value[0] = (reg & CS8427_UNLOCK) ? 1 : 0;
>  	return 0;
>  }

Ah, there we go! 
Tested OK connecting/disconnecting S/PDIF cable - 
 says 'locked' then 'no signal'.
Thanks again, Takashi. 
Tim.
