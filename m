From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
Date: Tue, 31 Aug 2004 20:48:46 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040831184846.GB25485@elte.hu>
References: <OF923A124A.1D8E364E-ON86256F01.0053F7B2-86256F01.0053F7D7@raytheon.com> <1093972819.5403.8.camel@krustophenia.net> <s5hllfvyxuf.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S266616AbUHaSrl@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hllfvyxuf.wl@alsa2.suse.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Mark_H_Johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>, linux-kernel <linux-kernel@vger.kernel.org>, Felipe Alfaro Solana <lkml@felipe-alfaro.com>, Daniel Schmitt <pnambic@unu.nu>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


* Takashi Iwai <tiwai@suse.de> wrote:

> Does the attached patch fix this problem?
> 
> 
> Takashi
> 
> --- linux/sound/pci/ens1370.c	25 Aug 2004 09:57:03 -0000	1.64
> +++ linux/sound/pci/ens1370.c	31 Aug 2004 18:17:45 -0000
> @@ -513,6 +513,7 @@
>  		r = inl(ES_REG(ensoniq, 1371_SMPRATE));
>  		if ((r & ES_1371_SRC_RAM_BUSY) == 0)
>  			return r;
> +		cond_resched();

but ... snd_es1371_wait_src_ready() is being called with
ensoniq->reg_lock held and you must not reschedule with a spinlock held. 
cond_resched_lock(&ensoniq->req_lock) might not crash immediately, but 
is it really safe to release the driver lock at this point?

	Ingo
