From: Alexander Nyberg <alexn@telia.com>
Subject: Re: Badness in remove_proc_entry called from
	snd_via82xx_remove	(2.6.4-mm)
Date: Thu, 11 Mar 2004 20:44:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1079034252.428.1.camel@boxen>
References: <20040204203426.GA1841@miriel.finwe.eu.org>
	 <1079026696.810.26.camel@boxen>  <s5hllm7jjc9.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <s5hllm7jjc9.wl@alsa2.suse.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2004-03-11 at 20:04, Takashi Iwai wrote:
> At Thu, 11 Mar 2004 18:38:16 +0100,
> Alexander Nyberg wrote:
> > 
> > This happens at shutdown when alsa is to be closed with kernel 2.6.4-mm.
> > I'm running debian sid, snd_via82xx compiled as module.
> > Happens also on 2.6.4-rc2-mm1, I can try on more kernels as well if it
> > is not a clear case.
> > 
> > 
> > I slapped a printk on these just before the badness:
> > de->subdir->name = "id", de->name = "card0"
> 
> does the attached patch work?
> 
> 
> --
> Takashi Iwai <tiwai@suse.de>		ALSA Developer - www.alsa-project.org
> --- linux/sound/core/init.c	4 Mar 2004 17:54:06 -0000	1.37
> +++ linux/sound/core/init.c	11 Mar 2004 19:01:42 -0000
> @@ -281,7 +281,7 @@
>  	}
>  	if (card->private_free)
>  		card->private_free(card);
> -	snd_info_free_entry(card->proc_id);
> +	snd_info_unregister(card->proc_id);
>  	if (snd_info_card_free(card) < 0) {
>  		snd_printk(KERN_WARNING "unable to free card info\n");
>  		/* Not fatal error */


Yes it worked, no more badness.

Thanks,
Alex
