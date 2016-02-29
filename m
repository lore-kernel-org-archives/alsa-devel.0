From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] ALSA: mts64: fix NULL pointer dereference
Date: Mon, 29 Feb 2016 21:52:20 +0530
Message-ID: <20160229162220.GA8495@sudip-laptop>
References: <1456748010-17038-1-git-send-email-sudipm.mukherjee@gmail.com>
 <s5hpovfu2kn.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hpovfu2kn.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 29, 2016 at 01:24:24PM +0100, Takashi Iwai wrote:
> On Mon, 29 Feb 2016 13:13:30 +0100,
> Sudip Mukherjee wrote:
> > 
> > While registering pardev, the irq_func was also registered. As a
> > result when we tried to probe for the card, an interrupt was generated
> > and in the ISR we tried to dereference private_data. But private_data
> > is still NULL as we have not yet done snd_mts64_create(). Lets probe
> > for the card after mts64 is created.
> > 
> > Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> > Fixes: 94a573500d48 ("ALSA: mts64: use new parport device model")
> > Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> 
> Applied, thanks.

Thanks, I will wait for one day for any report from 0day and then send
you the similar patch for portman.

BTW, i lost that auction of portman.

regards
sudip
