From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] sound: pci: ctxfi: prink replacement
Date: Tue, 26 Aug 2014 17:21:00 +0530
Message-ID: <20140826115100.GA21572@sudip-PC>
References: <1409048004-19838-1-git-send-email-sudipm.mukherjee@gmail.com>
 <s5hr4035ymf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hr4035ymf.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 26, 2014 at 12:33:28PM +0200, Takashi Iwai wrote:
> At Tue, 26 Aug 2014 15:43:24 +0530,
> Sudip Mukherjee wrote:
> > 
> > printk replaced with corresponding pr_err and pr_alert
> > 
> > Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> > ---
> > 
> > Initially started by copy-paste but as Takashi suggested it was done by a script.
> > bash script is as follows :
> > 
> > OLD="printk(KERN_ERR \?"
> > OLD1="printk(KERN_ALERT \?"
> > NEW="pr_err("
> > NEW1="pr_alert("
> > TFILE="/tmp/out.tmp.$$"
> > for f in *.c
> > do
> > sed "s/$OLD/$NEW/g" "$f" > $TFILE && mv $TFILE "$f"
> > sed "s/$OLD1/$NEW1/g" "$f" > $TFILE && mv $TFILE "$f"
> > done
> 
> All these can be a single call of sed :)

is it? I will try to see .. 

> 
> > this patch will generate a warning from checkpatch for an unnecessary space before new line and has not been fixed as this patch is only for printk replacement.
> 
> Better to put such information into the changelog.
> 
> Do you have the patch reformatting the broken lines, too?
> If yes, I'll wait for it, as we should apply both such patches at
> once.
> 

I will send you the broken string reformatting patch . 

thanks
sudip

> 
> Takashi
